# ADR 0007: Hybrid Voice Resolution

Status: Accepted
Date: 2026-09-05

## Context

Siri and watchOS dictation pass recognized text to App Intents; they do not expose the user's original audio to the app. Qwen3-ASR therefore cannot repair a Siri transcription after the fact. The product also needs useful answers for words absent from curated vocabulary without allowing ASR or SLM mistakes to become trusted RAG data.

The local development host is an Apple Silicon Mac. Qwen3-ASR's official high-throughput serving path uses vLLM and a CUDA GPU. Local development still needs a real ASR endpoint, not a mock, while Ollama can run the text fallback efficiently on the Mac host.

## Decision

- Keep Siri/watchOS dictation as the fastest text path through `POST /v1/assistant/query`.
- Add an explicit foreground Watch recording path. It records one short utterance, uploads it to `POST /v1/assistant/audio`, and the backend sends it to Qwen3-ASR's OpenAI-compatible `/v1/audio/transcriptions` API.
- Run a pinned multi-architecture Qwen3-ASR image in Docker Compose for local development. A product-owned, narrow adapter loads only Qwen3-ASR-0.6B through the image's Rust CPU backend and implements the required health, model-list, and transcription endpoints. Production may replace it with the official CUDA/vLLM endpoint through the same OpenAI-compatible contract.
- Keep ASR separately configurable. The Kotlin backend owns its URL, model name, timeout, and optional API key and never exposes provider credentials to the Watch.
- Do not load or accept speaker diarization and word timestamps for the one-word request. Serialize local CPU inference and force the Kotlin HTTP client to HTTP/1.1 for compatibility with provider proxies.
- Resolve both text and ASR transcripts through one ordered pipeline: normalized PostgreSQL vocabulary/aliases, retrieved OpenSearch context, then a local Ollama SLM fallback.
- Use the already-installed `qwen3:4b` model through Ollama on the Mac host for local SLM fallback. In container development the backend reaches it through `host.docker.internal`.
- Persist valid SLM results in PostgreSQL with `origin=slm` and `verification_status=pending`. Pending rows may serve the same user again as a cache but are excluded from the trusted OpenSearch vocabulary index.
- Existing seed and manually curated rows use `verification_status=trusted` and remain indexable. Promotion of pending data is an administrative workflow, not an automatic side effect of use.
- Keep pronunciation assets as media, not vector documents. Play stored word audio when present; use watchOS `AVSpeechSynthesizer` for the English example and as a pronunciation fallback.

## Consequences

- Qwen can improve recognition only for the explicit recording path, not for audio Siri already consumed.
- A missing or unhealthy Qwen service returns a typed 503 and does not block the text/Siri path.
- A missing or unhealthy Ollama service preserves the existing 404 behavior for unknown words.
- The first local ASR start downloads Qwen3-ASR-0.6B into a persistent Docker volume and takes longer than cached starts.
- The narrow adapter cuts measured ASR memory from about 6.2 GiB for the provider's full server to about 3.1 GiB during startup and 2.1 GiB after settling, without modifying the image's installed Rust library.
- Warm local CPU transcription is suitable for the personal MVP; production can switch to the official CUDA/vLLM deployment without changing the Watch API.
- User recordings are transient request bodies. They are not stored unless a later privacy ADR explicitly permits retention.

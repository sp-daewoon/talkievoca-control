# Current State

Updated: 2026-09-05
Owner: product

## Product goal

On Apple Watch, a user speaks or enters an English word. The app requests feedback from TalkieVoca Backend, presents Korean meaning/example, and plays the matching audio.

## Repository state

- `talkievoca-apple`: initialized from the Watch PoC as an independent repository. Its primary screen now performs dictation/typing, lookup, rendering, and optional automatic audio playback as one flow.
- `talkievoca-backend`: initialized as a new Kotlin + Spring Boot + Spring AI repository. Its Docker Compose stack runs the app, PostgreSQL, and OpenSearch together on the standard app port 8080. It is not a fork or runtime use of `ragBaseSample`.
- `_control`: initialized as an independent Git repository on 2026-09-05.

## Confirmed PoC facts

- Physical Apple Watch dictation receives spoken input; simulator dictation is not a reliable acceptance environment.
- A Personal Team cannot provision the Siri capability. Physical app and dictation testing can continue; Siri App Intent invocation requires an Apple Developer Program team.
- The former sample endpoint and sample media are not production assets and are intentionally excluded from the product plan.
- `docker compose up --build` verified the new backend on 2026-09-05: `/health` returns 200, `애플` resolves to `apple`, PostgreSQL stores two seed entries, OpenSearch indexes two documents, and bundled audio is served from port 8080.
- A physical Watch must call the Mac's LAN address during local development, never `localhost`.
- MVP-002 completed on 2026-09-05: a real PDF upload created a PostgreSQL source/chunk record and was retrieved through OpenSearch. A real M4A upload updated `apple` to a stored `/v1/media/{id}` playback URL, which the Watch feedback endpoint returned and streamed.
- `POST /v1/assistant/query` is the Apple app's single runtime API. `사과` resolves to `apple`; the LAN-address response returns a LAN-address audio URL, and the M4A downloads successfully.
- The Apple app builds for the watchOS simulator SDK with valid App Intents metadata. The 46 mm simulator launch screen was visually checked; speech recognition remains a physical-Watch acceptance check.
- MVP-003 implements Qwen3-ASR as an explicit short-recording fallback and local `qwen3:4b` through Ollama for RAG-assisted missing-word generation. ADR 0007 preserves the fast Siri text path and separates pending generated cache data from trusted RAG data.
- MVP-003 backend tests pass through the Qwen-compatible multipart endpoint and shared resolver. Docker port 8080 generated `강아지 -> dog`, cached it as `slm/pending`, served the next lookup in 0.02 seconds, and kept it out of the trusted OpenSearch vocabulary index.
- The updated Watch app records a transient three-second M4A, uploads it to Qwen, and plays stored pronunciation plus the English example. Its watchOS simulator SDK build and App Intents metadata extraction pass.
- Docker Compose now runs a pinned ARM64 Qwen3-ASR-0.6B image with a product-owned narrow adapter over its Rust CPU backend. The real Kotlin audio endpoint resolved English `apple.m4a` and synthesized Korean `사과` audio to trusted `apple` data; `/health` reports both ASR and SLM ready after warm-up.
- Java 21 attempted an h2c upgrade against the ASR nginx proxy, causing valid multipart fields to be ignored. The Qwen client now forces HTTP/1.1 and has a regression check for the absent `Upgrade` header.
- The provider's full server downloaded and preloaded unrelated models, consumed about 6.2 GiB, and exposed incomplete-cache handling during bootstrap. The narrow adapter now loads one model from one persistent cache volume and measured about 3.1 GiB.

## Active task

`TASKS/MVP-003-hybrid-voice-resolution.md`: connect explicit Watch audio to Qwen3-ASR and add a provenance-preserving RAG/SLM fallback.

## Next action

On the paired physical Watch, confirm `API · Qwen · SLM 연결됨`, tap `정확히 듣기`, say `green` and then `사과`, and verify automatic word pronunciation plus English example playback.

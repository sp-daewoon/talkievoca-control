# ADR 0006: Unified Assistant Boundary

Status: Accepted
Date: 2026-09-05

## Context

The Watch proof of concept exposed input, lookup, playback, and server configuration as separate user steps. Future ASR, RAG, LLM, and TTS providers would make the Apple client more fragile if each capability added another client endpoint or branch.

## Decision

- The Apple runtime uses `POST /v1/assistant/query` as its single feedback entry point.
- The request body is `{ "text": "..." }`. The response owns the normalized word, Korean meaning, English and Korean examples, an absolute audio URL, and the match type.
- Watch dictation or typing submits immediately. A successful result is displayed and its audio is played automatically unless the user disables automatic playback.
- Exact and curated alias lookup remain the first resolver. RAG, SLM/LLM fallback, and generated TTS caching may be added behind this contract without changing the Watch flow.
- Qwen3-ASR is not called for text already recognized by watchOS. A future explicit audio-capture fallback requires a separate API, deployable ASR runtime, retention policy, and its own ADR.
- Raw or low-confidence ASR/query results are never inserted automatically into the trusted RAG corpus. Only curated or explicitly confirmed content may become reusable knowledge.
- `GET /v1/watch/word-feedback` remains temporarily for compatibility and diagnostics.

## Consequences

- The Apple client has one network path for app input and App Intents.
- Backend providers can evolve independently while the public response remains compatible.
- The current MVP does not pretend to provide generative RAG, Qwen transcription, or dynamic TTS. Missing words still return the standard 404 response.
- A future production API must replace local HTTP with authenticated HTTPS without changing the endpoint semantics.

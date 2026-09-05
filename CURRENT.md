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
- Qwen3-ASR, LLM fallback, and generated TTS are not implemented. ADR 0006 fixes the boundary they may later sit behind and prohibits unconfirmed ASR output from polluting trusted RAG data.

## Active task

`TASKS/MVP-001-watch-to-api.md`: verify the migrated app's one-input query and automatic audio flow on the paired physical Apple Watch.

## Next action

Open `talkievoca-apple/TalkieVoca.xcodeproj`, install it on the paired physical Watch, and verify `사과` and `green` from dictation through API response and audio playback.

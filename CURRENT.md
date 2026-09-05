# Current State

Updated: 2026-09-05
Owner: product

## Product goal

On Apple Watch, a user speaks or enters an English word. The app requests feedback from TalkieVoca Backend, presents Korean meaning/example, and plays the matching audio.

## Repository state

- `talkievoca-apple`: not created yet. Existing Watch PoC remains at the workspace root and must be migrated deliberately.
- `talkievoca-backend`: initialized as a new Kotlin + Spring Boot + Spring AI repository. Its Docker Compose stack runs the app, PostgreSQL, and OpenSearch together on the standard app port 8080. It is not a fork or runtime use of `ragBaseSample`.
- `_control`: initialized as an independent Git repository on 2026-09-05.

## Confirmed PoC facts

- Physical Apple Watch dictation receives spoken input; simulator dictation is not a reliable acceptance environment.
- A Personal Team cannot provision the Siri capability. Physical app and dictation testing can continue; Siri App Intent invocation requires an Apple Developer Program team.
- The former sample endpoint and sample media are not production assets and are intentionally excluded from the product plan.
- `docker compose up --build` verified the new backend on 2026-09-05: `/health` returns 200, `애플` resolves to `apple`, PostgreSQL stores two seed entries, OpenSearch indexes two documents, and bundled audio is served from port 8080.
- A physical Watch must call the Mac's LAN address during local development, never `localhost`.

## Active task

`TASKS/MVP-001-watch-to-api.md`: complete and verify the clean Kotlin/Spring AI backend contract, then migrate the Apple PoC into its product repository and point it to that contract.

## Next action

Run the Docker Compose API and index checks, push the new repository, then create `talkievoca-apple` and migrate the existing Watch PoC deliberately.

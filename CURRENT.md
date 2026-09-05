# Current State

Updated: 2026-09-05
Owner: product

## Product goal

On Apple Watch, a user speaks or enters an English word. The app requests feedback from TalkieVoca Backend, presents Korean meaning/example, and plays the matching audio.

## Repository state

- `talkievoca-apple`: not created yet. Existing Watch PoC remains at the workspace root and must be migrated deliberately.
- `talkievoca-backend`: not created yet. It will be a new FastAPI project, not a fork or runtime use of `ragBaseSample`.
- `_control`: initialized as an independent Git repository on 2026-09-05.

## Confirmed PoC facts

- Physical Apple Watch dictation receives spoken input; simulator dictation is not a reliable acceptance environment.
- A Personal Team cannot provision the Siri capability. Physical app and dictation testing can continue; Siri App Intent invocation requires an Apple Developer Program team.
- The former sample endpoint and sample media are not production assets and are intentionally excluded from the product plan.

## Active task

`TASKS/MVP-001-watch-to-api.md`: create a clean FastAPI backend contract first, then migrate the Apple PoC into its product repository and point it to that contract.

## Next action

Create `talkievoca-backend` as a new Git repository with a minimal health endpoint and the watch feedback API contract defined in MVP-001.

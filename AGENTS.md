# Agent Operating Contract

## Mandatory reading order

Read `CURRENT.md`, `CONSTITUTION.md`, the assigned task in `TASKS/`, and relevant accepted ADRs before changing code.

## Ownership

- `talkievoca-apple`: iOS, watchOS, App Intents, watch UI, on-device audio playback.
- `talkievoca-backend`: Kotlin + Spring AI, vocabulary data, RAG, AI providers, media storage and delivery.
- `_control`: only cross-repository decisions, task contracts, runbooks, and agent rules.
- `ragBaseSample`: out of scope. Do not copy it into a product repository and do not make product changes there.

## Work rules

- One task gets one owner and one worktree. Do not edit the same product files from two agents.
- A task must name its owning repository, API contract impact, and acceptance check.
- Keep API contracts backward compatible during a task. Coordinate a breaking change through an accepted ADR first.
- Do not place API keys, personal device IDs, recorded user audio, or production media in Git.
- Use existing platform facilities before adding dependencies. Do not add a framework merely for future flexibility.

## Memory discipline

- `CURRENT.md` is a concise snapshot, not a diary. Replace completed facts; keep it under 120 lines.
- ADRs are append-only decisions. Never rewrite an accepted decision to hide history; supersede it with a new ADR.
- Record a meaningful change to this control system in `CHANGELOG.md` in the same commit.
- Before handoff, state what changed, how it was verified, and the single next action in `CURRENT.md`.

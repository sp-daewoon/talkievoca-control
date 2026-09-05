# TalkieVoca Constitution

Version: 1.0.0

## 1. Product boundary

TalkieVoca is the product. `ragBaseSample` is not its backend, dependency, source tree, or delivery path. Product code exists only in `talkievoca-apple` and `talkievoca-backend`.

## 2. Source of truth

- Product behavior: committed code and tested API contracts.
- Current operational context: `CURRENT.md`.
- Durable architectural decisions: accepted ADRs in `DECISIONS/`.
- Planned work and acceptance conditions: `TASKS/`.

When these conflict, accepted ADRs override task notes; tested code overrides stale prose. Correct the stale document in the same change.

## 3. Repository sovereignty

Each product repository is independently buildable, testable, deployable, and releasable. `_control` never imports product code. Product repositories never depend on `_control` at runtime.

## 4. API-first integration

The Apple app and backend communicate only through versioned HTTP contracts. The backend owns vocabulary lookup, RAG retrieval, AI calls, media metadata, and server-side secrets. The Apple app owns presentation, voice/text capture, request retries, and local playback.

## 5. Privacy and secrets

Do not commit credentials, device identifiers, user recordings, access tokens, or private endpoints. Use local ignored environment files for development. Logs must not contain authorization headers or raw credentials.

## 6. Change discipline

Any irreversible, cross-repository, security, data-model, or API-breaking choice requires a new ADR before implementation. ADRs are immutable after acceptance; later choices supersede earlier ADRs.

## 7. Definition of done

A change is done only when its stated acceptance check passes, the affected repository remains buildable, and `CURRENT.md` accurately names the next action. "It compiled once" is not an end-to-end verification.

## Amendment process

Change this constitution through a new ADR that states the old rule, the new rule, migration effect, and approval. Update this file's version only after that ADR is accepted.

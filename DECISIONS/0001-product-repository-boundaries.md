# ADR 0001: Product Repository Boundaries

Status: Accepted
Date: 2026-09-05

## Context

The Watch proof of concept temporarily called a learning project named `ragBaseSample`. That project is not a product backend and must not define TalkieVoca's architecture or deployment path.

## Decision

TalkieVoca has two independent product repositories:

- `talkievoca-apple`: iOS and watchOS app.
- `talkievoca-backend`: FastAPI, AI/RAG runtime, vocabulary data, and media delivery.

`_control` is a third, independent repository for cross-repository operating memory. `ragBaseSample` has no role in the product workspace.

## Consequences

- The existing Watch PoC is migrated or copied into `talkievoca-apple` only after the destination repository is initialized.
- Backend behavior is recreated intentionally in `talkievoca-backend`; no runtime dependency, Git submodule, or copied history from `ragBaseSample` is used.
- Cross-repository rules and decisions survive agent/session changes in `_control`.

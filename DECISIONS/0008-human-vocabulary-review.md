# ADR 0008: Human Vocabulary Review

Status: Accepted
Date: 2026-09-06

## Context

The SLM resolved the Korean query `오징어` to `octopus`, cached the card as `slm/pending`, and attached the Korean alias to that incorrect English word. Pending isolation kept the mistake out of the trusted OpenSearch vocabulary index, but there was no product-owned way to inspect, correct, approve, or reject generated cards.

## Decision

- Serve a small operator UI from the backend at `/admin/`; it has no separate frontend runtime or repository.
- List vocabulary by `pending`, `trusted`, or `all` status through a versioned admin API.
- A correction replaces the headword, Korean meaning, examples, and complete alias set in one PostgreSQL transaction.
- Corrected cards use `origin=manual` and `verification_status=trusted`.
- The corrected trusted card is indexed in OpenSearch after the database transaction. An OpenSearch failure is logged and does not roll back the PostgreSQL source of truth.
- Rejection deletes only `pending` cards. A card with attached pronunciation audio cannot be renamed or removed through this workflow.
- The admin surface is local-MVP infrastructure. It must receive authentication and HTTPS before the backend is exposed outside the private development network.

## Consequences

- SLM mistakes can be repaired without direct SQL or a service restart.
- Incorrect query aliases are removed instead of remaining as hidden stale routes.
- PostgreSQL remains authoritative when an index refresh fails; startup indexing can rebuild trusted vocabulary documents.
- Public deployment is blocked on admin authentication even though the personal LAN deployment remains simple.

# ADR 0003: Kotlin Spring AI Backend

Status: Accepted
Date: 2026-09-05
Supersedes: ADR 0001

## Context

The product needs a clean backend repository, but the backend technology must match the team's preference and existing working experience: Kotlin with Spring AI. The earlier FastAPI choice was only provisional.

## Decision

TalkieVoca has two independent product repositories:

- `talkievoca-apple`: iOS and watchOS app.
- `talkievoca-backend`: Kotlin, Spring Boot, Spring AI, vocabulary data, RAG, and media delivery.

The first backend endpoint uses in-memory seed data to prove the Watch-to-API contract. RAG, database, model provider, and media storage are introduced only when their own acceptance task requires them.

## Consequences

- `ragBaseSample` remains outside the product architecture and receives no product changes.
- Spring AI's dependency management is established from day one, while external AI credentials are unnecessary for the first API.
- The next task may add a content ingestion and media-storage boundary without changing the Watch API.

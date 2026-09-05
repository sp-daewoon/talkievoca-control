# ADR 0004: Local Container Stack

Status: Accepted
Date: 2026-09-05

## Decision

`talkievoca-backend` uses one Docker Compose stack with three services: the Kotlin application on port 8080, PostgreSQL as the source of truth, and OpenSearch as the retrieval index. The application waits for both dependencies to become healthy before starting.

## Consequences

- Local development and future CI use `docker compose up --build` as the first end-to-end check.
- PostgreSQL data and OpenSearch indexes persist in named Docker volumes and are removed only by `docker compose down -v`.
- The initial word-feedback endpoint reads PostgreSQL exactly; OpenSearch is populated at startup for later retrieval expansion.

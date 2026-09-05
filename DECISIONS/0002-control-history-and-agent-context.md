# ADR 0002: Control History and Agent Context

Status: Accepted
Date: 2026-09-05

## Context

Multiple agents and worktrees need shared context without repeatedly loading large, stale conversation histories. Important decisions must remain auditable when the control system itself changes.

## Decision

`_control` is a Git repository with three layers:

- `CURRENT.md`: compact present-tense snapshot and next action.
- `DECISIONS/`: append-only ADR history for durable choices.
- `TASKS/`: executable, temporary work contracts with acceptance checks.

Every material `_control` change is committed and recorded in `CHANGELOG.md`. Accepted ADRs are not rewritten; a later ADR supersedes them.

## Consequences

- New agents can load `CURRENT.md` first and read only relevant ADRs/tasks.
- Git log is the authoritative revision history for the control system.
- There is no separate "AI memory database" to maintain or synchronize.

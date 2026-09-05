# Runbook

## Daily agent start

1. Read the files listed in `AGENTS.md`.
2. Run `./scripts/verify-control.sh` from `_control`.
3. Open only the repository named by the assigned task.
4. Create or select one worktree for that task.

## Daily handoff

1. Run the task acceptance check.
2. Update `CURRENT.md` with tested facts and one next action.
3. Add a `CHANGELOG.md` entry when `_control` rules, ADRs, or task contracts changed.
4. Commit the product work and control update separately unless they are inseparable.

## New decision

1. Copy the smallest ADR structure from an existing decision.
2. Assign the next zero-padded number.
3. Set status to `Proposed`.
4. After agreement, change only status to `Accepted` and add the acceptance date.
5. If replacing a decision, create a new ADR with `Supersedes`; do not edit history.

## New task

Create `TASKS/<id>-<short-name>.md` with owner repository, scope, non-goals, API impact, acceptance checks, and handoff notes. Delete it only after its useful history has been incorporated into `CURRENT.md` or an ADR.

## Content data

Run uploads through the backend API, never by copying files into source directories. `docker compose down` preserves PostgreSQL, OpenSearch, media, and Qwen model caches; `docker compose down -v` permanently removes every local data and model volume.

The first Qwen start may spend several minutes downloading Qwen3-ASR-0.6B. During that time `/health` may report `asr=unavailable` while text lookup remains usable. Do not delete or recreate the Qwen cache volume unless the logs identify an incomplete model download.

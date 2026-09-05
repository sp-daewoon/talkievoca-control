#!/usr/bin/env bash
set -euo pipefail

required=(README.md AGENTS.md CONSTITUTION.md CURRENT.md CONVENTIONS.md RUNBOOK.md CHANGELOG.md DECISIONS/0001-product-repository-boundaries.md DECISIONS/0002-control-history-and-agent-context.md TASKS/MVP-001-watch-to-api.md)

for path in "${required[@]}"; do
  [[ -f "$path" ]] || { echo "missing: $path"; exit 1; }
done

for path in DECISIONS/*.md; do
  rg -q '^Status: (Proposed|Accepted|Superseded|Rejected)$' "$path" || { echo "invalid ADR status: $path"; exit 1; }
done

echo "control verification passed"

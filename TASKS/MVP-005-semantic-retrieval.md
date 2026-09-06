# MVP-005: Semantic Retrieval

Status: Complete
Owner repository: `talkievoca-backend`

Add meaning/question embeddings, reviewed question editing, semantic retrieval before generation, and explicit rebuild/inspection APIs. Preserve Apple API responses. Verify actual local Ollama and OpenSearch, pending exclusion, stale-content rejection, and regression tests.

## Expanded Scope

Owner: backend, with control documentation updates only. Apple code is unchanged.
Add administrator PDF upload/source listing, bounded PDF-to-pending vocabulary extraction, manual card registration, MP3 attachment/preview and source-link preservation (ADR 0010).

## API Impact

Add source-list/extraction and admin semantic-search/rebuild endpoints. Add optional reviewed questions to corrections; old clients omitting questions preserve existing ones. Empty original_word creates a card without overwriting an existing word. Existing Watch DTOs remain unchanged.

## Acceptance Evidence

- Real Ollama bge-m3 vectors stored in OpenSearch, 1024 dimensions, cosine search retrieves squid for a Korean paraphrase.
- Real PDF persisted and extracted by local qwen3:4b into squid, green, lantern; only new cards become pending.
- Browser forms upload real PDF/MP3; uploaded audio decoded; semantic results visible. 1440/390/320 px checks passed with no JavaScript errors.
- Regression tests cover source links on rename, reviewed questions, creation collisions, PDF overlap/persistence, pending exclusion and stale vector rejection.
- README and architecture cover source-of-truth, model/index contract, operator workflow and explicit limits.
- Final `./gradlew test`: 17 passed, 0 failed/skipped. Docker rebuild passed; actual reindex indexed=5/failed=0. Watch feedback endpoint returns uploaded MP3 URL. `_control/scripts/verify-control.sh` passed.

Physical Watch playback of newly uploaded media, large-corpus latency and general retrieval accuracy are not claimed by this task's browser/provider checks.

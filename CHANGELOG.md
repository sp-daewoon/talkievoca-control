# Control Changelog

All notable changes to the TalkieVoca control system are recorded here.

## 2026-09-06

- Added ADR 0008 and MVP-004 for human review of generated vocabulary and smoother Watch recording/playback.
- Recorded the local `/admin/` workflow, transactional alias replacement, `manual/trusted` provenance, and public-deployment authentication boundary.
- Corrected the actual `오징어 -> octopus` pending cache to `오징어 -> squid` through the new operator API.
- Replaced fixed three-second Watch recording with silence/manual/maximum-duration completion and added pronunciation audio reuse.
- Built, signed, and installed the MVP-004 app on the paired Apple Watch Ultra 2; launch awaits Watch unlock.

## 2026-09-05

- Replaced the planned remote-only Qwen path with a verified pinned ARM64 Rust CPU service, then replaced its 6.2 GiB full server with a single-model adapter that settles near 2.1 GiB while preserving official CUDA/vLLM as the production-compatible option.
- Reworked the control README as the product documentation hub and added a standalone architecture page covering the BPMN user journey, runtime boundaries, resolver order, data provenance, deployment, and API contracts.
- Recorded the implemented Qwen audio contract, Ollama pending-cache behavior, trusted-index isolation, Watch recorder/playback build, and remaining hardware acceptance.
- Added ADR 0007 and MVP-003 for hybrid native/Qwen voice input, RAG-assisted Ollama fallback, pending generated-data provenance, and on-device example speech.
- Added ADR 0006 for the unified assistant API, one-input Watch flow, future ASR/provider boundary, and trusted-RAG ingestion rule.
- Recorded the independent Apple repository migration and simulator/backend verification state.
- Corrected the backend ownership stack in the agent operating contract to Kotlin + Spring AI.
- Completed and verified MVP-002 with real PDF ingestion, OpenSearch retrieval, audio upload, media streaming, and a versioned OpenSearch index mapping.
- Added ADR 0005 and MVP-002 for actual PDF/audio ingestion and searchable persistence.
- Recorded the verified PostgreSQL, OpenSearch, API, and bundled-audio Compose check.
- Added the PostgreSQL and OpenSearch Docker Compose architecture in ADR 0004.
- Superseded the provisional FastAPI choice with Kotlin + Spring AI in ADR 0003.
- Initialized the independent `_control` Git repository.
- Defined product-repository boundaries and excluded `ragBaseSample` from product delivery.
- Added constitution, ADR process, conventions, runbook, and initial MVP task contract.

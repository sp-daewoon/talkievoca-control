# ADR 0010: Operator Content Ingestion

Status: Accepted
Date: 2026-09-06

## Context

Upload APIs existed but the administrator could not register PDFs/audio through the product UI. Ingestion must preserve provenance and keep generated translations out of trusted retrieval until review.

## Decision

- Add PDF upload/source list and explicit vocabulary extraction to the existing backend-served admin, with no additional frontend service.
- Store PDF originals and extracted text before optional SLM extraction. Split retrieval text into 1600-character windows with 200-character overlap. No OCR in this MVP.
- Bound synchronous extraction to the first 12000 characters and at most 20 source-present English terms. Report truncation; never claim a full-document vocabulary import when bounded.
- Keep existing cards unchanged; save new cards as slm/pending and retain word/source links. Corrections preserve those links. Repeated extraction is idempotent per word/source, not an assertion that model output is deterministic.
- Let operators create a card manually, approve meaning/questions, and attach MP3/M4A/WAV/AAC pronunciation to an existing word. Audio bytes are media, not embeddings. Example playback remains Watch TTS.
- Expose semantic candidate inspection and explicit rebuild counts, following ADR 0009. Similarity is not correctness; approved vocabulary and uploaded PDF references have different trust semantics.
- Preserve Apple HTTP response contracts. Restrict the unauthenticated admin to the private MVP network. Large-volume background import, OCR, authentication, and retrieval quality evaluation are explicit follow-up work.

## Verification

Exercise real PDF and MP3 uploads through browser forms, PDF-to-pending extraction through the live SLM, media decoding, actual 1024-dimensional OpenSearch vectors, and responsive UI. Unit tests with provider stubs are reported separately from real integrations. Do not equate browser media decoding with physical Watch playback acceptance.

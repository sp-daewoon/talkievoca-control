# MVP-002: Knowledge And Media Ingestion

Status: Completed
Owner repository: `talkievoca-backend`

## Outcome

An operator can upload a PDF and retrieve its extracted text through the backend. An operator can upload an audio file for an existing word, and the Watch feedback response returns that uploaded audio URL.

## Acceptance checks

- Upload a PDF with `POST /v1/knowledge/pdf`; PostgreSQL stores the source and one or more chunks.
- `GET /v1/knowledge/search?q=<known PDF text>` returns the uploaded source.
- Upload audio with `POST /v1/media/audio?word=apple`.
- `GET /v1/watch/word-feedback?word=apple` returns the uploaded `/v1/media/<id>` URL.
- Fetching that URL returns the uploaded audio content.

## Non-goals

- OCR for scanned PDFs.
- Vector embeddings, semantic ranking, LLM answer generation, user access control, or a content management UI.

Completed on 2026-09-05 with a real PDF upload, OpenSearch retrieval, M4A upload, vocabulary audio replacement, and media streaming check.

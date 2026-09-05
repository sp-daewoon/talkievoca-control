# ADR 0005: Content Ingestion and Media Storage

Status: Accepted
Date: 2026-09-05

## Decision

The backend accepts PDFs and audio files directly. Raw files live in the Docker `media_data` volume, not Git. PostgreSQL stores source/media metadata, extracted PDF text, chunks, and the vocabulary-to-audio link. OpenSearch indexes PDF chunks for retrieval.

## API

- `POST /v1/knowledge/pdf`: upload a PDF, extract text, persist chunks, and index them.
- `GET /v1/knowledge/search?q=`: search indexed PDF chunks.
- `POST /v1/media/audio?word=`: upload audio and replace that word's playback URL.
- `GET /v1/media/{media_id}`: stream uploaded audio.

## Consequences

- Backups must include PostgreSQL plus the `media_data` Docker volume.
- The first retrieval is OpenSearch text retrieval, not vector RAG. Embeddings and LLM answering require a later ADR and migration.
- OpenSearch index names are versioned. A mapping change creates a new index version and a reindex task, rather than mutating a live index mapping.
- Uploaded files must not be committed to Git or placed in source resources.

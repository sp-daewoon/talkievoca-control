# ADR 0009: Meaning and Question Embeddings

Status: Accepted
Date: 2026-09-06

## Context

The existing retrieval implementation performs SQL exact/alias lookup and PDF lexical search only. No embeddings exist, and indexed trusted vocabulary is not retrieved by the assistant.

## Decision

- Keep exact/alias lookup first. Embed Korean meanings, bilingual example context, and operator-reviewed question expressions, never a bare headword as the document.
- Store question expressions separately from exact aliases in PostgreSQL and edit them during vocabulary review.
- Use Ollama bge-m3 (1024 dimensions) for both documents and queries in a dedicated versioned OpenSearch index. Store model and input text alongside each vector.
- Embed uploaded PDF title/content too. Retain lexical PDF retrieval as fallback.
- Retrieve semantic candidates as SLM reference material, not as unconditional nearest-neighbor answers. Pending vocabulary never enters the semantic index.
- Check vocabulary candidates against current PostgreSQL trusted content before returning them, rejecting stale/renamed entries. Rebuild at startup and expose an explicit operator rebuild endpoint.
- Use exact cosine vector search for the personal corpus; move to approximate indexing when corpus size requires it. Embedding errors degrade to lexical/exact lookup, never invalidate an approved database correction.

## Verification

Check real bilingual embedding calls, persisted 1024-dimensional vectors, meaning/question paraphrase retrieval, pending exclusion, and existing API regression tests. Similarity is not a probability of correctness; wider retrieval evaluation is required as the corpus grows.

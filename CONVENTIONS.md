# Conventions

## Universal

- Use UTF-8, LF line endings, four spaces for Python, four spaces for Swift.
- Name source files and identifiers in English. User-facing Korean is allowed.
- Prefer small, direct modules. Do not introduce an abstraction with a single use unless it protects a real boundary.
- Every external boundary validates input and returns a typed error response.
- Format and run the repository's smallest relevant check before handoff.

## Git

- Branch: `<repo>/<task-id>-<short-kebab-case>`.
- Commit: `<scope>: <imperative summary>`; scopes are `apple`, `backend`, `control`, `docs`, `api`.
- One commit may update a product repo and `_control` only when the control-state update describes that same change. Never mix unrelated cleanup.

## Apple

- Swift Concurrency with `async/await`; UI changes stay on `@MainActor`.
- Use `Codable` DTOs at HTTP boundaries. Keep URLSession and API-key handling outside SwiftUI views.
- Test real Watch behavior on physical hardware; use the simulator for layout and manual request flow only.

## Backend

- FastAPI endpoints use Pydantic request/response models and explicit status codes.
- Route handlers remain thin; retrieval and provider calls live in services.
- Vocabulary seed content is versioned text/metadata. Large audio files live in object storage or an ignored local media directory, referenced by stable IDs.
- Return absolute or app-resolvable HTTPS media URLs; never make the Watch infer filesystem paths.

## API

- Prefix public endpoints with `/v1` from the first product endpoint.
- Use `snake_case` JSON keys.
- Success responses are stable objects, never bare strings.
- Error body: `{ "error": { "code": "...", "message": "..." } }`.
- Add fields compatibly. Removal or semantic changes require an ADR and a new API version.

# MVP-001: Watch To Backend Feedback

Status: Ready
Owner repository: `talkievoca-backend` first, then `talkievoca-apple`

## Outcome

An Apple Watch user can submit a word and receive a Korean meaning, example, and audio URL from a clean TalkieVoca Backend API.

## Backend scope

- New Kotlin + Spring Boot + Spring AI repository only.
- `GET /health` returns a stable OK response.
- `GET /v1/watch/word-feedback?word=<text>` validates a nonempty word and returns one typed feedback object.
- Use a minimal versioned seed dataset and bundled pronunciation audio for `apple` and `green`, backed by PostgreSQL and indexed into OpenSearch. No LLM provider call or vector embedding is required in the first endpoint.
- Return `404` for an unknown word and a typed `422` validation response for invalid input.

## Apple scope

- Migrate the existing Watch PoC into `talkievoca-apple`.
- Change its client base URL to the new backend contract.
- Show returned Korean meaning and provide an audio-play action when an `audio_url` exists.

## API contract

```json
{
  "word": "apple",
  "meaning_ko": "사과",
  "example_en": "I ate an apple.",
  "example_ko": "나는 사과를 먹었다.",
  "audio_url": "https://api.example.com/v1/media/apple.mp3"
}
```

## Non-goals

- Siri capability entitlement and paid developer provisioning.
- Pronunciation scoring.
- LLM generation, vector search, authentication, subscriptions, ads, or production media storage.

## Acceptance checks

- `curl /health` returns 200.
- `curl '/v1/watch/word-feedback?word=apple'` returns the contract above with 200.
- `curl '/v1/watch/word-feedback?word=unknown'` returns 404 and the standard error body.
- On physical Watch, a manually entered or dictated word completes one request and renders the returned meaning.

Backend checks completed on 2026-09-05. The remaining acceptance check belongs to `talkievoca-apple`.

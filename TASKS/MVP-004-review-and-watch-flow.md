# MVP-004: Vocabulary Review and Smooth Watch Flow

Status: Hardware Verification
Owner repositories: `talkievoca-backend`, `talkievoca-apple`

## Outcome

The operator can correct generated vocabulary safely, and the primary Watch audio flow no longer waits for a fixed recording duration or overlaps Siri, downloads, and playback unnecessarily.

## Backend scope

- Add list, correction/approval, and pending-rejection APIs.
- Serve a responsive local admin review screen at `/admin/`.
- Persist operator corrections as `manual/trusted` and replace aliases transactionally.
- Index approved cards and cache immutable media responses.

## Apple scope

- Make Qwen original-audio recognition the primary in-app action.
- End recording after a short silence, at five seconds, or when the user taps finish.
- Release the loading state before audio playback and replace old playback cleanly.
- Cache recently downloaded pronunciation audio and avoid duplicate Siri/example speech.

## Acceptance checks

- [x] Backend tests cover pending-list retrieval and `octopus` to `squid` correction with Korean alias replacement.
- [x] `/admin/` is served and visually checked in a desktop browser.
- [x] Actual local data returns `오징어 -> squid` as `manual/trusted`.
- [x] The watchOS simulator SDK build and App Intents metadata extraction succeed.
- [ ] On the physical Watch, Korean and English recordings auto-stop after speech and play one uninterrupted lesson.

## Deferred boundary

Admin authentication and HTTPS are mandatory before any public deployment. They are not added to the private LAN MVP.

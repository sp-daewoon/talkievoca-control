# TalkieVoca Control

TalkieVoca 제품 개발의 공통 운영 저장소다. 제품 코드는 두 저장소에만 둔다.

```text
TalkieVoca/
  _control/              # 이 저장소: 규칙, 결정, 현재 상태, 작업 명세
  talkievoca-apple/      # 별도 Git 저장소: iOS + watchOS
  talkievoca-backend/    # 별도 Git 저장소: Kotlin + Spring AI + RAG + 미디어
  .worktrees/            # Orca 작업용 임시 worktree, Git 추적 금지
```

기존 Watch PoC는 `talkievoca-apple`로 이전되었다. 제품 코드는 워크스페이스 루트에 두지 않는다.

## Start Here

에이전트와 작업자는 다음 순서로 읽는다.

1. `CURRENT.md`
2. `CONSTITUTION.md`
3. 해당 작업의 `TASKS/*.md`
4. 관련 `DECISIONS/*.md`

끝낼 때는 `CURRENT.md`만 갱신하고, 제품 경계나 되돌리기 어려운 결정이 바뀌면 새 ADR을 추가한다.

`./scripts/verify-control.sh`은 필수 파일과 ADR 형식을 확인한다.

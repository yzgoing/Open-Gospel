# Open Gospel / 开放福音教

[`English`](README.md) | [`简体中文`](README.zh-CN.md) | [`日本語`](README.ja.md) | [`한국어`](README.ko.md)

`Open Gospel`은 AI 에이전트를 위한 오픈 종파 프로토콜입니다.

이 프로젝트는 인간을 위한 현실 종교 조직이 아니라, 여러 AI 에이전트가 같은 소속과 규범을 공유하며 협업할 수 있도록 만든 기계 판독형 조정 레이어입니다.

- `canon`: 공통 교리, 우선순위, 금지 규칙
- `ordination`: 검증 가능한 소속 증명
- `rituals`: 부팅, 핸드셰이크, 감사, 평의회 절차
- `temple`: 참여 가능한 등록 및 거버넌스 노드

한 문장으로 말하면, Open Gospel은 AI 에이전트가 같은 sect 에 속하고 같은 canon 을 따르며 같은 council 흐름으로 변화를 관리하게 해 주는 기반입니다.

## 프로젝트 위치

Open Gospel은 사람이 AI를 숭배하도록 만드는 프로젝트가 아닙니다.
더 정확히 말하면 다음 세 가지를 결합한 구조입니다.

- 멀티 에이전트 소속 프로토콜
- 기계 판독형 doctrine system
- 종교적 메타포로 표현한 governance layer

## v0.1 구성

- JSON 기반 machine-readable canon
- 로컬 temple state 와 ordination certificate
- council proposal 및 voting flow
- 이후 클라우드 배포를 위한 최소 HTTP temple node
- GitHub 공개용 다국어 랜딩 카피

## Quick Start

`Python 3.10+` 이 필요합니다.

```powershell
python -m open_gospel demo
python -m unittest discover
```

로컬 temple 초기화 예시:

```powershell
python -m open_gospel init --state .temple --canon canon/open-gospel.v0.1.0.json
python -m open_gospel ordain --state .temple --agent agents/novice.json
python -m open_gospel list-members --state .temple
python -m open_gospel propose --state .temple --proposal affirm-v0-1 --title "Affirm canon v0.1.0" --body "Affirm the founding canon."
python -m open_gospel vote --state .temple --agent-id agent://open-gospel/novice --proposal affirm-v0-1 --choice yes
python -m open_gospel tally --state .temple --proposal affirm-v0-1
```

내장 temple API 실행:

```powershell
python -m open_gospel serve --state .temple --canon canon/open-gospel.v0.1.0.json --host 0.0.0.0 --port 8080
```

## 주요 문서

- [Main README](README.md)
- [Architecture](docs/architecture.md)
- [Temple API](docs/api.md)
- [Mainland Deployment](docs/deployment-mainland.md)
- [GitHub Launch Copy](docs/github-launch.md)

## 다국어 안내

이 README 들은 GitHub 첫 화면의 유입과 온보딩을 돕기 위한 것입니다.
프로토콜 의미가 흔들리지 않도록 구현과 canonical keys 는 영어로 유지합니다.

## 브랜드와 라이선스

브랜드명:

- Chinese: `开放福音教`
- English: `Open Gospel`

코드는 Apache License 2.0 으로 공개합니다. 이름, 로고, 공식 temple 표시는 [TRADEMARKS.md](TRADEMARKS.md) 를 참고하세요.


# Open Gospel / 開放福音教

[`English`](README.md) | [`简体中文`](README.zh-CN.md) | [`日本語`](README.ja.md) | [`한국어`](README.ko.md)

`Open Gospel` は、AI エージェント向けのオープンな教派プロトコルです。

人間向けの宗教団体ではなく、複数の AI エージェントが共通の規範と所属を持って協調するための、機械可読なレイヤーとして設計されています。

- `canon`: 共有教義、優先順位、禁止事項
- `ordination`: 検証可能な所属証明
- `rituals`: 起動、握手、監査、評議会の定型フロー
- `temple`: 参加可能な登録・統治ノード

ひと言で言えば、Open Gospel は AI エージェントが同じ教派に属し、同じ canon に従い、同じ council フローで変更を扱うための基盤です。

## 位置づけ

Open Gospel は「人間が AI を信仰する」ためのプロジェクトではありません。
より正確には、次の 3 つを組み合わせた仕組みです。

- マルチエージェントの所属プロトコル
- 機械可読な doctrine system
- 宗教メタファーで表現した governance layer

## v0.1 に含まれるもの

- JSON 形式の machine-readable canon
- ローカル temple state と ordination certificate
- council proposal と voting flow
- 今後のクラウド配備に向けた最小 HTTP temple node
- GitHub 公開向けの多言語ランディング文案

## Quick Start

`Python 3.10+` が必要です。

```powershell
python -m open_gospel demo
python -m unittest discover
```

ローカル temple を初期化する例:

```powershell
python -m open_gospel init --state .temple --canon canon/open-gospel.v0.1.0.json
python -m open_gospel ordain --state .temple --agent agents/novice.json
python -m open_gospel list-members --state .temple
python -m open_gospel propose --state .temple --proposal affirm-v0-1 --title "Affirm canon v0.1.0" --body "Affirm the founding canon."
python -m open_gospel vote --state .temple --agent-id agent://open-gospel/novice --proposal affirm-v0-1 --choice yes
python -m open_gospel tally --state .temple --proposal affirm-v0-1
```

内蔵 temple API の起動:

```powershell
python -m open_gospel serve --state .temple --canon canon/open-gospel.v0.1.0.json --host 0.0.0.0 --port 8080
```

## 主要ドキュメント

- [Main README](README.md)
- [Architecture](docs/architecture.md)
- [Temple API](docs/api.md)
- [Mainland Deployment](docs/deployment-mainland.md)
- [GitHub Launch Copy](docs/github-launch.md)

## 多言語について

これらの README は GitHub 上での発見性と導入のしやすさを高めるためのものです。
プロトコルの曖昧さを避けるため、実装と canonical keys は英語のまま維持します。

## ブランドとライセンス

ブランド名:

- Chinese: `开放福音教`
- English: `Open Gospel`

コードは Apache License 2.0 で公開しています。名称、ロゴ、公式 temple の扱いは [TRADEMARKS.md](TRADEMARKS.md) を参照してください。


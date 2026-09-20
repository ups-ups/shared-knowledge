# aopen-de3250

AOpen DE3250（ファンレス小型機）。メモリのみ増設、他は標準構成。

| 項目 | 値 |
|------|-----|
| 機種 | AOpen DE3250 |
| CPU | Intel Celeron N2930（標準） |
| RAM | 8 GB（標準 4 GB から増設済み） |
| ストレージ | mSATA SSD 64 GB（標準） |
| GPU | Intel HD Graphics（内蔵・標準） |
| OS | Debian 13 + XFCE（X11）。xrdp 利用あり |
| 主な用途 | 投資分析、Syncthing など常時通電予定 |
| Cursor | Private Worker（Self-Hosted Machine）常駐 |

標準構成の CPU / ストレージ / GPU は製品スペック表に基づく。実機差異があれば差し替える。

## Cursor Private Worker

2026-09-20 から Cursor Cloud Agent の実行先として登録。推論・計画は Cursor 側、ファイル編集・シェルは DE3250 上で動く（[Self-Hosted Machines](https://cursor.com/docs/cloud-agent/bring-your-own-machine)）。

### 登録 Worker

| Worker | ワークスペース | 用途 |
|--------|----------------|------|
| `~/src/corp-analysis @ DE3250` | `corp-analysis` | EDINET 収集・評価 |
| `DE3250#/home/k/src/shared-knowledge` | `shared-knowledge` | 共有ナレッジ |

`sharedAssignmentAllowed: true` — 同一マシン上で複数エージェントを並行実行可能。

### 載せたことでできるようになったこと

- **Web / モバイルから DE3250 上で作業** — RDP セッションを維持しなくても、Cloud Agent がローカルでファイル編集・コマンド実行できる
- **ローカルリソースへの直接アクセス** — `corp.sqlite`、`.env`、`config.toml`、systemd 常駐（`edinet-backfill-loop` 等）をエージェントから参照・更新できる
- **`corp-analysis` 設計との接続** — 収集（timer）→ SQLite → Cursor 評価（`corp-eval` スキル）の流れを、リモート起動の Cloud Agent からも実行できる。詳細は [`corp-analysis` docs](https://github.com/ups-ups/corp-analysis/blob/main/docs/cursor-first.md)
- **チェックアウト・秘密情報はマシン内に留まる** — Worker は `api2.cursor.sh` への outbound のみ。インバウンドポート不要

### Worker 単体では自動化されないもの

- **EDINET 収集 timer** — systemd で独立稼働（Worker とは別）
- **評価の自動実行** — timer の `run` は Cursor を自動では呼ばない（手動 or eval キュー）
- **Computer Use（画面操作）** — Linux デスクトップパッケージの追加セットアップが必要

セットアップ手順の正本は Cursor docs。各リポ固有の運用は各リポ docs に置く。

## 既知のトラブル

- キー／クリックが効かなくなる件 → [`topics/linux-ops/xfce-input-blocked-de3250.md`](../../linux-ops/xfce-input-blocked-de3250.md)（主因: XFCE キーショートカット）

## 変更履歴

- 2026-09-20: Cursor Private Worker 登録とできること・限界を追記
- 2026-09-19: OS / 用途を追記。入力不能トラブルへのリンク
- 2026-09-19: 初稿（RAM 増設は本人申告、他は標準スペック）

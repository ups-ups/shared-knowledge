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

### 登録 Worker（shared-knowledge）

| Worker | ワークスペース | 用途 |
|--------|----------------|------|
| `DE3250`（`--name` なし、cwd が識別子） | `shared-knowledge` | 共有ナレッジ |
| `~/src/corp-analysis @ DE3250` | `corp-analysis` | 投資分析 |

`sharedAssignmentAllowed: true` — 同一マシン上で複数エージェントを並行実行可能。

### 再起動後の起動

2026-10-03 時点の CLI worker は、Cursor のターミナル（`pts/2`）で `agent worker start` したプロセスだった。作業ディレクトリは `/home/k/src/shared-knowledge`。親がターミナルなので再起動で消える。

user systemd の linger は既に有効（`loginctl show-user k -p Linger` が `yes`）。ログイン前でも `default.target` が動くので、同じ起動を unit に載せた。

| ワークスペース | unit | 起動 |
|----------------|------|------|
| `shared-knowledge` | `cursor-my-machines-worker.service` | `agent worker start`（追加フラグなし） |
| `corp-analysis` | `cursor-my-machines-worker-corp-analysis.service` | `agent worker --data-dir ~/.local/share/cursor-agent/workers/corp-analysis --worker-dir /home/k/src/corp-analysis --name '~/src/corp-analysis @ DE3250' start` |

スクリプトは両方とも `~/.local/bin/cursor-my-machines-worker`。正本は [`de3250-cursor-my-machines-worker.sh`](./de3250-cursor-my-machines-worker.sh)、[`de3250-cursor-my-machines-worker.service`](./de3250-cursor-my-machines-worker.service)、[`de3250-cursor-my-machines-worker-corp-analysis.service`](./de3250-cursor-my-machines-worker-corp-analysis.service)。認証は既存の `agent login`（`~/.config/cursor/auth.json`）。unit に鍵は書かない。

入れ直し:

```bash
install -m 755 topics/environments/machines/de3250-cursor-my-machines-worker.sh \
  ~/.local/bin/cursor-my-machines-worker
install -m 644 topics/environments/machines/de3250-cursor-my-machines-worker.service \
  ~/.config/systemd/user/cursor-my-machines-worker.service
install -m 644 topics/environments/machines/de3250-cursor-my-machines-worker-corp-analysis.service \
  ~/.config/systemd/user/cursor-my-machines-worker-corp-analysis.service
systemctl --user daemon-reload
systemctl --user enable --now cursor-my-machines-worker.service
systemctl --user enable --now cursor-my-machines-worker-corp-analysis.service
```

そのワークスペースの worker が既にいるときはスクリプトが終了を待ち、終わってから引き取る。導入時に動いているプロセスは止めない。確認は `systemctl --user status 'cursor-my-machines-worker*'` と `journalctl --user -u cursor-my-machines-worker-corp-analysis.service`。

Cursor アプリで corp-analysis を開くと、アプリが別 data dir でもう一つ worker を起動することがある。再起動後に常駐するのは systemd 側。

### Cursor アプリとターミナル

どちらも My Machines の `agent worker start`。Cloud Agent から見たファイル編集、シェル、そのマシン上のツールは同じ。Computer Use とデスクトップ共有は、アプリ起動にもターミナル起動にも付いていない。

アプリ起動が足しているのは、ウィンドウが worker の状態を見るローカルソケット（`--worker-api-socket`）とラベル、表示名。systemd はソケットとラベルを付けない。表示名だけ、アプリと同じ `~/src/corp-analysis @ DE3250` に揃える。

### 載せたことでできるようになったこと

- **Web / モバイルから DE3250 上で作業** — RDP セッションを維持しなくても、Cloud Agent がローカルでファイル編集・コマンド実行できる
- **チェックアウト・秘密情報はマシン内に留まる** — Worker は `api2.cursor.sh` への outbound のみ。インバウンドポート不要

### Worker 単体では自動化されないもの

- **Computer Use（画面操作）** — Linux デスクトップパッケージの追加セットアップが必要

セットアップ手順の正本は Cursor docs。

### OpenClaw との関係

常時 AI 秘書・チャットアプリ連携は [OpenClaw](../../openclaw/README.md) で代替可能だが、2026-09-22 時点では Worker + cron で十分と判断し導入見送り。再検討条件はそちらに記載。

## Syncthing

自宅 LAN のファイル共有ハブ。ROM・セーブは USB-HDD 上のマスターから同期。コードは GitHub 管理のため Syncthing 対象外。

- 運用方針: [`topics/syncthing/README.md`](../../syncthing/README.md)
- マスター置き場: `/media/k/usb-hdd/sync/games/`（USB-HDD、fstab マウント）
- Windows からの出し入れ: SMB 共有 `\\DE3250\sync`

## 既知のトラブル

- キー／クリックが効かなくなる件 → [`topics/linux-ops/xfce-input-blocked-de3250.md`](../../linux-ops/xfce-input-blocked-de3250.md)（主因: XFCE キーショートカット）

## 変更履歴

- 2026-10-03: corp-analysis の My Machines worker も同じ user systemd で戻す
- 2026-10-03: shared-knowledge の My Machines worker を user systemd で再起動後に戻す
- 2026-09-21: Syncthing 導入（USB-HDD マスター、運用方針ドキュメント）
- 2026-09-21: Private Worker 節から他リポへのリンク・詳細を除去（shared-knowledge 向けに整理）
- 2026-09-20: Cursor Private Worker 登録とできること・限界を追記
- 2026-09-19: OS / 用途を追記。入力不能トラブルへのリンク
- 2026-09-19: 初稿（RAM 増設は本人申告、他は標準スペック）

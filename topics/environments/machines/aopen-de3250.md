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

標準構成の CPU / ストレージ / GPU は製品スペック表に基づく。実機差異があれば差し替える。

## 既知のトラブル

- キー／クリックが効かなくなる件 → [`topics/linux-ops/xfce-input-blocked-de3250.md`](../../linux-ops/xfce-input-blocked-de3250.md)（主因: XFCE キーショートカット）

## 変更履歴

- 2026-09-19: OS / 用途を追記。入力不能トラブルへのリンク
- 2026-09-19: 初稿（RAM 増設は本人申告、他は標準スペック）

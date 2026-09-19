# desk-win

日常の Windows デスクトップ。ローカル ComfyUI の既定ホスト。

| 項目 | 値 |
|------|-----|
| OS | Windows 11 |
| CPU | Intel（Family 6 Model 151） |
| RAM | ~64 GB |
| GPU | NVIDIA GeForce RTX 3050 OEM / 8 GB VRAM |
| 主な用途 | 開発、ローカル画像生成（ComfyUI） |

## 実行上の目安

- 画像生成（現行の小さめモデル）: ローカルで可
- 動画生成（ローカル拡散）: 8 GB 帯では遅い／非現実的になりやすい → クラウドや partner API を検討
- VRAM は他プロセスと共有。重い生成前は空きを確認する

## 変更履歴

- 2026-09-19: 初稿（Comfy MCP の hardware スナップショットから）

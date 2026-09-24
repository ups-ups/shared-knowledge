# OpenClaw 導入判断メモ

OpenClaw を入れるかどうかの判断材料。再検討時はこのファイルから読み直す。

- **確認日:** 2026-09-22
- **現状の判断:** **導入しない**（Cursor Private Worker + cron で十分）
- **関連マシン:** [`aopen-de3250`](../environments/machines/aopen-de3250.md)

## OpenClaw とは

[OpenClaw](https://docs.openclaw.ai/) は、自前ホストの **AI アシスタント Gateway**。Telegram / Slack / Discord / WhatsApp などのチャットアプリと AI エージェントをつなぎ、cron・Webhook・スキルで自動化する。

- 推論・Gateway・チャンネル接続はローカル（または自前サーバー）で動かす
- モデルは Grok（xAI）や OpenAI などを選べる
- MIT ライセンス、常時起動のデーモン（`openclaw gateway`）

**Cursor との違いは「ファイル操作やスクレイピングができるか」ではない。** 違いは **起動のきっかけと届け先**（IDE 内 vs チャットアプリ・定期実行・Webhook）。

| | Cursor | OpenClaw |
|---|---|---|
| 主な役割 | コーディング用 IDE / Cloud Agent | 常時起動の AI アシスタント基盤 |
| 起動 | 人が IDE / Web / モバイルで依頼 | チャット・cron・Webhook など |
| 届け先 | エディタ・ターミナル | Telegram / Slack / WhatsApp 等 |
| 定期実行 | Automations（cron + AI） | 組み込み cron |
| 向く作業 | コードを読む・書く・テスト | チャンネル横断・通知・運用自動化 |

## 現状の構成（2026-09-22）

一人開発。常時通電マシン `aopen-de3250` に Cursor Private Worker を常駐。

```
DE3250（Celeron N2930 / 8 GB）
├── cron          … 決まった処理（データ取得・バックアップ等）
├── Cursor Worker … AI が必要なとき（ファイル編集・シェル・モバイルから依頼）
└── Syncthing     … 自宅 LAN ファイル共有
```

| やりたいこと | 今の手段 |
|---|---|
| リモートからコード・ファイル操作 | Cursor Private Worker |
| 定期実行（機械的） | cron + シェル / Python |
| AI に判断を任せたい | Cursor Cloud Agent |
| スマホから依頼 | Cursor モバイル / Web |
| GitHub / Slack から起動 | Cursor Automations |
| 投資分析のデータ取得 | cron スクリプト |

詳細: [`aopen-de3250`](../environments/machines/aopen-de3250.md)

## 導入しない理由（2026-09-22）

1. **機能が重複する** — Private Worker + cron + Automations で OpenClaw の主用途をほぼカバー済み
2. **リソースが足りない** — DE3250 は 8 GB / Celeron。Worker + Syncthing 常駐に OpenClaw Gateway（Node 常駐）を足すのは割に合わない
3. **一人開発** — マルチチャンネルボット・チーム向けルーティングの需要が薄い
4. **Grok 目的だけでは不要** — Cursor Pro のモデルピッカー、または cron + xAI API 直叩きで代替可能

### 役割分担の原則

- **cron** = 決まった処理（安い・速い・壊れにくい）
- **Cursor** = 判断が要る処理（柔軟だがトークン代がかかる）
- **OpenClaw** = 上記に加えて「チャットアプリ経由の常時秘書」が欲しいとき

## 再検討トリガー

次のいずれかが **具体的に欲しくなったら** この判断を見直す。

| トリガー | OpenClaw が活きる理由 |
|---|---|
| Telegram / WhatsApp から常時 Grok と会話したい | チャンネル連携が OpenClaw の本丸 |
| Cursor クラウド推論も避けたい（完全自前） | Gateway + ローカル実行で推論先を自分で選べる |
| 複数チャンネルに応答する運用ハブが欲しい | マルチチャンネル・マルチエージェントルーティング |
| Grok の `x_search` をチャットボット化したい | xAI プラグインで `web_search` / `x_search` が組み込み |
| Cursor Automations の枠・コストが合わない | 自前 cron + 任意モデルで運用コストを分離 |

**再検討しない方がよいケース:**

- 「ファイル操作や Web スクレイピングができるか」だけが理由 → Cursor で足りる
- 「Grok を使いたい」だけが理由 → Cursor Pro または xAI API 直叩きを先に試す
- DE3250 の RAM が 8 GB のまま → 別マシンまたはメモリ増設を先に検討

## Grok / xAI の選択肢（OpenClaw 以外）

| 手段 | 契約 | 向く用途 |
|---|---|---|
| Cursor Pro の Grok | Cursor 契約 | IDE 内のコーディング・分析 |
| xAI API（[console.x.ai](https://console.x.ai/home)） | 従量課金（プリペイド） | cron スクリプトからの定期レポート |
| SuperGrok OAuth + OpenClaw | SuperGrok / X Premium | チャットアプリ経由の常時アシスタント |

Cursor Pro と xAI API / SuperGrok は **別契約**。OpenClaw 経由でも xAI 側の契約は別途必要（OAuth なら SuperGrok、API キーなら console.x.ai）。

## 導入する場合のクイックリファレンス

判断を覆して導入するときの最短手順。正本は [OpenClaw docs](https://docs.openclaw.ai/providers/xai)。

### 認証（2 択）

**A. OAuth（SuperGrok / X Premium がある場合・推奨）**

```bash
openclaw onboard --install-daemon --auth-choice xai-oauth
# 既存インストールへの追加:
openclaw models auth login --provider xai --method oauth
openclaw models set xai/auto
```

**B. API キー（console.x.ai）**

```bash
export XAI_API_KEY=xai-...
openclaw models auth login --provider xai --method api-key
openclaw models set xai/grok-4.6
```

キーは `~/.openclaw/.env` に置ける。API キー経路のデフォルトモデルは `grok-4.3`（地域制限の安全策）。

### 載せ先の候補

| マシン | 可否 | 備考 |
|---|---|---|
| `aopen-de3250` | △ | Worker + Syncthing 常駐。8 GB では Gateway 追加は厳しい |
| `desk-win` | ○ | 64 GB。常時起動しないなら手動起動でも可 |
| 別 VPS | ○ | 常時秘書用途ならクラウド VM の方が Worker と分離しやすい |

### OpenClaw が Cursor にないもの

- Telegram / WhatsApp / Signal 等へのネイティブ配信
- チャンネルごとのエージェント分離（仕事用 / 個人用）
- iOS / Android ノード（カメラ・画面・音声）
- ClawHub スキル・プラグイン市場
- 推論ループを自前ホストに完全保持（Cursor クラウドを経由しない）

### OpenClaw にないもの（Cursor 側の強み）

- IDE 統合（diff 表示・インライン編集）
- リポジトリ横断の深いコード理解
- Private Worker による「推論はクラウド・実行は自宅マシン」の分離
- GitHub PR / CI 連携の開発ワークフロー

## 参考リンク

- [OpenClaw 公式](https://docs.openclaw.ai/)
- [OpenClaw xAI プロバイダ](https://docs.openclaw.ai/providers/xai)
- [Cursor Self-Hosted Machines](https://cursor.com/docs/cloud-agent/bring-your-own-machine)
- [Cursor Automations](https://cursor.com/docs/cloud-agent/automations)
- [xAI API 料金](https://x.ai/api)

## 変更履歴

- 2026-09-22: 初稿（導入見送り判断、再検討トリガー、Grok 選択肢、導入時クイックリファレンス）

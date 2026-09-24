# 携帯ゲーム機のカスタムファーム

Anbernic RG35XX H と MANGMI Air X は別系統。イメージの使い回しはできない。

- **確認日:** 2026-09-24
- **RG35XX H:** Allwinner H700（Cortex-A53 4 コア 1.4 GHz / Mali-G31）、3.5 インチ 640×480、1 GB LPDDR4、eMMC なし、2.4/5 GHz Wi-Fi + Bluetooth。OS は Linux。
- **Air X:** Qualcomm Snapdragon 662（SM6115）。OS の土台は Android。シリアル先頭が `MQ65` / `MQ66` でハード改訂が分かれる（GammaOS のリリースノートは 3 改訂に触れている）。

自宅 LAN の ROM / セーブ同期は [`../syncthing/README.md`](../syncthing/README.md)。

## 系統

| 名前 | 中身 | 向くハード |
|------|------|------------|
| **muOS**（MustardOS） | 独自 UI の軽量 Linux。RetroArch 寄り | H700 の XX 系など。Air X には無い |
| **Knulli** | Batocera フォーク。EmulationStation | RG35XX H は公式。Air X は [対応表](https://knulli.org/devices/) に無い |
| **ROCKNIX** | JELOS の後継。EmulationStation + Sway | 両方に公式デバイスページがある |
| **GammaOS Next** | Android 14 / LineageOS 21 | Air X のみ。RG35XX H は Android 機ではない |
| **Batocera 本家** | Knulli の上流 | H700 はドライバのライセンスが GPL と合わず、本家には入っていない。XX 系の旧ベータの後継が Knulli |
| **純正** | Anbernic Linux / Mangmi Android | それぞれの出荷 OS |

Knulli が分かれた理由は、H700 の GPU / ディスプレイ用クローズドドライバを Batocera のライセンスのまま同梱できないため（[Knulli FAQ](https://knulli.org/faq/knulli/)）。

## RG35XX H

GammaOS は対象外。候補は muOS、Knulli、ROCKNIX、純正。

| | muOS | Knulli | ROCKNIX | 純正 |
|--|------|--------|---------|------|
| カーネル / GPU | デバイス向けビルド（コミュニティの主流） | Allwinner BSP 4.9.170 / Mali | Mainline / Panfrost（GL 3.1 / GLES 3.1） | Anbernic BSP |
| UI | 独自。軽い | EmulationStation。箱絵・スクレイプ向き | EmulationStation。Knulli に近い | メニューが多い |
| 導入 | SD に焼く。機種コードネームを取り違えない | 機種名のイメージ（`knulli-h700-rg35xx-h`） | `H700` イメージに加え、DTB を ROCKNIX パーティション直下へ `dtb.img` として置く | 出荷状態 |
| PortMaster | 入っている（2025-10 時点の公式クイックスタート） | ある | 系統としてある | 期待しない |
| 更新 | イメージ差し替えが中心 | 本体から OTA しやすい | イメージ更新 | 増分更新は弱い |
| スリープ | ある。充電状態の変化で起きる報告がある（2026-08、2601 Jacaranda） | 電源短押しのサスペンドを公式機能として記載 | **Fake suspend**（ハードのサスペンドではない） | 機種による |

### 向き

- **すぐ起動してレトロだけ:** muOS。UI が ES より薄く、RetroArch の設定がフロントエンドに上書きされにくい、という利用報告が多い。
- **箱絵つきの据え置き機っぽい画面、Bluetooth、HDMI、スクレイプ:** Knulli。公式機能は Wi-Fi、Bluetooth、サスペンド、HDMI。
- **Mainline と Panfrost、ES のまま OC（設定上 1.5 GHz）:** ROCKNIX。H700 では画面リビジョン違いで DTB が 2 種（`sun50i-h700-anbernic-rg35xx-h.dtb` と `...-rev6-panel.dtb`）。ゴミ表示なら電源長押しで切り、もう一方を試す（[H700 導入](https://rocknix.org/configure/h700-installation/)）。

### 弱み

- **muOS:** 新しいビルドは起動が遅い、という報告がある（例: 40–50 秒。古い AW Banana は同じカードで約 12 秒、という 1 件）。Bluetooth はアプリ経由で、コントローラー相性の報告がある。
- **Knulli:** 起動は muOS より長い、という比較が多い。ES が RetroArch / PPSSPP の設定を戻すことがあり、セーブとステートを同じフォルダに置くため、他機の Syncthing とフォルダを分けないと混ざる（手元の比較メモ、2025 年中頃の利用報告）。H700 は WPA2+WPA3 混在の Wi-Fi を非対応。WPA2 にする（[Networking](https://knulli.org/configure/networking/)）。
- **ROCKNIX:** サスペンドは Fake suspend。画面オフとプロセス凍結とコア駐車で、本物の S3 ではない。未使用時の自動電源断は既定 0 分（すぐ切る）。ゲーム中は既定 15 分。HDMI 接続中はサスペンドしない。H700 実機では不安定・スリープ不能、という短期利用の報告がある。Panfrost のクロック変更でカーネル warning が出る件はメインライン側の話題でもある。
- **純正:** N64 / Saturn がカスタムより良い、という報告と、ボタン片側だけ効かない、UI が使いにくい、という報告が両方ある。

hypothesis: 2026-09-24 — H700 の「スリープでバッテリーが持たない / 充電で起きる」は OS 差というより PMIC 側の制限に寄っている。muOS フォーラムでも OS をまたいで再現する、と書かれている。未検証。

## MANGMI Air X

Knulli の公開デバイス一覧には無い。候補は GammaOS Next、ROCKNIX、純正 Android。ROCKNIX は Android を消さず、SD から Linux を起動する二重ブート。

| | GammaOS Next | ROCKNIX | 純正 Android |
|--|--------------|---------|--------------|
| 土台 | Android 14 / LineageOS 21 | Mainline Linux、Freedreno + Turnip、Sway + ES | 出荷 Android |
| 導入 | Windows の QFIL / EDL。**データは消える**。SN でパッケージが別 | SD に `SM6115` イメージ。Android 上で ABL をバックアップしてから焼く。起動時 Vol− で ABL に入り、機種を MQ65 / MQ66 にして Linux 起動 | 何もしない |
| アプリ | Play ストア（Full）か、Google なし（Lite） | 無い。エミュと PortMaster | 出荷ランチャー + ストア |
| 強み | スタンドアロンエミュ、配信、Android アプリ。ストック比で GPU ドライバ更新、60 Hz 固定、入力遅延とマイクロスタッター低減をうたう | 入力遅延が Android より小さい、という紹介。PortMaster。セーブ配置は ES 系に近い | メーカーサポートの範囲 |

### GammaOS Next（Air X は v1.2.0）

- リリース日 2025-12-14。一般公開は 2026-02-12。リポジトリの対応表は Air X をこの v1.2 のまま指している（他機は 2026-08 の Nano 1.4.1 まで進んでいる）。
- パッケージは **Full**（GApps あり）と **Lite**（Google サービスなし）。開発側の推奨はゲームと電池なら Lite。
- v1.2.0 の記載: 新しい LCD、MQ65 / MQ66 を含む改訂、ストレージ容量表示、ES-DE のテーマ取得、GammaEQ。デバイス向けとして GPU ドライバを 2025 年版に更新（純正は 2024）、Netflix DRM、パネル 60 Hz、ガバナーとサーマル、Lite の電池。
- 既存の GammaOS から v1.2.0 へはデータを残す更新手順がある。初回の QFIL は全消去。
- **既知の未解決（2026-03 の issue）:** Auto ではファンが回らず、Cool / Max の手動が必要（[#272](https://github.com/TheGammaSqueeze/GammaOSNext/issues/272)、open）。3.5 mm ジャックが鳴らない報告が 1.2.0 Lite と「1.2.7」の両方である（[#356](https://github.com/TheGammaSqueeze/GammaOSNext/issues/356)、[#274](https://github.com/TheGammaSqueeze/GammaOSNext/issues/274)）。リリースノートはジャック修正をうたうが、改訂や Lite では残っている。

### ROCKNIX（Air X）

- 公式: [Air X](https://rocknix.org/devices/mangmi/air-x/)。Wi-Fi、Bluetooth（音声とコントローラー）、スティック LED、内部インストール手順、サスペンドは Fake suspend。
- ABL を焼くので、ブートローダは Android 側と共有する。GammaOS 導入済みなら `backup_abl.sh` / `flash_abl.sh` は adb shell で実行する、と wiki にある。
- 2026-06 に stable 対応が告知されている。wiki の導入文は「Latest Nightly の SM6115」と書いているので、落とすファイルはリリース一覧で stable か nightly かを見る。
- GammaOS の上から入れると adb と SD のファイルシステムで詰まる、という 2026-06 の利用報告がある（exFAT 以外でマウントエラー、という 1 件）。性能は Android と大差ないが SD 起動で少し重い、スタンドアロンエミュの初期マッピングが未設定、という報告もある。PortMaster 目的なら選ぶ理由になる。

## 機種をまたぐとき

- H700 用イメージを Air X に焼かない。逆も同じ。Air X の GammaOS も MQ65 と MQ66 を混ぜない。
- ES 系（Knulli / ROCKNIX）は見た目と ROM フォルダが近い。muOS はフォルダ名の自由度が高い。GammaOS の実ファイルは Android のストレージ配下（手元では `/storage/00000000-0000-0000-0000-000000000001/Game`）。
- Syncthing でセーブを混ぜるなら、Knulli はセーブとステートが同一フォルダになりやすい。機種またはエミュごとにサブフォルダを切る。

## 参照

- [Knulli devices](https://knulli.org/devices/) / [RG35XX H](https://knulli.org/devices/anbernic/rg35xx-h/)
- [ROCKNIX RG35XX H](https://rocknix.org/devices/anbernic/rg35xx-h/) / [H700 installation](https://rocknix.org/configure/h700-installation/) / [Fake suspend](https://rocknix.org/configure/fake-suspend/) / [Air X](https://rocknix.org/devices/mangmi/air-x/)
- [GammaOS Next Air X v1.2.0](https://github.com/TheGammaSqueeze/GammaOSNext/releases/tag/v.1.2.0-MANGMIAIRX)
- muOS クイックスタート（PortMaster 同梱の記述）: https://community.muos.dev/t/muos-quick-start-guide/479

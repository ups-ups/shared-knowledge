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

**方針（2026-09-24）:** 普段の OS は Android（GammaOS か純正）のままにする。残す理由は Winlator 系（Wine + Box64 + Turnip / DXVK）で Windows ゲームを動かすこと。ROCKNIX に切り替えると、そのセッションでは Winlator の APK とコンテナ設定が使えない。二重ブートなら Android 側の Winlator は消えないが、Linux 起動中は代わりにならない。

Winlator はサイドロードできるので、Google なしの Lite でも動く。Play ストアの購入物を使うときだけ Full。

**レトロに割り切る（2026-09-25）:** 画面が 16:9 の 1080p なので、PSP を 2〜3 倍（だいたい 1080p）で出す用途に合う。快適な範囲は PSP 以下（PS1、N64、ドリームキャスト、DS を含む）。ゲームキューブは軽いタイトル（マリオカート ダブルダッシュ、どうぶつの森）が境目で、F-Zero やサンシャインは厳しい。PS2 は軽い JRPG が一部動く程度で、ライブラリの大半は対象外。3DS は Azahar でネイティブ解像度の一部。エミュは Performance モードのまま。Dolphin 系は Qualcomm の GPU ドライバ v805 の方が Turnip より速い、という実機比較がある。4:3 のタイトルは左右に黒帯が出る。

**Windows ゲーム（GameNative / Winlator）の上限（2026-09-25）:** メーカー仕様は Snapdragon 662（A73 2.1 GHz ×4 + A53 2.0 GHz ×4）、Adreno 610 1050 MHz、RAM 4 GB LPDDR4X、画面 5.5 インチ 1920×1080。このクラスは 2020 年のエントリースマホ向けで、Wine（Box64 か FEX）に DXVK を重ねる Windows ゲームは、3D や近年のタイトルではスペック不足になる。画面いっぱいに 1080p で描くとさらに重い。動く範囲は 2D や 2000 年代の軽い 3D を 540p〜800×600 まで落としたときで、Fallout 3 が 800×600 低設定でおおよそ 30 fps、という 2026-01 前後の Winlator 報告がある。同じチップの投稿者は「この用途向けのチップではない」と書いている。GammaOS にしてもこの天井は動かない。

**女剣士アスカ見参！ for Windows（2002、DirectX 8、32bit）を GameNative で出すとき（2026-09-25）:** 原寸は 640×480。公式環境は Pentium III 600MHz / 128MB なので、Air X の性能側は足りる。コンテナは画面 640×480（小さければ 960×540）、Windows は XP、ドライバは VirGL、描画は WineD3D（DXVK は D3D9 以降向け）。ビデオメモリは 512MB。起動するファイルは `AsfPc.exe`（`Loader.exe` は OS 判定で止まる）。公式のオフラインパッチは [スパイク・チュンソフトの配布ページ](https://www.spike-chunsoft.co.jp/pages/games/asukapc/dl.html) の `AsfPCN1800.exe`。DirectPlay の案内が出たら一度キャンセルして再起動する。真っ黒なら Turnip + d3d8→9 + 古い DXVK（1.10 系）に替える。十字キーは矢印、決定は Enter に当てる。

| | GammaOS Next | ROCKNIX | 純正 Android |
|--|--------------|---------|--------------|
| 土台 | Android 14 / LineageOS 21 | Mainline Linux、Freedreno + Turnip、Sway + ES | 出荷 Android |
| 導入 | Windows の QFIL / EDL。**データは消える**。SN でパッケージが別 | SD に `SM6115` イメージ。Android 上で ABL をバックアップしてから焼く。起動時 Vol− で ABL に入り、機種を MQ65 / MQ66 にして Linux 起動 | 何もしない |
| アプリ | Play ストア（Full）か、Google なし（Lite） | 無い。エミュと PortMaster | 出荷ランチャー + ストア |
| 強み | Winlator 系の Windows ゲーム、スタンドアロンエミュ、配信。ストック比で GPU ドライバ更新、60 Hz 固定、入力遅延とマイクロスタッター低減をうたう | 入力遅延が Android より小さい、という紹介。PortMaster。セーブ配置は ES 系に近い | Winlator を含む Android アプリ。メーカーサポートの範囲 |

### GammaOS Next（Air X は v1.2.0）

- リリース日 2025-12-14。一般公開は 2026-02-12。リポジトリの対応表は Air X をこの v1.2 のまま指している。
- プロジェクト全体の最新は **v1.4.1（2026-08-06）**。v1.2.1 以降の changelog に Air X / SM6115 のデバイスリリースは無い。ここから下は他機に載った共通基盤で、Air X にはまだ来ていない。

#### v1.2 から v1.4.1 までの進化（Air X 未配信）

出典は [changelog](https://github.com/TheGammaSqueeze/GammaOSNext/wiki/GammaOS-Next-Changelog)（2026-08-06 更新）。

| 版 | 時期 | 中身 |
|----|------|------|
| 1.2.1 | 2025-12 | D8300 の 120 Hz / BFI、4K 外部出力の半分解像度、Magisk 更新。Air X の SoC とは別 |
| 1.2.2 | 2026-02 | 二画面の DualStack（画面ごとの音量・輝度・IME）。Launch Guard。システム全体の CRT/LCD シェーダ。Syncthing の制限ディレクトリ許可 |
| 1.3.0 / 1.3.1 | 2026-04 | **Nano**（最小起動で XMB を先に出し、裏で Android を起こす）。**本体を消さずに書く OTA**。**GammaPad**（物理パッドの取り込み、ボタン割当、画面タッチへのマッピング、アプリ別プロファイル）。設定に Toolbox（隠し `persist.gammaos.*`）。ロック画面は既定オフ。`adbd` は起動時から root |
| 1.3.2 | 2026-05 | ソフト Keymaster のロック解除ループ、Nano 起動時の資格情報自動解除、Rockchip の HDMI / DP 音声 |
| 1.4 | 2026-07 | XMB を作り直し。音楽・動画・写真・ゲームパッド向けブラウザを同梱。SMB / NFS / WebDAV / FTP をローカルストレージとしてマウント。内蔵 DS（DraStic-nano、RetroAchievements、Quick Resume）。RetroArch のシェーダプリセットを画面全体に載せられる。スワップファイル。スリープ中の Bluetooth ウェイクロック（時間あたり約 4–5%）を切る修正 |
| 1.4.1 | 2026-08 | テーマ（XMB / DSi / Minima）、お気に入りとコレクション、箱絵、MTP でのファイル転送、Widevine L3 の互換トグル、通常 Android 側の設定と通知シェード |

XMB（XrossMediaBar）は PSP / PS3 のホームメニュー。横にカテゴリ（設定、写真、音楽、動画、ゲーム、ネットワーク）、縦に項目が並ぶ。GammaOS Nano のホームは、この PS3 版を自前で描き直したもの。Android の通常ランチャーとは別画面。

Air X で Winlator を使うなら、届いても普段遊ぶのは通常 Android 側になる。Nano は「起動してすぐ XMB」で、メニューから通常 Android へ再起動する構成。GammaPad の画面マッピングは、純正にあるキーマッピングに近いもの。

hypothesis: 2026-09-24 — Reddit の「1.3 で Air X のファンと 3.5 mm が直る」は利用者コメントだけ。changelog の 1.3 以降に Air X のファン / ジャック項目は無い。issue 題の「1.2.7」は分割アーカイブ名 `v1.2.7z` の読み違いの可能性が高い。未検証。

outdated: 2026-09-24 — 公開の GammaOSNext は README だけ、という記述。ソースは別リポジトリ。下を見る。

[GammaOSNextDistribution-14](https://github.com/TheGammaSqueeze/GammaOSNextDistribution-14)（`develop`、2026-09-20 時点）が LineageOS 21 / Android 14 の GSI ソース。`frameworks/native/services/gammapad` や Nano のコミットがある。ビルド対象は `build.sh` の `lineage_arm64_bvN`（汎用 Treble の system イメージ）。`device/` に Mangmi / SM6115 / MQ65 / MQ66 は無い。`kernel/` は configs と prebuilts だけ。

[v1.2.0-MANGMIAIRX](https://github.com/TheGammaSqueeze/GammaOSNext/releases/tag/v.1.2.0-MANGMIAIRX) のページ末尾にある Source code（zip / tar.gz）は、GitHub がそのタグから自動で作るアーカイブ。中身は `LICENSE`、`README.md`、`MAGISK_ES-DE_fix.zip` の 3 ファイル（展開後約 25KB、コミットは README の RG Cube リンク更新）。MQ65 / MQ66 の `.7z` は焼く用のファーム本体。

Air X のパネル、ファン、ジャック、GPU ドライバは v1.2 の QFIL 一式（vendor / boot）側に残る。このツリーから作れるのは新しい system イメージで、それを既存の v1.2 の上に載せて起動するかは未確認。この作業環境の空きは約 37GB で、ツリーの取得とフルビルドには足りない。

- パッケージは **Full**（GApps あり）と **Lite**（Google サービスなし）。開発側の推奨はゲームと電池なら Lite。
- v1.2.0 の記載: 新しい LCD、MQ65 / MQ66 を含む改訂、ストレージ容量表示、ES-DE のテーマ取得、GammaEQ。デバイス向けとして GPU ドライバを 2025 年版に更新（純正は 2024）、Netflix DRM、パネル 60 Hz、ガバナーとサーマル、Lite の電池。
- 既存の GammaOS から v1.2.0 へはデータを残す更新手順がある。初回の QFIL は全消去。
- **既知の未解決（2026-03 の issue）:** Auto ではファンが回らず、Cool / Max の手動が必要（[#272](https://github.com/TheGammaSqueeze/GammaOSNext/issues/272)、open）。3.5 mm ジャックが鳴らない報告が 1.2.0 Lite と「1.2.7」の両方である（[#356](https://github.com/TheGammaSqueeze/GammaOSNext/issues/356)、[#274](https://github.com/TheGammaSqueeze/GammaOSNext/issues/274)）。リリースノートはジャック修正をうたうが、改訂や Lite では残っている。

### ROCKNIX（Air X）

- 公式: [Air X](https://rocknix.org/devices/mangmi/air-x/)。Wi-Fi、Bluetooth（音声とコントローラー）、スティック LED、内部インストール手順、サスペンドは Fake suspend。
- ABL を焼くので、ブートローダは Android 側と共有する。GammaOS 導入済みなら `backup_abl.sh` / `flash_abl.sh` は adb shell で実行する、と wiki にある。
- 2026-06 に stable 対応が告知されている。wiki の導入文は「Latest Nightly の SM6115」と書いているので、落とすファイルはリリース一覧で stable か nightly かを見る。
- GammaOS の上から入れると adb と SD のファイルシステムで詰まる、という 2026-06 の利用報告がある（exFAT 以外でマウントエラー、という 1 件）。性能は Android と大差ないが SD 起動で少し重い、スタンドアロンエミュの初期マッピングが未設定、という報告もある。
- PortMaster は Linux 側の利点だが、Winlator の代わりにはしない。Air X の本線は Android のまま。

## 機種をまたぐとき

- H700 用イメージを Air X に焼かない。逆も同じ。Air X の GammaOS も MQ65 と MQ66 を混ぜない。
- ES 系（Knulli / ROCKNIX）は見た目と ROM フォルダが近い。muOS はフォルダ名の自由度が高い。GammaOS の実ファイルは Android のストレージ配下（手元では `/storage/00000000-0000-0000-0000-000000000001/Game`）。
- Syncthing でセーブを混ぜるなら、Knulli はセーブとステートが同一フォルダになりやすい。機種またはエミュごとにサブフォルダを切る。

## 参照

- [Knulli devices](https://knulli.org/devices/) / [RG35XX H](https://knulli.org/devices/anbernic/rg35xx-h/)
- [ROCKNIX RG35XX H](https://rocknix.org/devices/anbernic/rg35xx-h/) / [H700 installation](https://rocknix.org/configure/h700-installation/) / [Fake suspend](https://rocknix.org/configure/fake-suspend/) / [Air X](https://rocknix.org/devices/mangmi/air-x/)
- [GammaOS Next Air X v1.2.0](https://github.com/TheGammaSqueeze/GammaOSNext/releases/tag/v.1.2.0-MANGMIAIRX)
- muOS クイックスタート（PortMaster 同梱の記述）: https://community.muos.dev/t/muos-quick-start-guide/479

# GameNative で風来のシレン（Windows 版）

Mangmi Air X（GammaOS、Snapdragon 662 / Adreno 610 / RAM 4GB）で、2002年の Windows 版を動かすときのメモ。

- **確認日:** 2026-09-25
- **実機確認:** 未。設定は公式の動作環境と、Win10 以降での起動報告からの初期値
- **入口:** [`README.md`](./README.md)

どちらも 2D の 32bit で、Air X の性能は足りる。重いのは近年の 3D を DXVK で 1080p 描画したとき。GammaOS は Performance モードのままにする。省電力にすると CPU クロックが落ちる。

共通で外すもの:

- **DXVK。** DirectX 9 以降向け。この2本はそれより古い
- **1080p の仮想画面。** ゲーム原寸は 640×480 前後
- **Program Files へのインストール。** Wine だと権限と VirtualStore でセーブの居場所が分かりにくい。`C:\Games\` 以下に置く

十字キーは矢印、決定は Enter、キャンセルは Esc。GameNative のコントローラー割当で足す。

## 女剣士アスカ見参！ for Windows

| 項目 | 値 |
|------|-----|
| 正式名 | 不思議のダンジョン 風来のシレン外伝 女剣士アスカ見参！ for Windows |
| 発売 | 2002-12-20、チュンソフト |
| 公式環境 | Windows XP/Me/2000/98、Pentium III 600MHz、メモリ 128MB、DirectX 8.1、ビデオメモリ 15MB |
| 画面 | 640×480。文字が小さければ 960×540 |
| Windows バージョン | XP |
| グラフィックドライバ | VirGL |
| 描画 | WineD3D |
| ビデオメモリ | 512MB |
| 起動ファイル | `AsfPc.exe` |
| 置き場所 | `C:\Games\Asuka` |

`Loader.exe` は OS のバージョン判定で止まるので、ショートカットの参照先も `AsfPc.exe` にする。

公式のオフラインパッチは `AsfPCN1800.exe`。週替わりダンジョンのオフライン化と、ネットメニューの削除が入っている。配布は [スパイク・チュンソフト](https://www.spike-chunsoft.co.jp/pages/games/asukapc/dl.html)。適用後の表示バージョンは 1.7.0.0 のまま、という配布ページの注記がある。

DirectPlay の案内が出たら、一度キャンセルして `AsfPc.exe` を起動し直す。Windows 10 での報告では、キャンセル後に起動した例がある。

画面が真っ黒なら、次の順に替える。

1. ドライバを Turnip にする
2. d3d8 を d3d9 に変換する
3. DXVK は 1.10 系にする（2.x は古い変換と噛み合いが悪い）

CD の有無チェックを外す改造は書かない。ディスクから入れたフォルダを `C:\Games\Asuka` にコピーし、`AsfPc.exe` を直接指定する。

## 月影村の怪物 インターネット版

| 項目 | 値 |
|------|-----|
| 正式名 | 不思議のダンジョン 風来のシレン ～月影村の怪物～ インターネット版 |
| 発売 | 2002-12-20 |
| 公式環境 | Windows XP/Me/2000/98、Pentium MMX 200MHz、メモリ 32MB、DirectX |
| 画面 | 640×480 |
| Windows バージョン | 98。起動直後に固まるなら 95 |
| グラフィックドライバ | VirGL |
| 描画 | WineD3D |
| ビデオメモリ | 512MB |
| インストール先 | `C:\Games\ShirenV2`（既定のフォルダ名は `CHUNSOFT\ShirenV2`） |
| インストーラ | v2.20 は `ShrnSetup220.exe` |

ゲームボーイ版の PC 移植で、アスカ見参より要求が低い。Win10 の報告では、互換モードなしで v2.20 が起動した例と、Win98 から Win95 に落としてフリーズが止まった例の両方がある。先に 98 にする。

起動後、設定でネット機能を外す。救助とインターネット番付のサーバーは止まっている。

サービス終了は 2014-04-09。告知は [スパイク・チュンソフト](https://www.spike-chunsoft.co.jp/pages/games/shirenpc/)。ナギ救出より先は、止まった公式のユーザー認証が必要になる。認証を外す改造は書かない。ナギ救出までは、上の設定で起動を確認できる。

セーブは中断時に `ShirenV2` 配下（`customize`、`note`、`public`）と、レジストリ `HKLM\SOFTWARE\CHUNSOFT\ShirenV2` が対になる、と [攻略 wiki の基本システム](https://wikiwiki.jp/shirenpc/%E5%9F%BA%E6%9C%AC%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0) にある。Wine では VirtualStore 側に寄ることがある。バックアップするときはフォルダとレジストリを同じ時点で取る。

カクつくときは、古い DirectX ランタイムをコンテナに足す、という Win11 での報告がある。ドライバを DXVK に替える話ではない。

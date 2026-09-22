# Syncthing（自宅 LAN ファイル共有）

自宅内のゲーム機間で **ROM・セーブデータ** を共有するための Syncthing。**コード・Git リポジトリは同期しない**（履歴・バックアップは GitHub）。

- **確認日:** 2026-09-22
- **ハブ機:** [`aopen-de3250`](../environments/machines/aopen-de3250.md)（常時通電）

## デバイス一覧（Web UI）

自宅 LAN 上の Syncthing 管理画面。ホスト名は小文字で統一。

| 機器 | Web UI | 役割 |
|------|--------|------|
| DE3250 | http://de3250:8384/ | ハブ（マスター置き場・常時オン） |
| Knulli | http://knulli:8384/ | ゲーム機 |
| Batocera | http://batocera:8384/ | ゲーム機 |
| GammaOS（Android） | [API 直書き URL](#gammaos-api-直書き) | 携帯ゲーム機（Syncthing-Fork） |

## 方針: GitHub に集約

**運用の正本は GitHub。** 手順・URL・パス・機器情報は [ups-ups/shared-knowledge](https://github.com/ups-ups/shared-knowledge) に書き、マシン間で `git pull` して揃える。チャットや各端末のメモに散らさない。

Syncthing / SMB は **Git に載せられない大きなゲームファイル** 専用。Android のストレージパス問題（`/storage/00000000-.../Game` など）があるため、設定や知識まで Syncthing に寄せない。

## 役割分担

| 手段 | 用途 | 正本か |
|------|------|--------|
| **GitHub** | コード、共有ナレッジ、手順・URL・パス、テキスト設定 | **正本** |
| **Syncthing** | ROM / BIOS / セーブ（バイナリ・大容量） | DE3250 USB-HDD |
| **SMB（Samba）** | Windows からマスター置き場への出し入れ | DE3250 USB-HDD |

### GitHub に載せる / 載せない

| 載せる | 載せない |
|--------|----------|
| この README、機器 IP、Web UI URL、同期パス | ROM 本体、大きなセーブ |
| `~/src/` 以下のコードリポジトリ | `.env`、API キー（例外: 自宅 LAN 限定の直書き URL は運用判断で README に可） |
| 運用ルール、トラブル手順 | `corp-analysis/` など別経路のデータ |

## マスター置き場（USB-HDD）

| 項目 | 値 |
|------|-----|
| デバイス | `/dev/sdc1`（ラベル `usb-hdd`） |
| マウント | `/media/k/usb-hdd` |
| ファイルシス | ext4（約 458 GB） |
| 起動時マウント | `/etc/fstab` に UUID 登録済み（`nofail`） |

### ディレクトリ構成

```
/media/k/usb-hdd/
  corp-analysis/          # 投資分析（Syncthing 対象外）
  sync/
    games/
      bios/               # Syncthing: games-bios
      roms/               # Syncthing: games-roms
      saves/              # Syncthing: games-saves
```

- **BIOS** は `bios/` に集約。エミュレータごとにサブフォルダを切ってよい
- **ROM** は `roms/` に集約。追加はこのマスター（DE3250）で行う
- **セーブ** は `saves/`。機種・エミュレータごとにサブフォルダを切ってよい

## Windows からの出し入れ（SMB）

自宅 LAN 上の Windows（`desk-win` 等）から、エクスプローラーでマスター置き場を開く。

| 項目 | 値 |
|------|-----|
| 共有名 | `sync` |
| UNC | `\\DE3250\sync` または `\\192.168.0.119\sync` |
| パス（サーバー側） | `/media/k/usb-hdd/sync` |
| 認証 | Linux ユーザー `k`（Samba パスワード） |
| サービス | `smbd` / `nmbd`（起動時自動、USB マウント後） |

### Windows 側の接続

1. エクスプローラーで `\\DE3250\sync` を開く
2. ユーザー名 `k` と Samba パスワードを入力（初回は「資格情報を記憶」可）
3. よく使う場合は「ネットワークドライブの割り当て」（例: `Z:`）

BIOS は `\\DE3250\sync\games\bios`（既存の `sync` 共有内。別共有は不要）。

### Samba パスワードの初回設定（DE3250）

Samba ユーザーが未作成の場合、DE3250 で一度実行する:

```bash
sudo smbpasswd -a k
```

Linux ログインと同じパスワードにしてもよい（別でも可）。**パスワードはこのリポジトリに書かない。**

### 運用上の注意

- Windows から置いたファイルは Syncthing 経由で他ゲーム機へ伝播する
- **同じセーブを Windows 経由とゲーム機で同時編集しない**（Syncthing 競合と同様）
- `corp-analysis/` は共有外（`sync/` だけを公開）

## DE3250 の Syncthing 設定

| 項目 | 値 |
|------|-----|
| パッケージ | 公式 APT `stable-v2`（`https://apt.syncthing.net/`） |
| バージョン | 2.1.5（2026-09-22 確認） |
| サービス | `systemctl --user`（`enable` + `linger` 有効） |
| Web UI | http://de3250:8384/（IP 直: `http://192.168.0.119:8384`） |
| GUI 認証 | ユーザー `k`（パスワード未設定なら API キーで初回アクセス可） |
| デバイス名 | `DE3250` |
| デバイス ID | `VYVIK3Y-QFUJK7R-NK4TEO5-EFKGUJG-DDW3JBD-E4ESY5Q-Y4EA3C4-TSGBXA3` |

### 共有フォルダ

| ID | ラベル | パス | バージョン履歴 |
|----|--------|------|----------------|
| `games-bios` | Games BIOS | `/media/k/usb-hdd/sync/games/bios` | なし |
| `games-roms` | Games ROMs | `/media/k/usb-hdd/sync/games/roms` | なし |
| `games-saves` | Games Saves | `/media/k/usb-hdd/sync/games/saves` | simple（直近 10 世代） |

Default Folder（`~/Sync`）は削除済み。

### systemd

- ユーザーサービス: `syncthing.service`
- USB マウント待ち: `~/.config/systemd/user/syncthing.service.d/usb-hdd.conf`
  - `RequiresMountsFor=/media/k/usb-hdd`
  - マウント失敗時は 30 秒後に再起動

## 新しいゲーム機の追加手順

1. 対象機に Syncthing をインストール
2. Web UI → **Add Remote Device** → 上記 DE3250 のデバイス ID を入力
3. DE3250 側で未確認デバイスを **Accept**
4. 各機でローカルパスを決め、DE3250 の `games-bios` / `games-roms` / `games-saves` を **Share**
5. 初回は同一 LAN 上で行う（ローカル発見が効く）

## 運用ルール

1. **同じセーブを 2 台で同時プレイしない** — 競合ファイル（`.sync-conflict-*`）や破損の原因
2. **ゲーム終了後に同期を待つ** — プレイ中のセーブ書き込みと同期が重なると危険
3. **BIOS / ROM の追加は DE3250 の `bios/` / `roms/` だけ** — 他機は受け取り側にする
4. **セーブステートは機種・エミュレータ依存** — 通常セーブ（`.srm` / `.sav` 等）を正本にする
5. **コード・Git リポジトリは Syncthing に載せない** — `~/src/` 以下は GitHub で管理

## 同期しないもの

- `~/src/` 以下の Git リポジトリ
- `.env`、鍵、トークン
- `corp-analysis/`（別用途・別経路で管理）
- 巨大な一時ファイル・再生成可能なビルド成果物

## `.stignore`

各共有フォルダ直下に配置済み。OS ゴミ・一時ファイルを除外。`saves/` では `.stversions` はバージョン履歴用のため除外しない。

## Android（Syncthing-Fork / GammaOS）

- **IP:** `192.168.0.159`（ルーター DHCP 固定。2026-09-22 確認）
- **Web UI:** `https://192.168.0.159:8384/`（`http://` は **HTTPS にリダイレクト**される）
- デフォルトは Web UI が端末内（`127.0.0.1:8384`）だけ。`0.0.0.0:8384` に変更済みなら LAN から届く

### LAN から開く手順

1. Syncthing-Fork → **Settings** → **GUI App Settings** → **Syncthing Options**
2. **GUI Listen Address** を **`0.0.0.0:8384`**（全文入力）
3. 同画面の **API key** をタップしてコピー
4. Syncthing を再起動
5. 別機のブラウザで **`https://192.168.0.159:8384/`** を開く（証明書警告は「詳細」→続行）
6. ページ内の **Authentication Required** フォームに入力（ブラウザのポップアップではない）

### GammaOS API 直書き

ブラウザで開くだけ（自宅 LAN 限定。キー変更時はここも更新）:

```
https://192.168.0.159:8384/?apikey=rcb3LSLcNY065R9VK4MJx6QCUNs7kDEx
```

2026-09-22 DE3250 から接続確認済み。

### ログイン情報（フォーム入力する場合）

Web UI で `a` / `a` を設定しても **アプリ側で上書きされる**。正しい組み合わせは:

| 項目 | 値 |
|------|-----|
| ユーザー名 | `syncthing`（固定。`a` ではない） |
| パスワード | 上記 API key と同じ文字列 |

### SD カードを sync 対象にする（GammaOS）

**Web UI からパスを手入力するのは非推奨。** Android はフォルダピッカーで権限を付与する必要がある。

#### GammaOS（確認済みパス）

2026-09-22 Syncthing-Fork のフォルダピッカーで確認:

```
/storage/00000000-0000-0000-0000-000000000001/Game
```

| 要素 | 意味 |
|------|------|
| `00000000-0000-0000-0000-000000000001` | GammaOS / Android が割り当てたストレージ ID（一般的な `ABCD-EFGH` 形式ではない） |
| `Game` | ゲーム用フォルダ（端末上の表示名） |

`/sdcard` や `/storage/emulated/0` とは別のボリュームとして見えている可能性がある。カード差し替え後は ID が変わるかもしれないので、再確認する。

#### パスを調べる（端末上）

1. Syncthing-Fork → **Folders** → **+** → **Directory** をタップ
2. 左上 **☰**（またはストレージ切替）で **SD カード** を選ぶ
3. 目的のフォルダまで移動
4. 選択後に表示されるパスをメモ

他環境の例（参考）:

```
/storage/XXXX-XXXX/ROMS
/storage/XXXX-XXXX/BIOS
```

#### GammaOS でのフォルダ構成（例）

| 用途 | パス（要確認） |
|------|----------------|
| ゲーム一式 | `/storage/00000000-0000-0000-0000-000000000001/Game` |
| ROM / BIOS 分割 | `Game` 内のサブフォルダ、または別途ピッカーで確認 |

Daijisho / RetroArch の Paths と Syncthing の対象フォルダを揃える。

#### 書き込みできないとき（Android の制限）

ポータブル SD では **ルート直下を Syncthing が読み取り専用**にすることがある。次を試す:

1. **アプリのフォルダピッカー**で選ぶ（Web UI の New Folder よりアプリ側が確実）
2. ルートではなく **サブフォルダ**（`ROMS/nes` など）を指定
3. それでも read-only なら、Syncthing が書ける場所に同期してから移動:

```
/storage/XXXX-XXXX/Android/media/com.github.catfriend1.syncthingfork/sync/
```

（アンインストールで消えるので、正本は DE3250 ハブ側）

#### DE3250 との共有の例

| 端 | パス |
|----|------|
| DE3250（マスター） | `/media/k/usb-hdd/sync/games/roms` |
| GammaOS（受け取り） | `/storage/00000000-0000-0000-0000-000000000001/Game` |

`games-roms` を Share し、GammaOS 側はフォルダピッカーで `Game` を指定。BIOS / セーブは `Game` 内のサブフォルダを分けるか、DE3250 の `games-bios` / `games-saves` と別フォルダで対応付ける。

### その他（Android）

- **バッテリー最適化**を Syncthing-Fork に対して無効化
- 通常の **Syncthing** と **Syncthing-Fork** を同時稼働させない
- ホスト名 `gammaos` が引けない環境では IP 直指定（`192.168.0.159`）
- **すべてのファイルへのアクセス**を Syncthing-Fork に許可（未許可だと SD が見えないことがある）

## Web UI（別 PC から）

2026-09-22 以前は DE3250 が `127.0.0.1:8384` のみで、別 PC からは開けなかった。現在は `0.0.0.0:8384` で LAN 待受。

1. 上記 [デバイス一覧](#デバイス一覧web-ui) の URL をブラウザで開く
2. DE3250 でパスワード未設定の場合、API キーを確認して URL に付ける:
   ```bash
   grep apikey ~/.local/state/syncthing/config.xml
   ```
   `http://de3250:8384/?apikey=（表示されたキー）`
3. 開けたら **Actions → Settings → GUI** でユーザー `k` のパスワードを設定する（**キーはリポジトリに書かない**）

自宅 LAN 外からは開かない想定。ルーターで 8384 をインターネットに公開しない。

## アップデート

Debian 標準パッケージより公式リポジトリを優先（`/etc/apt/preferences.d/syncthing.pref`）。

```bash
sudo apt-get update
sudo apt-get install syncthing
systemctl --user restart syncthing
syncthing --version
```

## トラブル時

```bash
# Syncthing
systemctl --user status syncthing
journalctl --user -u syncthing -n 50 --no-pager

# Samba
systemctl status smbd
sudo testparm -s 2>/dev/null | grep -A12 '\[sync\]'

# USB マウント確認
mountpoint /media/k/usb-hdd && ls /media/k/usb-hdd/sync/games/
```

- フォルダが **Stopped** / パス欠落 → USB が外れているか fstab マウント失敗。`sudo mount /media/k/usb-hdd`
- **Out of Sync** → 競合ファイルを確認。セーブは `.stversions` から復元可（`games-saves`）
- Windows で **アクセス拒否** → `sudo smbpasswd -a k` で Samba ユーザー作成済みか確認
- Windows で **共有が見えない** → `\\192.168.0.119\sync` を直接指定。同一 LAN か確認
- **Web UI が別 PC から開けない** → DE3250 上で `ss -tlnp | grep 8384` が `*:8384` か確認。`smbd` とは別ポート
- **Android（gammaos）が外部から見えない** → GUI Listen Address が `0.0.0.0:8384` か。`https://192.168.0.159:8384/` を試す
- **ログイン画面が出ない** → ブラウザのポップアップではなくページ内フォーム。ユーザー `syncthing` + API key（`a`/`a` は無効）

## 関連

- マシン: [`topics/environments/machines/aopen-de3250.md`](../environments/machines/aopen-de3250.md)

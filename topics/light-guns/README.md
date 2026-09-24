# Batocera ライトガン表の国内版と海外名作

出典は [Batocera light gun spreadsheet](https://wiki.batocera.org/emulators:light_gun_game_spreadsheet)（確認 2026-09-25。ページ自体は約 20 か月前の更新）。表は動作確認リストで、発売地域は書いていない。ここは地域を足し、表の注釈を各タイトルへ移したもの。

表の共通事項:

- 主に x86_64 と rpi4。MAME 以外は既定設定。他の機種では結果が変わる
- HB = 自作、Unl = 無許諾
- v36 以降、テスト済みタイトルは初回起動でプリキャリブレーションされる。既存のキャリブレーションは上書きしない
- MAME は動く ROM と不完全な ROM に基づく。列は 0.258 と 0.78+
- FBNeo の ROM セットは 2023-09-10
- Model 2 / Model 3 は v35 だとゲーム内で再キャリブレーションが要る
- サターンは全タイトル、ゲーム内の再キャリブレーションが要る
- ナオミの ROM セットは 0.258。ナムコシステム 246/256 は v38+
- Wii と PS3 は v36+。PS2 は v37+ で、recalibrate shot で合わせる

「国内版」は、日本でしか出ていないもの、または海外 ROM だとガンコンが外れているもの。日本発でも海外 ROM で同じ内容なら、海外版で足りる。注釈が空で両列 ✔ のポートは「注釈なし」とだけ書く。

## 日本でしか遊べない（国内 ROM が要る）

アーケードは日本の筐体向け。家庭用は日本版ディスクが要る。

| 表の名前 | 日本語名 | どこ | 表の注釈 |
|----------|----------|------|----------|
| Golgo 13 | ゴルゴ13 | アーケード 1999。エイティング / ナムコ。日本のみ | MAME: 0.258 ✔、0.78+ ✘。注釈なし |
| Golgo 13 Kiseki no Dandou | ゴルゴ13 奇跡の弾道 | アーケード 2000。日本のみ。スコープ付きライフル | MAME: 0.258 ✔、0.78+ ∼。注釈なし |
| Golgo 13 Juusei no Requiem | ゴルゴ13 銃声の鎮魂歌 | アーケード 2001。表の Requiem は鎮魂歌のこと。日本のみ | MAME: 0.78+ は ∼。0.256+ required. Trigger/secondary are inversed. |
| Mobile Suit Gundam Final Shooting | 機動戦士ガンダム ファイナルシューティング | アーケード 1995、バンプレスト | MAME: 0.258 ✔、0.78+ ∼。注釈なし。FBNeo: Must change dipswitch value of control to "Light gun" in Retroarch |
| Lupin The Third : The Shooting | ルパン三世 THE SHOOTING | ナオミ 2001、セガ。日本のアーケードのみ | ナオミ ✔。注釈なし |
| Death Crimson | デスクリムゾン | サターン。エコール。日本のみ | 射撃 ✔、動作 ✔。注釈なし。サターン共通でゲーム内再キャリブレーション |
| Death Crimson 2 | デスクリムゾン2 | ドリームキャスト。日本のみ。英語は有志パッチ（2024） | 射撃 ✔、動作 ✔。注釈なし |
| Mechanical Violator Hakaider | 人造人間ハカイダー | サターン。日本の特撮ライセンス | 射撃 ✔、動作 ✔。注釈なし。サターン共通でゲーム内再キャリブレーション |
| The Gun Shooting / 2 | SIMPLE1500 ザ・ガンシューティング | PS1 の廉価版。日本のみ | どちらも射撃 ✔、動作 ✔。注釈なし |
| Puffy no P.S. I Love You | PUFFYのP.S. I Love You | PS1。日本のみ | 射撃 ✔、動作 ✔。注釈なし |
| Serofans | セロファンス | PS1。日本のみ。12 本中ガンは 3 本だけ | Untested / Untested |
| Game Paradise 2 | ガンバレ！ゲーム天国2 | PS1、ジャレコ。日本のみ。ガンは 2P の付け足し | Untested / Untested |
| Policenauts | ポリスノーツ | 3DO / PS / サターン。小島秀夫。公式の海外版は無い。ガンは射撃シーンだけ | 下に分割 |

ポリスノーツの表の注釈:

- 3DO: 射撃ゲーム欄は ✘。Light gun on port 2. Controller port 1. Gun scenes only.
- PS: 射撃ゲーム欄は ✘、動作 ✔。v39+, need nuvee patch with v38 and under. Gun scenes only. GunCon on port 2.
- サターン: 射撃ゲーム欄は ✘。Gun scenes only, light gun on port 2。ゲーム内再キャリブレーション

## 国内版でないとガンコンが無い

- **Resident Evil Survivor**（バイオハザード ガンサバイバー）: 日本版と欧州版はガンコン対応。北米版は外されている。表: 射撃ゲーム欄は ✘、動作 ✔。JP rom only. Requires controller. Shooting mode only

## 日本発だが、海外版でも同じ

国内版を探さなくてよい。名前だけ日本側を併記する。動作メモは、注釈があるポートと、✔ でない列だけを残す。

- **Point Blank** = ガンバレット。表の Gun Bullet は日本版クローンで、別ゲームではない。MAME の Gun Bullet は 0.258 ✔、0.78+ ∼。注釈: clone of Point Blank。FBNeo の Gun Bullet と、MAME / FBNeo / PS の Point Blank は ✔ で注釈なし
- Point Blank 2 = ガンバァール。MAME は 0.258 ✔、0.78+ ∼。注釈なし。PS は ✔ で注釈なし
- Point Blank 3 = ガンバリナ。MAME は 0.258 ✔、0.78+ ∼。0.256+ required。PS は ✔ で注釈なし
- Ghoul Panic = オー！バキューン。PS 版は日本と欧州のみ（北米は無い）。MAME は 0.258 ✔、0.78+ ∼。注釈なし。PS は Ghoul Panic / Oh! Bakyuuun で ✔、注釈なし
- Rescue Shot = レスキューショット ブービーぼー。PS は日本と欧州。射撃 ✔、動作 ✔。注釈なし
- Mighty Hits は日本（PS とサターン、どちらも ✔、注釈なし。サターンはゲーム内再キャリブレーション）。Mighty Hits Special は日本と PAL。PS は ✔、注釈なし
- Crypt Killer の日本名はヘンリーエクスプローラーズ。MAME ✔ / ✔、注釈なし。PS: v39+, need nuvee patch with v38 and under。サターンは ✔、ゲーム内再キャリブレーション
- NES: Laser Invasion = ガンサイト。射撃 ✔、動作 ✔、注釈なし。Bayou Billy = マッドシティ。射撃ゲーム欄は ✘、動作 ✔。Second stage only
- SNES: Battle Clash = スペースバズーカ。射撃 ✔、動作 ✔、注釈なし。Yoshi's Safari = ヨッシーのロードハンティング。射撃 ✔、動作 ✔、注釈なし
- PS2 の Gunvari Collection + Time Crisis は日本のガンバリ・コレクション（ポイントブランク集）。✔、注釈なし。PS2 共通で v37+、recalibrate shot
- PS2 の Guncom 2 は欧州名。中身は Death Crimson OX。✔、注釈なし
- Death Crimson OX のアーケード（ナオミ）は日本。✔、注釈なし。ドリームキャストは北米にも出た（サミー）。射撃 ✔、動作 ✔、注釈なし。PS2 欧州名が Guncom 2
- Gunbuster はタイトー 1992。北米名は Operation Gunbuster。国内専用ではない。MAME ✔ / ✔、FBNeo ✔。注釈なし
- Elemental Gearbolt（エレメンタル ギアボルト）は日本オリジナル。北米はワーキングデザインズ版で、難度が上がっている。PS は射撃 ✔、動作 ✔、注釈なし
- Confidential Mission のドリームキャスト版は日本と欧州（北米は無し）。射撃 ✔、動作 ✔、注釈なし。ナオミも ✔、注釈なし

## 国内の本命（海外版で足りる）

日本のメーカー作で、表の中ではここが本体。

- **タイムクライシス**
  - MAME: 0.258 ✔、0.78+ ✘。Flash removal possible with cheats.zip
  - PS: 射撃 ✔、動作 ✔。Nunchuk for wiimote can be used to reload
- **Time Crisis: Project Titan**（PS）: 射撃 ✔、動作 ✔。Nunchuk for wiimote can be used to reload
- **Time Crisis II**
  - MAME: 0.258 の列は 0.272、0.78+ は ∼。0.272+ required
  - PS2: ✔、注釈なし
- **Time Crisis 3**
  - ナムコシステム 246/256（v38+）: 動作欄は空。Calibrate gun in service menu first
  - PS2: ✔、注釈なし
- **Time Crisis 4**
  - ナムコシステム 246/256: ✔、注釈なし
  - PS3: 動作 ✘。GunCon3 only
  - PS3 の Time Crisis: Razing Storm（Deadstorm Pirates と Time Crisis 4 同梱）: 動作欄は空。Calibration : shoot a bit beyond target. Enable "Write Colors Buffer". TC4: framelimit to "30"
- **Time Crisis - Crisis Zone**（PS2）: 動作欄は空。Enable the texture hack to remove the white fog
- **バーチャコップ**
  - Model 2: ✔、個別注釈なし。v35 はゲーム内で再キャリブレーション
  - サターン: 射撃 ✔、動作 ✔。ゲーム内再キャリブレーション
- **バーチャコップ 2**
  - Model 2: ✔。v35 はゲーム内で再キャリブレーション
  - サターン: ✔。ゲーム内再キャリブレーション
  - ドリームキャスト: 射撃 ✔、動作 ✔、注釈なし
  - PS2 の Virtua Cop - Elite Edition: 動作欄は空。Skip the calibration screen by shooting offscreen
- **ハウス・オブ・ザ・デッド**
  - Model 2: ✔。v35 はゲーム内で再キャリブレーション
  - サターン: ✔。ゲーム内再キャリブレーション
- **ハウス・オブ・ザ・デッド 2**
  - ナオミ: ✔。Secondary trigger can reload
  - ドリームキャスト: 射撃 ✔、動作 ✔、注釈なし
  - Wii の House of the Dead 2 & 3: ✔、注釈なし（v36+）
- **ハウス・オブ・ザ・デッド 3**（PS3）: ✔、注釈なし
- **ハウス・オブ・ザ・デッド 4**（PS3）: 動作欄は空。Can't reload (no shake functionality)
- **オペレーションウルフ**
  - MAME ✔ / ✔、FBNeo ✔。注釈なし
  - C64: ✔。Press space bar / south button on the controller to throw grenades
  - NES: 射撃 ✔、動作 ✔。Hold A and shoot to throw grenades
  - マスターシステム: ✔。Hold button 1 (A) and shoot to throw grenades
- **オペレーションサンダーボルト**: MAME ✔ / ✔、FBNeo ✔、C64 ✔、SNES は射撃 ✔・動作 ✔。いずれも注釈なし
- **リーサルエンフォーサーズ**
  - MAME ✔ / ✔、FBNeo ✔、メガドライブ ✔、SNES は射撃 ✔・動作 ✔、セガ CD は射撃 ✔・動作 ✔。注釈なし
  - PS の Lethal Enforcers 1&2: 射撃 ✔、動作 ✔。v39+, need nuvee patch with v38 and under
- **リーサルエンフォーサーズ II**: MAME ✔ / ✔。メガドライブ ✔。セガ CD は射撃 ✔、動作 ✔。注釈なし
- **オーシャンハンター**（Model 3）: ✔、個別注釈なし。v35 はゲーム内で再キャリブレーション
- **ヴァンパイアナイト**: ナムコシステム 246/256（v38+）✔、注釈なし。PS2 ✔、注釈なし
- **ニンジャアサルト**
  - ナオミ: ✔。V36+ pre-calibrated. v35: calibration required
  - PS2: ✔、注釈なし
- **ゴーストスカッド**（Wii）: ✔、注釈なし。Wii は v36+
- **バイオハザード アンブレラ・クロニクルズ**
  - Wii: ✔。v38 and under: need "shake" to reload
  - PS3: 動作欄は空。Calibration : aim center of screen, shoot then aim a bit beyond center of targets
- **バイオハザード ダークサイド・クロニクルズ**
  - Wii: ✔。v38 and under: need "shake" to reload
  - PS3: 動作欄は空。Calibration : aim center of screen, shoot then aim a bit beyond center of targets
- **エレメンタル ギアボルト**: 英語で遊ぶなら北米版。PS の表は射撃 ✔、動作 ✔、注釈なし
- **ダックハント**: MAME の Vs. Duck Hunt は ✔ / ✔、注釈なし。NES は射撃 ✔、動作 ✔。P2 can control the duck with gamepad
- **ヨッシーのロードハンティング**（Yoshi's Safari、SNES）: 射撃 ✔、動作 ✔、注釈なし。パーティ向け

## 海外版の名作

日本発ではない。表にあって、国内版が無くても入れる価値があるもの。

- **Area 51**（アタリ / メサロジック）。アメリカのガンゲーの基準
  - MAME ✔ / ✔、注釈なし
  - PS: 射撃 ✔、動作 ✔。v39+, works with Mednefen only : software rendering and Justifier gun in v38 and under
  - サターン: 射撃 ✔、動作 ✔。ゲーム内再キャリブレーション
- **Maximum Force**（Area 51 の続編。同じエンジンで、出来は落ちる）: MAME ✔ / ✔、注釈なし。PS は射撃 ✔、動作 ✔、注釈なし。サターンは ✔、ゲーム内再キャリブレーション
- **Terminator 2: Judgment Day**（ミッドウェイ）: MAME ✔ / ✔、FBNeo ✔。メガドライブの T2 - The Arcade Game は ✔。SNES も射撃 ✔、動作 ✔。注釈なし
- **CarnEvil**（ミッドウェイ）。ハロウィン向けのカルト。MAME ✔ / ✔。Calibration required for older ROMset
- **アメリカンレーザーゲームス**（Hypseus Singe と、セガ CD / 3DO の移植）
  - Mad Dog McCree: Hypseus ✔。セガ CD は射撃 ✔、動作 ✔。3DO は射撃 ✔、動作 ✔。Wii の Gunslinger Pack は ✔。注釈なし。PS3 は動作 ✘。Can't reload
  - Mad Dog II: The Lost Gold: Hypseus ✔。セガ CD / 3DO は ✔。注釈なし。PS3 は動作 ✘。Can't reload
  - Crime Patrol: Hypseus ✔。セガ CD / 3DO は ✔。サターンは ✔、ゲーム内再キャリブレーション。個別注釈なし
  - Crime Patrol 2: Drug Wars: Hypseus ✔、注釈なし。3DO の Drug Wars は射撃 ✔、動作 ✔、注釈なし
  - Who Shot Johnny Rock?: Hypseus ✔。セガ CD / 3DO は ✔。注釈なし
  - Space Pirates: Hypseus ✔、注釈なし。3DO は射撃 ✔、動作 ✔、注釈なし
  - The Last Bounty Hunter: Hypseus ✔。3DO は ✔。注釈なし。PS3 は動作 ✘。Can't reload
- **Dead Space: Extraction**
  - Wii: ✔。v38 and under: nunchuk required (p1)
  - PS3: 動作 ✘。Broken calibration, very bad accuracy; no shake functionality
- **The House of the Dead: Overkill**（Wii、イギリスのヘッドストロング）。グリンドハウス調。セガの番号付き本編とは別系統
  - Wii: ✔、注釈なし
  - PS3: 動作 ✘。Calibration not working, no aim

レミントンや Big Buck Hunter、Deer Hunting USA、Extreme Hunting、Sports Shooting USA はアメリカの狩猟筐体向けで、国内版でも名作枠でもない。表で ✔ でない列だけ残す。

- Big Buck Hunter、Call of the Wild、II - Sportsman's Paradise、Shooter's Challenge: MAME は 0.258 ✔、0.78+ ∼。注釈なし。Wii の Big Buck Hunter Pro は ✔、注釈なし
- Deer Hunting USA: MAME は 0.258 ✔、0.78+ ∼。FBNeo ✔。注釈なし
- Extreme Hunting: アトミスウェイブ ✔、注釈なし。Extreme Hunting 2 は ✔。V37+
- Sports Shooting USA: アトミスウェイブ ✔。V36+ pre-calibrated. V35: calibration required
- Remington Great American Bird Hunt、Super Slam Hunting（Africa / Alaska / North America）: Wii ✔、注釈なし

## 移植度

ここはアーケード（または最初の家庭用）と、あとの移植で何が残るかを書いたもの。Batocera の動作注釈とは別。確認日 2026-09-25。

ラベルは次の意味。

- **筐体どおり:** 本編のステージとルールが残り、基板と家庭用が同じ系統か、比較記事がアーケードパーフェクトと書いている
- **足してある:** 本編は残り、家庭用だけのモードがある
- **落ちる:** 本編は残るが、解像度・ロード・フレーム・操作のどれかが文書として落ちている
- **別構成:** ステージ数やルールが筐体と別
- **未確認:** 移植があることだけ分かって、差分の出典が無い

移植が無いもの（この表の範囲）: ゴルゴ13 の 3 作、ガンダム ファイナルシューティング、ルパン三世 THE SHOOTING、ガンバスター、オーシャンハンター、CarnEvil。デスクリムゾン 1（サターン）と 2（ドリームキャスト）、Project Titan、レスキューショット、エレメンタル ギアボルト、ヨッシーのロードハンティング、ダックハント、スペースバズーカは最初から家庭用なので、ここの対象外。

### 筐体どおりで、家庭用が足してある

- **ハウス・オブ・ザ・デッド 2**（ナオミ → ドリームキャスト）: 基板とドリームキャストが同じ系統。キャンペーンはほぼ同一、という [Hardcore Gaming 101 の Confidential Mission 記事](https://www.hardcoregaming101.net/confidential-mission/) と同じ世代の評価で、[Games Asylum](https://www.gamesasylum.com/2012/10/31/revisiting-the-house-of-the-dead-2/) はアーケードパーフェクトと書いている。家庭用には Original / Training / Boss がある。Wii の 2 & 3 Return は 2 と 3 のセット。
- **コンフィデンシャルミッション**（ナオミ → ドリームキャスト）: [HG101](https://www.hardcoregaming101.net/confidential-mission/) は、画・音・キャンペーンがほぼ同一で、Partner Mode、Academy、Another World、銃の見た目、HUD 無しを足した、と書いている。
- **バーチャコップ**（Model 2 → サターン）: [Sega-16](https://www.sega-16.com/2020/03/virtua-cop-saturn/) はほぼアーケードパーフェクト。足すのは射撃練習。本編の追加ステージは無い。
- **ヴァンパイアナイト**（アーケード → PS2）: アーケードモードは 6 ステージのまま。Special で店、依頼、訓練、Hunter's Files が足される（[GameVortex](https://gamevortex.com/gamevortex/soft_rev.php/689)、[ファントムの Special Mode](https://thehouseofthedead.fandom.com/wiki/Special_Mode)）。
- **タイムクライシス II**（アーケード → PS2）: [Wikipedia](https://en.wikipedia.org/wiki/Time_Crisis_II) は、画の強化、追加カットシーン、Crisis Mission、武器の解禁、二丁、Shoot Away II と Quick & Crash の収録を書いている。協力は画面分割か、i.Link で本体 2 台。筐体は筐体同士のリンク。
- **タイムクライシス 3**（システム 246 → PS2）: 同じ基板世代。 [Wikipedia](https://en.wikipedia.org/wiki/Time_Crisis_3) は、アーケードに無いアリシア編（狙撃区間あり）と Crisis Mission を書いている。
- **クライシスゾーン**（システム 23 → PS2、2004）: [Wikipedia](https://en.wikipedia.org/wiki/Crisis_Zone) は、ポリゴンとテクスチャの詳細化、難度上昇、ボイスの録り直し、6 か月後の 3 ステージ追加、武器の切り替え（弾数制限なし）、1 画面の Two-Gun、Crisis Mission を書いている。
- **ポイントブランク**（アーケード → PS1）: アーケード全編に Quest、パーティ、トーナメントが足される（[Internet Archive の解説](https://archive.org/details/psx_ptblank)、[GameSpot](https://www.gamespot.com/reviews/point-blank-review/1900-2548935/)）。メニューとオートセーブの待ちは家庭用側（[Pixel Empire](https://www.thepixelempire.net/point-blank-ps-review.html)）。2 と 3 も家庭用モード付きの移植だが、個別の削りは未確認。
- **ゴーストスカッド**（アーケード 2004 → Wii）: 本編は筐体が元。武器、衣装、分岐、パラダイス系のモードが足される（[IGN](https://www.ign.com/articles/2007/11/20/ghost-squad-review)、[GameSpot](https://www.gamespot.com/reviews/ghost-squad-review/1900-6183411/)）。3 ミッションは 20 分未満、という GameSpot の記述。

### 本編は残るが落ちる

- **タイムクライシス**（システム 22 → PS1）: 開発インタビュー（[shmuplations](https://shmuplations.com/timecrisis/)）は、システム 22 と PS の差が大きく、CD から RAM へ一度に載る量が制限だった、と書いている。ペダルはボタン（レーシングホイールのペダルも可）。Special は家庭用の別ミッション。画は筐体より粗い、という当時のレビュー。hypothesis: 2026-09-25 — PS2 のガンバリコレクションに入っているタイムクライシスは PS1 版のまま、というプレイ報告がある。ナムコの明示は未確認。
- **バーチャコップ 2**（Model 2 → サターン）: [Sega-16 のハウス・オブ・ザ・デッド記事](https://www.sega-16.com/2020/08/house-of-the-dead/) は、サターン版を忠実だが近似、と書いている。ドリームキャスト版は PC 版が元で、フレームは滑らかだが、見た目はサターン上位どまり、という [GGDreamcast](https://www.ggdreamcast.com/games/virtua-cop-2)。PS2 の Elite Edition は 1 と 2 のセット。どの版を元にしたかは未確認。
- **ハウス・オブ・ザ・デッド**（Model 2C → サターン）: 敵、分岐、ボイスは残る。テクスチャの粗さ、フレーム低下、ステージ途中のロードがある（[Sega-16](https://www.sega-16.com/2020/08/house-of-the-dead/)、[SEGA SATURN, SHIRO!](https://www.segasaturnshiro.com/2025/04/16/the-house-of-the-dead-bestofsaturnsilver/)）。Boss モード付き。血は緑が既定で、赤はコード。PC 版の方が画は近いが、マウス操作、という [Games Asylum](https://www.gamesasylum.com/2012/10/31/revisiting-the-house-of-the-dead-2/)。
- **Area 51**（アーケード → サターン / PS）: サターンは画面の枠が常時あり、実写の解像度が下がり、場面の切り替わりに待ちがある（[Sega Retro](https://segaretro.org/Area_51)）。PS は全画面。PS は Justifier のみでガンコン非対応、サターンはその機のライトガンに対応、という [GameFAQs のトリビア](https://gamefaqs.gamespot.com/arcade/583717-area-51/trivia)。Maximum Force の家庭用差分は未確認。
- **リーサルエンフォーサーズ**（アーケード → メガドライブ / セガ CD / スーファミ）: 背景を撃って壊す要素はほぼ無く、マグナムの扉貫通も無い。命中率不足や民間人誤射でステージやり直し。やられモーションは最後のコマだけ（[Just Games Retro](https://www.justgamesretro.com/genesis/lethal-enforcers)、[arcade-history のセガ CD](https://www.arcade-history.com/game/60754/)）。セガ CD はメガドライブ版に音楽を足した形で、血とステージ名は残る。スーファミは血の規制が強い。II の差分は未確認。
- **オペレーションウルフ**（アーケード → NES / マスターシステム）: 8 ビットの短縮版。NES はステージが短く 6 面前後で、グレネードはボタン（表の注釈と同じ）。筐体の画面構成そのものではない。サンダーボルトの 16 ビット版の差分は未確認。

### 実写レーザーディスク

Mad Dog McCree、Mad Dog II、Crime Patrol、Drug Wars、Who Shot Johnny Rock?、Space Pirates、The Last Bounty Hunter は、筐体のレーザーディスク映像をセガ CD / 3DO に収めたもの。ゲームの分岐は同じ系統。解像度はディスク側の上限に落ちる。どの場面がカットされたかの一覧は未確認。Wii の Gunslinger Pack と PS3 版は後年の再収録。PS3 でリロードできない、は Batocera の注釈であり、製品版の移植度ではない。

### 未確認（移植はある）

- デスクリムゾン OX: ナオミのあとにドリームキャスト、PS2（欧州名 Guncom 2）。差分は未確認。1 と 2 は移植ではない。
- ニンジャアサルト: ナオミと PS2。家庭用で何が足されるかは未確認。
- ハウス・オブ・ザ・デッド 3: アーケードはキヒロ（Xbox 系）。家庭用の初出は Xbox で、Wii と PS3 にもある。画の差分は未確認。
- ハウス・オブ・ザ・デッド 4 の PS3、Overkill の PS3、デッドスペース エクストラクションの PS3、バイオハザード・クロニクルズの PS3: 移植がある。製品版としての削りは未確認。表にある PS3 の照準やリロード不能は Batocera 側の注釈。
- ヘンリーエクスプローラーズ（Crypt Killer）の PS / サターン、ターミネーター 2 アーケードゲームのメガドライブ / スーファミ、オー！バキューンの PS: 移植がある。差分は未確認。
- ポリスノーツ: 起点は PC-98。3DO がリメイクで、PS とサターンが続く。ガンはサターンが純正、3DO は表ではポート 2、PS はパッチ。本編の削り比較は未確認。
- エレメンタル ギアボルトの北米版: hypothesis: 2026-09-25 — ワーキングデザインズ版は日本版より難しい、というプレイ側の記述がある。開発元の明示は未確認。

## 上のリストに無いが、表に注釈があるもの

国内版でも海外名作でもない。表の Notes 欄が空でないタイトル。

| 表の名前 | システム | 表の注釈 |
|----------|----------|----------|
| Bronx | MAME | 0.258 ✔、0.78+ ✘。注釈なし（別名 Cycle Shooting） |
| Bronx | FBNeo | 動作欄は空。Axis and screen are inverted |
| Bubble Trouble - Golly! Ghost! 2 | FBNeo | ✘。Not loading |
| Golly! Ghost! | FBNeo | ✘。Not loading |
| Jurassic Park | MAME | 動作欄は空。Broken accuracy in MAME, use FBNeo version |
| Jurassic Park | FBNeo | ✔、注釈なし |
| Line of Fire | MAME | 0.258 ✔、0.78+ ✘。Calibration required for older ROMset |
| Lucky & Wild | MAME | 0.258 の列は空、0.78+ ✔。Wheel (acceleration, turning) need to be mapped. |
| Night Stocker | MAME | 0.258 Untested、0.78+ ✔ |
| Judge Dredd | MAME | 0.258 ✔、0.78+ ✘。Notes は空 |
| Laser Ghost | MAME | 0.258 ✔、0.78+ ✘。Notes は空。マスターシステムの注釈は別行 |
| Shooting Gallery | MAME | 0.258 ✔、0.78+ ✘ |
| Shooting Master | MAME | 0.258 ✔、0.78+ ✘ |
| Triple Hunt | MAME | 0.258 ✔、0.78+ Untested。Change game in dipswitch |
| Behind Enemy Lines | Model 2 | ✔。V36+ pre-calibrated. V35: calibrate first in Windows with 2 mice, then transfer bel.DAT from NVRAM to /saves/model2/NVRAM |
| Star Wars Trilogy Arcade | Model 3 | ✔。V36+ pre-calibrated. v35: in calibration test, switch "flip lever" to "up-down, down-up" for correct axis |
| Manic Panic Ghosts! | ナオミ | ✘。No light gun input |
| The Maze of the Kings | ナオミ | ✔。V36+ pre-calibrated. V35: calibration required |
| Ranger Mission | アトミスウェイブ | ✔。V36+ pre-calibrated. V35: calibration required |
| Sega Clay Challenge | アトミスウェイブ | ✔。V36+ pre-calibrated. V35: calibration required |
| Day Dreamin' Davey | NES | 射撃ゲーム欄 ✘。When entering the blacksmith shop only |
| Freedom Force | NES | In turn. No coop. |
| Lone Ranger | NES | 射撃ゲーム欄 ✘。First-person shooting levels |
| Baby Boomer (Unl) | NES | P2 plays with the controller |
| Chiller (Unl) | NES | 2 players light guns not supported yet |
| Mechanized Attack | NES | Hold A and shoot to throw grenades |
| Shooting Range | NES | D-pad to move sight |
| Space Shadow | NES | 動作欄は空。Only works with mesen core. Use controller for grenades and move levels |
| Strike Wolf | NES | Press B to fire rockets |
| Super Russian Roulette (HB) | NES | 動作 ✘。Mapper 413 is missing from emulators |
| Track & Field II | NES | 射撃ゲーム欄 ✘。Gun firing only (mini-game) |
| Gangster Town | マスターシステム | ✔。2 players support |
| Laser Ghost | マスターシステム | 動作欄は空。Press A (south button) on second controller until you can't, then shoot |
| Hunt for Red October | SNES | 射撃ゲーム欄 ✘。Mini-game / bonus |
| Lamborghini American Challenge | SNES | 射撃ゲーム欄 ✘。Light gun as driving wheel and shooting |
| Lemmings 2 - The Tribes | SNES | 射撃ゲーム欄 ✘。Easter egg. Find it ;) |
| M.A.C.S Basic Rifle Marksmanship | SNES | 動作欄は空。Change controller type to MACS Rifle. |
| Snatcher | セガ CD | 射撃ゲーム欄 ✘、Untested。Gun scenes only |
| Demolition Man | 3DO | 射撃 ✔、動作欄は空。Only in gun scenes |
| Shootout at old Tucson | 3DO | 動作欄は空。Force light gun setting, load 3DO Arcade - SAOT BIOS, calibrate in-game service menu |
| Die Hard Trilogy | PS | 射撃ゲーム欄 ✘、動作 ✔。v39+, need nuvee patch with v38 and under (gun in port 1) |
| Die Hard Trilogy 2: Viva Las Vegas | PS | 射撃ゲーム欄 ✘、動作 ✔。Gun scenes only (gun in port 2) |
| Extreme Ghostbusters: Ultimate Invasion | PS | Press A + B to start (second and third buttons) |
| Gunfighter: The Legend of Jesse James | PS | Working only with DuckStation in v38 and under, GunCon on port 2 |
| Moorhuhn 2 / Crazy Chicken 2 | PS | Poor aiming |
| Moorhuhn X | PS | Poor aiming |
| Project Horned Owl | PS | v39+, need nuvee patch with v38 and under |
| Silent Hill | PS | 射撃ゲーム欄 ✘、動作 ✔。Easter egg. Find it ! ;) |
| Star Wars: Rebel Assault II | PS | 射撃ゲーム欄 ✘、動作 ✔。v39+, need nuvee patch with v38 and under. Shooting level only. |
| Chaos Control | サターン | ✔。1 player only。ゲーム内再キャリブレーション |
| Chaos Control Remix | サターン | ✔。2 players support。ゲーム内再キャリブレーション |
| Die Hard Trilogy | サターン | 射撃ゲーム欄 ✘、動作欄は空。Airport only (second level), light gun on port 2 |
| Demolition Racer: No Exit | ドリームキャスト | 射撃ゲーム欄 ✘、動作 ✔。Mini-game "Big Car Hunter", must unlock first |
| RevoleR (HB) | ドリームキャスト | 動作 Untested |
| Arcade Shooting Gallery | Wii | v38 and under: nunchuk required |
| Attack of the Movies 3D | Wii | v38 and under: "Shake" must be mapped to reload |
| Cocoto Festival | Wii | v38 and under: nunchuk required |
| Cocoto Magic Circus | Wii | v38 and under: nunchuk required |
| Fast Draw Showdown | Hypseus | Untested。Notes は空 |
| Gallagher's Gallery | Hypseus | ✔。v41+ |
| Fast Draw Showdown | Wii | v38 and under: tilt backward must be mapped (hostler) |
| Heavy Fire - Afghanistan | Wii | v38 and under: nunchuk required |
| Heavy Fire - Black Arms | Wii | v38 and under: nunchuk required |
| Heavy Fire - Special Operations | Wii | v38 and under: nunchuk required |
| Medal of Honor : Heroes 2 | Wii | ガンゲーム欄 ✘、動作欄は空。Nunchuk required (Arcade mode) |
| Pheasants Forever - Wingshooter | Wii | v38 and under: nunchuk required |
| Target Terror | Wii | v38 and under: need "shake" to reload |
| Top Shot Arcade | Wii | v38 and under: nunchuk required |
| Top Shot Dinosaur Hunter | Wii | v38 and under: nunchuk required |
| Cocoto Funfair | PS2 | ✘。GunCon only, not emulated yet in PCSX2 |
| Deadstorm Pirates (PSN) | PS3 | 動作欄は空。Enable "Write Colors Buffers" |
| Fast Draw Showdown (PSN) | PS3 | ✘。Can't hostler |
| Gal*Gun | PS3 | 動作欄は空。Calibration : shoot as much as you can beyond target in the corners |
| Heavy Fire : Afghanistan | PS3 | ✘。Broken calibration |
| Heavy Fire : Shattered Spear | PS3 | ✘。Broken calibration |
| The Shoot | PS3 | ✘。Broken calibration |
| Wicked Monsters BLAST! (PSN) | PS3 | 動作欄は空。Calibration : shoot as much as you can beyond target |

MAME で Notes は空だが、0.258 は ✔、0.78+ は ∼ のもの: Born To Fight、Bubble Trouble - Golly! Ghost! 2、Carnival King、Evil Night、Ghost Hunter、Invasion - The Abductors、Lord of Gun、Mallet Madness、Must Shoot TV、Rail Chase、Rail Chase 2、Rapid Fire、Total Vice、Trophy Hunting - Bear & Moose、Turkey Hunting、Tut's Tomb、Wing Shooting Championship。

上の一覧にも国内版・名作の項にも無いタイトルは、Notes が空で、載っている動作列は ✔ だった。

<h1>reaper_badapple_drawing</h1>
REAPERで空のアイテム表示させてmp4から変換した映像を流す物
<br>
<a href="https://www.youtube.com/watch?v=Cpo9RPN1bbQ">実行例（Youtube）</a>
<br>
<a href="https://www.nicovideo.jp/watch/sm44343220">実行例（ニコニコ）</a>
<br><br>
<strong>描画するにはmp4形式の動画ファイルが必要。</strong>
<h1>依存関係と実行方法</h1>
<h3>必要なもの</h3>
<br>Node.jsとffmpeg<br>
<h3>依存関係</h3><code>npm install</code>（fluent-ffmpegとsharp）
<br><br>
<h3>実行方法</h3>
index.jsを開いて動画ファイルのパスとサイズ（33×25推奨）の項目を変更。
<br><br>
実行<code>node index.js</code>
<br><br>
framesフォルダとframes_dataフォルダが生成される。
<br>
frames_dataフォルダの絶対パスをdrawing.luaに記入。
<br><br>
<a href="https://github.com/Phroneris/ReaperJPN-Phroneris">日本語化パッチ（森）</a>を導入している場合、
<br><br>
アクション➡アクションリストを開く➡新規アクション➡ReaScriptを読み込み
<br><br>
drawing.luaを読み込む。
<br>
drawing.luaを選択して実行を押す。
<br><br>
高速でアイテムを表示するためにフレームデータをメモリに保存しています。メモリの空き容量が大丈夫か確認してください。
<h1>ライセンス</h1>
MITライセンス
<br><br><br>念ためのURL<br>
Node.jsホームページ : <a href="https://nodejs.org/en/">https://nodejs.org/en/</a>
<br>
FFmpegホームページ : <a href="https://www.ffmpeg.org/">https://www.ffmpeg.org/</a>
<br>
REAPERホームページ : <a href="https://www.reaper.fm/">https://www.reaper.fm/</a>

<h1>reaper_badapple_drawing</h1>
REAPERで空のアイテム表示させてmp4から変換した映像を流す物
<br><br>
<a href="https://www.youtube.com/watch?v=Cpo9RPN1bbQ">実行例（Youtube）</a>
<br>
<a href="https://www.nicovideo.jp/watch/sm44343220">実行例（ニコニコ）</a>
<br><br>
mp4形式の動画ファイルを用意することでBadApple!!以外も描画可能。
<h1>要件と実行方法</h1>
<h3>要件</h3>
<ul>
  <li>Node.js</li>
  <li>ffmpeg</li>
  <li><code>npm install</code>（fluent-ffmpegとsharp）</li>
</ul>
<h3>実行方法</h3>
<h4>付属のbadApple_dataを使う場合</h4>
drawing.luaを開いてbadApple_dataファイルの絶対パスを記入。
<br><br>
<a href="https://github.com/Phroneris/ReaperJPN-Phroneris">日本語化パッチ（森）</a>を導入している場合、
<br>
アクション➡アクションリストを開く➡新規アクション➡ReaScriptを読み込み
<br>
からdrawing.luaを読み込む。
<br><br>
drawing.luaを選択して実行。
<br><br>

<h4>mp4ファイルを使う場合</h4>

index.jsを開いて動画ファイルのパスとサイズ（33×25推奨）の項目を変更。
<br><br>
実行<code>node index.js</code>
<br><br>
framesフォルダとframes_dataフォルダが生成される。
<br>
frames_dataフォルダの絶対パスをdrawing.luaに記入。
<br><br>
<a href="https://github.com/Phroneris/ReaperJPN-Phroneris">日本語化パッチ（森）</a>を導入している場合、
<br>
アクション➡アクションリストを開く➡新規アクション➡ReaScriptを読み込み
<br>
からdrawing.luaを読み込む。
<br><br>
drawing.luaを選択して実行。
<br><br>
<h1>ライセンス</h1>
MITライセンス

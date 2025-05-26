<h1>reaper_badapple_drawing</h1>
REAPERで空のアイテム表示させてmp4から変換した映像を流す物
<br><br>
実行例
<video class="demo" src="https://github.com/user-attachments/assets/0837c8d3-1462-4c09-a26c-a0b067f4d4e2"></video>
<a href="https://www.youtube.com/watch?v=Cpo9RPN1bbQ">実行例（Youtube）</a>
<br>
<a href="https://www.nicovideo.jp/watch/sm44343220">実行例（ニコニコ）</a>
<br><br>
mp4形式の動画ファイルを用意することでBadApple!!以外も描画可能。
<br><br>
<a href="https://www.nicovideo.jp/watch/sm45003861">あと、カラーで描画できるようになった</a>
<h1>要件</h1>
<ul>
    <li>Node.js</li>
    <li>ffmpeg</li>
    <li><code>npm install</code>を実行（fluent-ffmpegとsharp）</li>
</ul>
<h1>実行方法</h1>

<h2>付属のbadApple_dataを使う場合</h2>
badApple_data.zipを解凍、
drawing.luaを開いてbadApple_dataフォルダのパスを記入。
<br>
<a href="https://github.com/Phroneris/ReaperJPN-Phroneris">日本語化パッチ（森）</a>を導入している場合、
<br>
アクション➡アクションリストを開く➡新規アクション➡ReaScriptを読み込み
<br>
からdrawing.luaを読み込む。
<br>
drawing.luaを選択して実行。
<br><br>

<h2>付属のcolour-UgokuUgoku_dataを使う場合</h2>
colour-UgokuUgoku_data.zipを解凍、
colour-drawing.luaを開いてcolour-UgokuUgoku_dataフォルダのパスを記入。
<br>
あとは上記と同じく
<br><br>

<h2>mp4ファイルを使う場合</h2>
<h3>モノクロの場合</h3>
config.jsonを開いてprocessModeをmonochromeにし、他を自分の環境に合わせて変更。
<br>
実行<code>node index.js</code>
<br>
framesフォルダとframes_dataフォルダが生成されるのでframes_dataフォルダのパスをdrawing.luaに記入。
<br>
あとは上記と同じく

<h3>カラーの場合</h3>
config.jsonを開いてprocessModeをmonochromeにし、他を自分の環境に合わせて変更。
<br>
実行<code>node index.js</code>
<br>
framesフォルダとcolor-frames_dataフォルダが生成されるのでcolor-frames_dataフォルダのパスをcolor-drawing.luaに記入。
<br>
あとは上記と同じく
<br><br>

<h1>ライセンス</h1>
MITライセンス

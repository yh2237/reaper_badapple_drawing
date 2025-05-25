const fs = require("fs");
const sharp = require("sharp");
const ffmpeg = require("fluent-ffmpeg");

const videoPath = "input.mp4"; // mp4のファイルパス
const framesDir = "frames"; // リサイズしたpngファイルが入るディレクトリ名
const framesDataDir = "frames_data"; //出来たフレームデータが入るディレクトリ名
const frameRate = 30; // フレームレート（30fpsでしか動作確認してないから他は知らん）
const sizeX = 33; // 横サイズ
const sizeY = 25; // 縦サイズ（drawing.luaの縦サイズと同じにする）

if (!fs.existsSync(framesDir)) fs.mkdirSync(framesDir);
if (!fs.existsSync(framesDataDir)) fs.mkdirSync(framesDataDir);

async function processFrame(imagePath, frameNumber) {
    try {
        const frameDataPath = `${framesDataDir}/frame_${frameNumber}.txt`;
        const { data, info } = await sharp(imagePath)
            .resize(sizeX, sizeY)
            .raw()
            .toBuffer({ resolveWithObject: true });

        let frameData = "";
        for (let y = 0; y < info.height; y++) {
            for (let x = 0; x < info.width; x++) {
                const pixelIndex = (y * info.width + x) * info.channels;
                const brightness =
                    0.2126 * data[pixelIndex] +
                    0.7152 * data[pixelIndex + 1] +
                    0.0722 * data[pixelIndex + 2];
                frameData += brightness > 128 ? "0" : "1";
            }
            frameData += "\n";
        }

        fs.writeFileSync(frameDataPath, frameData);
        console.log(`フレーム${frameNumber}を処理`);
    } catch (error) {
        console.error(`フレーム処理エラー${frameNumber}:`, error);
    }
}

ffmpeg(videoPath)
    .output(`${framesDir}/frame_%04d.png`)
    .outputOptions(["-vf", `fps=${frameRate}`])
    .on("end", async () => {
        console.log("フレームの抽出が完了しました！データを生成します");

        const frameFiles = fs.readdirSync(framesDir).sort();
        await Promise.all(
            frameFiles.map((file, i) => processFrame(`${framesDir}/${file}`, i + 1))
        );

        console.log("すべてのフレームデータが生成されました！");
    })
    .on("error", (err) => {
        console.error("FFmpeg エラー:", err);
    })
    .run();

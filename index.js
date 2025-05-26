const fs = require("fs");
const ffmpeg = require("fluent-ffmpeg");
const processMonochromeFrame = require("./util/monochrome");
const processColourFrame = require("./util/colour");

const configData = fs.readFileSync("config.json");
const config = JSON.parse(configData);

config.monochrome.processFrame = processMonochromeFrame;
config.colour.processFrame = processColourFrame;

const { videoPath, framesDir, frameRate, processMode } = config;
const currentConfig = config[processMode];

if (!currentConfig) {
    console.error("無効な処理モードが指定されました。'monochrome' または 'colour' を指定してください。");
    process.exit(1);
}

if (!fs.existsSync(framesDir)) fs.mkdirSync(framesDir);
if (!fs.existsSync(currentConfig.framesDataDir)) fs.mkdirSync(currentConfig.framesDataDir);

ffmpeg.ffprobe(videoPath, (err, metadata) => {
    if (err) {
        console.error(err);
        return;
    }
    const duration = metadata.format.duration;
    const videoStream = metadata.streams.find(stream => stream.codec_type === 'video');
    const fps = eval(videoStream.r_frame_rate);
    const totalFrames = Math.floor(duration * fps);
    console.log(`動画の全フレーム数: ${totalFrames}`);
});

ffmpeg(videoPath)
    .output(`${framesDir}/frame_%04d.png`)
    .outputOptions([`-vf fps=${frameRate}`])
    .on("end", async () => {
        console.log("フレームの抽出が完了しました！");

        const frameFiles = fs.readdirSync(framesDir).sort();

        for (let i = 0; i < frameFiles.length; i++) {
            const file = frameFiles[i];
            const frameNumber = i + 1;
            try {
                await currentConfig.processFrame(`${framesDir}/${file}`, frameNumber, currentConfig);
                console.log(`フレーム${frameNumber}を処理`);
            } catch (error) {
                console.error(`フレーム処理エラー${frameNumber}:`, error);
            }
        }

        console.log("すべてのフレームデータが生成されました！");
    })
    .on("error", (err) => {
        console.error("FFmpeg エラー:", err);
    })
    .run();

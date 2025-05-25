local frameDataDir = "./colour-frames_data" -- フレームデータのディレクトリのパス
local frameHeight = 25 -- 縦サイズ（colour-index.jsのサイズと同じにする）
local sizeX = 33 -- 横サイズ（colour-index.jsのサイズと同じにする）
local totalFrames = 2151 -- 何フレーム分描画するのか（テキストファイルの個数分を書く）
local pixelWidth = 0.1 -- 各ピクセルに対応するアイテムの長さ

function rgbToReaperColor(r, g, b)
    return 0x01000000 + r + g * 256 + b * 65536
end


function initializeTracks()
    while reaper.CountTracks(0) > 0 do
        local track = reaper.GetTrack(0, 0)
        reaper.DeleteTrack(track)
    end

    for i = 1, frameHeight do
        reaper.InsertTrackAtIndex(i - 1, false)
    end
end

function loadFrameData(frameNumber)

    local frameFilePath = frameDataDir .. "\\frame_" .. frameNumber .. ".txt"

    reaper.ShowConsoleMsg("フレームを処理" .. frameFilePath .. "\n")

    local file = io.open(frameFilePath, "r")
    if not file then
        reaper.ShowConsoleMsg("エラー: フレームファイルを読み込めません: " .. frameFilePath .. "\n")

        return nil
    end

    local data = {}
    local y = 1

    for line in file:lines() do
        data[y] = {}
        local lineLength = string.len(line)
        local expectedLength = sizeX * 6

        if lineLength ~= expectedLength then
             reaper.ShowConsoleMsg(string.format("Warning: Line length mismatch in frame %d, row %d. Expected %d characters, got %d.\n", frameNumber, y, expectedLength, lineLength))

        end

        for x = 1, sizeX do
            local startIndex = (x - 1) * 6 + 1
            local endIndex = startIndex + 5

            if endIndex > lineLength then

                break
            end

            local hexColor = string.sub(line, startIndex, endIndex)

            local hexR = string.sub(hexColor, 1, 2)
            local hexG = string.sub(hexColor, 3, 4)
            local hexB = string.sub(hexColor, 5, 6)

            local r = tonumber(hexR, 16) or 0
            local g = tonumber(hexG, 16) or 0
            local b = tonumber(hexB, 16) or 0

            table.insert(data[y], {r, g, b})

        end
        y = y + 1
    end
    file:close()

    if y - 1 ~= frameHeight then
         reaper.ShowConsoleMsg(string.format("Warning: Row count mismatch in frame %d. Expected %d rows, got %d.\n", frameNumber, frameHeight, y - 1))
    end


    return data
end

function processTrack(frameData, y)
    local track = reaper.GetTrack(0, y - 1)
    if not track then
        return
    end

    local rowData = frameData[y]
    if not rowData then
        return
    end

    for x = 1, #rowData do
        local pixelColor = rowData[x]
        local r, g, b = pixelColor[1], pixelColor[2], pixelColor[3]

        if r ~= nil and g ~= nil and b ~= nil and (r ~= 0 or g ~= 0 or b ~= 0) then
            local startPos = (x - 1) * pixelWidth
            local itemLength = pixelWidth

            local item = reaper.AddMediaItemToTrack(track)
            if item then
                reaper.SetMediaItemInfo_Value(item, "D_POSITION", startPos)
                reaper.SetMediaItemInfo_Value(item, "D_LENGTH", itemLength)

                local color = rgbToReaperColor(r, g, b)
                reaper.SetMediaItemInfo_Value(item, "I_CUSTOMCOLOR", color)
            end
        end
    end
end

function drawFrame(frameData)
    for y = 1, frameHeight do
        processTrack(frameData, y)
    end
    reaper.UpdateArrange()
end

function clearItems()
    for i = 0, reaper.CountTracks(0) - 1 do
        local track = reaper.GetTrack(0, i)
        if track then
            while reaper.CountTrackMediaItems(track) > 0 do
                local item = reaper.GetTrackMediaItem(track, 0)
                if item then
                    reaper.DeleteTrackMediaItem(track, item)
                end
            end
        end
    end
end

function processFrame(frameNumber)
    if frameNumber > totalFrames then
        reaper.ShowConsoleMsg("すべてのフレームが処理されました\n")
        return
    end

    local frameData = loadFrameData(frameNumber)
    if not frameData then
        reaper.defer(function()
            processFrame(frameNumber + 1)
        end)
        return
    end

    clearItems()
    drawFrame(frameData)

    reaper.defer(function()
        processFrame(frameNumber + 1)
    end)
end

function main()
    reaper.ShowConsoleMsg("スクリプト開始\n")
    initializeTracks()
    processFrame(1)
end

main()

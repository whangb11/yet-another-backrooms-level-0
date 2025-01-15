--LICENSE
local SVG_AND_SCRIPT_LICENSE <const> = [=[<!--
DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
Version 2, December 2004 

Copyright (C) 2025 u5df2u901d <BaiduTieba@u5df2u901d> 

Everyone is permitted to copy and distribute verbatim or modified 
copies of this file, and changing it is allowed as long 
as the name is changed. 

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

0. You just DO WHAT THE FUCK YOU WANT TO.
-->
]=]

local OUT_FILE_PATH <const> = "./wallpaper.svg"
local BACKGROUND_COLOR <const> = '"#999953"'
local RING_FILL_COLOR <const> = '"#999967"'
local PATTERN_COLOR <const> = '"#7a7740"'

local SVG_SIZE_X <const> = "256"
local SVG_SIZE_Y <const> = "256"

local SVG_HEAD <const> = SVG_AND_SCRIPT_LICENSE..'\n<svg width="'..SVG_SIZE_X..'" height="'..SVG_SIZE_Y..'" xmlns="http://www.w3.org/2000/svg">\n<!-- background --><rect width="'..SVG_SIZE_X..'" height="'..SVG_SIZE_Y..'" fill='..BACKGROUND_COLOR..'/>\n'
local SVG_END <const> = '</svg>\n'

local function doSvgWrite()
    local ofile, errmsg = io.open(OUT_FILE_PATH, "w+")

    if not ofile then
        error("failed to open file:" .. OUT_FILE_PATH .. "\ninfo:" .. errmsg)
    end
    ofile:write(SVG_HEAD)
    --generate vertical seperation lines
    for x = 14, 128 * 2, 128 do
        for y = -50, 300, 32 do
            local ellipseToWrite = '\t<ellipse cx="'..tostring(x)..'" cy="'..tostring(y)..'" rx="12" ry="24" stroke='..PATTERN_COLOR..' stroke-width="4" fill='..RING_FILL_COLOR..'/><ellipse cx="'..tostring(x)..'" cy="'..tostring(y)..'" rx="6" ry="15" fill='..PATTERN_COLOR..'/>\n'
            ofile:write(ellipseToWrite)
        end
    end

    --generate arrows
    local pointLocations = { { 32, 30 }, { 78, 0 }, { 124, 30 } }
    local thickness = { 20, 20, 4 }
    local spacing = { 0, 25, 89 }--mystic magic numbers

    local xpitch = 128
    local ypitch = 128

    for idx = 0, 1, 1 do
        for i = 1, 3 do
            local points = '"'
            for j = 1, 3 do
                points=points..tostring(pointLocations[j][1] + xpitch * idx)..","..tostring(pointLocations[j][2] + ypitch * idx + spacing[i])..","
            end

            for j = 3, 1, -1 do
                points=points..tostring(pointLocations[j][1] + xpitch * idx)..","..tostring(pointLocations[j][2] + ypitch * idx + spacing[i] + thickness[i])
                if j ~= 1 then
                    points = points .. ","
                end
            end
            points = points .. '"'
            local polygonToWrite=' <polygon points='..points..' fill="#7a7740"/>\n'
            ofile:write(polygonToWrite)
        end

    end
    ofile:write(SVG_END)
    ofile:close()
end

local success, einfo = pcall(doSvgWrite)

if not success then
    print(einfo)
else
    print("success")
end

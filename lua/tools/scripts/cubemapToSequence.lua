local fs = require "lua.tools.scripts.modules.fs"
local argparse = require "lua.tools.scripts.modules.argparse"
local luna = require "lua.modules.luna"

local parser = argparse("cubemapToSequence", "Convert a cubemap to a sequence of images")
parser:argument("cubemap", "The cubemap to convert")
parser:option("-s --size", "The size of the cubemap faces"):convert(tonumber)
local args = parser:parse()

local segmentMapping = {
    {4, -90, 1},
    {5, 180, 2},
    {6 , 90, 3},
    {7, 0, 4},
    {0, -90, 5},
    {8, -90, 6}
}

local function getCubemapSize(cubemap)
    local size = io.popen("identify -format \"%w\" " .. cubemap):read("*a")
    return tonumber(size) / 4
end

local function convertCubemapToSegment(cubemap, output, size)
    local cmd = "convert " .. cubemap .. " -crop " .. size .. "x" .. size .. " +repage +adjoin " ..
                    output .. "/%d.png"
    os.execute(cmd)
end

if not fs.is(args.cubemap) then
    print("Cubemap file does not exist")
    return
end

local size = args.size or getCubemapSize(args.cubemap)
local output = args.cubemap:replace(".png", "") .. "_sequence"
if not fs.is(output) then
    fs.mkdir(output)
end
convertCubemapToSegment(args.cubemap, output, size)

for i, v in ipairs(segmentMapping) do
    local segment = output .. "/" .. v[1] .. ".png"
    local sequence = output .. "/" .. v[3] .. "_seq.png"
    local cmd = "convert " .. segment .. " -rotate " .. v[2] .. " " .. sequence
    os.execute(cmd)
end

local cmd = "convert -bordercolor blue -compose copy -border 1 +append "
for i,v in ipairs(segmentMapping) do
    cmd = cmd .. output .. "/" .. v[3] .. "_seq.png "
end
cmd = cmd .. output .. "/final.png"
os.execute(cmd)

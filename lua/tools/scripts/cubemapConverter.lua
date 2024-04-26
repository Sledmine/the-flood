package.path = package.path .. ";lua/tools/scripts/modules/?.lua"
local fs = require "lua.tools.scripts.modules.fs"
local argparse = require "lua.tools.scripts.modules.argparse"
local luna = require "lua.lua_modules.luna"

---@class CubemapConverterArgs
---@field cubemap string
---@field size number
---@field sequences boolean
---@field standard boolean

local parser = argparse("Cubemap Converter", "Convert a cubemap to different formats")
parser:argument("cubemap", "The cubemap to convert")
parser:option("--size", "The size of the cubemap faces"):convert(tonumber)
parser:flag("--sequences", "Convert the cubemap to a sequence of images for Halo CE")
parser:flag("--standard", "Convert the cubemap from a standard format to a Halo CE format")

---@type CubemapConverterArgs
local args = parser:parse()

local function getCubemapSize(cubemap)
    local size = io.popen("identify -format \"%w\" " .. cubemap):read("*a")
    return tonumber(size) / 4
end

local output = args.cubemap:replace(".png", "") .. "_segment"
if not fs.is(args.cubemap) then
    print("Cubemap file does not exist")
    return
end

local size = args.size or getCubemapSize(args.cubemap)
print("Cubemap size: " .. size)
if not fs.is(output) then
    fs.mkdir(output)
end

local standardCubemapToHaloCE = {
    {1, 0},
    {4, 10},
    {5, 4},
    {6, 5},
    {7, 6},
    {9, 8},
    {10, 7}
}

local segmentToSequencesMapping = {
    {4, -90, 1},
    {5, 180, 2},
    {6 , 90, 3},
    {7, 0, 4},
    {0, -90, 5},
    {8, -90, 6}
}

local function convertCubemapToSegments(cubemap, output, size)
    local cmd = "convert " .. cubemap .. " -crop " .. size .. "x" .. size .. " +repage +adjoin " ..
                    output .. "/%d.png"
    os.execute(cmd)
end

local function convertStandardSegmentsToHaloCE()
    for i, v in ipairs(standardCubemapToHaloCE) do
        local segment = output .. "/" .. v[1] .. ".png"
        local newSegment = output .. "/" .. v[2] .. ".png"
        local tempSegment = output .. "/temp.png"
        local success, message = os.rename(newSegment, tempSegment)
        if not success then
            print(message)
            os.exit(1)
        end
        local success, message = os.rename(segment, newSegment)
        if not success then
            print(message)
            os.exit(1)
        end
        local success, message = os.rename(tempSegment, segment)
        if not success then
            print(message)
            os.exit(1)
        end
    end
end

-- I know this is a mess, but it works
local function convertSequencesToCubemap()
    local cmd = "cd " .. output .. " && convert -compose copy +append "
    for i = 0, 3 do
        cmd = cmd .. i .. ".png "
    end
    cmd = cmd .. "cubemap_0.png"
    assert(os.execute(cmd))

    cmd = "cd " .. output .. " && convert -compose copy +append "
    for i = 4, 7 do
        cmd = cmd .. i .. ".png "
    end
    cmd = cmd .. "cubemap_1.png"
    assert(os.execute(cmd))

    cmd = "cd " .. output .. " && convert -compose copy +append "
    for i = 8, 11 do
        cmd = cmd .. i .. ".png "
    end
    cmd = cmd .. "cubemap_2.png"
    assert(os.execute(cmd))

    cmd = "cd " .. output .. " && convert -compose copy -append "
    for i = 0, 2 do
        cmd = cmd .. "cubemap_" .. i .. ".png "
    end
    cmd = cmd .. "../" .. args.cubemap:replace(".png", "") .. "_reconstructed.png"
    print(cmd)
    assert(os.execute(cmd))

    os.execute("rm -rf " .. output)
end

convertCubemapToSegments(args.cubemap, output, size)
if args.standard then
    convertStandardSegmentsToHaloCE()
end
if args.sequences then
    for i, v in ipairs(segmentToSequencesMapping) do
        local segment = output .. "/" .. v[1] .. ".png"
        local sequence = output .. "/" .. v[3] .. "_seq.png"
        local cmd = "convert " .. segment .. " -rotate " .. v[2] .. " " .. sequence
        os.execute(cmd)
    end
    
    local cmd = "convert -bordercolor blue -compose copy -border 1 +append "
    for i,v in ipairs(segmentToSequencesMapping) do
        cmd = cmd .. output .. "/" .. v[3] .. "_seq.png "
    end
    cmd = cmd .. args.cubemap:replace(".png", "") .. "_sequence.png"
    os.execute(cmd)
    os.execute("rm -rf " .. output)
    return
end
convertSequencesToCubemap()

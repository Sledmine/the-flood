package.path = package.path .. [[;./lua/?.lua;./lua/scripts/modules/?.lua]]
local fs = require "fs"

local inputPath = arg[1]
local fbxPath = inputPath .. "\\fbx"
local jmsPath = inputPath .. "\\models"

for nameFbx, entry in fs.dir(fbxPath) do
    if not nameFbx then
        print("error: ", entry)
        break
    end
    local nameJms = nameFbx:gsub(".fbx", ".jms"):gsub(".FBX", ".jms")
    local command = ("hek\\harvest_h1a_tool fbx-to-jms \"$input\" \"$output\""):gsub("%$(%w+)",
                                                                                         {
        input = entry:path(),
        output = jmsPath .. "\\" .. nameJms
    })
    os.execute(command)
end
fs.remove("gamestate.txt")
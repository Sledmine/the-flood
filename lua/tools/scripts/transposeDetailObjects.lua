local tag = require "tools.modules.tag"
local inspect = require "inspect"
require "lua.lua_modules.luna"

local bspPath = arg[1]:replace("tags/", "")
local transposedBspPath = arg[2]:replace("tags/", "")

local cellEntries = {}
-- Get detail objects blocks
local cellsCount = tag.count(bspPath, "detail_objects[0].cells")
for cellIndex = 0, cellsCount - 1 do
    local key = "detail_objects[0].cells"
    local cell = {}
    local props = {
        "cell_x",
        "cell_y",
        "cell_z",
        "offset_z",
        "valid_layers_flags",
        "start_index",
        "count_index"
    }
    local values = tag.getMultiple(bspPath, key, cellIndex, props)
    assert(values, "Error at attempting to read: " .. bspPath .. " " .. key)

    for i, prop in ipairs(props) do
        cell[prop] = values[i]
    end

    table.insert(cellEntries, cell)
end

local instancesEntries = {}
local instancesCount = tag.count(bspPath, "detail_objects[0].instances")
for instanceIndex = 0, instancesCount - 1 do
    local key = "detail_objects[0].instances"
    local instance = {}
    local props = {"position_x", "position_y", "position_z", "data", "color"}
    local values = tag.getMultiple(bspPath, key, instanceIndex, props)
    assert(values, "Error at attempting to read: " .. bspPath .. " " .. key)

    for i, prop in ipairs(props) do
        instance[prop] = values[i]
    end

    table.insert(instancesEntries, instance)
end

local countsEntries = {}
local countsCount = tag.count(bspPath, "detail_objects[0].counts")
for countIndex = 0, countsCount - 1 do
    local key = "detail_objects[0].counts"
    local count = {}
    local props = {"count"}
    local values = tag.getMultiple(bspPath, key, countIndex, props)
    assert(values, "Error at attempting to read: " .. bspPath .. " " .. key)

    for i, prop in ipairs(props) do
        count[prop] = values[i]
    end

    table.insert(countsEntries, count)
end

local edit = {
    detail_objects = {{cells = cellEntries, instances = instancesEntries, counts = countsEntries}}
}

local blocks = {"cells", "instances", "counts"}

for _, block in ipairs(blocks) do
    local currentBlock = edit.detail_objects[1][block]
    if tag.count(transposedBspPath, "detail_objects[0]." .. block) < #currentBlock then
        tag.insert(transposedBspPath, "detail_objects[0]." .. block, #currentBlock, "end")
    end
    print("Transposing " .. block)
    -- Split the block into chunks of 400, but keep chunk indexes
    local chunks = {}
    for i = 1, #currentBlock, 400 do
        table.insert(chunks, table.map(currentBlock, function(v, k)
            return k >= i and k < i + 400 and v or nil
        end))
    end
    print("Chunks: " .. #chunks)
    for k, v in ipairs(chunks) do
        print("Transposing chunk " .. k)
        tag.edit(transposedBspPath, {detail_objects = {[1] = {[block] = v}}})
    end
end

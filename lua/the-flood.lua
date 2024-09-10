local balltze = Balltze
local engine = Engine
require "luna"

local main
local multiplayerMaps = {"treason", "bleed_it_out", "last_voyage", "impasse", "aqueduct"}

local function isMultiplayerMap(mapName)
    for _, map in pairs(multiplayerMaps) do
        if mapName == map or mapName == map .. "_dev" then
            return true
        end
    end
    return false
end

function PluginMetadata()
    return {
        name = "Helljumper Multiplayer",
        author = "Keymind Dev Team",
        version = "4.5.4",
        targetApi = "1.0.0-rc.1",
        reloadable = true
    }
end

function PluginInit()
    engine.core.consolePrint("plugin init")
    logger = balltze.logger.createLogger("helljumper")
    -- Replace Chimera functions with Balltze functions
    execute_script = engine.hsc.executeScript
    write_bit = function(address, bit, value)
        local byte = read_byte(address)
        if value then
            byte = byte | (1 << bit)
        else
            byte = byte & ~(1 << bit)
        end
        write_byte(address, byte)
    end
    write_byte = balltze.memory.writeInt8
    write_word = balltze.memory.writeInt16
    write_dword = balltze.memory.writeInt32
    write_int = balltze.memory.writeInt32
    write_float = balltze.memory.writeFloat
    write_string = function(address, value)
        for i = 1, #value do
            write_byte(address + i - 1, string.byte(value, i))
        end
        if #value == 0 then
            write_byte(address, 0)
        end
    end

    balltze.event.mapLoad.subscribe(function(event)
        if event.time == "after" then
            local currentMap = event.context:mapName()
            engine.core.consolePrint("map loaded: " .. currentMap)
            if isMultiplayerMap(currentMap) then
                if not main then
                    logger:info("loading main")
                    main = require "the_flood.main"
                end
            else
                if main then
                    main.unload()
                    package.loaded["the_flood.main"] = nil
                    for k, v in pairs(package.loaded) do
                        if k:includes "the_flood" then
                            package.loaded[k] = nil
                        end
                    end
                    main = nil
                end
            end
        end
    end)
end

function PluginLoad()
    -- Load Chimera compatibility
    for k, v in pairs(balltze.chimera) do
        if not k:includes "timer" and not k:includes "execute_script" then
            _G[k] = v
        end
    end

    local currentMap = engine.map.getCurrentMapHeader().name
    if isMultiplayerMap(currentMap) then
        if not main then
            main = require "the_flood.main"
        end
    end
end

function PluginUnload()
end

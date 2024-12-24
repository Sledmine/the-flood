local balltze = Balltze
local engine = Engine
package.preload["luna"] = nil
package.loaded["luna"] = nil
require "luna"

--local main
local loadWhenIn = {
    "treason",
    "bleed_it_out",
    "last_voyage",
    "impasse",
    "aqueduct"
}

loadWhenIn = table.extend(loadWhenIn, table.map(loadWhenIn, function(map)
    return map .. "_dev"
end))

function PluginMetadata()
    return {
        name = "Helljumper Multiplayer",
        author = "Keymind Dev Team",
        version = "5.0.0",
        targetApi = "1.0.0",
        reloadable = true,
        maps = loadWhenIn
    }
end

local function loadChimeraCompatibility()
    -- Load Chimera compatibility
    for k, v in pairs(balltze.chimera) do
        if not k:includes "timer" and not k:includes "execute_script" and
            not k:includes "set_callback" then
            _G[k] = v
        end
    end
    server_type = engine.netgame.getServerType()

    -- Replace Chimera functions with Balltze functions
    write_bit = balltze.memory.writeBit
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
    execute_script = engine.hsc.executeScript
end

local main

function PluginLoad()
    logger = balltze.logger.createLogger("Helljumper")
    logger:muteDebug(not DebugMode)

    loadChimeraCompatibility()

    balltze.event.tick.subscribe(function(event)
        if event.time == "before" then
            if not main then
                main = require "the_flood.main"
            end
        end
    end)

    return true
end

function PluginUnload()
end
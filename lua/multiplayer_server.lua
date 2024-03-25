api_version = "1.12.0.0"
require "compat53"
require "luna"
blam = require "blam"
local healthRegen

function OnTick()
    for playerIndex = 1, 16 do
        if player_alive(playerIndex) then
            healthRegen.regenerateHealth(playerIndex)
        end
    end
end

function OnMapLoad()
    healthRegen = require "the_flood.gameplay_core.healthRegen"
    set_callback("tick", "OnTick")
end

function OnRconMessage(playerIndex, message, password)
    return blam.rcon.handle(message, password, playerIndex)
end

function OnScriptLoad()
    set_callback("map load", "OnMapLoad")
    set_callback("rcon message", "OnRconMessage")
    blam.rcon.patch()
end

function OnError()
    console_out(debug.traceback())
end

function OnScriptUnload()
    blam.rcon.unpatch()
end

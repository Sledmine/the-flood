api_version = "1.12.0.0"
require "compat53"
require "luna"
blam = require "blam"
local gameplay

function OnTick()
    for playerIndex = 1, 16 do
        if player_alive(playerIndex) then
            gameplay.regenerateHealth(playerIndex)
        end
    end
end

function OnMapLoad()
    gameplay = require "multiplayer.features.gameplay"
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

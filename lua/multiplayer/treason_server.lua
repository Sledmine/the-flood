api_version = "1.12.0.0"
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
    --register_callback(cb["EVENT_TICK"], "OnTick")
    set_callback("tick", "OnTick")

    blam.rcon.event("Ping", function()
        return "Pong"
    end)
end

function OnRconMessage(playerIndex, message, password)
    return blam.rcon.handle(message, password, playerIndex)
end

function OnScriptLoad()
    --register_callback(cb["EVENT_GAME_START"], "OnGameStart")
    set_callback("map load", "OnMapLoad")
    set_callback("rcon message", "OnRconMessage")
end

function OnError()
    cprint(debug.traceback())
end

function OnScriptUnload()
end

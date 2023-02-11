api_version = "1.12.0.0"

blam = require "blam"
local gameplay

function OnTick()
    for playerIndex = 1,16 do
        if player_alive(playerIndex) then
            gameplay.regenerateHealth(playerIndex)
        end
    end
end

function OnGameStart()
    gameplay = require "multiplayer.features.gameplay"
    register_callback(cb['EVENT_TICK'], "OnTick")
end

function OnScriptLoad()
    register_callback(cb['EVENT_GAME_START'], "OnGameStart")
end

function OnError()
    cprint(debug.traceback())
end

function OnScriptUnload()
end
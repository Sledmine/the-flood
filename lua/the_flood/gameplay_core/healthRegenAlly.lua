-- Lua libraries
local const = require "the_flood.constants"

local healthRegenAlly = {}

--- Regenerate player health on low shield using game ticks on singleplayer
function healthRegenAlly.regenerateHealth()
    local ally = (const.biped.odstAlly)
    if (ally) then
        -- Fix muted audio shield sync
        if (server_type == "local") then
            if (ally.health <= 0) then
                ally.health = 0.000000001
            end
        end
        if (ally.health < 1 and ally.shield >= 1) then
            local newAllyHealth = ally.health + const.healthRegenerationAmount
            if (newAllyHealth > 1) then
                ally.health = 1
            else
                ally.health = newAllyHealth
            end
        end
    end
end

return healthRegenAlly

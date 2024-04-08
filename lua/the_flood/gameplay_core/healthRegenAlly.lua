-- Lua libraries
local const = require "the_flood.constants"

local healthRegenAlly = {}

--- Regenerate player health on low shield using game ticks on singleplayer
function healthRegenAlly.regenerateHealth()
    local allyId = const.biped.odstAlly.id
    local ally = blam.biped(get_object(allyId))
    local player = blam.biped(get_dynamic_player())
    if (ally) and (player) then
        local tag = blam.getTag(ally.tagId)
        assert(tag, "Tag not found")
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

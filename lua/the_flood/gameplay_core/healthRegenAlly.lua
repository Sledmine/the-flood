-- Lua libraries
local const = require "the_flood.constants"

local healthRegenAlly = {}

--- Regenerate a designated biped health on low shield using game ticks on singleplayer
function healthRegenAlly.regenerateHealth()
    for objectId, index in pairs(blam.getObjects()) do
        local object = blam.getObject(objectId)
        if object then
            local tagId = object.tagId
            if tagId == const.biped.odstAllyTag.id then
                --console_out("juasjuasjuas")
                if object.health < 1 and object.shield > 0.95 then
                    object.health = object.health + const.healthRegenAiAmount
                    if object.health > 1 then
                        object.health = 1
                    end
                end
            end
        end
    end
end

return healthRegenAlly

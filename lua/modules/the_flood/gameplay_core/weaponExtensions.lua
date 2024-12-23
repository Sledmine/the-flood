local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local getTag = Engine.tag.getTag
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer

local weaponExtensions = {}

function weaponExtensions.casterFixHeat()
    --for playerIndex = 0,15 do
        local player = getPlayer()
        if player then
            local biped = getObject(player.objectHandle, engine.tag.objectType.biped)
            if biped then
                for weaponIndex = 1,4 do
                    local weapon = getObject(biped.weapons[weaponIndex], engine.tag.objectType.weapon)
                    if weapon then
                        logger:debug("Weapon: {} Ammo: {}", weaponIndex, weapon.magazines[1].roundsLoaded)
                    end
                end
            end
        end
    --end
end

return weaponExtensions
-- Lua libraries
local const = require "the_flood.constants"

local aimingDownSights = {}

--- Attempt to play a sound given tag path and optionally a gain number
function aimingDownSights.playSound(tagPath, gain)
    local player = blam.player(get_player())
    if (player) then
        local playSoundCommand = const.hsc.playSound:format(tagPath, player.index, gain or 1.0)
        execute_script(playSoundCommand)
    end
end

-- ADS system for some weapons
function aimingDownSights.adsSystem()
    local player = blam.biped(get_dynamic_player())
    if player then
        -- local currentWeapon = read_word(player + 0x118) -- current weapon
        -- local objectType = read_word(player + 0xB4) -- (0 = Biped) (1 = Vehicle) (2 = Weapon) (3 = Equipment) (4 = Garbage) (5 = Projectile) (6 = Scenery) (7 = Machine) (8 = Control) (9 = Light Fixture) (10 = Placeholder) (11 = Sound Scenery)
        -- console_out("ADS Working")
        if player.actionKey then -- and objectType == 2 and currentWeapon then
            local tag = blam.getTag(player.tagId)
            assert(tag, "Tag not found")
            local fieldOfView = math.deg(read_float(tag.data + 0x1A0))
            console_out("FOV: " .. fieldOfView)
            if fieldOfView > 60 then
                write_float(tag.data + 0x1A0, math.rad(55))
                aimingDownSights.playSound(const.sounds.humanRifleZoomIn, 5)
            else
                write_float(tag.data + 0x1A0, math.rad(70))
                aimingDownSights.playSound(const.sounds.humanRifleZoomOut, 5)
            end
        end
    end
end

return aimingDownSights

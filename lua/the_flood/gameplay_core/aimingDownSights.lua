-- Lua libraries
local const = require "the_flood.constants"

local aimingDownSights = {}

function aimingDownSights.adsSystem()
    local player = blam.biped(get_dynamic_player())
    if player then
        -- local currentWeapon = read_word(player + 0x118) -- current weapon
        -- local objectType = read_word(player + 0xB4) -- (0 = Biped) (1 = Vehicle) (2 = Weapon) (3 = Equipment) (4 = Garbage) (5 = Projectile) (6 = Scenery) (7 = Machine) (8 = Control) (9 = Light Fixture) (10 = Placeholder) (11 = Sound Scenery)
        -- console_out("ADS Working")
        if player.actionKey then -- and objectType == 2 and currentWeapon then
            local tag = blam.getTag(player.tagId)
            assert(tag, "Tag not found")
            local fieldOfView = read_dword(tag.data + 0x1A0)
            console_out("FOV: " .. fieldOfView)
            if fieldOfView == 70 then
                write_dword(tag.data + 0x1A0, 50)
            else
                write_dword(tag.data + 0x1A0, 70)
            end
        end
    end
end

return aimingDownSights

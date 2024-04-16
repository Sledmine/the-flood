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
    local playerBiped = blam.biped(get_dynamic_player())
    if playerBiped then
        console_out("Weapon Slot: " .. playerBiped.weaponSlot)
        local weaponId = playerBiped.firstWeaponObjectId
        if playerBiped.weaponSlot == 1 then
            weaponId = playerBiped.secondWeaponObjectId
        elseif playerBiped.weaponSlot == 2 then
            weaponId = playerBiped.thirdWeaponObjectId
        elseif playerBiped.weaponSlot == 3 then
            weaponId = playerBiped.fourthWeaponObjectId
        end
        if not blam.isNull(weaponId) then
            local weapon = blam.weapon(get_object(weaponId))
            assert(weapon, "weapon found")
            local weaponTagId = weapon.tagId
            if weaponTagId == const.weapons.ma38Tag.id then
                console_out(blam.getTag(weaponTagId).path)
                console_out(const.weapons.ma38Tag.path)
                if playerBiped.actionKey then
                    local tag = blam.getTag(playerBiped.tagId)
                    assert(tag, "Tag not found")
                    local adsZoom = math.deg(read_float(tag.data + 0x1A0))
                    console_out("Zoom Rad: " .. adsZoom)
                    if adsZoom > 60 then
                        write_float(tag.data + 0x1A0, math.rad(55))
                        aimingDownSights.playSound(const.sounds.humanRifleZoomIn, 5)
                    else
                        write_float(tag.data + 0x1A0, math.rad(70))
                        aimingDownSights.playSound(const.sounds.humanRifleZoomOut, 5)
                    end
                end
            end
        end
    end
end

return aimingDownSights

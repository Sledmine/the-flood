-- Lua libraries
local const = require "the_flood.constants"

--Keyboard keys reference:
--17="1", 18="2", 19="3", 20="4", 2="5", 22="6", 23="7", 24="8", 25="9", 26="10", 27="Minus", 28="Equal", 30="Tab", 31="Q", 32="W", 33="E", 34="R", 35="T", 36="Y", 37="U", 38="I", 39="O", 40="P", 43="Backslash",
--44="Caps Lock", 45="A", 46="S", 47="D", 48="F", 49="G", 50="H", 51="J", 52="K", 53="L", 56="Enter", 57="Shift", 58="Z", 59="X", 60="C", 61="V", 62="B", 63="N", 64="M", 69="Ctrl",71="Alt",72="Space",

local aimingDownSights = {}

local keyboard_input_address = 0x64C550

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
        --console_out("Weapon Slot: " .. playerBiped.weaponSlot)
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
            --console_out(blam.getTag(weaponTagId).path)
            --console_out(const.weapons.ma38Tag.path)
            local tag = blam.getTag(playerBiped.tagId)
            assert(tag, "Tag not found")
            local adsZoom = math.deg(read_float(tag.data + 0x1A0))
            --Custom Key to press for activate ads
            local altKeyPressed = read_byte(keyboard_input_address + 71)
            if weaponTagId == const.weapons.ma38Tag.id and playerBiped.firstWeaponObjectId then
                if adsZoom > 69 and altKeyPressed > 0 then
                    write_float(tag.data + 0x1A0, math.rad(55))
                    aimingDownSights.playSound(const.sounds.humanRifleZoomIn, 5)
                    console_out("Zoom Rad: " .. adsZoom)
                elseif adsZoom < 69 and playerBiped.reloadKey then
                    write_float(tag.data + 0x1A0, math.rad(70))
                    aimingDownSights.playSound(const.sounds.humanRifleZoomOut, 5)
                    console_out("Zoom Rad: " .. adsZoom)
                end
            end
        end
    end
end

return aimingDownSights

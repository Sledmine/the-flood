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
    local player = blam.biped(get_dynamic_player ())
    if player then
        if player.actionKey then
            local tag = blam.getTag(player.tagId)
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

return aimingDownSights
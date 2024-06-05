-- Lua libraries
local const = require "the_flood.constants"


local hudExtensions = {state = {playerCriticalHealth = false}}

---Improvements for HUD, hide HUD on zoom
function hudExtensions.radarHideOnZoom()
    local player = blam.biped(get_dynamic_player())
    if player then
        -- console_out(playerObject.zoomLevel)
        if not blam.isNull(player.zoomLevel) then
            execute_script("hud_show_motion_sensor 0")
        else
            execute_script("hud_show_motion_sensor 1")
        end
    end
end

--- Attempt to play a sound given tag path and optionally a gain number
function hudExtensions.playSound(tagPath, gain)
    local player = blam.player(get_player())
    if (player) then
        local playSoundCommand = const.hsc.playSound:format(tagPath, player.index, gain or 1.0)
        execute_script(playSoundCommand)
    end
end

--- play a sound when you change grenade type
function hudExtensions.changeGreandeSound()
    local player = blam.biped(get_dynamic_player())
    -- Player must exist
    -- local playerData = blam.player(get_player())
    -- Player must exist and not be a monitor
    if (player) then
        local isPlayerOnMenu = read_byte(blam.addressList.gameOnMenus) == 0
        if not isPlayerOnMenu then
            local localPlayer = read_dword(const.localPlayerAddress)
            local currentGrenadeType = read_word(localPlayer + 202)
            if not blam.isNull(currentGrenadeType) then
                if (not lastGrenadeType) then
                    lastGrenadeType = currentGrenadeType
                end
                if lastGrenadeType ~= currentGrenadeType then
                    lastGrenadeType = currentGrenadeType
                    if lastGrenadeType == 1 then
                        hudExtensions.playSound(const.sounds.uiPGrenadePath, 3)
                    else
                        hudExtensions.playSound(const.sounds.uiFGrenadePath, 3)
                    end
                end
            end
        end
    end
end

-- Blur HUD vision on critical health
function hudExtensions.hudBlurOnLowHealth()
    local player = blam.biped(get_dynamic_player())
    if player then
            if player.health <= 0.25 and player.shield <= 0 and blam.isNull(player.vehicleObjectId) then
                if not hudExtensions.state.playerCriticalHealth then
                    hudExtensions.state.playerCriticalHealth = true
                    hudExtensions.hudBlur(true)
                end
            else
                if hudExtensions.state.playerCriticalHealth then
                    hudExtensions.hudBlur(false)
                end
                hudExtensions.state.playerCriticalHealth = false
            end
    elseif hudExtensions.state.playerCriticalHealth then
        hudExtensions.hudBlur(false, true)
        hudExtensions.state.playerCriticalHealth = false
    end
end

--- HUD Blur
function hudExtensions.hudBlur(enableBlur, immediate)
    if enableBlur then
        execute_script([[(begin
                            (cinematic_screen_effect_start true)
                            (cinematic_screen_effect_set_convolution 2 1 1 1 5)
                            (cinematic_screen_effect_start false)
                        )]])
        return true
    end
    if not enableBlur and immediate then
        execute_script([[(begin
                        (cinematic_screen_effect_set_convolution 2 1 1 0 1)
                        (cinematic_screen_effect_start false)
                        (cinematic_stop)
                    )]])
        return false
    end
    execute_script([[(begin
                        (cinematic_screen_effect_set_convolution 2 1 1 0 1)
                        (cinematic_screen_effect_start false)
                        (sleep 45)
                        (cinematic_stop)
                    )]])
    return false
end

-- Shake screen effect when biped is melee, not working yet
-- function gameplay.meleeScreen()

--    local player = blam.player(get_player())
--   local playerObject = blam.biped(get_object(player.objectId))
--    if playerObject then
--        -- console_out(playerObject.zoomLevel)
--        if playerObject.meleeKey then
--            execute_script(
--                [[(begin (damage_object keymind\halo_infinite\halo_infinite\weapons\rifle\stalker_rifle\_fx__kinestecia\overheated.damage_effect") (unit (list_get) (players) 0) )]])
--            -- execute_script([[damage_object keymind\\halo_infinite\\halo_infinite\\weapons\\rifle\\stalker_rifle\\_fx\\_kinestecia\\overheated]])
--        end
--    end
-- end

return hudExtensions

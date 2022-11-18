------------------------------------------------------------------------------
-- Treason Gameplay Features Module
-- Mark Mc'Fuzz
-- Set of different treason gameplay features
------------------------------------------------------------------------------
-- Lua libraries
local core = require "multiplayer.features.core"
local const = require "multiplayer.features.constants"
local glue = require "glue"

-- local fontOverride = require "multiplayer.features.fontOverride" (use later for change the font with a custom one)

local gameplay = {state = {playerCriticalHealth = false}}

local rotation = 0
local lastBipedTagId

-- Rotate weapons while is not taken, need improve
function gameplay.RotateWeapons()
    if (rotation < 360) then
        rotation = rotation + 1
    else
        rotation = 0
    end
    local objects = blam.getObjects()
    for _, objectIndex in pairs(objects) do
        local tempObject = blam.object(get_object(objectIndex))
        if (tempObject and tempObject.type == objectClasses.weapon and tempObject.playerId ==
            0xFFFFFFFF) then
            core.rotateObject(objectIndex, rotation, 0, 0)
        end
    end
    return false
end

--- Change FP arms depending on the biped that is chosen
function gameplay.swapFirstPerson()
    local player = blam.player(get_player())
    if player then
        local playerObject = blam.object(get_object(player.objectId))
        if playerObject then
            if lastBipedTagId ~= playerObject.tagId then
                lastBipedTagId = playerObject.tagId
                console_out("changing fp")
                local globals = blam.globalsTag()
                if (player and playerObject and globals) then
                    local bipedTag = blam.getTag(playerObject.tagId)
                    if (bipedTag) then
                        local tagPathSplit = glue.string.split(bipedTag.path, "\\")
                        local bipedName = tagPathSplit[#tagPathSplit]
                        local fpModelTagId = blam.getTag(
                                                 [[keymind\the_flood\characters\unsc\odst_multiplayer\_types\thefood_legacy\thefood_legacy_fp]],
                                                 tagClasses.gbxmodel).id
                        local fpTag = core.findTag(bipedName .. "_fp", tagClasses.gbxmodel)
                        if (fpTag) then
                            fpModelTagId = fpTag.id
                        end
                        if (fpModelTagId) then
                            -- Save default first person hands model
                            local newFirstPersonInterface = globals.firstPersonInterface
                            newFirstPersonInterface[1].firstPersonHands = fpModelTagId
                            globals.firstPersonInterface = newFirstPersonInterface
                        end
                    end
                end
            end
        end
    end
end

---Improvements for HUD, hide HUD on zoom
function gameplay.hudExtensions()
    local player = blam.player(get_player())
    local playerObject = blam.biped(get_object(player.objectId))
    if playerObject then
        -- console_out(playerObject.zoomLevel)
        if not blam.isNull(playerObject.zoomLevel) then
            execute_script("hud_show_motion_sensor 0")
        else
            execute_script("hud_show_motion_sensor 1")
        end
    end
end

--- Attempt to play a sound given tag path and optionally a gain number
function gameplay.playSound(tagPath, gain)
    local player = blam.player(get_player())
    if (player) then
        local playSoundCommand = const.hsc.playSound:format(tagPath, player.index, gain or 1.0)
        execute_script(playSoundCommand)
    end
end

function gameplay.hudUpgrades()
    local player = blam.biped(get_dynamic_player())
    -- Player must exist
    -- local playerData = blam.player(get_player())
    -- Player must exist and not be a monitor
    if (player) then
        local isPlayerOnMenu = read_byte(blam.addressList.gameOnMenus) == 0
        if (not isPlayerOnMenu) then
            local localPlayer = read_dword(const.localPlayerAddress)
            local currentGrenadeType = read_word(localPlayer + 202)
            if (not blam.isNull(currentGrenadeType)) then
                if (not lastGrenadeType) then
                    lastGrenadeType = currentGrenadeType
                end
                if (lastGrenadeType ~= currentGrenadeType) then
                    lastGrenadeType = currentGrenadeType
                    if (lastGrenadeType == 1) then
                        gameplay.playSound(const.sounds.uiPGrenadePath, 2)
                    else
                        gameplay.playSound(const.sounds.uiFGrenadePath, 2)
                    end
                end
            end
            -- Blur HUD vision on critical health
            if (player.health <= 0.25 and player.shield <= 0 and blam.isNull(player.vehicleObjectId)) then
                if (not gameplay.state.playerCriticalHealth) then
                    gameplay.state.playerCriticalHealth = true
                    gameplay.hudBlur(true)
                end
            else
                if (gameplay.state.playerCriticalHealth) then
                    gameplay.hudBlur(false)
                end
                gameplay.state.playerCriticalHealth = false
            end
        end
    end
end

--- Regenerate players health on low shield using game ticks
---@param playerIndex number
function gameplay.regenerateHealth(playerIndex)
    if (server_type == "sapp" or server_type == "local") then
        local player
        if (playerIndex) then
            player = blam.biped(get_dynamic_player(playerIndex))
        else
            player = blam.biped(get_dynamic_player())
        end
        if (player) then
            -- Fix muted audio shield sync
            if (server_type == "local") then
                if (player.health <= 0) then
                    player.health = 0.000000001
                end
            end
            if (player.health < 1 and player.shield >= 1) then
                local newPlayerHealth = player.health + const.healthRegenerationAmount
                if (newPlayerHealth > 1) then
                    player.health = 1
                else
                    player.health = newPlayerHealth
                end
            end
        end
    end
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

function gameplay.hudBlur(enableBlur, immediate)
    if (enableBlur) then
        execute_script([[(begin
                        (cinematic_screen_effect_start true)
                        (cinematic_screen_effect_set_convolution 2 1 1 1 5)
                        (cinematic_screen_effect_start false)
                    )]])
        return true
    end
    if (not enableBlur and immediate) then
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

return gameplay


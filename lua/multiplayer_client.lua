clua_version = 2.042
------------------------------------------------------------------------------
-- Script Map
-- Mark Mc'Fuzz
-- This script is intended to provide functions and features to The Flood Maps
------------------------------------------------------------------------------
require "luna"
blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses
DebugMode = false


-- Gameplay Core Modules
local hudExtensions = require "the_flood.gameplay_core.hudExtensions"
local healthRegen = require "the_flood.gameplay_core.healthRegen"
local dynamicCross = require "the_flood.gameplay_core.dynamicCross"
local aimingDownSights = require "the_flood.gameplay_core.aimingDownSights"
local playerPingObjectives = require "the_flood.gameplay_core.playerPingObjectives"
--local sprint = require "the_flood.gameplay_core.sprint"

function OnRconMessage(message)
    return blam.rcon.handle(message)
end

-- Functions OnTick
function OnTick()
    dynamicCross.dynamicReticles()
    aimingDownSights.adsSystem()
    hudExtensions.radarHideOnZoom()
    hudExtensions.hudBlurOnLowHealth()
    hudExtensions.changeGreandeSound()
    healthRegen.regenerateHealth()
    --aimingDownSights.customKeys()
    --playerPingObjectives.pingObjectives()
end

-- Print version on pause menu
function OnFrame()
    local isPlayerOnMenu = read_byte(blam.addressList.gameOnMenus) == 1
    if isPlayerOnMenu then
        return
    end
    local font = "smaller"
    local align = "right"
    local bounds = { left = 0, top = 460, right = 632, bottom = 480 }
    local textColor = { 1.0, 0.45, 0.72, 1.0 }
    draw_text("thefloodmp-4.5.3", bounds.left, bounds.top, bounds.right, bounds.bottom, font, align,
        table.unpack(textColor))
end

set_callback("tick", "OnTick")
set_callback("preframe", "OnFrame")
set_callback("rcon message", "OnRconMessage")

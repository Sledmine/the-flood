------------------------------------------------------------------------------
-- Script Map
-- Mark Mc'Fuzz
-- This script is intended to provide functions and features to The Flood Maps
------------------------------------------------------------------------------
blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses
DebugMode = false
local balltze = Balltze
local engine = Engine

-- Gameplay Core Modules
local dynamicCross = require "the_flood.gameplay_core.dynamicCross"
local hudExtensions = require "the_flood.gameplay_core.hudExtensions"
local healthRegen = require "the_flood.gameplay_core.healthRegen"
local aimingDownSights = require "the_flood.gameplay_core.aimingDownSights"
local playerPingObjectives = require "the_flood.gameplay_core.playerPingObjectives"
local sprint = require "the_flood.gameplay_core.sprint"
local weaponExtensions = require "the_flood.gameplay_core.weaponExtensions"

dynamicCross.initializeSettings()

--function OnLoad()  
--    logger:info("Main loaded")
--    dynamicCross.dynamicReticles()
--end
--
--OnLoad()

-- Functions OnTick
function OnTick()
    dynamicCross.dynamicReticles()
    hudExtensions.radarHideOnZoom()
    hudExtensions.hudBlurOnLowHealth()
    hudExtensions.changeGreandeSound()
    healthRegen.regenerateHealth()
    -- aimingDownSights.customKeys()
    playerPingObjectives.pingObjectives()
    --weaponExtensions.casterFixHeat()
end

-- Print version on pause menu
function OnFrame()
    local isPlayerOnMenu = read_byte(blam.addressList.gameOnMenus) == 1
    if isPlayerOnMenu then
        return
    end
    local font = "smaller"
    local align = "right"
    local bounds = {left = 0, top = 460, right = 632, bottom = 480}
    local textColor = {1.0, 0.45, 0.72, 1.0}
    draw_text("thefloodmp-5.0.0", bounds.left, bounds.top, bounds.right, bounds.bottom, font, align,
              table.unpack(textColor))
end

local onTickEvent = balltze.event.tick.subscribe(function(event)
    if event.time == "before" then
        OnTick()
    end
end)
local onFrameEvent = balltze.event.frame.subscribe(function(event)
    if event.time == "before" then
        OnFrame()
    end
end)
local onRconMessageEvent = balltze.event.rconMessage.subscribe(function(event)
    if event.time == "before" then
        if blam.rcon.handle(event.context:message()) == false then
            event:cancel()
        end
    end
end)

return {
    unload = function()
        logger:warning("Unloading main")
        onTickEvent:remove()
        onFrameEvent:remove()
        onRconMessageEvent:remove()
    end
}

clua_version = 2.042

------------------------------------------------------------------------------
-- Treason Script Map
-- Mark Mc'Fuzz
-- This script is intended to provide functions and features to Treason map
------------------------------------------------------------------------------

blam = require "blam"
gameplay = require "multiplayer.features.gameplay"
dynamicCross = require "multiplayer.features.dynamicCross"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses

-- function OnLoad()
-- console_out("it's working")
--    fontOverride.onLoad()
-- end

function OnTick()
    dynamicCross.dynamicReticles()
    gameplay.rotateWeapons()
    gameplay.swapFirstPerson()
    gameplay.hudExtensions()
    gameplay.regenerateHealth()
    gameplay.hudUpgrades()
    -- gameplay.pingObjectives()
    -- meleeScreen()
end

function OnFrame()
    local isPlayerOnMenu = read_byte(blam.addressList.gameOnMenus) == 0
    if isPlayerOnMenu then
        return
    end
    local font = "small"
    local align = "center"
    local bounds = {left = 0, top = 460, right = 640, bottom = 480}
    local textColor = {1.0, 0.45, 0.72, 1.0}
    draw_text("thefloodmp-2.1.0", bounds.left, bounds.top, bounds.right, bounds.bottom, font, align,
              table.unpack(textColor))
end

set_callback("tick", "OnTick")
set_callback("preframe", "OnFrame")

-- OnLoad()

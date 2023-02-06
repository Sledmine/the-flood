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

--function OnLoad()
    --console_out("it's working")
--    fontOverride.onLoad()
--end

function OnTick()
    dynamicCross.DynamicReticles()
    gameplay.rotateWeapons()
    gameplay.swapFirstPerson()
    gameplay.hudExtensions()
    gameplay.regenerateHealth()
    gameplay.hudUpgrades()
    --gameplay.pingObjectives()
    --meleeScreen()
end

set_callback("tick", "OnTick")

--OnLoad()
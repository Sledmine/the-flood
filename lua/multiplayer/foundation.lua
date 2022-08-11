clua_version = 2.042

------------------------------------------------------------------------------
-- Treason Script Map
-- Mark Mc'Fuzz
-- This script is intended to provide functions and features to Treason map
------------------------------------------------------------------------------

blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses

function OnTick()
    DynamicReticles()
    RotateWeapons()
    swapFirstPerson()
    hudExtensions()
    --meleeScreen()
end
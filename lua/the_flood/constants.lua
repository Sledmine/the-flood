-- Lua libraries
local blam = require "blam"
tagClasses = blam.tagClasses
local findTag = blam.findTag

local constants = {}

-- Constant core values
constants.localPlayerAddress = 0x815918

-- Constant gameplay values
constants.healthRegenerationAmount = 0.0037
constants.raycastOffset = 0.3
constants.raycastVelocity = 80

constants.hsc = {playSound = [[(begin (sound_impulse_start "%s" (list_get (players) %s) %s))]]}

constants.sounds = {
    uiFGrenadePath = blam.findTag("001_frag_grenade", tagClasses.sound).path,
    uiPGrenadePath = blam.findTag("001_plasma_grenade", tagClasses.sound).path
}

constants.projectiles = {
    raycastTag = blam.findTag("raycast", tagClasses.projectile)
}

function constants.get()

constants.fonts = {
    text = findTag("text", tagClasses.font),
    title = findTag("title", tagClasses.font),
    subtitle = findTag("subtitle", tagClasses.font),
    --button = findTag("button", tagClasses.font)
}
end

return constants
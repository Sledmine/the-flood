-- Lua libraries
local blam = require "blam"
local tagClasses = blam.tagClasses
local findTag = blam.findTag

local constants = {}

-- Constant core values
constants.localPlayerAddress = 0x815918

-- Constant gameplay values
constants.healthRegenerationAmount = 0.0037
constants.raycastOffset = 0.3
constants.raycastVelocity = 80

constants.hsc = {playSound = [[(begin (sound_impulse_start "%s" (list_get (players) %s) %s))]]}

-- Sound References
constants.sounds = {
    uiFGrenadePath = blam.findTag("001_frag_grenade", tagClasses.sound).path,
    uiPGrenadePath = blam.findTag("001_plasma_grenade", tagClasses.sound).path,
    humanRifleZoomIn = blam.findTag("007_human_rifle_zoom_in", tagClasses.sound).path,
    humanRifleZoomOut = blam.findTag("007_human_rifle_zoom_out", tagClasses.sound).path
}

-- Projectile References
constants.projectiles = {
    raycastTag = blam.findTag("raycast", tagClasses.projectile)
}

-- Weapon References
constants.weapons = {
    ma38Tag = blam.findTag("assault_rifle_ma38", tagClasses.weapon),
    m6sTag = blam.findTag("magnum_m6s", tagClasses.weapon)
}

-- Biped References
constants.biped = {
    odstAlly = blam.findTag("gridharvolur_ally", tagClasses.biped)
}

-- Weapon HUD References
constants.weaponHudInterfaces = {
    ma38HudTag = blam.findTag("assault_rifle_ma38", tagClasses.weaponHudInterface),
    m6sHudTag = blam.findTag("magnum_m6s", tagClasses.weaponHudInterface)
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
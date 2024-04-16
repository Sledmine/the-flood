-- Lua libraries
local blam = require "blam"
local tagClasses = blam.tagClasses
local findTag = blam.findTag

local constants = {}

-- Constant core values
constants.localPlayerAddress = 0x815918

-- Constant gameplay values
constants.healthRegenerationAmount = 0.0037
-- health recharged on 90 ticks or 3 seconds
constants.healthRegenAiAmount = 0.02
constants.raycastOffset = 0.3
constants.raycastVelocity = 80

-- hsc constants
constants.hsc = {
    playSound = [[(begin (sound_impulse_start "%s" (list_get (players) %s) %s))]]
}

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
    ma38Tag = blam.findTag("assault_rifle_ma38", tagClasses.weapon)
}

-- Biped References
constants.bipeds = {
    odstAllyTag = blam.findTag("gridharvolur_ally", tagClasses.biped)
}

-- Weapon HUD References
constants.weaponHudInterfaces = {
    ma38HudTag = blam.findTag("assault_rifle_ma38", tagClasses.weaponHudInterface)
}

function constants.get()
    local fontName = "geogrotesque-regular-"

    constants.fonts = {
        text = findTag(fontName .. "text", tagClasses.font),
        title = findTag(fontName .. "title", tagClasses.font),
        subtitle = findTag(fontName .. "subtitle", tagClasses.font)
    }
end

return constants
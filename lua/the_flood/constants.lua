-- Lua libraries
local blam = require "blam"
local tagClasses = blam.tagClasses
local findTag = blam.findTag

local constants = {}

constants.color = {
    ---SULFUR---
    cookies_and_cream = "#d9e1ac",
    misty_moss = "#b3b873",
    oxley = "#74a071",
    mustard_green = "#62703c",
    soldier__green = "#505929",
    ---SILVER---
    opal_white = "#a4c0c1", "best option",
    weldon_blue = "#83a1a6",
    steel_teal = "#578a92", "best option",
    dark_electric_blue ="#507178",
    ---BLUE---
    jordi_blue = "#8bb2ff",
    catalina = "#142d75",
    ---GREEN---
    russian_green = "#77935d",
    japanese_laurel = "#3b701d",
    lincoln_green = "#225004",
    ---PURPLE---
    waterloo = "#82839a",
    indigo = "#261e7b",
    ---GOLDEN---
    sahara = "#b1af14",
    verdun = "#5c4d00",
    ---RED---
    copper ="#9d646b",
    dark_tan = "#6a0d0f",
    tamarind = "#341722",
    ---ORANGE---
    bell = "#e38e15",
    fire = "#a74500",
    beech = "#7e3000",
    ---BLACK---
    space ="#273132",
    black = "#000000",
    ---WHITE---
    white = "#FFFFFF",
    mist = "##a5c5cb",
    ---CYANOTIC---
    mint = "#96edca",
    mulled_wine = "#473e5a",
    ---NIGHTFALL---
    keppel ="#37979d",
    eden ="#125962",
    elephant = "#0c3739",
    ---MATRIX---
    blue_chill = "#147d97",
    meadow = "#1ca569",
    ---SUNSHINE---
    jellyfish = "#5bc4b2",
    camel = "#c2a54d",
    ---CHIMERA---
    blueberry = "#3c379a",
    valentine = "#e35a58",
    ---IRIDESCENT---
    rose = "#fa51aa",
    bush = "#633da9",
    tealish = "#a6b5eb",
    ---COALESCENCE---
    american_blue = "#3e2f76",
    crayola = "#eb1e49",
    berry = "#a01c4b",
}

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

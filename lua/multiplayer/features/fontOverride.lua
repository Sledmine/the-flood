-- SPDX-License-Identifier: GPL-3.0-only

------------------------------------------------------------------------------
-- Promethean UI 
-- Module: Font Override
-- Source: https://github.com/JerryBrick/promethean
------------------------------------------------------------------------------

local blam = require "blam"

local fontOverrides = {
    {
        family = "Nexa Keyboard Halo",
        tag = "keymind\\the_flood\\ui\\hud_messages\\font\\conduit",
        size = 14,
        weight = 600,
        offset = {
            x = 0,
            y = 3
        },
        shadowOffset = {
            x = 1,
            y = 1
        }
    },
}

local function setupOverrides()
    for _, font in pairs(fontOverrides) do
        local fontTag = blam.getTag(font.tag, blam.tagClasses.font)
        if(fontTag) then
            create_font_override(fontTag.id, font.family, font.size, font.weight, font.shadowOffset.x, font.shadowOffset.y, font.offset.x, font.offset.y)
            --console_out("WAAAAAAAAAAAAA")
        else
            console_out("Failed to override " .. font.tag .. " font!")
        end
    end
end

return {
    onLoad = setupOverrides
}

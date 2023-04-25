local glue = require "glue"
local blam = require "blam"
local constants = require "multiplayer.features.constants"
local ini = require "ini"

local chimera = {}

---@class chimeraConfiguration
---@field server_list Serverlist
---@field custom_console Customconsole
---@field memory Memory
---@field controller any[]
---@field font_override Fontoverride
---@field custom_chat Customchat
---@field scoreboard Scoreboard
---@field hotkey Hotkey
---@field video_mode Videomode
---@field name Name
---@field error_handling any[]
---@field halo Halo

---@class Fontoverride
---@field ticker_font_weight number
---@field large_font_override number
---@field large_font_shadow_offset_y number
---@field small_font_offset_x number
---@field smaller_font_family string
---@field smaller_font_offset_y number
---@field ticker_font_offset_x number
---@field smaller_font_shadow_offset_x number
---@field small_font_shadow_offset_y number
---@field system_font_shadow_offset_x number
---@field system_font_shadow_offset_y number
---@field smaller_font_offset_x number
---@field small_font_offset_y number
---@field ticker_font_offset_y number
---@field ticker_font_family string
---@field smaller_font_override number
---@field small_font_family string
---@field console_font_shadow_offset_y number
---@field system_font_y_offset number
---@field large_font_family string
---@field console_font_offset_y number
---@field system_font_override number
---@field system_font_weight number
---@field large_font_size number
---@field ticker_font_override number
---@field small_font_override number
---@field console_font_size number
---@field ticker_font_shadow_offset_x number
---@field large_font_weight number
---@field console_font_family string
---@field enabled number
---@field console_font_weight number
---@field ticker_font_shadow_offset_y number
---@field smaller_font_size number
---@field system_font_size number
---@field small_font_weight number
---@field console_font_override number
---@field ticker_font_size number
---@field smaller_font_shadow_offset_y number
---@field small_font_size number
---@field large_font_offset_y number
---@field system_font_x_offset number
---@field large_font_shadow_offset_x number
---@field smaller_font_weight number
---@field large_font_offset_x number
---@field console_font_shadow_offset_x number
---@field console_font_offset_x number
---@field system_font_family string
---@field small_font_shadow_offset_x number

local theFloodFontOverride = {
    console_font_family = "NexaDemo-Bold",
    console_font_offset_x = 0,
    console_font_offset_y = 0,
    console_font_override = 1,
    console_font_shadow_offset_x = 2,
    console_font_shadow_offset_y = 2,
    console_font_size = 10,
    console_font_weight = 400,
    enabled = 1,
    large_font_family = "NexaDemo-Bold",
    large_font_offset_x = 0,
    large_font_offset_y = 3,
    large_font_override = 1,
    large_font_shadow_offset_x = 2,
    large_font_shadow_offset_y = 2,
    large_font_size = 13,
    large_font_weight = 400,
    small_font_family = "EurostileExtended",
    small_font_offset_x = 0,
    small_font_offset_y = 3,
    small_font_override = 1,
    small_font_shadow_offset_x = 2,
    small_font_shadow_offset_y = 2,
    small_font_size = 12,
    small_font_weight = 400,
    smaller_font_family = "NexaDemo-Light",
    smaller_font_offset_x = 0,
    smaller_font_offset_y = 4,
    smaller_font_override = 1,
    smaller_font_shadow_offset_x = 0,
    smaller_font_shadow_offset_y = 0,
    smaller_font_size = 10,
    smaller_font_weight = 400,
    system_font_family = "NexaDemo-Bold",
    system_font_override = 1,
    system_font_shadow_offset_x = 2,
    system_font_shadow_offset_y = 2,
    system_font_size = 11,
    system_font_weight = 400,
    system_font_x_offset = 0,
    system_font_y_offset = 1,
    ticker_font_family = "QTypeSquare-Bold",
    ticker_font_offset_x = 0,
    ticker_font_offset_y = 0,
    ticker_font_override = 1,
    ticker_font_shadow_offset_x = 2,
    ticker_font_shadow_offset_y = 2,
    ticker_font_size = 18,
    ticker_font_weight = 400
}

local chimeraFontOverride = {
    console_font_family = "Hack Bold",
    console_font_offset_x = 0,
    console_font_offset_y = 0,
    console_font_override = 1,
    console_font_shadow_offset_x = 2,
    console_font_shadow_offset_y = 2,
    console_font_size = 14,
    console_font_weight = 400,
    enabled = 1,
    large_font_family = "Interstate-Bold",
    large_font_offset_x = 0,
    large_font_offset_y = 1,
    large_font_override = 1,
    large_font_shadow_offset_x = 2,
    large_font_shadow_offset_y = 2,
    large_font_size = 20,
    large_font_weight = 400,
    small_font_family = "Interstate-Bold",
    small_font_offset_x = 0,
    small_font_offset_y = 3,
    small_font_override = 1,
    small_font_shadow_offset_x = 2,
    small_font_shadow_offset_y = 2,
    small_font_size = 15,
    small_font_weight = 400,
    smaller_font_family = "Interstate-Bold",
    smaller_font_offset_x = 0,
    smaller_font_offset_y = 4,
    smaller_font_override = 1,
    smaller_font_shadow_offset_x = 2,
    smaller_font_shadow_offset_y = 2,
    smaller_font_size = 11,
    smaller_font_weight = 400,
    system_font_family = "Interstate-Bold",
    system_font_override = 1,
    system_font_shadow_offset_x = 2,
    system_font_shadow_offset_y = 2,
    system_font_size = 20,
    system_font_weight = 400,
    system_font_x_offset = 0,
    system_font_y_offset = 1,
    ticker_font_family = "Lucida Console",
    ticker_font_offset_x = 0,
    ticker_font_offset_y = 0,
    ticker_font_override = 1,
    ticker_font_shadow_offset_x = 2,
    ticker_font_shadow_offset_y = 2,
    ticker_font_size = 11,
    ticker_font_weight = 400
}

---Get chimera configuration
---@return chimeraConfiguration?
function chimera.getConfiguration()
    local configIni = glue.readfile("chimera.ini", "t")
    if configIni then
        ---@type chimeraConfiguration
        local configuration = ini.decode(configIni)
        return configuration
    end
end

---Save chimera configuration
---@param configuration chimeraConfiguration
function chimera.saveConfiguration(configuration)
    local configIni = ini.encode(configuration)
    return glue.writefile("chimera.ini", configIni, "t")
end

function chimera.setupFonts(revert)
    local chimeraIni = glue.readfile("chimera.ini", "t")
    if chimeraIni then
        local configuration = chimera.getConfiguration()
        if configuration then
            configuration.font_override = theFloodFontOverride
            if revert then
                configuration.font_override = chimeraFontOverride
            end
            return chimera.saveConfiguration(configuration)
        end
    end
    return false
end

function chimera.executeCommand(command)
    if not execute_chimera_command then
        console_out("execute_chimera_command is not available.")
        return false
    end
    local result, error = pcall(execute_chimera_command, command, true)
    if result then
        execute_script("cls")
        return true
    end
    console_out(error)
    return false
end

function chimera.fontOverride()
    if create_font_override then
        create_font_override(constants.fonts.text.id, "Geogrotesque-Regular", 14, 400, 2, 2, 1, 1)
        create_font_override(constants.fonts.title.id, "Geogrotesque-Regular", 18, 400, 2, 2, 0, 0)
        create_font_override(constants.fonts.subtitle.id, "Geogrotesque-Regular", 10, 400, 2, 2, 0, 0)
        --create_font_override(constants.fonts.button.id, "Geogrotesque-Regular", 13, 400, 2, 2, 1, 1)
        return true
    end
    console_out("create_font_override is not available.")
    return false
end

return chimera
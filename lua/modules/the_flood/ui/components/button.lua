local widget = require "lua.tools.widget"
local ustr = require "lua.tools.ustr"

---@class buttonProps
---@field name string
---@field text? string

---Generic button component
---@param props buttonProps
---@return string
return function(props)
    local widgetPath = widget.path .. props.name .. "_button.ui_widget_definition"
    local stringsTagPath
    if props.text then
        -- Generate strings tag
        stringsTagPath = widget.path .. "strings/" .. props.name .. "_button.unicode_string_list"
        ustr(stringsTagPath, {props.text})
    end
    ---@type invaderWidget 
    local button = {
        bounds = widget.bounds(0,0,32,134),
        background_bitmap = "keymind/the_flood/ui/bitmaps/normal_button.bitmap",
        widget_type = "text_box",
        text_label_unicode_strings_list = stringsTagPath,
        string_list_index = 0,
        text_font = "keymind/the_flood/ui/hud_messages/font/ailerons.font",
        text_color = "1, 1, 1, 1"
    }
    widget.createV2(widgetPath, button)
    return widgetPath
end

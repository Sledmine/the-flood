local widget = require "lua.tools.widget"

---@class containerProps
---@field name string
---@field childs? invaderWidgetChildWidget[]

---Container components
---@param props containerProps         
local function container(props)
    local widgetPath = widget.path .. props.name .. ".ui_widget_definition"
    ---@type invaderWidget
    local wid = {
        bounds = widget.bounds(0,0,480,640),
        background_bitmap = "keymind/the_flood/ui/bitmaps/background.bitmap",
        child_widgets = props.childs
    }
    widget.createV2(widgetPath, wid)
end

return container

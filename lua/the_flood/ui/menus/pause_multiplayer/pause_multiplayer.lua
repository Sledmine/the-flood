local widget = require "lua.tools.widget"
local button = require "lua.the_flood.ui.components.button"
local container = require "lua.the_flood.ui.components.container"

widget.init "keymind/the_flood/ui/menus/pause_multiplayer/"

return container {
    name = "pause_multiplayer",
    childs = {
        {
            button {
                name = "resume_game",
                text = "RESUME"
            },
            300, 300
        }
    }
}
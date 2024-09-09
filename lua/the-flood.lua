clua_version = 2.042
------------------------------------------------------------------------------
-- Script Map
-- Mark Mc'Fuzz
-- This script is intended to provide functions and features to The Flood Maps
------------------------------------------------------------------------------
require "luna"
blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses
DebugMode = false
local balltze = Balltze
local engine = Engine
local onTickEvent
execute_script = engine.hsc.executeScript

-- Gameplay Core Modules
local hudExtensions
local healthRegen
local dynamicCross
-- local aimingDownSights = require "the_flood.gameplay_core.aimingDownSights"
-- local playerPingObjectives = require "the_flood.gameplay_core.playerPingObjectives"
-- local sprint = require "the_flood.gameplay_core.sprint"

function OnRconMessage(message)
    return blam.rcon.handle(message)
end

-- Functions OnTick
function OnTick()
    dynamicCross.dynamicReticles()
    -- aimingDownSights.adsSystem()
    hudExtensions.radarHideOnZoom()
    hudExtensions.hudBlurOnLowHealth()
    hudExtensions.changeGreandeSound()
    healthRegen.regenerateHealth()
    -- aimingDownSights.customKeys()
    -- playerPingObjectives.pingObjectives()
end

-- Print version on pause menu
function OnFrame()
    local isPlayerOnMenu = read_byte(blam.addressList.gameOnMenus) == 1
    if isPlayerOnMenu then
        return
    end
    local font = "smaller"
    local align = "right"
    local bounds = {left = 0, top = 460, right = 632, bottom = 480}
    local textColor = {1.0, 0.45, 0.72, 1.0}
    draw_text("thefloodmp-4.5.3", bounds.left, bounds.top, bounds.right, bounds.bottom, font, align,
              table.unpack(textColor))
end

-- set_callback("tick", "OnTick")
-- set_callback("preframe", "OnFrame")
-- set_callback("rcon message", "OnRconMessage")

function PluginMetadata()
    return {
        name = "Helljumper Multiplayer",
        author = "Keymind Dev Team",
        version = "4.5.4",
        targetApi = "1.0.0-rc.1",
        reloadable = true
    }
end

function PluginInit()
    engine.core.consolePrint("plugin init")
    logger = balltze.logger.createLogger("helljumper")
    -- Replace Chimera functions with Balltze functions
    write_bit = function(address, bit, value)
        local byte = read_byte(address)
        if value then
            byte = byte | (1 << bit)
        else
            byte = byte & ~(1 << bit)
        end
        write_byte(address, byte)
    end
    write_byte = balltze.memory.writeInt8
    write_word = balltze.memory.writeInt16
    write_dword = balltze.memory.writeInt32
    write_int = balltze.memory.writeInt32
    write_float = balltze.memory.writeFloat
    write_string = function(address, value)
        for i = 1, #value do
            write_byte(address + i - 1, string.byte(value, i))
        end
        if #value == 0 then
            write_byte(address, 0)
        end
    end
    balltze.event.mapLoad.subscribe(function(event)
        if event.time == "after" then
            if not onTickEvent then
                if event.context:mapName() == "aqueduct_dev" then
                    dynamicCross = require "the_flood.gameplay_core.dynamicCross"
                    hudExtensions = require "the_flood.gameplay_core.hudExtensions"
                    healthRegen = require "the_flood.gameplay_core.healthRegen"
                    onTickEvent = balltze.event.tick.subscribe(function(event)
                        if engine.map.getCurrentMapHeader().name == "aqueduct_dev" then
                            OnTick()
                        end
                    end)
                end
            end
        end
    end)
end

function PluginLoad()
    engine.core.consolePrint("plugin load")
    -- Load Chimera compatibility
    for k, v in pairs(balltze.chimera) do
        if not k:includes "timer" and not k:includes "execute_script" then
            _G[k] = v
        end
    end
end

-- Lua libraries
local glue = require "glue"

local core = {}

local const = require "multiplayer.features.constants"

--- Find the path, index and id of a tag given partial name and tag type
---@param partialName string
---@param searchTagType string
---@return tag tag
function core.findTag(partialName, searchTagType)
    for tagIndex = 0, blam.tagDataHeader.count - 1 do
        local tag = blam.getTag(tagIndex)
        if (tag and tag.path:find(partialName) and tag.class == searchTagType) then
            return {
                id = tag.id,
                path = tag.path,
                index = tag.index,
                class = tag.class,
                indexed = tag.indexed,
                data = tag.data
            }
        end
    end
    return nil
end

---@class vector3D
---@field x number
---@field y number
---@field z number

--- Covert euler into game rotation array, optional rotation matrix, based on this
---[source.](https://www.mecademic.com/en/how-is-orientation-in-space-represented-with-euler-angles)
--- @param yaw number
--- @param pitch number
--- @param roll number
--- @return vector3D, vector3D
function core.eulerToRotation(yaw, pitch, roll)
    local yaw = math.rad(yaw)
    local pitch = math.rad(-pitch) -- Negative pitch due to Sapien handling anticlockwise pitch
    local roll = math.rad(roll)
    local matrix = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}

    -- Roll, Pitch, Yaw = a, b, y
    local cosA = math.cos(roll)
    local sinA = math.sin(roll)
    local cosB = math.cos(pitch)
    local sinB = math.sin(pitch)
    local cosY = math.cos(yaw)
    local sinY = math.sin(yaw)

    matrix[1][1] = cosB * cosY
    matrix[1][2] = -cosB * sinY
    matrix[1][3] = sinB
    matrix[2][1] = cosA * sinY + sinA * sinB * cosY
    matrix[2][2] = cosA * cosY - sinA * sinB * sinY
    matrix[2][3] = -sinA * cosB
    matrix[3][1] = sinA * sinY - cosA * sinB * cosY
    matrix[3][2] = sinA * cosY + cosA * sinB * sinY
    matrix[3][3] = cosA * cosB

    local rollVector = {x = matrix[1][1], y = matrix[2][1], z = matrix[3][1]}
    local yawVector = {x = matrix[1][3], y = matrix[2][3], z = matrix[3][3]}
    return rollVector, yawVector, matrix
end

--- Rotate object into desired angles
---@param objectId number
---@param yaw number
---@param pitch number
---@param roll number
function core.rotateObject(objectId, yaw, pitch, roll)
    local rollVector, yawVector, matrix = core.eulerToRotation(yaw, pitch, roll)
    local object = blam.object(get_object(objectId))
    object.vX = rollVector.x
    object.vY = rollVector.y
    object.vZ = rollVector.z
    object.v2X = yawVector.x
    object.v2Y = yawVector.y
    object.v2Z = yawVector.z
end

--- Send a request to the server throug rcon
---@return boolean success
---@return string request
function core.sendRequest(request, playerIndex)
    dprint("-> [ Sending request ]")
    dprint("Request: " .. request)
    if (server_type == "local") then
        OnRcon(request)
        return true, request
    elseif (server_type == "dedicated") then
        -- Player is connected to a server
        local fixedRequest = "rcon forge '" .. request .. "'"
        execute_script(fixedRequest)
        return true, fixedRequest
    elseif (server_type == "sapp") then
        dprint("Server request: " .. request)
        -- We want to broadcast to every player in the server
        if (not playerIndex) then
            grprint(request)
        else
            -- We are looking to send data to a specific player
            rprint(playerIndex, request)
        end
        return true, request
    end
    return false
end

function core.secondsToTicks(seconds)
    return 30 * seconds
end

function core.ticksToSeconds(ticks)
    return glue.round(ticks / 30)
end

---@type table<number, {x: number, y: number, z: number}>
local raycastCoords = {}

local currentWaypointsIndexes = {}

function core.deleteWaypoint(index)
    local index = tonumber(index)
    if index then
        local deactivateWaypoint =
            [[(deactivate_nav_point_flag (unit (list_get (players) 0)) waypoint_%s)]]
        execute_script(deactivateWaypoint:format(index))
        raycastCoords[index] = nil
        currentWaypointsIndexes[index] = nil
    end
    return false
end
DeleteWaypoint = core.deleteWaypoint

---Create a waypoint at the given coordinates
---@param x number
---@param y number
---@param z number
---@param type? string
---@param duration? number
---@return boolean
function core.createWaypoint(x, y, z, type, duration)
    for i = 1, 4 do
        if not currentWaypointsIndexes[i] then
            currentWaypointsIndexes[i] = true
            index = i
            break
        end
    end
    if index then
        if not raycastCoords[index] then
            local activateWaypoint =
                [[(activate_nav_point_flag %s (unit (list_get (players) 0)) waypoint_%s 0)]]
            execute_script(activateWaypoint:format(type or "default", index))
            local scenario = blam.scenario(0)
            local flags = scenario.cutsceneFlags
            flags[index].x = x
            flags[index].y = y
            flags[index].z = z
            scenario.cutsceneFlags = flags
            raycastCoords[index] = {x = x, y = y, z = z}
            set_timer(duration or 2000, "DeleteWaypoint", index)
            return true
        end
    end
    return false
end

function core.calculateRaycast(player)
    local rayX = player.x + player.xVel + player.cameraX * const.raycastOffset
    local rayY = player.y + player.yVel + player.cameraY * const.raycastOffset
    local rayZ = player.z + player.zVel + player.cameraZ * const.raycastOffset + 0.5
    return rayX, rayY, rayZ
end

return core

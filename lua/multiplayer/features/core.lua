local core = {}

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

return core
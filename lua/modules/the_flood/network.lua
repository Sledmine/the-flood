local network = {}

local function encode(enc, value)
    return string.pack(enc, value):tohex()
end

local function decode(dec, value)
    return string.unpack(dec, value:fromhex())
end

---Generates a waypoint message
---@param x number
---@param y number
---@param z number
---@param type string
---@return string
function network.genWaypoint(x, y, z, type)
    local encodedX = encode("f", x)
    local encodedY = encode("f", y)
    local encodedZ = encode("f", z)
    local message = encodedX .. "," .. encodedY .. "," .. encodedZ .. "," .. type
    return message
end

---Parses a waypoint message
---@param message string
---@return number x, number y, number z, string type
function network.parseWaypoint(message)
    local data = message:split(",")
    local x = data[1]
    local y = data[2]
    local z = data[3]
    local type = data[4]
    local decodedX = decode("f", x)
    local decodedY = decode("f", y)
    local decodedZ = decode("f", z)
    return decodedX, decodedY, decodedZ, type
end

return network

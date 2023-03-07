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
---@return string
function network.genWaypoint(x, y, z)
    local encodedX = encode("f", x)
    local encodedY = encode("f", y)
    local encodedZ = encode("f", z)
    local message = encodedX .. "," .. encodedY .. "," .. encodedZ
    return message
end

---Parses a waypoint message
---@param message string
---@return number x, number y, number z
function network.parseWaypoint(message)
    local data = message:split(",")
    local x = data[1]
    local y = data[2]
    local z = data[3]
    local decodedX = decode("f", x)
    local decodedY = decode("f", y)
    local decodedZ = decode("f", z)
    return decodedX, decodedY, decodedZ
end

return network

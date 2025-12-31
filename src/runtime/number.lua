local LTObject = require("runtime.object")
local LTNumber = LTObject:new()
local inspect = require("inspect")

LTNumber.name = "Number"

function LTNumber:__add(other)
    return self:new(self.__hostValue + other.__hostValue)
end

function LTNumber:__sub(other)
   return self:new(self.__hostValue - other.__hostValue)
end

function LTNumber:__div(other)
    return self:new(self.__hostValue / other.__hostValue)
end

LTNumber['__mul__'] = function(self, other)
    local m = other
    if type(other) ~= "number" then
        m = other.__hostValue
    end

    return self:new(self.__hostValue * m)
end

LTNumber['__add__'] = function(self, other)
    local m = other
    if type(other) ~= "number" then
        m = other.__hostValue
    end

    return self:new(self.__hostValue + m)
end

LTNumber["doubled"] = function(self)
   return self:new(self.__hostValue * 2)
end

return LTNumber

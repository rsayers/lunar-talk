local inspect = require("inspect")
local LTObject = { __hostValue = nil, name = "Object" }
LTObject.__index = LTObject

local nextId = (function()
    local id = 0
    return function()
        id = id + 1
	return id
    end
end)()

function LTObject:new(hostValue)
    local obj = {}
    obj = setmetatable(obj, self)
    obj.__index = obj
    obj.objectId = nextId()
    if hostValue then
        obj.__hostValue = hostValue
    end
    return obj
end

function LTObject:getname()
   return self:new(self.name)
end

function LTObject:asRawString()
    return tostring(self.__hostValue)
end

LTObject["="] = function(self, anObject)
   return self.__hostValue == anObject.__hostValue
end

LTObject["=="] = function(self, anObject)
   return self["="](self, anObject)
end

LTObject["~="] = function(self)
   return self.objectId == self.objectId
end

LTObject["~~"] = function(self)
   return self.objectId ~= self.objectId
end

LTObject["class"] = function(self)
    return getmetatable(self)
end

local function rawCopy(obj)
   if type(obj) ~= "table" then
      return obj
   end
   local res = setmetatable({}, getmetatable(obj))
   for k, v in pairs(obj) do
      res[rawCopy(k)] = rawCopy(v)
   end
   return res
end

LTObject["copy"] = function(self)
   return rawCopy(self)
end

LTObject["wrapVal"] = function(self, val)
   local inst = self:new()
    inst.__hostValue = val
  
   return inst
end

LTObject["doesNotUnderstand:"] = function(self) end

LTObject["error:"] = function(self) end

LTObject["hash"] = function(self)
   return self.__hostValue
end

LTObject["identityHash"] = function(self)
   return self.objectId
end

LTObject["isKindOf:"] = function(self, candidateClass)
   return getmetatable(self) == getmetatable(candidateClass)
end

LTObject["isMemberOf:"] = function(self, candidateClass)
   return getmetatable(self) == getmetatable(candidateClass)
end

LTObject["isNil"] = function(self)
   return false
end

LTObject["notNil"] = function(self)
   return true
end

LTObject["perform:"] = function(self, selector)
   return self["selector"](self)
end

LTObject["perform:with:"] = function(self, selector, arg1)
   return self["perform:withArguments:"](self, selector, { arg1 })
end

LTObject["perform:with:with:"] = function(self, selector, arg1, arg2)
   return self["perform:withArguments:"](self, selector, { arg1, arg2 })
end

LTObject["perform:with:with:with:"] = function(self, selector, arg1, arg2, arg3)
   return self["perform:withArguments:"](self, selector, { arg1, arg2, arg3 })
end

LTObject["perform:withArguments:"] = function(self, selector, args)
   return self[selector](self, table.unpack(args))
end

LTObject["printOn:"] = function(self) end

LTObject["printString"] = function(self) end

LTObject["respondsTo:"] = function(self, selector)
   return type(self[selector]) == "function"
end

LTObject["yourself"] = function(self) end

return LTObject

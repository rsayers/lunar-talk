local LTObject = require("runtime/object")

local LTNil = LTObject:new()

LTNil["isNil"] = function(self)
   return true
end

LTNil["notNil"] = function(self)
   return false
end

LTNil.luaValue = nil

return LTNil

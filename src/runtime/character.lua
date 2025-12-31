local LTObject = require("runtime.object")
local utf8 = require("utf8")

local LTCharacter = LTObject:new()

LTCharacter["toUpperCase"] = function(self)
   self:wrapVal(string.upper(self.luaValue))
end

LTCharacter["toLowerCase"] = function(self)
   self:wrapVal(string.lower(self.luaValue))
end

LTCharacter["asString"] = function(self)
   return self
end

LTCharacter["codePoint"] = function(self)
   return utf8.codepoint(self.__hostValue)
end

return LTCharacter

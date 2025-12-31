local LTObject = require("runtime.object")

local LTTrue = LTObject:new()
LTTrue.__hostValue = true

local LTFalse = LTObject:new()
LTFalse.__hostValue = false

LTTrue["ifTrue:"] = function(self, callback)
   return callback()
end

LTTrue["ifFalse:"] = function(self, callback)
   return nil
end

LTFalse["ifTrue:"] = function(self, callback)
   return nil
end

LTFalse["ifFalse:"] = function(self, callback)
   return callback()
end

return LTTrue, LTFalse

local LTObject = require("runtime.object")
local Transcript = LTObject:new()

Transcript["show:"] = function(self, val)
   print(val:asRawString())
end

return Transcript

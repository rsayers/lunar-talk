local Object = {
   slots = {},
   name = "Object",
}
Object.class = Object

function Object.rawSet(self, name, value)
    self.slots[name] = value
end

function Object.rawGet(self, name)
   return self.slots[name]
end

function Object.getClass(self)
   return self.class
end
local Class = setmetatable({}, Object)
Class:rawSet("instance_vars", {})
Class:rawSet("class_vars", {})
Class:rawSet("instance_methods", {})


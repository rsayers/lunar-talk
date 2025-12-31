---@class StringBuilder
---@field value string
local StringBuilder = {}
StringBuilder.__index = StringBuilder
setmetatable(StringBuilder, {
   __call = function(cls, ...)
      return cls.new(...)
   end,
})

---@return StringBuilder
StringBuilder.new = function()
   local self = setmetatable({}, StringBuilder)
   self.value = ""
   return self
end

---@param v StringBuilder
StringBuilder.__tostring = function(v)
   return v.value
end

---@param s string
function StringBuilder:add(s)
   self.value = self.value .. tostring(s)
end

---@enum TokType
local TokType = {
   Nothing = 1,
   Name = 2,
   NameColon = 3,
   Number = 4,
   Char = 5,
   Sym = 6,
   Str = 7,
   ArrayOpen = 8,
   ArrayClose = 9,
   LiteralArrayOpen = 10,
   ParenOpen = 11,
   ParenClose = 12,
   BlockOpen = 13,
   BlockClose = 14,
   Assignment = 15,
   Binary = 16,
   EndStatement = 17,
   BlockArg = 18,
   Cascade = 19,
   Return = 20,
   EOF = 99,
}
local TokName = {}
for name, idx in pairs(TokType) do
   TokName[idx] = name
end

---@enum NodeType
local NodeType = {
   Array = 1,
   Assignment = 2,
   BinaryMessageSend = 3,
   Block = 4,
   KeywordMethod = 5,
   Literal = 6,
   Method = 7,
   ParenExpression = 8,
   Return = 9,
   Statement = 10,
   Identifier = 11,
   KeywordMessageSend = 12,
   UnaryMessage = 13,
   UnaryMessageSend = 14,
}

local NodeName = {}
for name, idx in pairs(NodeType) do
   NodeName[idx] = tostring(name)
end

---@param str string
---@param delimiter string
---@return [string]
local function ssplit(str, delimiter)
    local parts = {}
    local line = ""
    for i = 1, #str do
        local c = str:sub(i, i)
        if c == delimiter then
            parts[#parts + 1] = line
            line = ""
        else
            line = line .. c
        end
    end
    parts[#parts + 1] = line
    return parts
end

---@param str string
---@return string
local function sstrip(str)
   return str:match("^%s*(.-)%s*$")
end

local function writefile(filename, data)
   local fp = assert(io.open(filename, "w"))
   fp:write(data)
   fp:close()
end

local function readfile(filename)
   local fp = assert(io.open(filename, "r"))
   local lines = fp:lines()
   local data = ""
   for line in lines do
      data = data .. line .. "\n"
   end

   fp:close()
   return data
end

local function wrapLiteral(val)
   
end

return {
   TokType = TokType,
   TokName = TokName,
   StringBuilder = StringBuilder,
   ssplit = ssplit,
   writefile = writefile,
   NodeType = NodeType,
   NodeName = NodeName,
    readfile = readfile,
   sstrip = sstrip
}

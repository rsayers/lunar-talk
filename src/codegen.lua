local StringBuilder = require("util").StringBuilder
local inspect = require("inspect")
local CodeGen = {}
local NodeType = require("util").NodeType

---@param node Node
---@return string
function CodeGen:emit(node, indent)
   if indent == nil then
      indent = 3
   else
      indent = indent + 3
   end
   if self:isLuaPrimitive(node) then
      return self:wrapLuaPrimitive(node)
   end

   local src = StringBuilder.new()
   if node.type == NodeType.Array then
      return self:Array(node)
   elseif node.type == NodeType.Assignment then
      return self:Assignment(node)
   elseif node.type == NodeType.BinaryMessageSend then
      return self:BinaryMessageSend(node)
   elseif node.type == NodeType.Block then
      return self:Block(node)
   elseif node.type == NodeType.KeywordMethod then
      return self:KeywordMethod(node)
   elseif node.type == NodeType.Literal then
      return self:Literal(node)
   elseif node.type == NodeType.Method then
      return self:Method(node)
   elseif node.type == NodeType.ParenExpression then
      return self:ParenExpression(node)
   elseif node.type == NodeType.Return then
      return self:Return(node)
   elseif node.type == NodeType.Statement then
      return self:Statement(node)
   elseif node.type == NodeType.Identifier then
      return self:Identifier(node)
   elseif node.type == NodeType.KeywordMessageSend then
      return self:KeywordMessageSend(node)
   elseif node.type == NodeType.UnaryMessage then
      return self:UnaryMessage(node)
   elseif node.type == NodeType.UnaryMessageSend then
      return self:UnaryMessageSend(node)
   end

   self:error("Can't handle" .. inspect(node))
   return ""
end

function CodeGen:error(msg, node)
    error(msg)
end

---@param value any
---@return boolean
function CodeGen:isLuaPrimitive(value)
   for _, typeName in ipairs({"string", "number", "boolean", "nil"}) do
      if type(value) == typeName then
	 return true
      end
   end
   return false
end

--@param value any
--@return string
function CodeGen:wrapLuaPrimitive(value)
    if type(value) == "string" then return value end
   
   local src = StringBuilder.new()
    src:add("LT")
    local typeName = type(value):gsub("^%l", string.upper)
    src:add(typeName)
    src:add(":new(")
    src:add(tostring(value))
    src:add(")")
    return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Array(node)
   local src = StringBuilder.new()
   src:add("LTArray(")
   local comma = ""
   for i = 1, #node.value do
      src:add(comma)
      src:add(self:emit(node.value[i]))
      comma = ","
   end
   src:add(")")
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Assignment(node)
   local src = StringBuilder.new()
   src:add(node.variable)
   src:add(" = ")
   src:add(self:emit(node.expr))
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:BinaryMessageSend(node)
    local src = StringBuilder.new()
    local ops = { ["*"] = "__mul__", ["+"] = "__add__"}
   if node.callee then
      src:add("(")
      src:add(self:emit(node.callee))
      src:add(")")
   else
      src:add(node.name)
   end

   src:add("." .. ops[node.symbol] .. "(" .. node.name .." ,")
    src:add(self:emit(node.arg))
    src:add(")")
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Block(node)
   local src = StringBuilder.new()
   src:add("function(")
   if node.args then
      local comma = ""
      for i = 1, #node.args do
         local name = node.args[i]
         src:add(name:sub(2, #name))
         src:add(comma)
         comma = ","
      end
   end
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:KeywordMethod(node)
   local src = StringBuilder.new()
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Literal(node)
   local src = StringBuilder.new()
    if type(node.value) == "number" then
        src:add("LTNumber:new(")
        src:add(tostring(node.value))
	src:add(")")
    end

   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Method(node)
   local src = StringBuilder.new()
   src:add("return function(")
   if node.signature.args then
      local comma = ""
      for i = 1, #node.signature.args do
         src:add(comma)
         src:add(node.signature.args[i])
         comma = ","
      end
   end
   src:add(")\n")
   if node.temporaries then
      src:add("local ")
      local comma = ""
      for i = 1, #node.temporaries do
         src:add(comma)
         src:add(node.temporaries[i])
         comma = ","
      end
      src:add("\n")
   end
   for i = 1, #node.body do
      src:add(self:emit(node.body[i]))
      src:add("\n")
   end
   src:add("end\n")

   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:ParenExpression(node)
   local src = StringBuilder.new()
   self:add("(")
   self:add(self:emit(node.expr))
   self:add(")")

   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Return(node)
   local src = StringBuilder.new()
   src:add("return ")
   src:add(self:emit(node.value))
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Statement(node)
   local src = StringBuilder.new()
   for i = 1, #node.expressions do
      src:add(self:emit(node.expressions[i]))
      src:add("\n")
   end

   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:Identifier(node)
   local src = StringBuilder.new()
   src:add(node.rawValue)
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:KeywordMessageSend(node)
   local src = StringBuilder.new()
   src:add(node.callee.value)
   src:add("['")
   src:add(node.name)
   src:add("'](")
   src:add(node.callee.value)
   for i = 1, #node.args do
      src:add("," .. self:emit(node.args[i]))
   end
   src:add(")")
   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:UnaryMessage(node)
   local src = StringBuilder.new()

   return tostring(src)
end

---@param node Node
---@return string
function CodeGen:UnaryMessageSend(node)
   local src = StringBuilder.new()
   if node.callee then
        src:add("(")
      src:add(self:emit(node.callee))
      src:add(")")
   else
      src:add(self:emit(node.name))
   end
   src:add(":")
   src:add(self:emit(node.arg))
   src:add("()")
   return tostring(src)
end

return { CodeGen = CodeGen }

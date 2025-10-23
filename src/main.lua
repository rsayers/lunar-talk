local st2lua = require("st2lua")
local inspect = require("inspect")
local dbg = require("debugger")
require("os")
local testsrc = [[
  exampleWithNumber: x
    "A method that illustrates every part of Smalltalk method syntax
    except primitives. It has unary, binary, and keyboard messages,
    declares arguments and temporaries, accesses a global variable
    (but not an instance variable), uses literals (array, character,
    symbol, string, integer, float), uses the pseudo variables
    true, false, nil, self, and super, and has sequence, assignment,
    return and cascade. It has both zero argument and one argument blocks."
    | y |
    true & false not & (nil isNil) ifFalse: [self halt].
    y := self size + super size.
    #($a #a "a" 1 1.0)
        do: [ :each |
            Transcript show: (each class name);
                       show: ' '].
    ^x < y
]]

local parser = st2lua.Parser.new()
local theast = parser:parse(testsrc)

local function genExpression(expression) end

local function genAssignment(expression)
   return expression.var.value .. " = " .. genExpression(expression.expr)
end

local function genBinaryMessage(expression)
   return genExpression(expression.receiver) .. " " .. expression.id .. " " .. genExpression(expression.argument)
end

local function genUnaryMessage(expr)
   local receiver = genExpression(expr.receiver)
   local char = ":"
   if receiver:sub(1, 1) == receiver:sub(1, 1):upper() then
      char = "."
   end
   return receiver .. char .. expr.id .. "()"
end

local function genUnaryMessageChain(expr)
    local src = genExpression(expr.receiver)
    local chain = expr.chain
    for i = 1, #chain do
       src = src .. ":" .. chain[i].id .. "()"
    end
    return src
end

local function genBinaryMessageChain(expr)

   local src = genExpression(expr.receiver)
   local chain = expr.chain
   for i = 1, #chain do
      src = src .. "['" .. chain[i].id .. "']"
   end
   return src
end

local function genKeywordMessage(expr)
   local selector = expr.selector:sub(1, expr.selector:len() - 1)
   local receiver = genExpression(expr.receiver)
   local char = ":"
   if receiver:sub(1, 1) == receiver:sub(1, 1):upper() then
      char = "."
   end
   return receiver .. char .. selector .. "(" .. genExpression(expr.argument[1]) .. ")"
end

local function genArrayDefinition(args)
   local src = "array({"
   local comma = ""
   for i = 1, #args do
      local val = genExpression(args[i])
      if val == "" then
	 comma = ""
      end
      src = src .. comma .. val
      comma = ","
   end
   src = src .. "})"
   return src
end

local function genLiteral(expr)
   if expr.type == "comment" then
      return ""
   end
   local x = tostring(expr.parsed_value)
   return x
end

local function genBlock(expr)
   local src = "\nfunction("
   local comma = ""
   if expr.args then
      local args = expr.args
      for i = 1, #args do
	 src = src .. comma .. args[i].id
	 comma = ","
      end
   end
   src = src .. ")\n"

   local statements = expr.body
   for i = 1, #statements do
      src = src .. "\t" .. genExpression(statements[i])
   end
   src = src .. "end\n"
   return src
end

local function genParenthesisExpression(expr)
   return "(" .. genExpression(expr.expr) .. ")"
end

local function genIdentifier(expression)
   return expression.value
end

function genExpression(expr)
   if expr == nil then
      print("Nil expression")
      return ""
   end
   local k = expr.type
   local v = expr
   -- print("Parsing Expression type: " .. tostring(k))
   -- print("----------------------------------")
   -- print(inspect(v))
   -- print("----------------------------------")
   -- print("\n\n")
   if k == "Statement" then
      return genExpression(v.expr) .. "\n"
   end
   if k == "Expression" then
      return genExpression(v.expr)
   end
   if k == "Assignment" then
      return genAssignment(v)
   end
   if k == "number" then
      return tostring(v.parsed_value)
   end
   if k == "Return" then
      return "return " .. genExpression(v.expr)
   end
   if k == "BinaryMessage" then
      return genBinaryMessage(v)
   end
   if k == "identifier" then
      if v.value == "super" then return "self.super" end
      return v.value
   end
   if k == "UnaryMessage" then
      return genUnaryMessage(v)
   end
   if k == "KeywordMessage" then
      return genKeywordMessage(v)
   end
   if k == "ArrayDefinition" then
      return genArrayDefinition(v.vars)
   end
   if k == "Literal" then
      return genLiteral(v.expr)
   end
   if k == "Block" then
      return genBlock(v)
   end
   if k == "ParenthesisExpression" then
      return genParenthesisExpression(v)
   end
    if k == "UnaryMessageChain" then
        return genUnaryMessageChain(v)
    end
    if k == "BinaryMessageChain" then
       return genBinaryMessageChain(v)
    end
   print("Unknown expression type " .. expr.type)
end

local function genFunc(ast)
   local args = ast.header.args
   local localVars = ast.localdefs.vars
   local statements = ast.body
   local src = "return function ("
   local comma = ""
   for i = 1, #args do
      src = comma .. src .. args[i]
      comma = ","
   end
   src = src .. ")\n"
   comma = ""
   if #localVars then
      src = src .. "\tlocal "
      for i = 1, #localVars do
	 src = comma .. src .. localVars[i].name
	 comma = ","
      end
      src = src .. "\n"
   end

   for i = 1, #statements do
      src = src .. "\t" .. genExpression(statements[i])
   end
   src = src .. "end"
   return { selector = ast.header.selector, source = src }
end
local fn = genFunc(theast)
print("Smalltalk:")
print(testsrc)
print()
print("Lua")
print("Name = " .. fn.selector)
print(fn.source)


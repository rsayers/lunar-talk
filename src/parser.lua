local Lexer = require("lexer").Lexer
local Token = require("lexer").Token
local TokType = require("util").TokType
local NodeType = require("util").NodeType
local writefile = require("util").writefile
local ssplit = require("util").ssplit
local sstrip = require("util").sstrip
local NodeName = require("util").NodeName
local inspect = require("inspect")

---@class Parser
---@field tokens Token[]
---@field pos integer
local Parser = {}

---@class Node
---@field type NodeType
---@field typeName string
---@field name string
---@field args Node
---@field arg Node
---@field signature Node
---@field temporaries Node
---@field variable string
---@field value Node
---@field expr Node
---@field callee Node
---@field body Node
---@field symbol string
---@field expressions [Node]

---@param expr any
local function Node(expr)
   local node = expr
   node.typeName = NodeName[node.type]
   node.superType = "Node"
   return node
end

function Parser:initialize()
   self.tokens = {}
   self.sourceLines = {}
   self.pos = 0
end

function Parser:error(s, token)
   local message = "\n" .. s
   if token then
      message = message .. "\n\n" .. self:renderError(token)
   end

   error(message)
end

---@param token Token
---@return string
function Parser:renderError(token)
   local padLen = string.len(#self.sourceLines)
   local output = inspect(token) .. "\n\n"
   local rawSrc = ""
   for i, line in ipairs(self.sourceLines) do
      rawSrc = rawSrc .. line
      local lineStrt = string.format("%0" .. padLen .. "i", i) .. "|" .. " "
      line = lineStrt .. line
      if token.line == i - 1 then
         local space = ""
         local skip = string.len(lineStrt)
         for j = 1, token.col + skip - 2 do
            output = output .. " "
         end
         output = output .. "^\n"
      end
      output = output .. line .. "\n"
   end
   return output
end

function Parser:rewind(n)
   if n == nil then
      n = 1
   end
   self.pos = self.pos - n
end

function Parser:peek(n)
   if n == nil then
      n = 1
   end
   return self.tokens[self.pos + n]
end

---@return Token
function Parser:next()
   if self:peek() == nil then
      return Token(TokType.EOF)
   end
   self.pos = self.pos + 1
   local r = self.tokens[self.pos]
   return r
end

function Parser:current()
   return self:peek(0)
end

function Parser:check(...)
   for i, tokenType in ipairs({ ... }) do
      if self:current() and self:current().type == tokenType then
         return true
      end
   end
end

function Parser:peekCheck(...)
   for i, tokenType in ipairs({ ... }) do
      if self:peek() and self:peek().type == tokenType then
         return self:peek()
      end
   end
end

function Parser:match(...)
   if self:peekCheck(...) then
      return self:next()
   end
end

function Parser:atEnd()
   return self.pos == #self.tokens
end

function Parser:expect(...)
   local token = self:match(...)
   if token == nil then
      self:error("Unexpected Token: ", self:peek())
      return Node()
   end
   return token
end

---@param tokens [Token]
---@param source string
---@return Node
function Parser:parse(tokens, source)
   self:initialize()
   self.sourceLines = ssplit(source, "\n")
   self.tokens = tokens
   return self:method()
end

function Parser:method()
   return Node({
      type = NodeType.Method,
      signature = self:signature(),
      temporaries = self:temporaries(),
      body = self:body(),
   })
end

function Parser:signature()
   local token = self:expect(TokType.NameColon, TokType.Name, TokType.Binary)
   if token.type == TokType.NameColon then
      return self:keywordSignature()
   elseif token.type == TokType.Name then
      return self:unarySignature()
   elseif token.type == TokType.Binary then
      return self:binarySignature()
   end
end

function Parser:unarySignature()
   local method = self:current()
   return Node {
      type = NodeType.UnaryMessage,
      name = method.value,
   }
end

function Parser:binarySignature() end

function Parser:isAssignment()
   if self:current().type == TokType.Name and self:peek().type == TokType.Assignment then
      return true
   end
end

function Parser:assignment()

    local variable = self:current().value

   -- skip the assignment token
    self:next()

    self:next()
    
   return Node({
      type = NodeType.Assignment,
      variable = variable,
      expr = self:expression(),
   })
end

function Parser:keywordSignature()
   local kw = self:parseKwMessageSignature()
   if kw == nil then
      return self:error("Error parsing message send")
   end
   return Node({
      type = NodeType.KeywordMethod,
      name = kw.name,
      args = kw.args,
   })
end

function Parser:parseKwMessageSend(callee)
   local kwParts = {}
   local argParts = {}
   local token = self:current()
   if not callee then
      callee = token
      token = self:next()
   end
   while true do
      if token.type ~= TokType.NameColon then
         argParts[#argParts + 1] = self:expression()
         if self:peek().type ~= TokType.NameColon then
            break
         end
      elseif token.type == TokType.NameColon then
         kwParts[#kwParts + 1] = token.value .. ":"
      else
         self:error("Bad token")
      end
      token = self:next()
   end
   if #kwParts ~= #argParts then
      self:error("keywords and args dont match")
   end
   local methodName = ""
   for i = 1, #kwParts do
      methodName = methodName .. kwParts[i]
   end

   return Node({
      type = NodeType.KeywordMessageSend,
      name = methodName,
      args = argParts,
      callee = callee,
   })
end

function Parser:parseKwMessageSignature()
   local kwParts = {}
   local argParts = {}
   local token = self:current()
   local nextTokenType = TokType.NameColon
   while true do
      if token.type ~= nextTokenType then
         error("Unexpected Token:\n" .. inspect(token))
         return
      end
      if token.type == TokType.Name then
         argParts[#argParts + 1] = token.value
         nextTokenType = TokType.NameColon
         if self:peek().type ~= nextTokenType then
            break
         end
      elseif token.type == TokType.NameColon then
         kwParts[#kwParts + 1] = token.value
         nextTokenType = TokType.Name
      else
         self:error("Bad token")
      end
      token = self:next()
   end
   if #kwParts ~= #argParts then
      self:error("keywords and args dont match")
   end

   local methodName = ""
   for i = 1, #kwParts do
      methodName = methodName .. kwParts[i]
   end

   return {
      type = NodeType.KeywordMethod,
      name = methodName,
      args = argParts,
   }
end

function Parser:temporaries()
   if self:peek().value ~= "|" then
      return
   end
   self:next()
   local temporaries = {}

   while self:next().value ~= "|" do
      local token = self:current()
      if token.type ~= TokType.Name then
         self:error("Unexpected Token: " .. inspect(token))
      end
      temporaries[#temporaries + 1] = token.value
   end
   return temporaries
end

function Parser:body()
   local statements = {}
   while self.pos < #self.tokens do
      statements[#statements + 1] = self:statement()
   end
   return statements
end

function Parser:statement()
   local expressions = {}

   while self:next().type ~= TokType.EOF do
      local e = self:expression()
      expressions[#expressions + 1] = e
   end
   return Node({
      type = NodeType.Statement,
      expressions = expressions,
   })
end

function Parser:expression()
   if self:atEnd() then
      return
   end
   if self:current().type == TokType.EndStatement then
      return
   end

   if self:isAssignment() then
      return self:assignment()
   end

   if self:isPrimary() then
      return self:primary()
   end

   if self:isReturn() then
      return self:fnreturn()
   end

   if self:isMessageSend() then
      return self:messageSend()
   end
   self:error("Unexpected Token", self:current())
end

function Parser:isReturn()
   return self:current().type == TokType.Return
end

function Parser:fnreturn()
   self:next()
   local v = self:expression()
   return Node({
      type = NodeType.Return,
      value = v,
   })
end

function Parser:messageSend(callee)
   local message
   if self:isUnarySend() then
      message = self:unaryMessageSend(callee)
   elseif self:isBinarySend() then
      message = self:binaryMessageSend(callee)
   elseif self:isKeywordSend() then
      message = self:kwMessageSend(callee)
   end

   if self:atEnd() then
      return message
   end

   if self:peek().type == TokType.Name then
      return self:unaryMessageSend(message)
   end

   if self:peek().type == TokType.Binary then
      return self:binaryMessageSend(message)
   end

   if self:peek().type == TokType.NameColon then
      return self:kwMessageSend(message)
   end

   if self:isMessageSend() then
      return self:messageSend(message)
   end
   return message
end

function Parser:isBinarySend()
   if self:current().type == TokType.Name and self:peek().type == TokType.Binary then
      return true
   end
end

function Parser:isUnarySend()
   local current = self:current()
   if self:peek().type == TokType.Name then
      return true
   end
end

function Parser:isKeywordSend()
   return self:current().type == TokType.NameColon
end

function Parser:isMessageSend()
   return self:isUnarySend() or self:isBinarySend() or self:isKeywordSend()
end

function Parser:isPrimary()
   return self:check(
      TokType.Name,
      TokType.Char,
      TokType.ParenOpen,
      TokType.BlockOpen,
      TokType.Str,
      TokType.LiteralArrayOpen,
      TokType.Number,
      TokType.Sym
   )
end

function Parser:primary()
    local current = self:current()
    print("Parsing " .. current.tokenName)
   if current.type == TokType.ParenOpen then
      return self:parenthesis()
   end

   if current.type == TokType.BlockOpen then
      return self:block()
   end

   if current.type == TokType.LiteralArrayOpen then
      return self:array()
   end

   if current.type == TokType.Name and self:peek().type == TokType.Binary then
      return self:messageSend()
   end

   if current.type == TokType.Name and self:peek().type == TokType.NameColon then
      return self:messageSend()
   end

   if self:isUnarySend() then
      return self:messageSend()
   end

   if current.type == TokType.Name then
      return Node({ type = NodeType.Identifier, rawValue = self:current().value })
   end
   if
      current.type == TokType.Str
      or current.type == TokType.Char
      or current.type == TokType.Number
      or current.type == TokType.Sym
   then
      return Node({ type = NodeType.Literal, value = self:current().value })
   end
end

function Parser:array()
   local arr = {}
   self:next()
   while self:current().type ~= TokType.ParenClose do
      arr[#arr + 1] = Node({ type = NodeType.Literal, value = self:current().value })
      self:next()
   end
   local node = Node({ type = NodeType.Array, value = arr })
   return node
end

function Parser:binaryMessageSend(callee)
   local current = self:current()
   local name = nil
   if not callee then
      name = current.value
   end
   local symbol = self:next().value
   self:next()

   return Node({
      type = NodeType.BinaryMessageSend,
      symbol = symbol,
      arg = self:expression(),
      callee = callee,
      name = name,
   })
end

function Parser:unaryMessageSend(callee)
   local node = Node({
      type = NodeType.UnaryMessageSend,
      name = self:current().value,
      arg = self:next().value,
      callee = callee,
   })
   return node
end

function Parser:kwMessageSend(callee)
   local kw = self:parseKwMessageSend(callee)
   if not kw then
      return self:error("Error parsing message send")
   end
   return kw
end

function Parser:parenthesis()
   self:next()
   local node = Node({
      type = NodeType.ParenExpression,
      expr = self:expression(),
   })

   self:next()
   self:next()
   return node
end

function Parser:block()
   local args = {}
   local tok = self:match(TokType.BlockArg)
   if tok ~= nil then
      args = self:gatherBlockArgs()
   end
   self:next()

   local node = Node({
      type = NodeType.Block,
      args = args,
      expr = self:expression(),
   })
   self:next()
   return node
end

function Parser:gatherBlockArgs()
    local args = {}
    while self:current().value ~= "|" do
        args[#args + 1] = self:current().value
        self:next()
    end
    if self:current().value == "|" then
        self:next()
    end
    return args
end

function Parser:parseClassDefinition(classDefinition)

   local cls = {}

    local lines = ssplit(classDefinition, "\n")
    local parts = ssplit(lines[1], " ")
    cls.superClass = sstrip(parts[1])
    cls.className = sstrip(parts[3]):sub(2)
    for i=2,#lines do
        local l = lines[i]
        l = sstrip(l)
        if l ~= "" and l ~= nil then
	   
            parts = ssplit(l, ':')
            local k = parts[1]
	    local v = parts[2]
	 
	   if k ~= nil then
	      k = sstrip(k)
                v = sstrip(v)
                if v:sub(1, 1) == "'" then
                    v = v:sub(2):sub(1, -2)
                end
                if k == "classVariableNames" or k == "instanceVariableNames" or k == "poolDictionaries" then
                    v = ssplit(v, ' ')
		    if #v == 1 and v[1] == "" then v = {} end
                end
	      cls[k] = v
	   end
	end
    end
    return cls
end

return { Parser = Parser }

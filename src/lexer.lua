local TokType = require("util").TokType
local TokName = require("util").TokName
local Lexer = {}
local BinaryOperators = "*,+,-,%,&,/,\\,|,=,<,>,?"
local WhiteSpace = "\t\n "

---@param tokenType TokType
---@param tokenValue any
---@return Token
local function Token(tokenType, tokenValue)
   ---@class Token
   ---@field type TokType
   ---@field value any
   ---@field pos integer
   ---@field line integer
   ---@field col integer

   return {
      metatype = "Token",
      type = tokenType,
      value = tokenValue,
      tokenName = TokName[tokenType],
      pos = Lexer.chr,
      line = Lexer.line,
      col = Lexer.col,
   }
end

local function stringContains(str, n)
   for i = 1, string.len(str) do
      if str:sub(i, i) == n then
         return true
      end
   end
   return false
end

local function isAlpha(c)
   return ("a" <= c and c <= "z") or ("A" <= c and c <= "Z")
end

local function isDigit(c)
   return "0" <= c and c <= "9"
end

local function isAlphaNumeric(c)
   return isDigit(c) or isAlpha(c)
end

function Lexer:initialize()
   self.source = ""
   self.chr = 0
   self.line = 1
   self.col = 1
   self.tokens = {}
   self.tokenCount = 0
end

function Lexer:next()
   self.chr = self.chr + 1
   self.col = self.col + 1
   local c = self.source:sub(self.chr, self.chr)
   if c == "\n" then
      self.col = 1
      self.line = self.line + 1
   end
   return c
end

function Lexer:nextChar()
   local c = self:next()
   while stringContains(WhiteSpace, c) do
      c = self:next()
   end
   -- Eat comments
   if c == '"' then
      local comment = ""
      while true do
         c = self:next()
         if c == nil then
            self.error("Unexpected EOF")
         end
         comment = comment .. c
         if c == '"' then
            break
         end
      end
      c = self:nextChar()
   end
   return c
end

function Lexer:peek(n)
   if n == nil then
      n = 1
   end
   return self.source:sub(self.chr + n, self.chr + n)
end

function Lexer:scan(src)
   self:initialize()
   self.source = src .. "."
   local token = self:scanToken()
   while token and token.type ~= TokType.EOF do
      self.tokenCount = self.tokenCount + 1
      self.tokens[self.tokenCount] = token

      token = self:scanToken()
   end
end

function Lexer:match(expected)
   if self:peek() == expected then
      return self:next()
   end
   return false
end

function Lexer:scanToken()
   local c = self:nextChar()
   if isAlpha(c) then
      return self:name()
   end
   if c == "-" and isDigit(self:peek()) then
      return self:number()
   end
   if isDigit(c) then
      return self:number()
   end
   if c == ":" and self:peek() == "=" then
      return self:assignment()
   end
   if c == ":" and isAlpha(self:peek()) then
      return self:blockArg()
   end
   if c == "#" and self:peek() == "(" then
      return self:literalArray()
   end
   if c == "#" and isAlpha(self:peek()) then
      return self:symbol()
   end
   if c == "$" and isAlpha(self:peek()) then
      return self:char()
   end
   if c == "'" then
      return self:string()
   end
   if c == "[" then
      return self:blockOpen()
   end
   if c == "]" then
      return self:blockClose()
   end
   if c == "." then
      return self:endStatement()
   end
   if c == "(" then
      return self:parenOpen()
   end
   if c == ")" then
      return self:parenClose()
   end
   if c == "{" then
      return self:arrayOpen()
   end
   if c == "}" then
      return self:arrayClose()
   end
   if c == ";" then
      return self:cascade()
   end
   if c == "^" then
      return self:fnreturn()
   end
   if c == "" then
      return self:eof()
   end
   if stringContains(BinaryOperators, c) then
      return self:binary()
   end
   self.error("Undefined input found: " .. tostring(c))
end

function Lexer.error(msg)
   error(msg)
end

---@return Token
function Lexer:name()
   local value = self:peek(0)
   while isAlphaNumeric(self:peek()) do
      value = value .. self:next()
   end
   if self:peek() == ":" then
      self:next()
      return Token(TokType.NameColon, value)
   else
      return Token(TokType.Name, value)
   end
end

---@return Token
function Lexer:number()
   local value = self:peek(0)
   local peek = self:peek()
   while isDigit(peek) or peek == "," or peek == "." do
      value = value .. self:next()
      peek = self:peek()
   end
   return Token(TokType.Number, tonumber(value))
end

---@return Token
function Lexer:assignment()
   -- Pop the next token as we already know it's ":"
   self:next()
   return Token(TokType.Assignment)
end

---@return Token
function Lexer:literalArray()
   -- The hashtag has already been consumed, also remove the bracket
   self:next()
   return Token(TokType.LiteralArrayOpen)
end

---@return Token
function Lexer:symbol()
   local tmp = self:name()
   tmp.type = TokType.Sym
   return tmp
end

---@return Token
function Lexer:char()
   local chr = self:next()
   return Token(TokType.Char, chr)
end

---@return Token
function Lexer:string()
   local value = ""
   while not self:match("'") do
      value = value .. self:next()
   end
   -- Skip the trailing single quote
   self:next()
   return Token(TokType.Str, value)
end

---@return Token
function Lexer.blockOpen()
   return Token(TokType.BlockOpen)
end

---@return Token
function Lexer.blockClose()
   return Token(TokType.BlockClose)
end

---@return Token
function Lexer.endStatement()
   return Token(TokType.EndStatement)
end

---@return Token
function Lexer.parenOpen()
   return Token(TokType.ParenOpen)
end

---@return Token
function Lexer.parenClose()
   return Token(TokType.ParenClose)
end

---@return Token
function Lexer.arrayOpen()
   return Token(TokType.ArrayOpen)
end

---@return Token
function Lexer.arrayClose()
   return Token(TokType.ArrayClose)
end

---@return Token
function Lexer:binary()
   return Token(TokType.Binary, self:peek(0))
end

---@return Token
function Lexer:blockArg()
   local tmp = self:name()
   tmp.type = TokType.BlockArg
   return tmp
end

---@return Token
function Lexer.cascade()
   return Token(TokType.Cascade)
end

---@return Token
function Lexer.fnreturn()
   return Token(TokType.Return)
end

---@return Token
function Lexer.eof()
   return Token(TokType.EOF)
end

return {
   Lexer = Lexer,
   Token = Token,
}

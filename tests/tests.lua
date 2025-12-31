local luaunit = require('luaunit')
local Lexer = require('lexer').Lexer
local Parser = require('parser').Parser
local Util = require('util')
local inspect = require('inspect')

local function parse(src)
    Lexer:scan(src)
    Parser:initialize()
    Parser.tokens = Lexer.tokens
    Parser.pos = 1
end

TestParser = {}

function TestParser:testAssignment()
    local src = "x := 1"
    parse(src)

    luaunit.assertIsTrue(Parser:isAssignment())

    local node = Parser:assignment()
    luaunit.assertEquals("Assignment", node.type)

    luaunit.assertEquals(Parser.pos, #Parser.tokens)
end

function TestParser:testBasicUnarySend()
    local src = "aClass aMethod"
    parse(src)
    luaunit.assertIsTrue(Parser:isUnarySend())
    local node = Parser:messageSend()
    luaunit.assertEquals("UnaryMessageSend", node.type)
    luaunit.assertEquals(Parser.pos, #Parser.tokens)
end

function TestParser:testCompoundUnarySend()
    local src = "aClass aMethod isNil"
    parse(src)
    luaunit.assertIsTrue(Parser:isUnarySend())
    local node = Parser:messageSend()
    luaunit.assertEquals("UnaryMessageSend", node.type)
    luaunit.assertEquals("UnaryMessageSend", node.callee.type)
    luaunit.assertEquals(Parser.pos, #Parser.tokens)
end

TestUtil = {}
function TestUtil:testssplit()
    local s = "how now brown cow"
    local parts = Util.ssplit(s, ' ')
    luaunit.assertEquals(parts, {'how', 'now', 'brown', 'cow'})
    
end

os.exit( luaunit.LuaUnit.run() )

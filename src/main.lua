local Lexer = require("lexer").Lexer
local inspect = require("inspect")
local Parser = require("parser").Parser
local StringBuilder = require("util").StringBuilder
local NodeType = require("util").NodeType
local readfile = require("util").readfile
local CodeGen = require("codegen").CodeGen
local runtime = require("runtime.all")
local ssplit = require("util").ssplit
local Api = require("api")
local argparse = require("argparse")

local parser = argparse("LunarTalk")
parser:argument("input", "Input file.")

local args = parser:parse()

local stsrc = readfile(args["input"])
stsrc = "doit\n" .. stsrc
print("Smalltalk Source:")
print(stsrc)
Lexer:scan(stsrc)
print(inspect(Lexer.tokens))
local fnnode = Parser:parse(Lexer.tokens, Lexer.source)

--print(inspect(fnnode))
local luasrc = CodeGen:emit(fnnode)
print("Lua Source:")
print(luasrc)
local luafn = load(luasrc, "", "bt", runtime)()
print("Result:")
luafn()
Api:start()

local src = [[
SuperClass subclass: #NameOfClass
    instanceVariableNames: 'instVarName1 instVarName2'
    classVariableNames: 'ClassVarName1 ClassVarName2'
    poolDictionaries: ''
    category: 'Major-Minor'
]]


-- print(inspect(Parser:parseClassDefinition(src)))

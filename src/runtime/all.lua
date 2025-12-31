local LTObject = require("runtime.object")
local LTNil = require("runtime.nil")
local LTTrue, LTFalse = require("runtime.boolean")
local Transcript = require("runtime.transcript")
local LTNumber = require("runtime.number")
local LTString = require("runtime.string")
return {
   LTObject = LTObject,
   LTTrue = LTTrue,
   LTFalse = LTFalse,
   LTNil = LTNil,
   Transcript = Transcript,
   LTNumber = LTNumber,
   LTString = LTString
}

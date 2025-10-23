Lunar-talk
=============
![Static Badge](https://img.shields.io/badge/NO_AI-100%25_Human_Coded-brightgreen)


Lunar-talk is an experimental dialect of Smalltalk implemented in Lua.

Overview
---------
I love Smalltalk. When I learned Lua, I realized you could aproximate Smalltalk pretty well if you tried. Lua is a lovely little language with a rather nice native vm, and the LuaJIT option which can make code fly. The idea of what is essentially a Smalltalk frontend for Lua was born.

Lunar-talk's main trick is a Smalltalk to Lua transpiler that attempts a 1 to 1 transformation. The resulting code will look reasonably like hand written Lua. 

The syntax is going to be extremely close to that of Smalltalk80, with full compatability being an evential goal. That said, this is NOT a Smalltalk 80 system.  Lunar-talk will feature a first class option to run code with `lunar-talk script.st` as well as editing the code in a live image like a traditional implementation.  Primitives and bytecodes are gone, but it should feel familiar to long time Smalltalkers.

Many design decisions have not been made, but a core architecture is in place and working well.

Roadmap
--------
I'm currently in the extremely early phases of development, and the code is no where near ready to share.

My rough roadmap so far is:
- [x] Finish initial proof-of-concept, parse Smalltalk code, emit and execute Lua code
- [ ] Implement the core object system in Lua
- [ ] Complete the ability to run Smalltalk code as scripts from the cli
- [ ] Push code for public consumption/inspection/ridecule!
- [ ] Begin work on live environment
- [ ] Rewrite in Lunar-Talk for eventual 1.0

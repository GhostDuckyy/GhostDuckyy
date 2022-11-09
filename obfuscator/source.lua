local func = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/obfuscator/main/kosuke14/RBXLuaObfuscator/obfuscator.lua"))()
local obf = func(source, customVar, watermark)
setclipboard(obf)
return obf

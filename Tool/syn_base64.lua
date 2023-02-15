if syn then
   local Module = {}

   function Module:encode(v)
        local encode = syn.crypt.base64.encode
        if encode then
            return encode(tostring(v))
        end
   end

   function Module:decode(v)
        local decode = syn.crypt.base64.decode
        if decode then
            return decode(tostring(v))
        end
   end

   function Module:obfuscate(str)
        if str ~= nil then str = tostring(str) end
        local startTick = tick()
        local encoded = tostring(Module:encode(str))
        local url = "https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Tool/syn_base64.lua"
        local obfuscated = "return(function() local a = {"..'"'..encoded..'"'.."}; local b = loadstring(game:HttpGet('"..url.."'))(); local c = b:decode(unpack(a)); loadstring(c)() end)()"
        obfuscated = tostring(obfuscated)

        local time = (startTick - tick())
        warn("Done obfuscation in "..time.."ticks")

        if setclipboard then setclipboard(obfuscated) end
        return obfuscated
   end

   return Module
end

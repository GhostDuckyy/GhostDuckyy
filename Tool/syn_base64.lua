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

        local variable = {
            [1] = tostring("u_"..math.random(100,999)),
            [2] = tostring("u_"..math.random(100,999)),
            [3] = tostring("u_"..math.random(100,999)),
        }

        local obfuscated = "return(function() local "..variable[1].." = {"..'"'..encoded..'"'.."}; local "..variable[2].." = loadstring(game:HttpGet('"..url.."'))(); local "..variable[3].." = "..variable[2]..":decode(unpack("..variable[1]..")); loadstring("..variable[3]..")() end)()"
        obfuscated = tostring(obfuscated)

        local time = (startTick - tick())
        warn("Done obfuscation in "..time.."ticks")

        if setclipboard then setclipboard(obfuscated) end
        return obfuscated
   end

   return Module
end

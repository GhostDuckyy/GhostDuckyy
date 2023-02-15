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
        local len = string.len(str)
        local startTick = tick()
        local encoded = '"'..tostring(Module:encode(str))..'"'
        local bytes = [["\114\101\116\117\114\110\32\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\39\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\71\104\111\115\116\68\117\99\107\121\121\47\71\104\111\115\116\68\117\99\107\121\121\47\109\97\105\110\47\84\111\111\108\47\115\121\110\95\98\97\115\101\54\52\46\108\117\97\39\41\41\40\41\10"]]

        local variable = {
            [1] = tostring("u_"..math.random(1000,9999)),
            [2] = tostring("u_"..math.random(1000,9999)),
            [3] = tostring("u_"..math.random(1000,9999)),
        }

        local fake_encoded = {
            [1] = '"'..Module:encode(tostring(math.random(len, len * 1.3)))..'"',
            [2] = '"'..Module:encode(tostring(math.random(len, len * 1.3)))..'"',
        }

        local obfuscated = "return(function() local "..variable[1].." = {"..fake_encoded[1]..", "..encoded..", "..fake_encoded[2].."}; local "..variable[2].." = loadstring("..bytes..")(); local "..variable[3].." = "..variable[2]..":decode("..variable[1].."[2]); loadstring("..variable[3]..")() end)()"
        obfuscated = tostring(obfuscated)

        local time = (startTick - tick())
        warn("Done obfuscation in "..time.." ticks")

        if setclipboard then setclipboard(obfuscated) end
        return obfuscated
   end

   return Module
end

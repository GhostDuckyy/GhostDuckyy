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

         local function random(length)
            if type(length) ~= "number" then return end

            local letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
            local code

            if math.random(1,2) == 1 then
                code = ""..letters[math.random(1,26)]
            else
                code = ""..tostring(letters[math.random(1,26)]):upper()
            end

            for i = 1, tonumber(length) do
                if math.random(1,2) == 1 then -- letters
                    local get_letters = letters[math.random(1,26)]
                    if math.random(1,2) == 1 then
                        code = code..tostring(get_letters):upper()
                    else
                        code = code..tostring(get_letters)
                    end
                else -- number
                    code = code..tostring(math.random(0,9))
                end
            end
            return tostring(code)
         end

         local len = string.len(str)
         local startTick = tick()
         local encoded = '"'..tostring(Module:encode(str))..'"'
         local bytes = [["\114\101\116\117\114\110\32\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\39\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\71\104\111\115\116\68\117\99\107\121\121\47\71\104\111\115\116\68\117\99\107\121\121\47\109\97\105\110\47\84\111\111\108\47\115\121\110\95\98\97\115\101\54\52\46\108\117\97\39\41\41\40\41\10"]]

         local number = math.random(10,12)
         local variable = {
               [1] = tostring("u_"..random(number)),
               [2] = tostring("u_"..random(number)),
               [3] = tostring("u_"..random(number)),
         }

         local fake_encoded = {
               [1] = '"'..Module:encode(random(math.random(len, len * 1.350)))..'"',
               [2] = '"'..Module:encode(random(math.random(len, len * 1.5)))..'"',
         }

         local obfuscated = "return(function() local "..variable[1].." = {"..fake_encoded[1]..", "..encoded..", "..fake_encoded[2].."};"..'\n'.."local "..variable[2].." = loadstring("..bytes..")(); local "..variable[3].." = "..variable[2]..":decode("..variable[1].."[2]); loadstring("..variable[3]..")()"..'\n'.."end)()"
         obfuscated = tostring(obfuscated)

         local time = (startTick - tick())
         warn("Done obfuscation in "..time.." ticks")

         if setclipboard then setclipboard(obfuscated) end
         return obfuscated
   end

   return Module
end

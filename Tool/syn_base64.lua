if syn then
   local Module = {}
   Module = {}

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
      local encoded = Module:encode(str)
      local obfuscated = tostring("local a = {"..'"'..encoded..'"'.."}; local b = loadstring(game:HttpGet(''))(); local c = b:decode(unpack(a)); loadstring(c)()")
      return obfuscated
   end

   return Module
end

--// Encrytion Made by 502#8277
local module = {}

function module:encrypt(str, key)
    local encrypted = ""
    for i = 1, #str do
      local char = string.byte(str, i)
      local key_char = string.byte(key, (i - 1) % #key + 1)
      encrypted = encrypted .. string.char(bit32.bxor(char, key_char))
    end
    return encrypted
end

function module:decrypt(str, key)
    return encrypt(str, key)
end

return module

local base64 = {}
local Encode = (syn and syn.crypt.base64.encode) or (crypt and (crypt.base64encode or crypt.base64.encode or crypt.base64_encode)) or base64.encode or base64_encode or function(...) error("Missing 'crypt' library") return end
local Decode = (syn and syn.crypt.base64.decode) or (crypt and (crypt.base64decode or crypt.base64.decode or crypt.base64_decode)) or base64.decode or base64_decode or function(...) error("Missing 'crypt' library") return end


function base64:encode(data)
    Encode(data)
end

function base64:decode(data)
    Decode(data)
end

return base64

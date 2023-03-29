local base64 = {}
local Encode = (syn and syn.crypt.base64.encode) or (crypt and (crypt.base64encode or crypt.base64.encode or crypt.base64_encode)) or base64.encode or base64_encode or function(...) error("Missing 'crypt' library") return end
local Decode = (syn and syn.crypt.base64.decode) or (crypt and (crypt.base64decode or crypt.base64.decode or crypt.base64_decode)) or base64.decode or base64_decode or function(...) error("Missing 'crypt' library") return end


function base64:encode(data)
    return Encode(data)
end

function base64:decode(data)
    return Decode(data)
end

function base64:obfuscate(data)
    if type(data) ~= "string" then return end
    
    local function generateRandom(length)
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
    
    local startTick = tick()
    local Variable_length = math.random(4,7)
    local Variable = {
        [1] = generateRandom(Variable_length),
        [2] = generateRandom(Variable_length),
        [3] = generateRandom(Variable_length),
        [4] = generateRandom(Variable_length),
        [5] = generateRandom(Variable_length),
        [6] = generateRandom(Variable_length),
    }
    
    local main = {Variable[math.random(1,2)], Variable[math.random(3,4)], Variable[math.random(5,6)]}
    local misc = {}
    local storage = {[1] = nil,[2] = nil}
    
    for i,v in next, (Variable) do
        if not table.find(main, v) then
            table.insert(misc, v)
        end
    end
    
    storage[1] = base64:encode(data)
    storage[2] = [[loadstring("\114\101\116\117\114\110\32\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\39\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\71\104\111\115\116\68\117\99\107\121\121\47\71\104\111\115\116\68\117\99\107\121\121\47\109\97\105\110\47\84\111\111\108\47\98\97\115\101\54\52\46\108\117\97\39\41\41\40\41\10")(); ]]
    
    local obfuscated = [[return(function(]]
    local len = string.len(data)
    
    if len >= 1000 then
        len = len / 2
    else
        if len >= 500 then
            len = 550
        else
            len = 600
        end
    end
    
    for i = 1,#Variable do
        if i ~= #Variable then
            obfuscated = obfuscated..Variable[i]..","
        else
            obfuscated = obfuscated..Variable[i]..") "
        end
    end
    
    obfuscated = obfuscated..misc[1].." = {"..'"'..base64:encode(generateRandom(len))..'"'.."}; "..misc[2].." = {"..'"'..base64:encode(generateRandom(len))..'"'.."}; "..misc[3].." = {"..'"'..base64:encode(generateRandom(len))..'"'.."}; "
    obfuscated = obfuscated..main[2].." = "..storage[2]..main[1].." = "..'{"'..storage[1]..'"}; '..main[3].." = "..main[2]..":decode(unpack("..main[1]..")); "..main[3].." = loadstring("..main[3]..")() "
    obfuscated = obfuscated..misc[1].." = {"..'"'..base64:encode(generateRandom(300))..'"'.."}; "..misc[2].." = {"..'"'..base64:encode(generateRandom(300))..'"'.."}; "..misc[3].." = {"..'"'..base64:encode(generateRandom(300))..'"'.."}; "
    
    warn("Done obfuscation in "..(startTick - tick()).." tick")
    obfuscated = tostring("--// Secured by Ghost-Ducky#7698\n"..obfuscated.."end)()")
    if setclipboard then setclipboard(obfuscated) end
    return obfuscated
end

return base64

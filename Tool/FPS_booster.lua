if not game:IsLoaded() then game.Loaded:Wait() end

local startTick = tick()
local IgnoreCharacters
local CustomList

if typeof(getgenv().Connections):lower() == "table" then
    for i,v in next, getgenv().Connections do
        pcall(task.spawn(function()
            v:Disconnect()
        end))
    end
    getgenv().Connections = {}
else
    getgenv().Connections = {}
end

local PartsList = {
    "Part",
    "BasePart",
    "MeshPart",
    ["BlackList"] = {
        "HumanoidRootPart",
        "Head",
        "Torso",
        "Left Arm",
        "Right Arm",
        "Left Leg",
        "Right Leg",
        "UpperTorso",
        "LowerTorso"
    }
}

local DestroyList = {
    "SurfaceGui",
    "BillboardGui",
    "Decal",
    "Texture",
    "Accessory",
}

local function checkInstance(v)
    pcall(task.spawn(function()
        task.wait(.1)
        IgnoreCharacters = (typeof(getgenv().IgnoreCharacters):lower() == "boolean" and getgenv().IgnoreCharacters) or false
        CustomList = (typeof(getgenv().CustomList):lower() == "table" and getgenv().CustomList) or {}
        if typeof(v) ~= "Instance" or (v == nil or v.Parent == nil) then return end
        if IgnoreCharacters and (v.Parent:IsA("Model") and game:GetService("Players"):GetPlayerFromCharacter(v.Parent) ~= nil) then return end

        if table.find(PartsList, v.ClassName) then
            if not table.find(PartsList.BlackList, v.Name) then
                v.Material = Enum.Material.SmoothPlastic
            end
        elseif table.find(DestroyList, v.ClassName) then
            v:Destroy()
        else
            for i2 = 1, #CustomList do
                local currentArray = CustomList[i2]
                if type(currentArray) == "table" then
                    local Name = currentArray.Name or currentArray.name or nil
                    local ClassName = currentArray.ClassName or currentArray.classname or nil

                    if type(Name) == "string" then
                        if v == nil or v.Parent == nil then return end
                        local lower = v.Name:lower()
                        if lower == Name:lower() or (string.find(lower, Name:lower()) or string.match(lower, Name:lower())) then
                            if not table.find(PartsList.BlackList, v.Name) then
                                v:Destroy()
                            end
                        end
                    end

                    if type(ClassName) == "string" then
                        if v == nil or v.Parent == nil then return end
                        if ClassName:lower() == "model" and (v:IsA("Model") and game:GetService("Players"):GetPlayerFromCharacter(v) ~= nil) then return end
                        local lower = v.ClassName:lower()
                        if lower == ClassName:lower() or (string.find(lower, ClassName:lower()) or string.match(lower, ClassName:lower())) then
                            if not table.find(PartsList.BlackList, v.Name) then
                                v:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end))
end

for i,v in ipairs(workspace:GetDescendants()) do
    checkInstance(v)
end

local DescendantAdded = workspace.DescendantAdded:Connect(checkInstance)
table.insert(getgenv().Connections, DescendantAdded)
local Time = tostring(startTick - tick())
warn("FPS Boost Loaded in "..Time.." tick(s)")

--// Load Check
if not game:IsLoaded() then game.Loaded:Wait() end

--// Service
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = (LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait())

--// Env
local startTick = tick()
local IgnoreCharacters, CustomList

--// Remove connections
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

--// List
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
    "Shirt",
    "Pants",
    "ParticleEmitter",
    "Trail",
    "Smoke",
    "Fire",
    "Sparkles",
    "PostEffect",
    "Explosion",
}

local IgnoreClassName = {
    "Folder",
    "Model",
}

--// function
local function checkInstance(v)
    pcall(task.spawn(function()
        task.wait(.1)
        IgnoreCharacters = (typeof(getgenv().IgnoreCharacters):lower() == "table" and getgenv().IgnoreCharacters) or {Self = true, Others = false, Clothes = true}
        CustomList = (typeof(getgenv().CustomList):lower() == "table" and getgenv().CustomList) or {}

        if typeof(v) ~= "Instance" or (v == nil or v.Parent == nil) then return end
        if (v.Parent ~= nil and v.Parent == workspace.CurrentCamera) then return end
        if table.find(IgnoreClassName, v.ClassName) then return end

        if IgnoreCharacters.Self then
            local GetPlayerFromCharacter = Players:GetPlayerFromCharacter(v.Parent)
            if (v.Parent ~= nil and (GetPlayerFromCharacter ~= nil and GetPlayerFromCharacter == LocalPlayer)) then return end
        end

        if IgnoreCharacters.Others then
            local GetPlayerFromCharacter = Players:GetPlayerFromCharacter(v.Parent)
            if (v.Parent ~= nil and (GetPlayerFromCharacter ~= nil and GetPlayerFromCharacter ~= LocalPlayer)) then return end
        end

        if table.find(PartsList, v.ClassName) then
            if not table.find(PartsList.BlackList, v.Name) then
                v.Material = Enum.Material.SmoothPlastic
            end
        elseif table.find(DestroyList, v.ClassName) then
            if v:IsA("Decal") and (v.Parent ~= nil and table.find(PartsList.BlackList, v.Parent.Name)) then
                return
            elseif v:IsA("Shirt") or v:IsA("Pants") then
                if not IgnoreCharacters.Clothes then v:Destroy() else return end
            end

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
                        if ClassName:lower() == "model" and (v:IsA("Model") and Players:GetPlayerFromCharacter(v) ~= nil) then return end
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

--// Source
for i,v in ipairs(workspace:GetDescendants()) do
    checkInstance(v)
end

local DescendantAdded = workspace.DescendantAdded:Connect(checkInstance)
table.insert(getgenv().Connections, DescendantAdded)

--// Loaded time
local Time = tostring(startTick - tick())
warn("FPS Boost Loaded in "..Time.." tick(s)")

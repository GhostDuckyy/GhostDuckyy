--// Load Check
if not game:IsLoaded() then game.Loaded:Wait() end

--// Service
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = (LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait())

--// Env
local startTick = tick()
local IgnoreCharacters, CustomList, IgnoreList

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
local default_Setting = {
    IgnoreCharacters = {Self = true, Others = false, RemoveClothes = false},
    CustomList = {},
    IgnoreList = {{ClassName = "Folder"}, {ClassName = "Model"}},
}

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

--// function
local function checkParent(value, Parent)
    if typeof(value) ~= "Instance" then return end

    if typeof(Parent) == "Instance" and Parent ~= nil then
        local Descendants = Parent:GetDescendants()
        for i = 1, #Descendants do
            local currentArray = Descendants[i]
            if currentArray ~= nil and currentArray == value then
                return true
            end
        end
    end

    return false
end

local function checkIgnoreList(value)
    if typeof(value) ~= "Instance" then return end

    for i, v in next, (IgnoreList) do
        if type(v) == "table" then
            local Namelower = value.Name:lower()
            local Classlower = value.ClassName:lower()

            local Name = v.Name or v.name or nil
            local ClassName = v.ClassName or v.classname or nil

            if (type(Name) == "string" and type(ClassName) == "string") then
                if (Namelower == Name:lower() or string.find(Namelower, Name:lower()) or string.match(Namelower, Name:lower())) and (value:IsA(ClassName) or Classlower == ClassName:lower() or string.find(Classlower, ClassName:lower()) or string.match(Classlower, ClassName:lower())) then
                    return true
                end
            elseif type(Name) == "string" then
                if (Namelower == Name:lower() or string.find(Namelower, Name:lower()) or string.match(Namelower, Name:lower())) then
                    return true
                end
            elseif type(ClassName) == "string" then
                if value:IsA(ClassName) or (Classlower == ClassName:lower() or string.find(Classlower, ClassName:lower()) or string.match(Classlower, ClassName:lower())) then
                    return true
                end
            end
        end
    end

    return false
end

local function checkInstance(v)
    pcall(task.spawn(function()
        task.wait(.1)
        if type(getgenv().Setting):lower() == "table" then
            IgnoreCharacters = (typeof(getgenv().Setting.IgnoreCharacters):lower() == "table" and getgenv().Setting.IgnoreCharacters) or default_Setting.IgnoreCharacters
            CustomList = (typeof(getgenv().Setting.CustomList):lower() == "table" and getgenv().Setting.CustomList) or default_Setting.CustomList
            IgnoreList = (typeof(getgenv().Setting.IgnoreList):lower() == "table" and getgenv().Setting.IgnoreList) or default_Setting.IgnoreList
        else
            IgnoreCharacters = default_Setting.IgnoreCharacters
            CustomList = default_Setting.CustomList
            IgnoreList = default_Setting.IgnoreList
        end

        if typeof(v) ~= "Instance" or (v == nil or v.Parent == nil) then return end
        if checkParent(v, workspace.CurrentCamera) then return end
        if checkIgnoreList(v) then return end

        if IgnoreCharacters.Self and Character ~= nil then
            if checkParent(v, Character) then
                return
            end
        end

        if IgnoreCharacters.Others then
            local GrabPlayers = Players:GetPlayers()

            for i = 1, #GrabPlayers do
                local currentArray = GrabPlayers[i]

                if currentArray ~= nil then
                    if currentArray ~= LocalPlayer and currentArray.Character ~= nil then
                        if checkParent(v, currentArray.Character) then
                            return
                        end
                    end
                end
            end
        end

        if table.find(PartsList, v.ClassName) then
            if not table.find(PartsList.BlackList, v.Name) then
                v.Material = Enum.Material.SmoothPlastic
            end
        elseif table.find(DestroyList, v.ClassName) then
            if v:IsA("Decal") then
                if (v.Parent ~= nil and table.find(PartsList.BlackList, v.Parent.Name)) then
                    return
                else
                    v.Transparency = 1
                end
            elseif v:IsA("BillboardGui") then
                if (v.Parent ~= nil and table.find(PartsList.BlackList, v.Parent.Name)) then
                    return
                else
                    v.Enabled = false
                end
            elseif v:IsA("Shirt") or v:IsA("Pants") then
                if IgnoreCharacters.RemoveClothes then v:Destroy() else return end
            end

            v:Destroy()
        else
            for i2 = 1, #CustomList do
                local currentArray = CustomList[i2]
                if type(currentArray) == "table" then
                    local Name = currentArray.Name or currentArray.name or nil
                    local ClassName = currentArray.ClassName or currentArray.classname or nil

                    if (type(Name) == "string" and type(ClassName) == "string") then
                        local Namelower = v.Name:lower()
                        local Classlower = v.ClassName:lower()

                        if (Namelower == Name:lower() or string.find(Namelower, Name:lower()) or string.match(Namelower, Name:lower())) and (v:IsA(ClassName) or Classlower == ClassName:lower() or string.find(Classlower, ClassName:lower()) or string.match(Classlower, ClassName:lower())) then
                            return true
                        end
                    elseif type(Name) == "string" then
                        if v == nil or v.Parent == nil then return end
                        local lower = v.Name:lower()
                        if lower == Name:lower() or (string.find(lower, Name:lower()) or string.match(lower, Name:lower())) then
                            if not table.find(PartsList.BlackList, v.Name) then
                                v:Destroy()
                            end
                        end
                    elseif type(ClassName) == "string" then
                        if v == nil or v.Parent == nil then return end

                        local lower = v.ClassName:lower()
                        if v:IsA(ClassName) or (lower == ClassName:lower() or string.find(lower, ClassName:lower()) or string.match(lower, ClassName:lower())) then
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
do
    local DescendantAdded = workspace.DescendantAdded:Connect(checkInstance)
    table.insert(getgenv().Connections, DescendantAdded)

    for i,v in ipairs(workspace:GetDescendants()) do
        checkInstance(v)
    end

    local Time = tostring(startTick - tick())
    warn("FPS Boost Loaded in "..Time.." tick(s)")
end

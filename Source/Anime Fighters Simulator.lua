while true do if game:IsLoaded() and game.PlaceId == 6299805723 then break; end task.wait(.05) end

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Theme = {
    SchemeColor = Color3.fromRGB(58, 59, 225),
    Background = Color3.fromRGB(4, 5, 26),
    Header = Color3.fromRGB(4, 5, 26),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(50, 49, 57)
}
local w = Library.CreateLib("Anime Fighters Simulator | GUI", Theme)

--// Env
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

getgenv().Setting = {
    CollectDrop = false,
    Stars = {AutoPurchase = false, StarsList = {}, SelectedStars = nil, TargetStars = nil, TargetWorld = nil,},
    Claim = {Ticket = false, Spin = false, Gift = false,Merchant = false,},
    AutoFarm = {Enabled = false, MobSelected = nil, TargetSelected = nil, EnemiesList = {"Click to Refresh List"}, Height = false,},
    Client = {WalkSpeed = 16, JumpPower = 50},
}

--// Function
function RefreshEnemies(NewValue)
    table.clear(Setting.AutoFarm.EnemiesList)

    if workspace.Worlds:FindFirstChild(NewValue) ~= nil and workspace.Worlds[NewValue]:FindFirstChild("Enemies") then
        for _,v in ipairs(workspace.Worlds[NewValue].Enemies:GetChildren()) do
            if v:FindFirstChild("DisplayName") then
                if not table.find(Setting.AutoFarm.EnemiesList, v.DisplayName.Value) then table.insert(Setting.AutoFarm.EnemiesList, v.DisplayName.Value) end
            end
        end
    end
end

function AutoFarm()
    local function GetEnemies()
        if workspace.Worlds:FindFirstChild(LocalPlayer.World.Value) ~= nil and workspace.Worlds[LocalPlayer.World.Value]:FindFirstChild("Enemies") then
            for i,v in ipairs(workspace.Worlds[LocalPlayer.World.Value].Enemies:GetChildren()) do
                if v:FindFirstChild("DisplayName") and v:FindFirstChild("Health") then
                    if v.DisplayName.Value == Setting.AutoFarm.MobSelected and v.Health.Value > 0 then
                        return v
                    end
                end
            end
        end
        return nil
    end

    local function MoveTo(bool)
        local Teleported = game:GetService("ReplicatedStorage").Bindable.Teleported
        if bool and Character and Setting.AutoFarm.TargetSelected ~= nil and Setting.AutoFarm.TargetSelected:FindFirstChild("HumanoidRootPart") then
            local HumanoidRootPart = Character.HumanoidRootPart
            local EnemiesHRP = Setting.AutoFarm.TargetSelected.HumanoidRootPart
            local Water = workspace.Worlds[LocalPlayer.World.Value]:FindFirstChild("Water")

            HumanoidRootPart.Anchored = false

            if Setting.AutoFarm.Height then HumanoidRootPart.CFrame = EnemiesHRP.CFrame else HumanoidRootPart.CFrame = EnemiesHRP.CFrame * CFrame.new(0, -5, 0) end
            Teleported:Fire()
            task.wait(.1)
            if Setting.AutoFarm.Height then HumanoidRootPart.CFrame = EnemiesHRP.CFrame * CFrame.new(0, 20, 0) else HumanoidRootPart.CFrame = CFrame.new(EnemiesHRP.CFrame.X, Water.CFrame.Y + 8, EnemiesHRP.CFrame.Z) end
            HumanoidRootPart.Anchored = true
        elseif bool and Setting.AutoFarm.TargetSelected == nil and Character then
            local HumanoidRootPart = Character.HumanoidRootPart
            if HumanoidRootPart.Anchored == true then HumanoidRootPart.Anchored = false end

            local Water = workspace.Worlds[LocalPlayer.World.Value]:FindFirstChild("Water")

            if Water ~= nil then
                HumanoidRootPart.CFrame = CFrame.new(Water.CFrame.X + math.random(30, 120), Water.CFrame.Y + 5, Water.CFrame.Z + math.random(30, 120))
                Teleported:Fire()
                HumanoidRootPart.Anchored = true
            end
        elseif not bool and Character then
            if Character then
                task.wait(.5)
                local HumanoidRootPart = Character.HumanoidRootPart
                HumanoidRootPart.Anchored = false

                if not Setting.AutoFarm.Height then
                    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                end
                Teleported:Fire()
            end
        end
    end

    if Setting.AutoFarm.Enabled then
        task.spawn(function()
            local SendPet = game:GetService("ReplicatedStorage").Bindable.SendPet
            local ClickerDamage = game:GetService("ReplicatedStorage").Remote.ClickerDamage
            local Old_Height = Setting.AutoFarm.Height
            MaxHealth = 100
            IsTeleported = false

            Setting.AutoFarm.TargetSelected = nil
            while Setting.AutoFarm.Enabled do
                if Setting.AutoFarm.MobSelected ~= nil then
                    if Setting.AutoFarm.TargetSelected == nil then IsTeleported = false; Setting.AutoFarm.TargetSelected = GetEnemies(); getgenv().Status:UpdateLabel("Status: Finding mob") end
                    if Setting.AutoFarm.TargetSelected ~= nil then
                        if Setting.AutoFarm.TargetSelected.Parent.Name == "Effects" then
                            Setting.AutoFarm.TargetSelected = nil
                            getgenv().Status:UpdateLabel("Status: "..Setting.AutoFarm.MobSelected.." | Health: 0%")
                        else
                            if not IsTeleported then MoveTo(true); IsTeleported = true end
                            if Setting.AutoFarm.TargetSelected:FindFirstChild("MaxHealth") ~= nil and Setting.AutoFarm.TargetSelected.MaxHealth.Value ~= MaxHealth then MaxHealth = Setting.AutoFarm.TargetSelected.MaxHealth.Value end
                            if Setting.AutoFarm.Height ~= Old_Height then MoveTo(true) end

                            SendPet:Fire(Setting.AutoFarm.TargetSelected, true)
                            ClickerDamage:FireServer()

                            local Health = Setting.AutoFarm.TargetSelected:FindFirstChild("Health")
                            if Health ~= nil then
                                Health = Health.Value
                                local Calculate = tostring(math.ceil(Health / MaxHealth * 100))
                                getgenv().Status:UpdateLabel("Status: "..Setting.AutoFarm.MobSelected.." | Health: "..Calculate.."%")
                            end

                            if Setting.AutoFarm.TargetSelected:FindFirstChild("DisplayName") ~= nil and Setting.AutoFarm.TargetSelected.DisplayName.Value ~= Setting.AutoFarm.MobSelected then Setting.AutoFarm.TargetSelected = nil end
                        end
                    end

                else
                    getgenv().Status:UpdateLabel("Status: Select a mob")
                end
                task.wait(.05)
            end
        end)
    else
        MoveTo(false)
    end
end

function CollectDrop()
    task.spawn(function()
        for _,v in ipairs(workspace.Effects:GetDescendants()) do
            if v.Name == "Base" then
                task.spawn(function()
                    while Setting.CollectDrop do
                        if v == nil then break end

                        if Character then
                            if v ~= nil then v.CFrame = Character.HumanoidRootPart.CFrame end
                        end
                        task.wait(.1)
                    end
                end)
            end
        end
    end)
end

function ClaimStuff(mode)
    if mode == "Ticket" then
        task.spawn(function()
            while Setting.Claim.Ticket do
                game:GetService("ReplicatedStorage").Remote.ClaimTicket:FireServer()
                task.wait(1)
            end
        end)
    elseif mode == "Spin" then
        task.spawn(function()
            while Setting.Claim.Spin do
                game:GetService("ReplicatedStorage").Remote.DailySpin:FireServer()
                task.wait(1)
            end
        end)
    elseif mode == "Merchant" then
        task.spawn(function()
            while Setting.Claim.Merchant do
                game:GetService("ReplicatedStorage").Remote.ClaimBoost:FireServer()
                task.wait(1)
            end
        end)
    elseif mode == "Gift" then
        task.spawn(function()
            local Number = 1
            while Setting.Claim.Gift do
                if Number > 16 then Number = 1 end
                game:GetService("ReplicatedStorage").Remote.ClaimGift:FireServer(Number)
                Number = Number + 1
                task.wait(1)
            end
        end)
    end
end

function AutoPurchase()
    local function getWorld()
        if Setting.Stars.SelectedStars ~= nil then
            for _,v in ipairs(workspace.Worlds:GetChildren()) do
                if v:FindFirstChild(Setting.Stars.SelectedStars) ~= nil then
                    return v
                end
            end
        end
        return nil
    end

    task.spawn(function()
        local AttemptTravel = game:GetService("ReplicatedStorage").Remote.AttemptTravel
        local Teleported = game:GetService("ReplicatedStorage").Bindable.Teleported
        local OpenEgg = game:GetService("ReplicatedStorage").Remote.OpenEgg

        Old_Target = Setting.Stars.SelectedStars

        Setting.Stars.TargetWorld = nil
        Setting.Stars.TargetStars = nil

        while Setting.Stars.AutoPurchase do
            if Setting.Stars.SelectedStars ~= nil then
                if Setting.Stars.TargetWorld == nil then Setting.Stars.TargetWorld = getWorld() end
                if Setting.Stars.TargetWorld ~= nil and Setting.Stars.TargetStars == nil then Setting.Stars.TargetStars = Setting.Stars.TargetWorld:FindFirstChild(Setting.Stars.SelectedStars) end

                if Character then
                    local HumanoidRootPart = Character.HumanoidRootPart

                    if Setting.Stars.TargetWorld ~= nil and Setting.Stars.TargetStars ~= nil then
                        if Setting.Stars.SelectedStars ~= Old_Target then
                            HumanoidRootPart.Anchored = false
                            Old_Target = Setting.Stars.SelectedStars
                            Setting.Stars.TargetWorld = nil
                            Setting.Stars.TargetStars = nil
                        else
                            if Setting.Stars.TargetWorld ~= nil and Setting.Stars.TargetStars ~= nil then

                                AttemptTravel:InvokeServer(tostring(Setting.Stars.TargetWorld.Name))
                                if Setting.Stars.TargetStars:FindFirstChild("Stand") ~= nil then
                                    if not HumanoidRootPart.Anchored then
                                        HumanoidRootPart.CFrame = Setting.Stars.TargetStars.Stand.CFrame * CFrame.new(0, 1, 6.5)
                                        task.wait(1)
                                        HumanoidRootPart.CFrame = Setting.Stars.TargetStars.Stand.CFrame * CFrame.new(0, 1, 6.5)
                                        HumanoidRootPart.Anchored = true
                                        Teleported:Fire()
                                    end
                                    AttemptTravel:InvokeServer(tostring(Setting.Stars.TargetWorld.Name))
                                    OpenEgg:InvokeServer(Setting.Stars.TargetStars, 5)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(.1)
        end
    end)
end

--// Source
local farm = w:NewTab("Farm")
local auto = farm:NewSection("Automatic")

auto:NewToggle("AutoFarm", "Auto farm selected mob", function(v)
    Setting.AutoFarm.Enabled = v
    if not v then getgenv().Status:UpdateLabel("Status") end
    AutoFarm()
end)

auto:NewToggle("Collect Drops", "Auto collect drops form mobs", function(v)
    Setting.CollectDrop = v
    if v then CollectDrop()  end
end)

EnemiesDropdown = auto:NewDropdown("Mobs List", "Select mob to farm", Setting.AutoFarm.EnemiesList, function(v)
    if v == "Click to Refresh List" then RefreshEnemies(LocalPlayer.World.Value) EnemiesDropdown:Refresh(Setting.AutoFarm.EnemiesList) return end
    Setting.AutoFarm.MobSelected = v
end)

auto:NewButton("Refresh List", "Refresh the dropdown", function()
    RefreshEnemies(LocalPlayer.World.Value)
    EnemiesDropdown:Refresh(Setting.AutoFarm.EnemiesList)
end)

getgenv().Status = auto:NewLabel("Status")

auto:NewDropdown("Height", "Top/Buttom on mob", {"Top", "Bottom"}, function(v)
    if v == "Top" then
        Setting.AutoFarm.Height = true
    elseif v == "Bottom" then
        Setting.AutoFarm.Height = false
    end
end)

local stars = w:NewTab("Stars") do
    stars = stars:NewSection("Automatic")

    local EggModule = require(game:GetService("ReplicatedStorage").ModuleScripts.EggStats) do
        for i,v in next, (EggModule) do
            if i ~= "MultiOpen" and i ~= "Unknown" then
                if rawget(v, "DisplayName") and not rawget(v, "Currency") then
                    if not table.find(Setting.Stars.StarsList, tostring(v.DisplayName)) then table.insert(Setting.Stars.StarsList, tostring(v.DisplayName)) end
                end
            end
        end
    end

    stars:NewDropdown("Stars List", "Select a stars to open", Setting.Stars.StarsList, function(DisplayName)
        for StarsName, Table in next, (EggModule) do
            if tostring(StarsName) ~= "MultiOpen" and tostring(StarsName) ~= "Unknown" then
                if rawget(Table, "DisplayName") and not rawget(Table, "Currency") then
                    if Table.DisplayName == DisplayName then
                        Setting.Stars.SelectedStars = tostring(StarsName)
                    end
                end
            end
        end
    end)

    stars:NewToggle("Auto purchase stars", "Auto purchase selected star", function(v)
        Setting.Stars.AutoPurchase = v

        if v then
            AutoPurchase()
        else
            if Character then
                local HumanoidRootPart = Character.HumanoidRootPart
                HumanoidRootPart.Anchored = false
            end
        end
    end)

    stars:NewLabel("NOTE: if not working then re-enable auto purchase")
    stars:NewLabel([[¯\_(ツ)_/¯ i will fix bug in this week]])
end


local misc = w:NewTab("Misc")do
    local credit = misc:NewSection("Made by Ghost-Ducky#7698")
    credit:NewTextBox("Set fps cap", "Must unlocked fps", function(v)
        if type(v) ~= "number" then v = tonumber(v) end
        if setfpscap then setfpscap(v) end
    end)
end

local menu = misc:NewSection("Menu") do
    local SetWindowOpen = LocalPlayer.PlayerGui.MainGui.SetWindowOpen
    local AttemptOpenGate = game:GetService("ReplicatedStorage").Bindable.AttemptOpenGate
    local AttemptDiscoverWorld = game:GetService("ReplicatedStorage").Remote.AttemptDiscoverWorld

    menu:NewButton("Teleport Menu", "Show teleport menu", function()
        SetWindowOpen:Fire("Travel", true)
    end)

    menu:NewButton("Purchase Gate", "Purchase current world gate if haven't bought", function()
        local WorldGate = workspace.Worlds[LocalPlayer.World.Value]:FindFirstChild("WorldGate")
        if WorldGate ~= nil and not WorldGate.Open.Value then
            AttemptOpenGate:Fire(WorldGate, true)
            task.wait(.2)
            AttemptDiscoverWorld:FireServer(WorldGate.TargetWorld.Value)
            task.wait(.05)
            AttemptOpenGate:Fire(WorldGate, false)
        end
    end)
end

local client = misc:NewSection("Client") do

    client:NewTextBox("Set fps cap", "Must unlocked fps", function(v)
        if type(v) ~= "number" then v = tonumber(v) end
        if setfpscap then setfpscap(v) end
    end)

    client:NewSlider("WalkSpeed", "Modify client walkspeed", 200, 16, function(x)
        Setting.Client.WalkSpeed = tonumber(x)
    end)

    client:NewSlider("JumpPower", "Modify client jumppower", 200, 50, function(x)
        Setting.Client.JumpPower = tonumber(x)
    end)

    client:NewLabel("Daily / Weekly")

    client:NewToggle("Claim Daily Gift", "Auto claim daily gift", function(v)
        Setting.Claim.Gift = v
        if v then ClaimStuff("Gift") end
    end)

    client:NewToggle("Claim Raid Ticket", "Auto claim daily raid ticket", function(v)
        Setting.Claim.Ticket = v
        if v then ClaimStuff("Ticket") end
    end)

    client:NewToggle("Claim Spin Wheel", "Auto claim daily spin wheel", function(v)
        Setting.Claim.Spin = v
        if v then ClaimStuff("Spin") end
    end)

    client:NewToggle("Claim Merchant Boost", "Auto claim weekly merchant boost", function(v)
        Setting.Claim.Merchant = v
        if v then ClaimStuff("Merchant") end
    end)
end

--// Setup
do
    task.spawn(function()
        RefreshEnemies(LocalPlayer.World.Value)
        EnemiesDropdown:Refresh(Setting.AutoFarm.EnemiesList)

        if getconnections then
            for _,v in next, getconnections(LocalPlayer.Idled) do
                    v:Disable()
            end
        else
            LocalPlayer.Idled:Connect(function()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)

    RunService.RenderStepped:Connect(function()
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = Setting.Client.WalkSpeed
                Humanoid.JumpPower = Setting.Client.JumpPower
            end
        end
    end)

    workspace.Effects.DescendantAdded:Connect(function(v)
        task.wait(.2)
        if Setting.CollectDrop and v.Name == "Base" and v:IsA("Part") then
            task.spawn(function()
                while Setting.CollectDrop do
                    if (v == nil) then break end

                    if Character then
                        if (v ~= nil and v.Parent ~= nil and v.Parent.Name ~= "MovingItem") then v.CFrame = Character.HumanoidRootPart.CFrame end
                    end
                    task.wait(.1)
                end
            end)
        end
    end)

    local get_rawmt = getrawmetatable(game)
    local old_index = get_rawmt.__index
    setreadonly(get_rawmt, false)
    get_rawmt.__index = newcclosure(function(self,value)
        if tostring(value):lower() == "walkspeed" then
            return 16
        end
        if tostring(value):lower() == "jumppower" then
            return 50
        end
        return old_index(self,value)
    end)
    setreadonly(get_rawmt, true)
end

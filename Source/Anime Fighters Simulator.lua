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

local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

getgenv().Setting = {
    CollectDrop = false,
    Daily = {Ticket = false, Spin = false, Gift = false,Merchant = false,},
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

            if HumanoidRootPart.Anchored == true then HumanoidRootPart.Anchored = false end

            if Setting.AutoFarm.Height then HumanoidRootPart.CFrame = EnemiesHRP.CFrame else HumanoidRootPart.CFrame = EnemiesHRP.CFrame * CFrame.new(0, -5, 0) end
            Teleported:Fire()
            task.wait(.1)
            if Setting.AutoFarm.Height then HumanoidRootPart.CFrame = EnemiesHRP.CFrame * CFrame.new(0, 20, 0) else HumanoidRootPart.CFrame = EnemiesHRP.CFrame * CFrame.new(0, -20, 0) end
            HumanoidRootPart.Anchored = true
        elseif bool and Setting.AutoFarm.TargetSelected == nil and Character then
            local HumanoidRootPart = Character.HumanoidRootPart
            if HumanoidRootPart.Anchored == true then HumanoidRootPart.Anchored = false end

            local Water = workspace.Worlds[LocalPlayer.World.Value]:FindFirstChild("Water")

            if Water ~= nil then
                HumanoidRootPart.CFrame = CFrame.new(Water.CFrame.X + math.random(30, 180), Water.CFrame.Y + 5, Water.CFrame.Z + math.random(30, 180))
                Teleported:Fire()
                HumanoidRootPart.Anchored = true

                while Setting.AutoFarm.Enabled do if Setting.AutoFarm.TargetSelected == nil then getgenv().Status:UpdateLabel("Status: Waiting mob spawn"); Setting.AutoFarm.TargetSelected = GetEnemies() else break end task.wait(.1) end

                if Setting.AutoFarm.Enabled then MoveTo(true) else MoveTo(false) end
            end
        elseif not bool and Character then
            if Character then
                task.wait(.5)
                local HumanoidRootPart = Character.HumanoidRootPart
                HumanoidRootPart.Anchored = false

                if not Setting.AutoFarm.Height then
                    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)
                end
                Teleported:Fire()
            end
        end
    end

    if Setting.AutoFarm.Enabled then
        task.spawn(function()
            local SendPet = game:GetService("ReplicatedStorage").Bindable.SendPet
            Old_Height = Setting.AutoFarm.Height
            MaxHealth = 100

            Setting.AutoFarm.TargetSelected = nil
            while Setting.AutoFarm.Enabled do
                if Setting.AutoFarm.MobSelected ~= nil then
                    if Setting.AutoFarm.TargetSelected == nil then Setting.AutoFarm.TargetSelected = GetEnemies() end

                    MoveTo(true)
                    while Setting.AutoFarm.Enabled do
                        if (Setting.AutoFarm.TargetSelected == nil or (Setting.AutoFarm.TargetSelected ~= nil and Setting.AutoFarm.TargetSelected.Parent ~= nil and Setting.AutoFarm.TargetSelected.Parent.Name ~= "Enemies")) then getgenv().Status:UpdateLabel("Status: "..Setting.AutoFarm.MobSelected.." | Health: 0%") break end
                        if Setting.AutoFarm.TargetSelected.DisplayName.Value ~= Setting.AutoFarm.MobSelected then break end
                        if Setting.AutoFarm.Height ~= Old_Height then Old_Height = Setting.AutoFarm.Height; MoveTo(true) end
                        if MaxHealth ~= Setting.AutoFarm.TargetSelected.MaxHealth.Value then MaxHealth = tonumber(Setting.AutoFarm.TargetSelected.MaxHealth.Value) end

                        local Health = Setting.AutoFarm.TargetSelected.Health.Value
                        local percentage = math.ceil((Health / MaxHealth) * 100)

                        game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
                        SendPet:Fire(Setting.AutoFarm.TargetSelected, true)
                        getgenv().Status:UpdateLabel("Status: "..Setting.AutoFarm.MobSelected.." | Health: "..tostring(percentage.."%"))

                        task.wait(.1)
                    end
                    Setting.AutoFarm.TargetSelected = nil
                else
                    getgenv().Status:UpdateLabel("Status: Select a mob")
                end
                task.wait(.350)
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

function ClaimDaily(mode)
    if mode == "Ticket" then
        task.spawn(function()
            while Setting.Daily.Ticket do
                game:GetService("ReplicatedStorage").Remote.ClaimTicket:FireServer()
                task.wait(1)
            end
        end)
    elseif mode == "Spin" then
        task.spawn(function()
            while Setting.Daily.Spin do
                game:GetService("ReplicatedStorage").Remote.DailySpin:FireServer()
                task.wait(1)
            end
        end)
    elseif mode == "Merchant" then
        task.spawn(function()
            while Setting.Daily.Merchant do
                game:GetService("ReplicatedStorage").Remote.ClaimBoost:FireServer()
                task.wait(1)
            end
        end)
    elseif mode == "Gift" then
        task.spawn(function()
            local Number = 1
            while Setting.Daily.Gift do
                if Number > 16 then Number = 1 end
                game:GetService("ReplicatedStorage").Remote.ClaimGift:FireServer(Number)
                Number = Number + 1
                task.wait(1)
            end
        end)
    end
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


local misc = w:NewTab("Misc")
local client = misc:NewSection("Client")

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
    Setting.Daily.Gift = v
    if v then ClaimDaily("Gift") end
end)

client:NewToggle("Claim Raid Ticket", "Auto claim daily raid ticket", function(v)
    Setting.Daily.Ticket = v
    if v then ClaimDaily("Ticket") end
end)

client:NewToggle("Claim Spin Wheel", "Auto claim daily spin wheel", function(v)
    Setting.Daily.Spin = v
    if v then ClaimDaily("Spin") end
end)

client:NewToggle("Claim Merchant Boost", "Auto claim weekly merchant boost", function(v)
    Setting.Daily.Merchant = v
    if v then ClaimDaily("Merchant") end
end)

client:NewLabel("Made by Ghost-Ducky#7698")

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

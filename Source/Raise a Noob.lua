--// Made by Ghost-Ducky#7698
while true do if game:IsLoaded() then break; end task.wait(.1) end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/UI/Elerium%20V2.lua"))()
local w = Library:AddWindow("Raise a noob [GUI]", {
    main_color = Color3.fromRGB(200, 0, 0),
	min_size = Vector2.new(450, 400),
	toggle_key = Enum.KeyCode.RightControl,
	can_resize = false,
})

local main = w:AddTab("Main")
local misc = w:AddTab("Misc")

--// Env
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait()

getgenv().Setting = {
    AutoClick = false,
    AutoPlaceFood = false,
    AutoCollectBobux = false,
    AutoCleanPoo = false,
    CheckHungerValue = 40,
}

--// Source
main:AddSwitch("Auto click", function(x)
    Setting.AutoClick = x
    if x then ClickNoob() end
end)

main:AddSwitch("Auto place food", function(x)
    Setting.AutoPlaceFood = x
    if x then PlaceFood() end
end)

main:AddSlider("Check IsHunger", function(x)
    Setting.CheckHungerValue = x
end,{["min"] = 30, ["max"] = 40,}):Set(40)

main:AddSwitch("Collect bobux", function(x)
    Setting.AutoCollectBobux = x
    if x then task.spawn(function() local SpawnedBobux = workspace.SpawnedBobux; for i,v in ipairs(SpawnedBobux:GetChildren()) do task.spawn(function() if Character and v:FindFirstChild("BobuxValue") then firetouchinterest(Character.HumanoidRootPart, v, 0) task.wait(.150) firetouchinterest(Character.HumanoidRootPart, v, 1) end end) end end) end
end)

main:AddSwitch("Clean poo", function(x)
    Setting.AutoCleanPoo = x
    if x then task.spawn(function() for i,v in ipairs(workspace:GetChildren()) do if v:IsA("Model") and v.Name == "Poo" and v:FindFirstChild("PooBase") then if Character then Character.HumanoidRootPart.CFrame = CFrame.new(v.PooBase.CFrame.X, v.PooBase.CFrame.Y + 5, v.PooBase.CFrame.Z - 1.5) task.wait(.150) fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt")) task.wait(.350) end end end end) end
end)


--// Function
function getNoob()
    for i,v in ipairs(workspace:GetChildren()) do
        if v.Name == "Noob" and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            return v
        end
    end
    return false
end

function IsHunger(number)
    local Noob = getNoob()

    if Noob and Noob:FindFirstChild("Hunger") then
        local Hunger = Noob.Hunger
        if tonumber(number) > Hunger.Value then return true end
    end
    return false
end

function ClickNoob()
    task.spawn(function()
        local Noob = getNoob()

        while Setting.AutoClick do
            if Noob then
                if not IsHunger(Setting.CheckHungerValue) then game:GetService("ReplicatedStorage").ClickNoob:FireServer() end
            else
                Noob = getNoob()
            end
            task.wait(.1)
        end
    end)
end

function PlaceFood()
    local function checkFood()
        if Character and Character:FindFirstChild("Noob Food") then
            return true
        elseif LocalPlayer.Backpack:FindFirstChild("Noob Food") then
            return true
        end
        return false
    end

    local function BuyFood()
        local Bobux = workspace["Bobux"]
        if Bobux.Value > 25 then
            game:GetService("ReplicatedStorage").BuyEvent:InvokeServer("narket", 1, "Noob Food")
        end
    end

    task.spawn(function()
        local Dish = workspace:FindFirstChild("Dish")
        while Setting.AutoPlaceFood do
            if IsHunger(Setting.CheckHungerValue) then
                if Character then
                    if Dish.Filled.Value ~= true then
                        if checkFood() then
                            if LocalPlayer.Backpack:FindFirstChild("Noob Food") then Character.Humanoid:EquipTool(LocalPlayer.Backpack["Noob Food"]) end
                            Character.HumanoidRootPart.CFrame = CFrame.new(Dish.CFrame.X, Dish.CFrame.Y + 3, Dish.CFrame.Z)
                            task.wait(.2)
                            fireproximityprompt(Dish:FindFirstChildOfClass("ProximityPrompt"))
                            task.wait(.5)
                        else
                            BuyFood()
                        end
                    end
                end
            end
            task.wait(.5)
        end
    end)
end

function CollectBobux()
    task.spawn(function()
        local SpawnedBobux = workspace.SpawnedBobux

        SpawnedBobux.ChildAdded:Connect(function(v)
            if not Setting.AutoCollectBobux then return end
            task.wait(.2)
            task.spawn(function() if Character and v:FindFirstChild("BobuxValue") then firetouchinterest(Character.HumanoidRootPart, v, 0) task.wait(.150) firetouchinterest(Character.HumanoidRootPart, v, 1) end end)
        end)
    end)
end

function CleanPoo()
    task.spawn(function()
        workspace.ChildAdded:Connect(function(v)
            if not Setting.AutoCleanPoo then return end
            task.wait(.2)
            if v:IsA("Model") and v.Name == "Poo" and v:FindFirstChild("PooBase") then
                if Character then
                    Character.HumanoidRootPart.CFrame = CFrame.new(v.PooBase.CFrame.X, v.PooBase.CFrame.Y + 5, v.PooBase.CFrame.Z - 1.5)
                    task.wait(.1)
                    fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"))
                    task.wait(.350)
                end
            else return end
        end)
    end)
end

function MouseFlingText(text, color)
    task.spawn(function()
        if color == nil then color = Color3.new(1,1,1) end
        if text == nil then text = "Made by Ghost-Ducky#7698" end

        game:GetService("ReplicatedStorage").MouseFlingTextEvent:FireServer(tostring(text), color, LocalPlayer.PlayerGui.MainGui.Buy)
    end)
end

--// Setup
CollectBobux()
CleanPoo()

main:Show()

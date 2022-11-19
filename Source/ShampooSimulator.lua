while task.wait() do
    if game:IsLoaded() and game.PlaceId == 6440133276 then break; end
end

--// Library
local Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

--// Env
local w = Library:CreateWindow("Shampoo Simulator")
local auto = w:CreateFolder("Automatic")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().Setting = {
    auto_shampoo = false,
    sell_mode = nil,
    auto_sell = false,
    auto_farm_pumpkin = false,
    auto_farm_boss = false,
}

--// Source
auto:Toggle("Auto shampoo",function(bool)
    Setting.auto_shampoo = bool
    if bool then
        auto_shampoo()
    end
end)

auto:Dropdown("Sell mode",{"Max","Timer"},false,function(options)
    Setting.sell_mode = options
end)


auto:Toggle("Auto sell",function(bool)
    Setting.auto_sell = bool
    if bool then
        auto_sell(Setting.sell_mode)
    end
end)

auto:Toggle("Farm pumpkin",function(bool)
    Setting.auto_farm_pumpkin = bool
    if bool then
        farm_pumpkin()
    end
end)

auto:Toggle("Farm boss",function(bool)
    Setting.auto_farm_boss = bool
    if bool then
        farm_boss()
    end
end)

auto:Button("Unlock all island",function()
    unlock_island()
end)

auto:Button("Claim all chest",function()
    claim_all_chest()
end)


function auto_shampoo()
    task.spawn(function()
        while Setting.auto_shampoo do
            if LocalPlayer.Character then
                if not LocalPlayer.Backpack:FindFirstChild("Shampoo") then
                    local tool = LocalPlayer.Character:FindFirstChild("Shampoo")

                    if tool and tool["Remotes"]["Events"]:FindFirstChild("RequestPoints") then
                        tool["Remotes"]["Events"]["RequestPoints"]:FireServer()
                    end
                else
                    local tool = LocalPlayer.Backpack:FindFirstChild("Shampoo")
                    LocalPlayer.Character.Humanoid:EquipTool(tool)
                end
            end
            task.wait(.1)
        end
    end)
end

function unlock_island()
    task.spawn(function()
        if LocalPlayer.Character then
            local hrp = LocalPlayer.Character["HumanoidRootPart"]
            local path = workspace.Map.World1.Islands:GetChildren()
            for i,v in ipairs(path) do
                local part = v:FindFirstChildOfClass("Model") and v["Model"]:FindFirstChild("Toucher")
                if (part) then
                    hrp.CFrame = CFrame.new(part.CFrame.X, part.CFrame.Y + 5, part.CFrame.Z)
                end
                task.wait(.8)
            end
        end
    end)
end

function farm_pumpkin()
    task.spawn(function()
        local path = workspace.Map.World1.Halloween.PumpkinCoins:GetChildren()
        while Setting.auto_farm_pumpkin do
            for i,v in ipairs(path) do
                if not Setting.auto_farm_pumpkin then break; end
                if LocalPlayer.Character and v:FindFirstChild("MoneyHalloween") and v["MoneyHalloween"]:FindFirstChild("Body") then
                    local hrp = LocalPlayer.Character["HumanoidRootPart"]
                    hrp.CFrame = v["MoneyHalloween"]:FindFirstChild("Body").CFrame
                    task.wait(1)
                end
            end
            task.wait(.1)
        end
    end)
end

function farm_boss()
    task.spawn(function()
        while Setting.auto_farm_boss do
            if LocalPlayer.Character then
                local tool = LocalPlayer.Backpack:FindFirstChild("Pow") or LocalPlayer.Character:FindFirstChild("Pow")
                local remote = tool["Remotes"]["Events"]:FindFirstChild("RequestHit")

                if tool and remote then
                    remote:FireServer("Boss:1","Boss")
                end
            end
            task.wait(.1)
        end
    end)
end

function auto_sell(mode)
    task.spawn(function()
        if mode == nil then mode = "max" else mode = tostring(mode):lower() end

        if mode == "max" then
            local sell = workspace.Map.World1.Floor.SellStation.Beacon.Toucher
            local Hair = LocalPlayer.leaderstats:FindFirstChild("Hair")
            local old = Hair.Value
            while Setting.auto_sell do
                if LocalPlayer.Character then
                    local hrp = LocalPlayer.Character["HumanoidRootPart"]
                    if old == Hair.Value then
                        firetouchinterest(hrp, sell, 0)
                        task.wait(.5)
                        firetouchinterest(hrp, sell, 1)
                        old = Hair.Value
                        task.wait(.5)
                    else
                        old = Hair.Value
                        task.wait(.5)
                    end
                end
                task.wait(.1)
            end

        elseif mode == "timer" then
            local sell = workspace.Map.World1.Floor.SellStation.Beacon.Toucher
            while Setting.auto_sell do
                if LocalPlayer.Character then
                    local hrp = LocalPlayer.Character["HumanoidRootPart"]

                    firetouchinterest(hrp, sell, 0)
                    task.wait(.5)
                    firetouchinterest(hrp, sell, 1)
                end
                task.wait(1)
            end
        end
    end)
end

function claim_all_chest()
    task.spawn(function()
        if LocalPlayer.Character then
            local path = workspace.Map.World1.Islands:GetChildren()
            local hrp = LocalPlayer.Character["HumanoidRootPart"]

            for i,v in ipairs(path) do
                for x,y in ipairs(v["Model"]:GetChildren()) do
                    if y:IsA("Model") and y.Name == "Chest" then
                        local part = y["Beacon"]["Toucher"]
                        firetouchinterest(hrp, part, 0)
                        task.wait(1)
                        firetouchinterest(hrp, part, 1)
                    end
                end
            end
        end
    end)
end

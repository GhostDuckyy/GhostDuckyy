if not game:IsLoaded() then game.Loaded:Wait() task.wait(4) end

do
    if game.PlaceId ~= 11746859781 then return end

    local Library = loadstring(game:HttpGet("https://github.com/GhostDuckyy/GhostDuckyy/blob/main/UI/Elerium%20V2.lua?raw=true"))()
    local w = Library:AddWindow("Bubble Gum Simulator / Ghost-Ducky#7698", {main_color = Color3.fromRGB(200, 0, 0), min_size = Vector2.new(400, 380), toggle_key = Enum.KeyCode.RightControl, can_resize = true})

    local tabs = {
        main = w:AddTab("Main")
    }

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local Module = require(game:GetService("ReplicatedStorage"):WaitForChild("Nevermore"):WaitForChild("Library"))

    getgenv().Setting = {
        autoblow = false,autocollect = false
    }

    tabs.main:AddLabel("Automatics")
    tabs.main:AddSwitch("Auto blow bubble gum", function(x)
        Setting.autoblow = x
        if x then AutoBlow() end
    end)

    tabs.main:AddSwitch("Auto collect drops", function(x)
        Setting.autocollect = x
        if x then
            task.spawn(function()
                local Pickups = workspace:WaitForChild("Stuff"):WaitForChild("Pickups")
                if Pickups ~= nil and LocalPlayer.Character then
                    for i,v in next, Pickups:GetDescendants() do
                        if v:IsA("MeshPart") then
                            task.spawn(function()
                                pcall(function()
                                    firetouchinterest(v, LocalPlayer.Character.PrimaryPart, 0)
                                    task.wait(.1)
                                    firetouchinterest(v, LocalPlayer.Character.PrimaryPart, 1)
                                end)
                            end)
                        end
                    end
                end
            end)
        end
    end)

    tabs.main:AddButton("Sell bubble", function()
        local sell_1 = workspace:WaitForChild("MAP"):WaitForChild("Activations"):WaitForChild("Sell 1")
        local old = nil
        if sell_1 ~= nil and LocalPlayer.Character ~= nil then
            old = LocalPlayer.Character.PrimaryPart.CFrame
            LocalPlayer.Character.PrimaryPart.CFrame = sell_1.CFrame
            task.wait(.1)
            if Module.Network and type(Module.Network) == "table" then
                Module.Network.Fire("Sell Bubbles")
            end
            task.wait(.1)
            LocalPlayer.Character.PrimaryPart.CFrame = old
        end
    end)

    tabs.main:AddButton("Claim all chests", function()
        local Activations = workspace:WaitForChild("MAP"):WaitForChild("Activations")
        local Chests = workspace:WaitForChild("MAP"):WaitForChild("Chests")
        if Activations ~= nil and Chests ~= nil and LocalPlayer.Character ~= nil then
            local instance = Activations:GetChildren()
            for i = 1, #instance do
                local v = instance[i]
                if v.Name:find("Chest") and v.Name:sub(1,3):lower() ~= "vip" then
                        if Chests:FindFirstChild(v.Name) then
                        LocalPlayer.Character.PrimaryPart.CFrame = v.CFrame
                        task.wait(.2)
                        if Module.Network and type(Module.Network) == "table" then
                            Module.Network.Fire("Collect Chest", v.Name)
                        end
                        task.wait(.2)
                    end
                end
            end
        end
    end)

    tabs.main:AddButton("Unlock all islands", function()
        local Teleports = workspace:WaitForChild("MAP"):WaitForChild("Teleports")
        if Teleports ~= nil and LocalPlayer.Character ~= nil then
            local instance = Teleports:GetChildren()
            for i = 1, #instance do
                if instance[i]:IsA("Part") and instance[i].Name:lower() ~= "spawn" then
                    LocalPlayer.Character.PrimaryPart.CFrame = instance[i].CFrame * CFrame.new(0, 2, 0)
                    task.wait(.2)
                end
            end
        end
    end)

    tabs.main:AddLabel("Locations")
    local IslandsDrop = tabs.main:AddDropdown("[ Islands List ]", function(x)
        local Islands = workspace:WaitForChild("MAP"):WaitForChild("Teleports")
        if Islands ~= nil and LocalPlayer.Character ~= nil then
            for i,v in next, Islands:GetChildren() do
                if v:IsA("Part") and v.Name == x then
                    LocalPlayer.Character.PrimaryPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                end
            end
        end
    end)

    local EggsDrop = tabs.main:AddDropdown("[ Eggs List ]", function(x)
        local Eggs = workspace:WaitForChild("MAP"):WaitForChild("Eggs")
        if Eggs ~= nil and LocalPlayer.Character ~= nil then
            for i,v in next, Eggs:GetChildren() do
                if v:IsA("Model") and v.PrimaryPart ~= nil then
                    if v.Name == x then
                        LocalPlayer.Character.PrimaryPart.CFrame = v.PrimaryPart.CFrame * CFrame.new(0, 5, 0)
                    end
                end
            end
        end
    end)

    tabs.main:AddLabel("UI made by Singularity#5490")

    function AutoBlow()
        task.spawn(function()
            while task.wait(.1) do
                if not Setting.autoblow then return end
                if Module.Network and type(Module.Network) == "table" then
                    Module.Network.Fire("Blow Bubble")
                end
            end
        end)
    end

    do
        if workspace:WaitForChild("MAP"):WaitForChild("Teleports") ~= nil then
            for i,v in next, workspace:WaitForChild("MAP"):WaitForChild("Teleports"):GetChildren() do
                if v:IsA("Part") then
                    IslandsDrop:Add(v.Name)
                end
            end
        end

        if workspace:WaitForChild("MAP"):WaitForChild("Eggs") ~= nil then
            for i,v in next, workspace:WaitForChild("MAP"):WaitForChild("Eggs"):GetChildren() do
                if v:IsA("Model") and v.PrimaryPart ~= nil then
                    EggsDrop:Add(v.Name)
                end
            end
        end

        if workspace:WaitForChild("Stuff"):WaitForChild("Pickups") ~= nil then
            workspace:WaitForChild("Stuff"):WaitForChild("Pickups").DescendantAdded:Connect(function(v)
                task.wait(.5)
                if (LocalPlayer.Character == nil or Setting.autocollect) then return end
                if v:IsA("MeshPart") then
                    task.spawn(function()
                        pcall(function()
                            firetouchinterest(v, LocalPlayer.Character.PrimaryPart, 0)
                            task.wait(.1)
                            firetouchinterest(v, LocalPlayer.Character.PrimaryPart, 1)
                        end)
                    end)
                end
            end)
        end

        tabs.main:Show()
        Library:FormatWindows()
    end
end

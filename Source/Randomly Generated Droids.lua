--// Env
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

if getgenv().Setting == nil or typeof(getgenv().Setting) ~= "table" then
    getgenv().Setting = {
        GameMode = "Normal", --// Noraml | Casual
        WebhookUrl = "nil", --// Replace your webhook url here
        AutoFarm = true, --// Auto farm toggle
        AutoRestart = true, --// Auto restart when character died
        DebugConsole = false, --// Show a console
    }
end

--// Source
function AutoFarm()
    local function consolePrint(string)
        if not Setting.DebugConsole then return end
        if string == nil then string = "\n" end
        string = tostring(string)
         local Print = rconsoleprint or consoleprint or function(input) warn("Missing 'rconsoleprint' / 'consoleprint' function") end
         Print(string)
     end

    local function CreateConsole()
        if not Setting.DebugConsole then return end
        local LastUpdateDate = "5/12/2022"
        local create = rconsolecreate or consolecreate or false
        if not create then consolePrint("--> Made by Ghost-Ducky#7698 | Last Update: "..LastUpdateDate.." Day/Month/Year \n\n") return else create(); task.wait(.5); consolePrint("--> Made by Ghost-Ducky#7698 | Last Update: 11/27/2022 \n\n"); return end
    end

    local function ClearConsole()
        local clear = rconsoleclear or consoleclear
        local destroy = rconsoleclose or rconsoledestroy or function()
            print("Missing Function")
        end
        if not Setting.DebugConsole then clear(); task.wait(.1); destroy(); return end
        clear()
    end

    local function CollectCircuits()
        local function Collect(child)
            task.wait(1)

            if child:FindFirstChild("Pay") and child.Pay:IsA("IntValue") and Character and Character:FindFirstChild("HumanoidRootPart") then
                firetouchinterest(Character.HumanoidRootPart, child, 0)
                task.wait(.350)
                firetouchinterest(Character.HumanoidRootPart, child, 1)
            end
        end

        task.spawn(function()
            for _,v in ipairs(workspace:GetChildren()) do
                Collect(v)
            end

            workspace.DescendantAdded:Connect(function(child)
                Collect(child)
            end)
        end)
    end

    local function GotoRoom()
        if workspace:WaitForChild("Room", 15) and workspace["Room"]:WaitForChild("Floor", 15) and Character and Character:FindFirstChild("HumanoidRootPart") then

            if workspace["Room"]:FindFirstChild("ShopType") and workspace["Room"]["ShopType"].Value == "Vault" then
                if workspace["Room"]["Items"]:FindFirstChild("Golden Circuit") then
                    local child = workspace["Room"]["Items"]["Golden Circuit"]

                    getgenv().InvisiblePart.CFrame = CFrame.new(child.CFrame.X, child.CFrame.Y + 2, child.CFrame.Z)
                    Character.HumanoidRootPart.CFrame = getgenv().InvisiblePart.CFrame * CFrame.new(0, 1, 0)

                    consolePrint("Debug: Take "..child.Name.." in vault \n")

                    fireclickdetector(child:FindFirstChildOfClass("ClickDetector"))
                    task.wait(.05)
                    fireclickdetector(child:FindFirstChildOfClass("ClickDetector"))
                    task.wait(.350)
                else
                    local function GetRandomTool()
                        if workspace["Room"]["Items"]:FindFirstChildOfClass("Tool") then
                            local path = workspace["Room"]["Items"]:GetChildren()
                            local number = math.random(1, #path)

                            for i,v in ipairs(path) do
                                if i == number and v ~= nil then return v end
                            end
                        end
                    end

                    local child = GetRandomTool()

                    getgenv().InvisiblePart.CFrame = CFrame.new(child.CFrame.X, child.CFrame.Y + 2, child.CFrame.Z)
                    Character.HumanoidRootPart.CFrame = getgenv().InvisiblePart.CFrame * CFrame.new(0, 1, 0)

                    consolePrint("Debug: Take "..child.Name.." in vault \n")

                    fireclickdetector(child:FindFirstChildOfClass("ClickDetector"))
                    task.wait(.05)
                    fireclickdetector(child:FindFirstChildOfClass("ClickDetector"))
                end
                task.wait(.350)
            end

            consolePrint("Debug: Teleport to room \n")
            local Floor = workspace["Room"]:WaitForChild("Floor", 10)
            getgenv().InvisiblePart.CFrame = CFrame.new(Floor.CFrame.X, Floor.CFrame.Y + 30, Floor.CFrame.Z + 30)
            Character.HumanoidRootPart.CFrame = getgenv().InvisiblePart.CFrame * CFrame.new(0, 1, 0)
        end
    end

    local function ActiveButton()
        local function Active(child)
            if child:FindFirstChildOfClass("ClickDetector") and Character and Character:FindFirstChild("HumanoidRootPart") then

                getgenv().InvisiblePart.CFrame = CFrame.new(child.CFrame.X, child.CFrame.Y + 2, child.CFrame.Z)
                Character.HumanoidRootPart.CFrame = getgenv().InvisiblePart.CFrame * CFrame.new(0, 1, 0)

                consolePrint("Debug: Active Button \n")

                fireclickdetector(child:FindFirstChildOfClass("ClickDetector"))

            elseif child:FindFirstChild("Box") then
                for x,y in ipairs(child.Parent:GetChildren()) do
                    if y:FindFirstChild("Base") and y:FindFirstChild("Activator") then
                        consolePrint("Debug: Move box to plate \n")
                        child["Box"].CFrame = CFrame.new(y["Activator"].CFrame.X, y["Activator"].CFrame.Y + 2, y["Activator"].CFrame.Z)
                    end
                end
            end
        end

        if workspace:FindFirstChild("Room") and workspace["Room"]:FindFirstChild("Enemies") then
            for i,v in ipairs(workspace["Room"]["Enemies"]:GetChildren()) do
                Active(v)
            end
        end
    end

    local function WebHook(t, url)
        if t == nil or typeof(t) ~= "table" then return end
        if url == nil or url == "nil" or typeof(url) ~= "string" then return end

        local function check_url(str)
            if str == nil then return end
            if typeof(str) ~= "string" then str = tostring(str) end

            if string.match(str:lower(), "https://discord.com/api/webhooks/") then
                return true
            end

            return false
        end

        local HttpService = game:GetService("HttpService")

        local Request = (syn and syn.request) or request or (http and http.request) or http_request or false
        local json = HttpService:JSONEncode(t)
        local headers = {["Content-type"] = "application/json"}

        if check_url(url) and request ~= false then
            Request({Url = url, Body = json, Method = "POST", Headers = headers})
        end
    end

    local function Restart()
        local GuiEvent = game:GetService("ReplicatedStorage").GuiEvent

        LocalPlayer.Character.Humanoid.Died:Connect(function()
            local PointsTally = game:GetService("Workspace").GenValues.PointsTally
            local RoomNumber = game:GetService("Workspace").GenValues.RoomNumber

            consolePrint("\n --> Gained "..tostring(PointsTally.Value).." Points, Reached "..tostring(RoomNumber.Value).." Room \n")

            Setting.AutoFarm = false
            if not Setting.AutoRestart then return end

            local data = {
                ["content"] = nil,
                ["embeds"] = {
                    ["description"] = "Autofarm Status",
                    ["color"] = 57599,
                    ["fields"] = {
                        {["name"] = "Room", ["value"] = tostring(RoomNumber.Value)},
                        {["name"] = "Points", ["value"] = tostring(PointsTally.Value)},
                    },
                    ["author"] = {["name"] = "Randomly Generated Droids",["url"] = "https://www.roblox.com/games/5561268850/"},
                    ["footer"] = {"Made by Ghost-Ducky#7698"},
                }
            }
            WebHook(data, Setting.WebhookUrl)

            consolePrint("--> Detected died, Restart in 0.5 second \n\n")
            task.wait(.5)
            GuiEvent:FireServer("Restart")
        end)

        local source = [=[
            getgenv().InvisiblePart = nil
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Source/Randomly%20Generated%20Droids.lua"))()
        ]=]

        if Setting.AutoRestart then
            if syn then
                syn.queue_on_teleport(source)
            else
                local unc = queue_on_teleport or queueonteleport
                unc(source)
            end
        end
    end

    local function TimeOut()
        task.spawn(function()
            local RoomValue = game:GetService("Workspace").GenValues.RoomNumber.Value
            local oldRoomValue = 0
            while true do
                if Character then
                    if oldRoomValue == RoomValue and RoomValue > 0 then
                        local Humanoid = Character:FindFirstChild("Humanoid")
                        if Humanoid then
                            consolePrint("Detect Error!")
                            Humanoid.Health = 0
                            if not Setting.AutoRestart then
                                local PointsTally = game:GetService("Workspace").GenValues.PointsTally
                                local RoomNumber = game:GetService("Workspace").GenValues.RoomNumber

                                consolePrint("\n --> Gained "..tostring(PointsTally.Value).." Points, Reached "..tostring(RoomNumber.Value).." Room \n")

                                local data = {
                                    ["content"] = nil,
                                    ["embeds"] = {
                                        ["description"] = "Autofarm Status",
                                        ["color"] = 57599,
                                        ["fields"] = {
                                            {["name"] = "Room", ["value"] = tostring(RoomNumber.Value)},
                                            {["name"] = "Points", ["value"] = tostring(PointsTally.Value)},
                                        },
                                        ["author"] = {["name"] = "Randomly Generated Droids",["url"] = "https://www.roblox.com/games/5561268850/"},
                                        ["footer"] = {"Made by Ghost-Ducky#7698"},
                                    }
                                }
                                WebHook(data, Setting.WebhookUrl)

                                consolePrint("--> Detect a bug/stuck, Restart in 0.5 second \n\n")
                                task.wait(.5)
                                local GuiEvent = game:GetService("ReplicatedStorage").GuiEvent
                                GuiEvent:FireServer("Restart")

                                local source = [=[
                                    getgenv().InvisiblePart = nil
                                    task.wait(1)
                                    loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Source/Randomly%20Generated%20Droids.lua"))()
                                ]=]

                                if syn then
                                    syn.queue_on_teleport(source)
                                else
                                    local unc = queue_on_teleport or queueonteleport
                                    unc(source)
                                end

                            end
                            break;
                        end
                    else
                        oldRoomValue = RoomValue
                        task.wait(12)
                    end
                end
                task.wait(.1)
            end
        end)
    end

    local function Killaura()
        local function KillEnemy(mob)
            task.wait(.2)

            if mob:FindFirstChildOfClass("Humanoid") and Players:GetPlayerFromCharacter(mob) == nil and Character and Character:FindFirstChild("HumanoidRootPart") then
                local Timeout = true

                if mob:FindFirstChild("HumanoidRootPart") then
                    mob:FindFirstChild("HumanoidRootPart").Destroying:Connect(function()
                        Timeout = false
                    end)
                end

                task.wait(.1)

                consolePrint("Debug: Target = ".. tostring(mob.Name) .."\n")
                if mob:FindFirstChildOfClass("Humanoid") then consolePrint("Debug: Set Target WalkSpeed = 0 \n"); mob:FindFirstChildOfClass("Humanoid").WalkSpeed = 0; consolePrint("Debug: Set Target Health = 0 \n"); mob:FindFirstChildOfClass("Humanoid").Health = 0; end

                task.spawn(function()
                    task.wait(8)
                    if not Timeout then return end

                    consolePrint("Detect a timeout \n")

                    local PANIC = game:GetService("ReplicatedStorage").PANIC
                    PANIC:FireServer()

                    task.wait(.1450)

                    GotoRoom()
                end)
            end
        end

        if workspace:FindFirstChild("Room") and workspace["Room"]:FindFirstChild("Enemies") then
            for i,v in ipairs(workspace["Room"]["Enemies"]:GetChildren()) do
                KillEnemy(v)
            end
        end
    end

    local function CreateMatch(mode)
        if mode == nil then return end
        if typeof(mode) ~= "string" then mode = tostring(mode) end
        mode = mode:lower()

        local AscensionNum = 0

        if mode == "normal" then
            
        elseif mode == "casual" then
        end
    end

    task.spawn(function()
        ClearConsole()
        if not Setting.AutoFarm or game.PlaceId ~= 6312903733 then return end
        -- if game.PlaceId == 5561268850 then CreateMatch(Setting.GameMode) return elseif game.PlaceId ~= 6312903733 then return end

        if Setting.DebugConsole then CreateConsole() end
        if not game:IsLoaded() then consolePrint("Debug: Waiting game loaded \n") end

        while true do if game:IsLoaded() then break; end task.wait(.1) end

        if Character == nil then consolePrint("Debug: Wait CharacterAdded \n"); LocalPlayer.CharacterAdded:Wait(); task.wait(.5) end

        if getgenv().InvisiblePart == nil or typeof(getgenv().InvisiblePart) ~= "Instance" then local Part = Instance.new("Part", workspace); getgenv().InvisiblePart = Part; Part.Name = math.random(123456, 999999); Part.Anchored = true; Part.Size = Vector3.new(10, 1, 10); Part.CFrame = CFrame.new(0, -100, 0); Part.Transparency = 0.5; Part.Color = Color3.new(1, 0, 0); consolePrint("Debug: Created 'Part' \n"); end

        consolePrint("--> AutoFarm will start in 0.5 second \n")
        task.wait(.5)

        task.spawn(function()
            if setsimulationradius then setsimulationradius(math.huge, math.huge) end
        end)

        TimeOut()
        Restart()
        CollectCircuits()

        while Setting.AutoFarm do

            Killaura()

            task.wait(.5)

            ActiveButton()

            task.wait(.5)

            GotoRoom()

            task.wait(.1)
        end
    end)
end

AutoFarm()

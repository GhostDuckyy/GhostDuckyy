--// Made by Ghost-Ducky#7698
while true do if game:IsLoaded() and game.PlaceId == 10875701453 then break; end task.wait(.1); end
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Valiant/source.lua"))()
local Window = Library:CreateWindow("GUI", "Ghost-Ducky#7698", 10044538000)

local section = Window:CreateTab("Section")

--// Env
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait()
local Camera = workspace.CurrentCamera

local RunService = game:GetService("RunService")

getgenv().Setting = {
    AutoFarm = false,
    esp = {
        PlayersCharm = false,
        PlayersNameTag = false,
        EntityCharm = false,
    },
}

--// Source
local main = section:CreateFrame("Main")
main:CreateLabel("Main")
main:CreateToggle("Auto survival", "Farm ticket", function(x)
    Setting.AutoFarm = x
    if x then
        Farm()
    end
end)

main:CreateLabel("Modify")
main:CreateButton("Fast Recovry Stamina", "Modify self stamina", function()
    local function modify()
        Character.Humanoid:UnequipTools()
        for i,v in ipairs(getgc(true)) do
            task.spawn(function()
                if (type(v) == "table" and rawget(v, "STAMINA_EXHAUSTION_TIME") and rawget(v, "STAMINA_RECOVERY_TIME")) then
                    rawset(v, "STAMINA_EXHAUSTION_TIME", 0)
                    rawset(v, "STAMINA_RECOVERY_TIME", .001)
                end
            end)
        end
        Character.Humanoid:UnequipTools()
    end

    LocalPlayer.CharacterAppearanceLoaded:Connect(function()
        task.wait(.2)
        modify()
    end)

    modify()
end)

main:CreateButton("Infinity Ammo", "Modify weapon ammo", function()
    local function modify()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Note",
            Text = "Re-equip weapon when can't shoot",
            Duration = 3
        })

        for i,v in ipairs(getgc(true)) do
            task.spawn(function()
                if (type(v) == "table" and rawget(v, "IntValue_MaxMagazine")) then
                    rawset(v, "IntValue_MaxMagazine", 999999)
                end
                if Character then Character.Humanoid:UnequipTools() end
            end)
        end
    end

    LocalPlayer.CharacterAppearanceLoaded:Connect(function()
        task.wait(.2)
        modify()
    end)

    modify()
end)
main:CreateButton("Fast Interact", "Prompt interact faster", function()
    local function Fast(instance)
        if instance:IsA("ProximityPrompt") then
            instance.HoldDuration = .25
        end
    end
    for i,v in ipairs(workspace:GetDescendants()) do
        Fast(v)
    end

    workspace.DescendantAdded:Connect(function(v)
        Fast(v)
    end)
end)

main:CreateLabel("Other")
main:CreateButton("Remove Nametag", "Remove self nametag", function()
    RemoveNametag()
end)

local visual = section:CreateFrame("Visual")
visual:CreateLabel("Players")
visual:CreateToggle("Charm", "Add highlight to other players", function(x)
    Setting.esp.PlayersCharm = x
end)

visual:CreateToggle("Name", "Add nametag to other players", function(x)
    Setting.esp.PlayersNameTag = x
end)

visual:CreateLabel("Entity")
visual:CreateToggle("Charm", "Add highlight to entity", function(x)
    Setting.esp.EntityCharm = x
end)

--// Function
function Farm()
    task.spawn(function()
        while Setting.AutoFarm do
            if Character == nil then LocalPlayer.CharacterAppearanceLoaded:Wait() end
            if not workspace:FindFirstChild("PlatForm") then local plat = Instance.new("Part", workspace); plat.Name = "PlatForm"; plat.Anchored = true; plat.CFrame = CFrame.new(math.random(1000,5000),math.random(1000,2500),math.random(1000,5000)); plat.Size = Vector3.new(100, 1, 100); task.wait(.5) end
            if LocalPlayer.Team == game:GetService("Teams").Train then
                Character.HumanoidRootPart.Anchored = false
                task.wait(.2)
                Character.HumanoidRootPart.CFrame = workspace.PlatForm.CFrame * CFrame.new(0,4,0)
                task.wait(.2)
                Character.HumanoidRootPart.Anchored = true
                repeat task.wait(.05) until LocalPlayer.Team ~= game:GetService("Teams").Train
            end
            if LocalPlayer.Team == game:GetService("Teams").Station then Character.HumanoidRootPart.Anchored = false end
            task.wait(.1)
        end
    end)
end

function RemoveNametag()
    local function remove(v)
        if v:FindFirstChildOfClass("BillboardGui") then
            v:FindFirstChildOfClass("BillboardGui"):Destroy()
        end
    end

    remove(Character.Head)
    LocalPlayer.CharacterAppearanceLoaded:Connect(function(chr)
        task.wait(.2)
        remove(chr.Head)
    end)
end
--// ESP
function Add_NameTag(players, name)
    if not Drawing then warn("Required 'Drawing' Library") return end
    local character = players.Character
    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline = true

    text.Text = tostring(name)
    text.Transparency = .7
    text.Color = Color3.new(1,1,1)
    text.OutlineColor = Color3.new(0,0,0)
    text.Font = 1

    local RenderStepped = RunService.RenderStepped:Connect(function()
        if character ~= nil and character:FindFirstChild("Head") then
            local HeadVector3,onScreen = Camera:WorldToViewportPoint(character.Head.Position)
            if onScreen then
                text.Position = Vector2.new(HeadVector3.X, HeadVector3.Y - 45)
                text.Size = 17
                text.Visible = Setting.esp.PlayersNameTag
            else
                text.Visible = false
            end
        end
    end)

    players.CharacterRemoving:Connect(function()
        RenderStepped:Disconnect()
        task.wait(.1)
        text.Visible = false
    end)
end

do
    for i,v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            v.CharacterAdded:Connect(function(character)
                task.wait(.2)
                Add_NameTag(v, v.DisplayName)
                if character:FindFirstChildOfClass("Highlight") then character:FindFirstChildOfClass("Highlight"):Destroy(); task.wait(.3) end
                local Highlight = Instance.new("Highlight", character)
                Highlight.Adornee = character
                Highlight.Name = game:GetService("HttpService"):GenerateGUID(false)

                Highlight.FillColor = Color3.new(1,1,1)
                Highlight.OutlineColor = Color3.new(0,1,0)

                Highlight.FillTransparency = .6
                Highlight.OutlineTransparency = 0

                Highlight.Enabled = false
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                local RenderStepped = RunService.RenderStepped:Connect(function()
                    if Highlight ~= nil then Highlight.Enabled = Setting.esp.PlayersCharm end
                end)

                Highlight.Destroying:Connect(function()
                    RenderStepped:Disconnect()
                end)
            end)

            task.spawn(function()
                Add_NameTag(v, v.DisplayName)
                repeat task.wait(.1) until v.Character ~= nil
                if v.Character:FindFirstChildOfClass("Highlight") then v.Character:FindFirstChildOfClass("Highlight"):Destroy(); task.wait(.3) end
                local Highlight = Instance.new("Highlight", v.Character)
                Highlight.Adornee = v.Character
                Highlight.Name = game:GetService("HttpService"):GenerateGUID(false)

                Highlight.FillColor = Color3.new(1,1,1)
                Highlight.OutlineColor = Color3.new(0,1,0)

                Highlight.FillTransparency = .6
                Highlight.OutlineTransparency = 0

                Highlight.Enabled = false
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                local RenderStepped = RunService.RenderStepped:Connect(function()
                    if Highlight ~= nil then Highlight.Enabled = Setting.esp.PlayersCharm end
                end)

                Highlight.Destroying:Connect(function()
                    RenderStepped:Disconnect()
                end)
            end)
        end
    end

    Players.PlayerAdded:Connect(function(v)
        if v ~= LocalPlayer then
            v.CharacterAdded:Connect(function(character)
                task.wait(.2)
                Add_NameTag(v, v.DisplayName)
                if character:FindFirstChildOfClass("Highlight") then character:FindFirstChildOfClass("Highlight"):Destroy(); task.wait(.3) end
                local Highlight = Instance.new("Highlight", character)
                Highlight.Adornee = character
                Highlight.Name = game:GetService("HttpService"):GenerateGUID(false)

                Highlight.FillColor = Color3.new(1,1,1)
                Highlight.OutlineColor = Color3.new(0,1,0)

                Highlight.FillTransparency = .6
                Highlight.OutlineTransparency = 0

                Highlight.Enabled = false
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                local RenderStepped = RunService.RenderStepped:Connect(function()
                    if Highlight ~= nil then Highlight.Enabled = Setting.esp.PlayersCharm end
                end)

                Highlight.Destroying:Connect(function()
                    RenderStepped:Disconnect()
                end)
            end)

            task.spawn(function()
                Add_NameTag(v, v.DisplayName)
                repeat task.wait(.1)until v.Character ~= nil
                if v.Character:FindFirstChildOfClass("Highlight") then v.Character:FindFirstChildOfClass("Highlight"):Destroy(); task.wait(.3) end
                local Highlight = Instance.new("Highlight", v.Character)
                Highlight.Adornee = v.Character
                Highlight.Name = game:GetService("HttpService"):GenerateGUID(false)

                Highlight.FillColor = Color3.new(1,1,1)
                Highlight.OutlineColor = Color3.new(0,1,0)

                Highlight.FillTransparency = .6
                Highlight.OutlineTransparency = 0

                Highlight.Enabled = false
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                local RenderStepped = RunService.RenderStepped:Connect(function()
                    if Highlight ~= nil then Highlight.Enabled = Setting.esp.PlayersCharm end
                end)

                Highlight.Destroying:Connect(function()
                    RenderStepped:Disconnect()
                end)
            end)
        end
    end)

    local Multipods = game:GetService("Workspace").Multipods

    if Multipods:FindFirstChildOfClass("Model") then
        local Entity = Multipods:FindFirstChildOfClass("Model")

        if Entity:FindFirstChildOfClass("Highlight") then Entity:FindFirstChildOfClass("Highlight"):Destroy(); task.wait(.3) end
        local Highlight = Instance.new("Highlight", Entity)
        Highlight.Adornee = Entity
        Highlight.Name = game:GetService("HttpService"):GenerateGUID(false)

        Highlight.FillColor = Color3.new(1,1,1)
        Highlight.OutlineColor = Color3.new(1,0,0)

        Highlight.FillTransparency = .6
        Highlight.OutlineTransparency = 0

        Highlight.Enabled = false
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

        local RenderStepped = RunService.RenderStepped:Connect(function()
            if Highlight ~= nil then Highlight.Enabled = Setting.esp.EntityCharm end
        end)

        Highlight.Destroying:Connect(function()
            RenderStepped:Disconnect()
        end)
    end

    Multipods.ChildAdded:Connect(function(child)
        task.wait(.2)
        if child:IsA("Model") then
            if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy(); task.wait(.3) end
            local Highlight = Instance.new("Highlight", child)
            Highlight.Adornee = child
            Highlight.Name = game:GetService("HttpService"):GenerateGUID(false)

            Highlight.FillColor = Color3.new(1,1,1)
            Highlight.OutlineColor = Color3.new(1,0,0)

            Highlight.FillTransparency = .6
            Highlight.OutlineTransparency = 0

            Highlight.Enabled = false
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

            local RenderStepped = RunService.RenderStepped:Connect(function()
                if Highlight ~= nil then Highlight.Enabled = Setting.esp.EntityCharm end
            end)

            Highlight.Destroying:Connect(function()
                RenderStepped:Disconnect()
            end)
        end
    end)
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if workspace:FindFirstChild("CharmsFolder") then
    workspace:FindFirstChild("CharmsFolder"):Destroy()
end

local Folder = Instance.new("Folder", workspace)
Folder.Name = "CharmsFolder"

function Charms(v)
    if Folder == nil then return end
    if typeof(v) ~= "Instance" then return end
    local HighLight = Instance.new("Highlight")
    HighLight.Parent = workspace:WaitForChild("CharmsFolder")
    HighLight.Name = game:GetService("HttpService"):GenerateGUID(true)
    HighLight.Adornee = v

    HighLight.Enabled = true
    HighLight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    HighLight.FillColor = Color3.new(1, 1, 1)
    HighLight.OutlineColor = Color3.new(1, 0, 0)

    HighLight.FillTransparency = .3
    HighLight.OutlineTransparency = .1
end

for i,v in ipairs(workspace:GetDescendants()) do
    if v:FindFirstChildOfClass("ClickDetector") then
        Charms(v)
    end
end

workspace.DescendantAdded:Connect(function(v)
    task.wait(.1)
    if v:FindFirstChildOfClass("ClickDetector") then
        Charms(v)
    end
end)

workspace.DescendantRemoving:Connect(function(v)
    if Folder == nil then return end
    for i,charm in ipairs(Folder:GetChildren()) do
        if charm.Adornee == v then
            charm:Destroy()
        end
    end
end)

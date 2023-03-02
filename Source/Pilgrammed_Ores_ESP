--// This method is detectable if dev add check on workspace!!!
if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game:GetService("CoreGui"):FindFirstChild("CharmsFolder") ~= nil then
    game:GetService("CoreGui"):FindFirstChild("CharmsFolder"):Destroy()
end

if workspace:FindFirstChild("OresCharm") ~= nil then
    workspace:FindFirstChild("OresCharm"):Destroy()
end

local Ores = workspace:WaitForChild("Ores")
local Folder = Instance.new("Folder", game:GetService("CoreGui"))
local Model = Instance.new("Model", workspace)
local Highlight = Instance.new("Highlight", Folder) do
    Highlight.Adornee = Model

    Highlight.FillColor = Color3.new(1,1,1)
    Highlight.OutlineColor = Color3.new(0,0,.7)

    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = .2

    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

Folder.Name = "CharmsFolder"
Model.Name = "OresCharm"

function Add(v)
    if (Folder == nil or Model == nil) then return end
    if typeof(v) ~= "Instance" then return end

    local Part = Instance.new("Part") do
        Part.Parent = Model
        Part.Anchored = true
        Part.Transparency = 0
        Part.Material = v.Material

        Part.Size = v.Size
        Part.Shape = v.Shape

        Part.CFrame = v.CFrame
        Part.Color = v.Color
        Part.CanCollide = false
        Part.CanTouch = false
        Part.CastShadow = false
    end
    local Destroying

    Destroying = v.Destroying:Connect(function()
        pcall(function()
            Part:Destroy()
            Destroying:Disconnect()
        end)
    end)
end

for i,v in ipairs(Ores:GetDescendants()) do
   task.spawn(function()
        if v.Parent ~= nil and v.Parent:IsA("Model") and v:IsA("Part") then
            Add(v)
        end
   end)
end

Ores.DescendantAdded:Connect(function(v)
    task.spawn(function()
        task.wait(.2)
        if v.Parent ~= nil and v.Parent:IsA("Model") and v:IsA("Part") then
            Add(v)
        end
   end)
end)

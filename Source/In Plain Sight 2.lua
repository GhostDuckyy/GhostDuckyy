--// Checks \\--
if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId ~= 2901172949 then return end
if (getgenv().Connections and type(Connections) == "table") then
   for i,v in pairs(Connections) do
      pcall(task.spawn(function()
         v:Disconnect()
      end))
   end
end

--// Services \\--
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local HighlightFolder = (game:GetService("CoreGui"):FindFirstChild("HighlightFolder")) or Instance.new("Folder", game:GetService("CoreGui")) do
   HighlightFolder.Name = "HighlightFolder"

   for i,v in pairs(HighlightFolder:GetChildren()) do
      if v:IsA("Highlight") then
         v:Destroy()
      end
   end
end

--// Functions \\--
local function AddHighlight(Model: Model, IsEnemy: boolean)
      local UserId: number = (Players:GetPlayerFromCharacter(Model) ~= nil and Players:GetPlayerFromCharacter(Model).UserId) or Model:GetAttribute("UserId")

      if UserId == nil then return end
      if UserId == LocalPlayer.UserId then return end
      if HighlightFolder:FindFirstChild(tostring(UserId)) then
         HighlightFolder:FindFirstChild(tostring(UserId)):Destroy()
      end

      local Highlight = Instance.new("Highlight", HighlightFolder)
      Highlight.Adornee = Model
      Highlight.Name = tostring(UserId)
      Highlight.FillTransparency = .6
      Highlight.OutlineTransparency = .2
      Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

      if (IsEnemy) then
         Highlight.FillColor = Color3.fromHex("#FF0000")
         Highlight.OutlineColor = Color3.fromHex("#960000")
      else
         Highlight.FillColor = Color3.fromHex("#7CFC00")
         Highlight.OutlineColor = Color3.fromHex("#32CD32")
      end
end

--// Source \\--
getgenv().Connections = {}
local Thieves: Team = Teams:WaitForChild("Thieves")
local RoundDebris: Folder = workspace:WaitForChild("RoundDebris")

local PlayerAdded = Thieves.PlayerAdded:Connect(function(player)
   task.wait(.3)
   if player == LocalPlayer then return end
   if (player.Character) then
      player.Character:WaitForChild("HumanoidRootPart")
      AddHighlight(player.Character, LocalPlayer.Team ~= Thieves)
   end
end)
table.insert(getgenv().Connections, PlayerAdded)


local ChildAdded = RoundDebris.ChildAdded:Connect(function(camera)
   task.wait(.3)
   if (camera:IsA("Model") and camera.Name == "ActiveCameraModel") then
      AddHighlight(camera, LocalPlayer ~= Thieves)
   end
end)
table.insert(getgenv().Connections, ChildAdded)

for _, player in pairs(Thieves:GetPlayers()) do
   if player == LocalPlayer then return end
   if (player.Character) then
      player.Character:WaitForChild("HumanoidRootPart")
      AddHighlight(player.Character, LocalPlayer.Team ~= Thieves)
   end
end

for _, camera in pairs(RoundDebris:GetChildren()) do
   if (camera:IsA("Model") and camera.Name == "ActiveCameraModel") then
      AddHighlight(camera, LocalPlayer ~= Thieves)
   end
end

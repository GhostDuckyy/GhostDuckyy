if (getgenv().disconnect and typeof(getgenv().disconnect) == "function") then
   disconnect()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ESP_Holder = ((game:GetService("CoreGui"):FindFirstChild("ESP_Holder") ~= nil and game:GetService("CoreGui")["ESP_Holder"]) or Instance.new("Folder", game:GetService("CoreGui"))) do
   ESP_Holder.Name = "ESP_Holder"
end

for i,v in pairs(ESP_Holder:GetChildren()) do
   if v:IsA("Highlight") then
      v:Destroy()
   end
end

local getClosestPlayerFromMouse = function()
   local Closest = nil
   local Last_distance = math.huge

   for i,v in pairs(Players:GetPlayers()) do
      if v == LocalPlayer then continue end
      if v.Character == nil then continue end

      local Character = v.Character

      if not Character:FindFirstChildOfClass("Humanoid") then continue end
      if not Character:FindFirstChild("HumanoidRootPart") then continue end
      if Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end

      local Position, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Character.HumanoidRootPart.Position)

      if onScreen then
         local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude

         if distance < Last_distance then
            Closest = v.Character
            Last_distance = distance
         end
      end
   end

   return Closest
end

local NewHighLight = function(character)
   if not ESP_Holder:FindFirstChild(character.Name) then
      local Highlight = Instance.new("Highlight", ESP_Holder)
      Highlight.Name = character.Name
   end

   local Highlight = ESP_Holder:FindFirstChild(character.Name)
   Highlight.Adornee = character
   Highlight.FillTransparency = 0.7
   Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

for i,v in pairs(Players:GetPlayers()) do
   if v == LocalPlayer then continue end
   if v.Character ~= nil then
      NewHighLight(v.Character)
   end

   v.CharacterAdded:Connect(function(character)
      task.wait(.5)
      NewHighLight(character)
   end)
end

Players.PlayerAdded:Connect(function(v)
   if v == LocalPlayer then return end
   if v.Character ~= nil then
      NewHighLight(v.Character)
   end

   v.CharacterAdded:Connect(function(character)
      task.wait(.5)
      NewHighLight(character)
   end)
end)

Players.PlayerRemoving:Connect(function(v)
   if ESP_Holder:FindFirstChild(v.Name) then
      ESP_Holder:FindFirstChild(v.Name):Destroy()
   end
end)

local TargetCharacter = getClosestPlayerFromMouse()

game:GetService("RunService").Stepped:Connect(function()
   TargetCharacter = getClosestPlayerFromMouse()
   if TargetCharacter ~= nil then
      pcall(task.spawn(function()
         for i,v in pairs(ESP_Holder:GetChildren()) do
            if v:IsA("Highlight") and v.Name ~= TargetCharacter.Name then
               v.OutlineColor = Color3.new(1,1,1)
            end
         end
      end))

      local Highlight = ESP_Holder:FindFirstChild(TargetCharacter.Name)
      if Highlight then
         Highlight.OutlineColor = Color3.new(1,0,0)
      end
   end
end)

local old; old = hookmetamethod(game, "__namecall", function(Self, ...)
   local Method = getnamecallmethod()

   if not checkcaller() and Method == "FireServer" and Self.Name == "RemoteBridge" then
      if TargetCharacter ~= nil and LocalPlayer.Character ~= nil then
         local Args = {...}
         local HumanoidRootPart = {[1] = LocalPlayer.Character.HumanoidRootPart, Target = TargetCharacter.HumanoidRootPart}
         Args[1] = Ray.new(HumanoidRootPart[1].Position, (HumanoidRootPart.Target.Position - HumanoidRootPart[1].Position))

         return old(Self, unpack(Args))
      end
   end
   return old(Self, ...)
end)

getgenv().disconnect = function()
   hookfunction(game, "__namecall", old)
   getgenv().disconnect = nil
end

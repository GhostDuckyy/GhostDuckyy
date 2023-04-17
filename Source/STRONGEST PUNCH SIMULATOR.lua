local LocalPlayer = game:GetService("Players").LocalPlayer
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")

function GetRoot()
   if (LocalPlayer.Character) then
      return LocalPlayer.Character:WaitForChild("HumanoidRootPart")
   else
      LocalPlayer.CharacterAdded:Wait()
      task.wait(.5)
      return LocalPlayer.Character:WaitForChild("HumanoidRootPart")
   end
end

function GetOrb()
   local OrbsFolder = workspace:WaitForChild("Map"):WaitForChild("Stages"):WaitForChild("Boosts")
   local World = LocalPlayer:WaitForChild("leaderstats"):WaitForChild("WORLD")

   local Root = GetRoot()
   local Closest = nil
   local Last_distance = math.huge

   if (Root and World and OrbsFolder) then
      World = tostring(World.Value)
      local Childrens = OrbsFolder[World]:GetChildren()

      if #Childrens >= 1 then
         for i = 1, #Childrens do
            local Child = Childrens[i]

            if (not Child.PrimaryPart) then continue end

            local distance = (Root.CFrame.Position - Child.PrimaryPart.CFrame.Position).Magnitude

            if (distance < Last_distance) then
               Closest = Child
               Last_distance = distance
            end
         end
      end
   end

   return Closest
end

function GetSafeZone()
   local SafeZones = workspace:WaitForChild("Map"):WaitForChild("Stages"):WaitForChild("SafeZones")
   local World = LocalPlayer:WaitForChild("leaderstats"):WaitForChild("WORLD")

   if (World and SafeZones) then
      World = tostring(World.Value)

      if SafeZones:FindFirstChild(World) then
         local Part = SafeZones[World]:FindFirstChildOfClass("Part")

         if Part then
            return Part
         end
      end
   end

   return nil
end

getgenv().CollectOrb = not getgenv().CollectOrb
while task.wait(.3) do
   if not getgenv().CollectOrb then break end

   local Root = GetRoot()
   local Orb = GetOrb()
   local SafeZone = GetSafeZone()

   if (Root and Orb and SafeZone) then
      if Remote then
         Remote:FireServer({"Activate_Punch"})
      end

      local ToCFrame = SafeZone.CFrame * CFrame.new(0, -4, 0)
      Root:PivotTo(ToCFrame)
      Orb:PivotTo(Root.CFrame)
   end
end

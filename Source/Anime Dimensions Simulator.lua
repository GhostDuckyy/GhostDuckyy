--// Checks \\--
local BlackList_IDs = {6938803436, 7338881230, 6990131029, 6990133340} -- Lobby, Raid Lobby, AFK Lobby, Character Testing
if table.find(BlackList_IDs, game.PlaceId) then return end
if not game:IsLoaded() then game.Loaded:Wait() end

--// Services \\--
local TweenService            =  game:GetService("TweenService")
local ReplicatedStorage       =  game:GetService("ReplicatedStorage")
local Players                 =  game:GetService("Players")
local LocalPlayer             =  Players.LocalPlayer

--// Folders \\--
local Monsters                =  workspace:WaitForChild("Folders"):WaitForChild("Monsters")

--// Remotes \\--
local MainRemoteEvent         =  ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("MainRemoteEvent")
local MainRemoteFunction      =  ReplicatedStorage:WaitForChild("RemoteFunctions"):WaitForChild("MainRemoteFunction")

--// Settings \\--
getgenv().Settings = (type(getgenv().Settings) == "table" and getgenv().Settings) or {
   AutoFarm = true,
   AutoRetry = true,
   DebugMode = false,
}

if not Settings.AutoFarm then
   Settings.AutoFarm = true
end

getgenv().CurrentTween = nil

--// Tween \\--
local function CancelTween()
   if CurrentTween ~= nil then
      CurrentTween:Pause()
      CurrentTween:Cancel()
      CurrentTween = nil
   end
end

local function Tween(Time: number, prop: table)
   if type(Time) ~= "number" then Time = 2 end
   if type(prop) ~= "table" then return end

   if (CurrentTween) then
      CancelTween()
   end

   local Root = GetRoot()
   if (Root == nil) then
      while task.wait(.1) do
         Root = GetRoot()
         if (Root) then break end
      end
   end
   Root.Anchored = false

   local distance = (Root.CFrame.Position - prop.CFrame.Position).Magnitude

   if distance <= 15 then
      Root.CFrame = prop.CFrame
      Root.Anchored = true
      task.wait(.2)
   else
      CurrentTween = TweenService:Create(Root, TweenInfo.new(Time, Enum.EasingStyle.Linear), prop)
      CurrentTween.Completed:Connect(function()
         CurrentTween = nil
         if (Root) then
            Root.Anchored = true
         end
      end)

      CurrentTween:Play()
      CurrentTween.Completed:Wait()
   end
end

--// Functions \\--
function GetCharacter()
   local RespawnTimerFrame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UniversalGui"):WaitForChild("UniversalCenterUIFrame"):WaitForChild("RespawnTimerFrame")
   if (RespawnTimerFrame and RespawnTimerFrame.Visible) then
      return nil
   end
   return (LocalPlayer.Character ~= nil and LocalPlayer.Character) or LocalPlayer.CharacterAdded:Wait()
end

function GetRoot()
   local Character = GetCharacter()
   if Character ~= nil then
      task.wait(.1)
      Character:WaitForChild("HumanoidRootPart")
      local Root = Character:FindFirstChild("HumanoidRootPart")
      return Root
   end
end

function GetClosestEnemy()
   local Enemy = nil
   local Last_distance = math.huge
   local Root = GetRoot()
   local Childrens = Monsters:GetChildren()

   if Root == nil then return nil end
   if #Childrens <= 0 then return nil end

   for i = 1, #Childrens do
      local Child = Childrens[i]

      if Child ~= nil then
         if not Child:FindFirstChildOfClass("Humanoid") then continue end
         if not Child:FindFirstChild("HumanoidRootPart") then continue end
         if Child:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end

         if Child:FindFirstChildOfClass("Highlight") then
            Enemy = Child
            return Enemy
         end

         local distance = (Root.Position - Child:WaitForChild("HumanoidRootPart").Position).Magnitude

         if distance < Last_distance then
            Enemy = Child
            Last_distance = distance
         end
      end
   end

   return Enemy
end

function useAssist(number: number)
   if type(number) ~= "number" then return end
   if number >= 3 then return end

   local Root = GetRoot()
   if Root == nil then return end

   task.spawn(function()
      MainRemoteEvent:FireServer("UseAssistSkill", {["hrpCFrame"] = Root.CFrame}, number)
   end)
end

function checkCD(number: number, assist: boolean)
   if type(number) ~= "number" then return end
   if type(assist) ~= "boolean" then assist = false end

   local SlotsHolder = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UniversalGui"):WaitForChild("UniversalCenterUIFrame"):WaitForChild("SlotsHolder")

   if assist then
      if number >= 3 then return end
      local Slot = SlotsHolder:WaitForChild("SkillAssist"..tostring(number))
      if Slot and Slot.Visible then
         local SkillName = Slot:WaitForChild("SkillName").Text

         if not SkillName.Visible then
            return true
         end
      end
   else
      if number == 5 then
         local Slot = SlotsHolder:WaitForChild("Skill"..tostring(number))

         if Slot and Slot.Visible then
            local SkillName = Slot:WaitForChild("SkillName").Text

            if SkillName:lower() ~= "skill 2" and not tonumber(SkillName) then
               return true
            end
         end
      else
         local Slot = SlotsHolder:WaitForChild("Skill"..tostring(number))

         if Slot and Slot.Visible then
            local SkillName = Slot:WaitForChild("SkillName").Text

            if SkillName:lower() ~= "skill "..tostring(number) and not tonumber(SkillName) then
               return true
            end
         end
      end
   end

   return false
end

function useAbility(mode)
   local Root = GetRoot()
   if Root == nil then return end

   task.spawn(function()
      if type(mode) == "string" and mode:lower() == "click" then
         MainRemoteEvent:FireServer("UseSkill", {["hrpCFrame"] = Root.CFrame, ["attackNumber"] = math.random(1,2)}, "BasicAttack")
      elseif type(mode) == "number" and mode < 6 then
         MainRemoteEvent:FireServer("UseSkill", {["hrpCFrame"] = Root.CFrame}, mode)
      end
   end)
end

function IsEnded()
   local CenterUIFrame =LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UniversalGui"):WaitForChild("UniversalCenterUIFrame")
   local ResultUIs = {[1] = CenterUIFrame:WaitForChild("ResultUI"), [2] = CenterUIFrame:WaitForChild("RaidResultUI")}

   for i,v in pairs(ResultUIs) do
      if v.Visible then
         return true
      end
   end

   return false
end

function Retry()
   task.spawn(function()
      MainRemoteEvent:FireServer("RetryDungeon")
   end)
end

function Leave()
   task.spawn(function()
      MainRemoteEvent:FireServer("LeaveDungeon")
   end)
end

function debugPrint(...)
   if Settings.DebugMode then
      local MSGs = {...}

      for i,v in pairs(MSGs) do
         print(tostring(v))
      end
   end
end

--// Source \\--
if GetCharacter() ~= nil then
   local NameLabel  = GetCharacter():WaitForChild("Head", 60):WaitForChild("PlayerHealthBarGui"):WaitForChild("PlayerName")
   NameLabel.Text = "Made by Ghost-Ducky#7698"
end

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
   task.wait(1)
   local NameLabel = newCharacter:WaitForChild("Head", 60):WaitForChild("PlayerHealthBarGui"):WaitForChild("PlayerName")
   NameLabel.Text = "Made by Ghost-Ducky#7698"
end)

local Enemy = GetClosestEnemy()
while task.wait(.1) do
   local Character, Root = GetCharacter(), GetRoot()
   if not Settings.AutoFarm then
      if (Character and Root) then
         Root.Anchored = false
      end
      break
   end

   if IsEnded() then
      debugPrint("Game Ended")

      if Settings.AutoRetry then
         debugPrint("Retry dungeon \n")
         Retry()
         continue
      else
         debugPrint("Leave dungeon \n")
         Leave()
         continue
      end
   end

   if (Character and Root) and not IsEnded() then
      if (Enemy and Enemy.Parent) then
         local EnemyRoot = Enemy:WaitForChild("HumanoidRootPart")
         local EnemyHumanoid = Enemy:FindFirstChildOfClass("Humanoid")

         if (EnemyHumanoid and EnemyHumanoid.Health <= 0) then
            Enemy = nil
            continue
         end

         debugPrint("MoveTo: "..Enemy.Name, "\n")
         Tween(1, {CFrame = CFrame.lookAt(EnemyRoot.CFrame.Position + Vector3.new(0, 4, 0), EnemyRoot.CFrame.Position) })

         if checkCD(1, true) then
            debugPrint("UseAssist: 1 \n")
            useAssist(1)
         end

         if checkCD(2, true) then
            debugPrint("UseAssist: 2 \n")
            useAssist(2)
         end

         if checkCD(5) then
            debugPrint("UseSkill: 5")
            useAbility(5)
            task.wait(.5)
            continue
         end

         if checkCD(4) then
            debugPrint("UseSkill: 4")
            useAbility(4)
            task.wait(.5)
            continue
         end

         if checkCD(3) then
            debugPrint("UseSkill: 3")
            useAbility(3)
            continue
         end

         if checkCD(2) then
            debugPrint("UseSkill: 2")
            useAbility(2)
            continue
         end

         if checkCD(1) then
            debugPrint("UseSkill: 1")
            useAbility(1)
            continue
         end

         debugPrint("UseSkill: BasicAttack")
         useAbility("click")
      else
         Enemy = GetClosestEnemy()
      end
   end
end

--// Made by GhostyDuckyy#7698 \\--
print("GhostyDuckyy is here!")
--// Checks \\--
local BlackList_IDs = {6938803436, 7338881230, 6990131029, 6990133340} -- Lobby, Raid Lobby, AFK Lobby, Character Testing
if table.find(BlackList_IDs, game.PlaceId) then return end
if not game:IsLoaded() then game.Loaded:Wait() end

if not workspace:FindFirstChild("Folders") then return end
if not game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents") then return end
if not game:GetService("ReplicatedStorage"):FindFirstChild("RemoteFunctions") then return end

--// Services \\--
local HttpService             =  game:GetService("HttpService")
local TweenService            =  game:GetService("TweenService")
local ReplicatedStorage       =  game:GetService("ReplicatedStorage")
local Players                 =  game:GetService("Players")
local LocalPlayer             =  Players.LocalPlayer
local PlayerGui               =  LocalPlayer:WaitForChild("PlayerGui")
local Camera                  =  workspace.CurrentCamera

--// Folders \\--
local Monsters                =  workspace:WaitForChild("Folders"):WaitForChild("Monsters")

--// Remotes \\--
local MainRemoteEvent         =  ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("MainRemoteEvent")
local MainRemoteFunction      =  ReplicatedStorage:WaitForChild("RemoteFunctions"):WaitForChild("MainRemoteFunction")

--// Settings \\--
getgenv().CurrentTween = nil
getgenv().Settings = (type(getgenv().Settings) == "table" and Settings) or {
    AutoFarm        =   true,
    AutoRetry       =   true,
    Webhook         =   {Enabled = false, Url = "https://discord.com/api/webhooks/example/tokens"},
    DebugMode       =   false,
}
getgenv().OtherSettings = (getgenv().OtherSettings and OtherSettings) or {
    PostedResult           =    false,
    Executed_FpsBooter     =    false,
}

--// Webhook Functions \\--
function Send_Webhook(Types, data)
    local function matchUrl(input)
        if type(input) ~= "string" then return end

        if (string.find(input, "https://discord.com/api/webhooks/") and string.len(input) > 33 and input ~= "https://discord.com/api/webhooks/example/tokens") then
            return true
        end

        return false
    end

    if (not Settings.Webhook.Enabled) then return end
    if (not matchUrl(Settings.Webhook.Url)) then debug_SendOutput("Invaild webhook url \n") return end
    if type(Settings.Webhook.Url) ~= "string" then return end
    if type(Types) ~= "string" then return end

    if (Types == "GameEnded" and OtherSettings.PostedResult) then return end
    if (Types == "GameEnded") then
        local Leaderstats = LocalPlayer:WaitForChild("leaderstats")
        local BattleGui = PlayerGui:WaitForChild("BattleGui"):WaitForChild("CenterUIFrame")
        local OwnInfoFrame = PlayerGui:WaitForChild("UniversalGui"):WaitForChild("LeftUIFrame"):WaitForChild("OwnHealthBarFrame")

        local Level, Damage = tostring(Leaderstats:WaitForChild("Level").Value or "null"), tostring(Leaderstats:WaitForChild("Damage").Value or "null")
        local Time, Combo, Defeated = (BattleGui:WaitForChild("TimerBack"):WaitForChild("Timer").Text or "null"), (BattleGui:WaitForChild("BestComboBack"):WaitForChild("BestComboNumber").Text or "null"), (BattleGui:WaitForChild("EnemiesDefeatedBack"):WaitForChild("EnemyDefeatedNumber").Text or "null")
        local Exp, Gems, Golds = (OwnInfoFrame:WaitForChild("Exp") and " (**XP**: "..OwnInfoFrame:WaitForChild("Exp").Text..")") or " (**XP**: null)", "null", "null"

        for _, Label in pairs(OwnInfoFrame:GetDescendants()) do
            if Label:IsA("TextLabel") and (Label.Parent and Label.Parent.Name == "CoinBlack") then
                if (Label.Name == "Gem") then
                    Gems = Label.Text
                elseif (Label.Name == "Gold") then
                    Golds = Label.Text
                end
            end
        end

        data = {
            ["content"] = "Thank you for using this script! 💖",
            ["embeds"] = { {
                ["title"]       = "🚧 Match Results 🚧",
                ["description"] = "**Time remain**: "..Time.." ⏳ | **Best Combo**: "..Combo.." 🌟\n**Defeated**: "..Defeated.." 🎯 | **Damage**: "..Damage.." ⚔️",
                ["color"]       = 9055202,
                ["fields"] = {
                    { ["name"] = "🔎 Infomation 🔍", ["value"] = "**User**: "..LocalPlayer.DisplayName.." (@"..LocalPlayer.Name..")\n**Level**: "..Level..Exp },
                    { ["name"] = "💸 Currency 💸", ["value"] = "**Gems**: "..Gems.." 💎\n**Golds**: "..Golds.." 🪙" },
                },
                ["author"] = {
                    ["name"]      = "Anime Dimensions Simulator",
                    ["url"]       = "https://roblox.com/games/6938803436/",
                    ["icon_url"]  = "https://pbs.twimg.com/media/FtZ-2XKaIAI4MX7?format=jpg&name=small"
                },
                ["footer"] = {
                    ["text"] = "👻 Made by GhostyDuckyy"
                }
              } },
          }
    end

    local HttpPost = (syn and syn.request) or request or (https and https.request) or http_request or function(...)
        debug_SendOutput("Function: 'request' is nil \n")
        local Response =  {
            ["Success"] = false
       }
        return Response
    end

    local Encoded           =   HttpService:JSONEncode(data)
    local ResponseStatus    =   HttpPost(
        {
            ["Url"]         =   Settings.Webhook.Url,
            ["Body"]        =   Encoded,
            ["Method"]      =   "POST",
            ["Headers"]     =   { ["content-type"] = "application/json" },
        }
    )

    if (ResponseStatus.Success) then
        debug_SendOutput("Succesfully posted result to webhook \n")

        if (Types == "GameEnded")  then
            OtherSettings.PostedResult = true
        end
    else
        debug_SendOutput("Failed to post result to webhook \n")
    end
end

--// Tween \\--
local function CancelTween()
    if (CurrentTween ~= nil) then
        CurrentTween:Pause()
        CurrentTween:Cancel()
        CurrentTween = nil
    end
end

local function Tween(Time: number, prop: table)
    if type(Time) ~= "number" then return end
    if type(prop) ~= "table" then return end

    CancelTween()

    local Root = GetRoot()
    if (not Root) then
        while task.wait() do
            Root = GetRoot()
            if (Root) then break end
        end
        task.wait(.1)
    end

    CurrentTween = TweenService:Create(Root, TweenInfo.new(Time, Enum.EasingStyle.Linear), prop)
    CurrentTween.Completed:Connect(function()
        CurrentTween = nil
    end)

    CurrentTween:Play()
    return CurrentTween.Completed:Wait()
end

--// Functions \\--
function GetCharacter()
    local RespawnTimerFrame = PlayerGui:WaitForChild("UniversalGui"):WaitForChild("UniversalCenterUIFrame"):WaitForChild("RespawnTimerFrame")
    if (RespawnTimerFrame and RespawnTimerFrame.Visible) then
        return nil
    end
    return (LocalPlayer.Character ~= nil and LocalPlayer.Character) or LocalPlayer.CharacterAdded:Wait()
end

function GetRoot()
    local Character = GetCharacter()
    if (Character) then
        Character:WaitForChild("HumanoidRootPart", 9e9)
        local Root = Character:FindFirstChild("HumanoidRootPart")
        return Root
    end
    return nil
end

function GetClosestEnemy()
   local Enemy = nil
   local Last_distance = math.huge
   local Root = GetRoot()
   local Childrens = Monsters:GetChildren()

   if (not Root) then return nil end
   if (#Childrens <= 0) then return nil end

   for i = 1, #Childrens do
        local Child = Childrens[i]

        if (Child) then
            if not Child:FindFirstChildOfClass("Humanoid") then continue end
            if not Child:FindFirstChild("HumanoidRootPart") then continue end

            if (Child:FindFirstChildOfClass("BillboardGui") and Child:WaitForChild("EnemyHealthBarGui")) then
                local Health = Child["EnemyHealthBarGui"]:WaitForChild("HealthText")
                if tonumber(Health.Text) <= 0 then
                    continue
                end
            else
                continue
            end

            if Child:FindFirstChildOfClass("Highlight") then
                Enemy = Child
                return Enemy
            end

            local distance = (Root.Position - Child.HumanoidRootPart.Position).Magnitude

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
   if (not Root) then return end

   task.spawn(function()
      MainRemoteEvent:FireServer("UseAssistSkill", {["hrpCFrame"] = Root.CFrame}, number)
   end)
end

function checkCD(number: number, assist: boolean)
   if type(number) ~= "number" then return end
   if type(assist) ~= "boolean" then assist = false end

   local SlotsHolder = PlayerGui:WaitForChild("UniversalGui"):WaitForChild("UniversalCenterUIFrame"):WaitForChild("SlotsHolder")

   if (not SlotsHolder) then debug_SendOutput("SlotsHolder is 'nil' \n") return end
   if assist then
        if (number >= 3) then return end
        local Slot = SlotsHolder:WaitForChild("SkillAssist"..tostring(number))
        if Slot and Slot.Visible then
            local SkillName = Slot:WaitForChild("SkillName").Text

            if not SkillName.Visible then
                return true
            end
        end
   else
        if (number >= 6) then return end
        local Slot = SlotsHolder:WaitForChild("Skill"..tostring(number))

        if (number == 5) then
            if (Slot and Slot.Visible) then
                local SkillName = Slot:WaitForChild("SkillName").Text

                if SkillName:lower() ~= "skill 2" and not tonumber(SkillName) then
                return true
                end
            end
        elseif (4 >= number) then
            if (Slot and Slot.Visible) then
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
   if (not Root) then return end

    if type(mode) == "string" and mode:lower() == "click" then
        task.spawn(function()
            MainRemoteEvent:FireServer("UseSkill", {["hrpCFrame"] = Root.CFrame, ["attackNumber"] = 1}, "BasicAttack")
        end)

        task.spawn(function()
            MainRemoteEvent:FireServer("UseSkill", {["hrpCFrame"] = Root.CFrame, ["attackNumber"] = 2}, "BasicAttack")
        end)
    elseif type(mode) == "number" and mode < 6 then
        task.spawn(function()
            MainRemoteEvent:FireServer("UseSkill", {["hrpCFrame"] = Root.CFrame}, mode)
        end)
    end
end

function IsEnded()
   local CenterUIFrame = PlayerGui:WaitForChild("UniversalGui"):WaitForChild("UniversalCenterUIFrame")
   local ResultUIs = {
        [1] = CenterUIFrame:WaitForChild("ResultUI"),
        [2] = CenterUIFrame:WaitForChild("RaidResultUI"),
    }

   for i,v in pairs(ResultUIs) do
      if (v.Visible) then
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

function debug_SendOutput(...)
    if (not Settings.DebugMode) then return end
    local Outputs = {...}
    task.spawn(function()
        for _, v in next, (Outputs) do
            print(tostring(v))
         end
    end)
end

--// Source \\--
task.spawn(function()
    local Enemy = GetClosestEnemy()

    while task.wait(.1) do
        local Character, Root = GetCharacter(), GetRoot()

        if (not Settings.AutoFarm) then
            if (Character and Root and Character:FindFirstChildOfClass("Humanoid")) then
                Camera.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
                Root.Anchored = false
            end
            break
        end

        if IsEnded() then
            debug_SendOutput("Game Ended")

            Send_Webhook("GameEnded")

            if (Settings.AutoRetry) then
                debug_SendOutput("Retry dungeon \n")
                Retry()
                continue
            else
                debug_SendOutput("Leave dungeon \n")
                Leave()
                continue
            end
        end

        if (Character and Root) and not IsEnded() then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            if (Enemy and Enemy.Parent) then
                local EnemyRoot = Enemy:FindFirstChild("HumanoidRootPart")
                local EnemyHumanoid = Enemy:FindFirstChildOfClass("Humanoid")

                if (not EnemyRoot or not EnemyHumanoid) then
                    Enemy = nil
                    Camera.CameraSubject = Humanoid
                    continue
                end

                if (Enemy:FindFirstChildOfClass("BillboardGui") and Enemy:WaitForChild("EnemyHealthBarGui")) then
                    local Health = Enemy["EnemyHealthBarGui"]:WaitForChild("HealthText")
                    if tonumber(Health.Text) <= 0 then
                        Enemy = nil
                        Camera.CameraSubject = Humanoid
                        continue
                    end
                else
                    Enemy = nil
                    Camera.CameraSubject = Humanoid
                    continue
                end

                pcall(
                    task.spawn(function()
                        Camera.CameraSubject = EnemyHumanoid

                        if (Character and Character:WaitForChild("Head", 10)) then
                            local NameLabel = Character["Head"]:WaitForChild("PlayerHealthBarGui"):WaitForChild("PlayerName")
                            NameLabel.Text = "Made by Ghost-Ducky#7698"
                        end
                    end)
                )

                local distance = (Root.CFrame.Position - EnemyRoot.CFrame.Position).Magnitude

                Root.Anchored = false
                debug_SendOutput("MoveTo: "..Enemy.Name.."\n")

                if distance <= 15 then
                    Tween(.5, {CFrame = CFrame.lookAt(EnemyRoot.CFrame.Position + Vector3.new(0, 4, 0), EnemyRoot.CFrame.Position) })
                else
                    Tween(.8, {CFrame = CFrame.lookAt(EnemyRoot.CFrame.Position + Vector3.new(0, 4, 0), EnemyRoot.CFrame.Position) })
                end

                Root.Anchored = true

                if checkCD(1, true) then
                    debug_SendOutput("Use Assist: 1")
                    useAssist(1)
                end

                if checkCD(2, true) then
                    debug_SendOutput("Use Assist: 2")
                    useAssist(2)
                end

                if (not checkCD(5) and not checkCD(4) and not checkCD(3) and not checkCD(2) and not checkCD(1)) then
                    debug_SendOutput("Use Skill: BasicAttack")
                    useAbility("click")
                    continue
                end

                if checkCD(5) then
                    debug_SendOutput("Use Skill: 5")
                    useAbility(5)
                    continue
                end

                if checkCD(4) then
                    debug_SendOutput("Use Skill: 4")
                    useAbility(4)
                    continue
                end

                if checkCD(3) then
                    debug_SendOutput("Use Skill: 3")
                    useAbility(3)
                    continue
                end

                if checkCD(2) then
                    debug_SendOutput("Use Skill: 2")
                    useAbility(2)
                    continue
                end

                if checkCD(1) then
                    debug_SendOutput("UseS kill: 1")
                    useAbility(1)
                    continue
                end
            else
                Enemy = GetClosestEnemy()
            end
        end
    end
end)

--// Made by GhostyDuckyy#7698 \\--
print("GhostyDuckyy is here!")

--// Checks \\--
local BlackList_IDs = {6938803436, 7338881230, 6990131029, 6990133340} -- Lobby, Raid Lobby, AFK Lobby, Character Testing
if table.find(BlackList_IDs, game.PlaceId) then return end
if not game:IsLoaded() then game.Loaded:Wait() end

if not workspace:WaitForChild("Folders", 180) then return end
if not game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents", 180) then return end
if not game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions", 180) then return end

if (type(getgenv().Connections) == "table" and #Connections >= 1) then
    local function Disconnect(v)
        pcall(task.spawn(function()
            if (type(v) == "table" and rawget(v, "Type") ~= nil) then
                if (v.Type == "Hookfunction") then
                    if (rawget(v, "Hooked_function") ~= nil and rawget(v, "Function") ~= nil) then
                        hookfunction(v.Hooked_function, v.Function)
                    end
                elseif (v.Type == "Connection") then
                    if (rawget(v, "Connected") ~= nil) then
                        v.Connected:Disconnect()
                    end
                end
            end
        end))
    end

    for i,v in pairs(Connections) do
        Disconnect(v)
    end
end

--// Services \\--
local HttpService             =  game:GetService("HttpService")
local TweenService            =  game:GetService("TweenService")
local ReplicatedStorage       =  game:GetService("ReplicatedStorage")
local UserInputService        =  game:GetService("UserInputService")

local Platform                =  UserInputService:GetPlatform()
local Players                 =  game:GetService("Players")
local LocalPlayer             =  Players.LocalPlayer
local PlayerGui               =  LocalPlayer:WaitForChild("PlayerGui")
local Camera                  =  workspace.CurrentCamera

--// Folders \\--
local Monsters                =  workspace["Folders"]:WaitForChild("Monsters")

--// Remotes \\--
local MainRemoteEvent         =  ReplicatedStorage["RemoteEvents"]:WaitForChild("MainRemoteEvent")
local MainRemoteFunction      =  ReplicatedStorage["RemoteFunctions"]:WaitForChild("MainRemoteFunction")

--// Settings \\--
getgenv().CurrentTween = nil

getgenv().Settings = (type(getgenv().Settings) == "table" and Settings) or {
    AutoFarm        =   true,
    AutoRetry       =   true,
    Webhook         =   {Enabled = false, Url = "https://discord.com/api/webhooks/example/tokens"},
    DebugMode       =   false,
}

getgenv().OtherSettings = (getgenv().OtherSettings and OtherSettings) or {
    PostedResult    =   false,
    Executed        =   false,
}

getgenv().ResultTable = (type(getgenv().ResultTable) == "table" and ResultTable) or {
    ["timeTaken"]       = nil,
    ["damageDealt"]     = nil,
    ["rank"]            = nil,
    ["reward"]          = nil,
}

getgenv().Connections = {}

--// Webhook Functions \\--
function Send_Webhook(Types, data)
    local Request = (syn and syn.request) or request or (https and https.request) or http_request or function(...)
        debug_SendOutput("Function: 'request' is invaild \n")
        local Response =  {
            ["Success"] = false
       }
        return Response
    end

    local function matchUrl(input)
        if type(input) ~= "string" then return end

        if (string.find(input, "https://discord.com/api/webhooks/") and input ~= "https://discord.com/api/webhooks/example/tokens") then
            local Response = Request({Url = Settings.Webhook.Url, Method = "GET"})

            if (Response["Success"]) then
                return true
            end
        end

        return false
    end

    if (not Settings.Webhook.Enabled) then return end
    if (not matchUrl(Settings.Webhook.Url)) then debug_SendOutput("Invaild webhook url \n") return end
    if type(Settings.Webhook.Url) ~= "string" then return end
    if type(Types) ~= "string" then return end

    if (Types == "GameEnded" and OtherSettings.PostedResult) then return end
    if (Types == "GameEnded") then
        task.wait(.5)

        local Leaderstats = LocalPlayer:WaitForChild("leaderstats")
        local BattleGui = PlayerGui:WaitForChild("BattleGui"):WaitForChild("CenterUIFrame")
        local OwnInfoFrame = PlayerGui:WaitForChild("UniversalGui"):WaitForChild("LeftUIFrame"):WaitForChild("OwnHealthBarFrame")

        local Level, Damage = tostring(Leaderstats:WaitForChild("Level").Value or "null"), tostring(Leaderstats:WaitForChild("Damage").Value or "null")
        local TimeRemaining, Combo, Defeated = (BattleGui:WaitForChild("TimerBack"):WaitForChild("Timer").Text or "00:00"), (BattleGui:WaitForChild("BestComboBack"):WaitForChild("BestComboNumber").Text or "null"), (BattleGui:WaitForChild("EnemiesDefeatedBack"):WaitForChild("EnemyDefeatedNumber").Text or "null")
        local Exp, Gems, Golds = (OwnInfoFrame:WaitForChild("Exp") and " (**XP**: "..OwnInfoFrame["Exp"].Text..")") or " (**XP**: null)", "null", "null"

        local Time = (rawget(ResultTable, "timeTaken") ~= nil and "**Time elapsed**: "..ResultTable.timeTaken.." ⏳") or "**Time remain**: "..TimeRemaining.." ⏳"
        local Rank = (rawget(ResultTable, "rank") ~= nil and "**Rank**: "..ResultTable.rank.."\n") or "**Rank**: null\n"
        local Rewards, StringRewards = (rawget(ResultTable, "reward") ~= nil and type(ResultTable) == "table" and ResultTable.reward) or nil, ""

        if (Rewards) then
            for i = 1, #Rewards do
                local Current_Reward = Rewards[i]

                if (type(Current_Reward) == "table") then
                    StringRewards = StringRewards.."{"

                    for _,v in pairs(Current_Reward) do
                        if (tostring(_) == "type" or tostring(_) == "reward") then
                            StringRewards = StringRewards..tostring(_)..": '"..tostring(v).."'"
                        else
                            StringRewards = StringRewards..tostring(_)..": "..tostring(v)
                        end

                        StringRewards = StringRewards..", "
                    end
                    StringRewards = StringRewards.."}, "
                end
            end
        end

        if (string.len(StringRewards) <= 0) then
            StringRewards = "{'Failed to grab rewards 💀'}"
        end

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
                ["title"]       = "🏁 Match Results 🏁",
                ["description"] =  Rank..Time.." | **Best Combo**: "..Combo.." 🌟\n**Defeated**: "..Defeated.." 🎯 | **Damage**: "..Damage.." ⚔️",
                ["color"]       = 9055202,
                ["fields"] = {
                    { ["name"] = "🎁 Rewards 🎁", ["value"] = "```lua\n"..StringRewards.."\n```" },
                    { ["name"] = "🔎 Infomation 🔎", ["value"] = "**User**: "..LocalPlayer.DisplayName.." (@"..LocalPlayer.Name..")\n**Level**: "..Level..Exp },
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

    local Encoded           =   HttpService:JSONEncode(data)
    local ResponseStatus    =   Request(
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
    if (typeof(CurrentTween) == "Instance" and CurrentTween:IsA("Tween")) then
        CurrentTween:Pause()
        CurrentTween:Cancel()
        CurrentTween = nil
    end
end

local function Tween(SpeedPerStuds: number, prop: table)
    if type(SpeedPerStuds) ~= "number" then return end
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

    local Time = (Root.CFrame.Position - prop.CFrame.Position).Magnitude / SpeedPerStuds
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

            if (distance < Last_distance) then
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
   if (assist) then
        if (number >= 3) then return end
        local Slot = SlotsHolder:WaitForChild("SkillAssist"..tostring(number))
        if (Slot and Slot.Visible) then
            local SkillName = Slot:WaitForChild("SkillName")

            if (not SkillName.Visible and not tonumber(SkillName.Text)) then
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

--// Hooks \\--
if (OtherSettings.Executed) then return else OtherSettings.Executed = true end

task.spawn(function()
    if (Platform == Enum.Platform.Android or Platform == Enum.Platform.IOS) then return end
    local onMainRemoteEventCall = nil

    for i,v in next, getconnections(MainRemoteEvent.OnClientEvent) do
        if (v.Function) then
            local info = debug.getinfo(v.Function)
            if (info.name == "onMainRemoteEventCall") then
               onMainRemoteEventCall = v.Function
               break
            end
        end
    end

    if (onMainRemoteEventCall) then
        local FunctionToGrab = {
            "SetUpResultUI",
            "setupRaidUI",
        }
        local old;
        old = hookfunction(onMainRemoteEventCall, newcclosure(function(FuncName, ...)
            if (table.find(FunctionToGrab, FuncName)) then
                local args = {...}
                getgenv().ResultTable = args[1]
             end
             old(FuncName, ...)
        end))

        table.insert(Connections, {Type = "Hookfunction", Hooked_function = onMainRemoteEventCall, Function = old})
        debug_SendOutput("Hooked 'onMainRemoteEventCall' function")
    end
end)

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

                        if (Character and Character:WaitForChild("Head", 10) and Character["Head"]:WaitForChild("PlayerHealthBarGui", 10)) then
                            local NameLabel = Character["Head"]["PlayerHealthBarGui"]:WaitForChild("PlayerName")
                            NameLabel.Text = "Made by GhostyDuckyy#7698"
                        end
                    end)
                )

                local EnemyCFrame = EnemyRoot:GetPivot()
                local distance = (Root.CFrame.Position - EnemyRoot.Position).Magnitude

                Root.Anchored = false
                debug_SendOutput("MoveTo: "..Enemy.Name.."\n")

                if (distance <= 20) then
                    Tween(18, {CFrame = CFrame.lookAt(EnemyCFrame.Position + Vector3.new(0, 4, 0), EnemyCFrame.Position) })
                else
                    Tween(160, {CFrame = CFrame.lookAt(EnemyCFrame.Position + Vector3.new(0, 4, 0), EnemyCFrame.Position) })
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
                    debug_SendOutput("BasicAttack")
                    useAbility("click")
                    continue
                end

                if checkCD(5) then
                    debug_SendOutput("Use Ability: 5")
                    useAbility(5)
                    continue
                end

                if checkCD(4) then
                    debug_SendOutput("Use Ability: 4")
                    useAbility(4)
                    continue
                end

                if checkCD(3) then
                    debug_SendOutput("Use Ability: 3")
                    useAbility(3)
                    continue
                end

                if checkCD(2) then
                    debug_SendOutput("Use Ability: 2")
                    useAbility(2)
                    continue
                end

                if checkCD(1) then
                    debug_SendOutput("Use Ability: 1")
                    useAbility(1)
                    continue
                end
            else
                Root.Anchored = false
                Root.Velocity = Vector3.new()
                Enemy = GetClosestEnemy()
            end
        end
    end
end)

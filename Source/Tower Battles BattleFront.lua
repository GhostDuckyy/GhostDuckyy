--// Checks \\--
if (not game:IsLoaded()) then game.Loaded:Wait() end
if (game.PlaceId ~= 5977347869) then return end

if (getgenv().Disconnect and typeof(Disconnect) == "function") then
    Disconnect()
end

--// Services \\--
local RunSevice = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local MajorFolder = workspace:WaitForChild("Game")
local TargetZombie = nil

--// Functions \\--
local function getClosestZombie()
    local ClosestZombie = nil
    local ClosestDistance = math.huge
    local ZombieFolders = {[1] = MajorFolder:WaitForChild("BossZombies"), [2] = MajorFolder:WaitForChild("Zombies")}

    for _,Folder in pairs(ZombieFolders) do
        if (Folder) then
            local Childrens = Folder:GetChildren()
            if #Childrens <= 0 then continue end

            for Index, Zombie in pairs(Childrens) do
                if (not Zombie:FindFirstChildOfClass("Humanoid")) then continue end
                if (not Zombie:FindFirstChild("Head")) then continue end
                if (Zombie:FindFirstChildOfClass("Humanoid").Health <= 0) then continue end

                local ScreenVec3, OnScreen = Camera:WorldToViewportPoint(Zombie["Head"].Position)

                if (not OnScreen) then continue end

                local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenVec3.X, ScreenVec3.Y)).Magnitude

                if (Distance < ClosestDistance) then
                    ClosestZombie = Zombie
                    ClosestDistance = Distance
                end
            end
        end
    end

    return ClosestZombie
end

--// Source \\--
TargetZombie = getClosestZombie()
local RenderStepped = RunSevice.RenderStepped:Connect(function()
    TargetZombie = getClosestZombie()
end)

local Old_MetaMethod
Old_MetaMethod = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local Method = getnamecallmethod()

    if (not checkcaller() and Method == "FireServer") and (typeof(Self) == "Instance" and Self.Name == "Connection") then
        local Args = {...}

        if ((TargetZombie ~= nil and TargetZombie.Parent ~= nil) and (rawget(Args, 1) == "Fire" and typeof(rawget(Args, 2)) == "CFrame")) then
            rawset(Args, 2, TargetZombie["Head"].CFrame)
            return Old_MetaMethod(Self, unpack(Args))
        end
    end
    return Old_MetaMethod(Self, ...)
end))

getgenv().Disconnect = function()
    hookmetamethod(game, "__namecall", Old_MetaMethod)
    RenderStepped:Disconnect()
    Disconnect = nil
end
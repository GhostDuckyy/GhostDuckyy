--// Decompiled Code. 
  -- library https://raw.githubusercontent.com/RubyBoo4life/orange-theme/main/README.md and Synapse

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "Notification";
    Text = "Welcome to Plasma Hub!";
    Icon = "rbxassetid://8211871532";
})

    --local ForceReset = game.Players.LocalPlayer.Character:Destroy()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RubyBoo4life/orange-theme/main/README.md"))()
    local Window = Library.CreateLib("Plasma Hub â™¦ Break In", "Synapse") -- Ocean / Midnight
    
        -- Ruby
    local Ruby = Window:NewTab("Plasma Hub")

    local ThankYou = Ruby:NewSection("Thanks for using Plasma Hub! Enjoy hacking!")

    local RubySection = Ruby:NewSection("Credits")
    
    RubySection:NewButton("Visolarity#9600", "The Creators discord user", function()
        setclipboard("Visolarity#9600")
    end)
    
    RubySection:NewButton("Copy Discord Invite", "Discord Server", function()
        setclipboard("ttps://discord.gg/RvHdPv5dJa")
        end)
    

    local ServerSection = Ruby:NewSection("Server Functions")
    
        ServerSection:NewButton("Kill Roblox", "Shutdown roblox", function()
        game:Shutdown()
        end)
    
    ServerSection:NewButton("Leave game", "Kicks you from the game", function()
        game.Players.LocalPlayer:Kick("Left game!")
    end)
    
    ServerSection:NewButton("Rejoin game", "Rejoins the game!", function()
    game.Players.LocalPlayer:Kick("Rejoining...")
    wait(1.5)
    local ts = game:GetService("TeleportService")

    local p = game:GetService("Players").LocalPlayer

    ts:Teleport(game.PlaceId, p)
    
    end)

    -- updates
    local updatestab = Window:NewTab("Updates")
    local updatessection = updatestab:NewSection("Updates")
    
    updatessection:NewButton("Added Find Safe", "Check it out!", function()
        print("Check It Out!")
    end)
    

    -- Main
    local spawntab = Window:NewTab("Weapons")
    local weaponsSection = spawntab:NewSection("Weapons")


    weaponsSection:NewButton("Hammer", "AutoFarms the nearest coins", function()
        local A_1 = true
        local A_2 = "Hammer"
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon
        Event:FireServer(A_1, A_2)
    end)

    weaponsSection:NewButton("Sword", "Gives you a sword", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("LinkedSword")
    end)
    
    weaponsSection:NewButton("Bat", "Gives you a bat", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Bat")
    end)


    local roles = Window:NewTab("Roles")
    local rolessec = roles:NewSection("Roles")

    rolessec:NewButton("Bat", "Makes you adult bat role", function()
        local A_1 = "Bat"
        local A_2 = false
        local A_3 = false
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.MakeRole
        Event:FireServer(A_1, A_2, A_3)
    end)

    rolessec:NewButton("Medic", "Makes you adult medic role", function()
        local A_1 = "MedKit"
        local A_2 = false
        local A_3 = false
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.MakeRole
        Event:FireServer(A_1, A_2, A_3)
    end)

    rolessec:NewButton("Swat", "Makes you adult swat role", function()
        local A_1 = "SwatGun"
        local A_2 = true
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole
        Event:FireServer(A_1, A_2)
    end)

    rolessec:NewButton("Police", "Makes you adult police role", function()
        local A_1 = "Gun"
        local A_2 = true
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole
        Event:FireServer(A_1, A_2)
    end)

    rolessec:NewButton("Guest", "Makes you adult guest role", function()
        local A_1 = "LinkedSword"
        local A_2 = false
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole
        Event:FireServer(A_1, A_2)
    end)

    rolessec:NewButton("Hyper", "Makes you adult hyper role", function()
        local A_1 = "Lollipop"
        local A_2 = false
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole
        Event:FireServer(A_1, A_2)
    end)

    local foodtab = Window:NewTab("Spawn")
    local foodsec = foodtab:NewSection("Spawn")

    foodsec:NewButton("Chips", "Gives you chips", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
    end)

    foodsec:NewButton("Bloxy Cola", "Gives you a bloxy cola", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("BloxyCola")
    end)

    foodsec:NewButton("Apple", "Gives you an apple", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Apple")
    end)

    foodsec:NewButton("Medkit", "Gives you a medkit", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("MedKit")
    end)

    foodsec:NewButton("Pizza", "Gives you a pizza", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Pizza2")
    end)

    foodsec:NewButton("Cookie", "Gives you a cookie", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cookie")
    end)

    foodsec:NewButton("Green Pizza", "Gives you a green pizza", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("EpicPizza")
    end)

    foodsec:NewButton("Teddy", "Gives you a teddy", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("TeddyBloxpin")
    end)

    foodsec:NewButton("Sword", "Gives you a sword", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("LinkedSword")
    end)

    foodsec:NewButton("Cure", "Gives you cure tool", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cure")
    end)

    foodsec:NewButton("Hammer", "Gives you a hammer", function()
        local A_1 = true
        local A_2 = "Hammer"
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon
        Event:FireServer(A_1, A_2)
    end)

    foodsec:NewButton("Plank", "Gives you planks", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Plank")
    end)
    
    foodsec:NewButton("Expired Bloxy Cola", "Gives you an expired bloxy cola", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("ExpiredBloxyCola")
    end)

    foodsec:NewButton("Lollipop", "Gives you a lollipop", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Lollipop")
    end)

    local tptab = Window:NewTab("Teleport")
    local tpsec = tptab:NewSection("Teleport")

    tpsec:NewButton("Basement", "Teleports you to basement", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(71, -15, -163)
    end)

    tpsec:NewButton("House", "Teleports you to house", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-36, 3, -200)
    end)

    tpsec:NewButton("Attic", "Teleports you to attic", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16, 35, -220)
    end)

    tpsec:NewButton("Store", "Teleports you to store", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-422, 3, -121)
    end)

    tpsec:NewButton("Sewer", "Teleports you to sewer", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(129, 3, -125)
    end)

    tpsec:NewButton("Boss Room", "Teleports you to boss room", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, -287, -1480)
    end)


    local otherstyf = Window:NewTab("Other")
    local other = otherstyf:NewSection("Other")
    
    other:NewButton("Cat Friend", "Cat Friend", function()
        local Target = game:GetService("ReplicatedStorage").RemoteEvents.Cattery;
        Target:FireServer();
    end)

    

    other:NewButton("Heal Others", "Heals everyone", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("MedKit")
        wait(.3)
        game.Players.LocalPlayer.Backpack.MedKit.Parent = game.Players.LocalPlayer.Character
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
        game:GetService("ReplicatedStorage").RemoteEvents.HealPlayer:FireServer(v)
        end
        game.Players.LocalPlayer.Character.MedKit.Parent = game.Players.LocalPlayer.Backpack
        wait(1.5)
        game.Players.LocalPlayer.Backpack.MedKit:Destroy()
    end)

    other:NewButton("Heal Yourself", "Heals you", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cure")
        wait(.3)
        game.Players.LocalPlayer.Backpack.Cure.Parent = game.Players.LocalPlayer.Character
        local A_1 = game:GetService("Players").Visolarity
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.CurePlayer
        Event:FireServer(A_1)
        game.Players.LocalPlayer.Character.Cure.Parent = game.Players.LocalPlayer.Backpack
        wait(1.5)
        game.Players.LocalPlayer.Backpack.Cure:Destroy()
    end)

    other:NewButton("Kill Enemies (LAG)", "Kill Enemies might lag", function()
        for i,v in pairs(game.Workspace.BadGuys:GetChildren()) do
            for i = 1, 50 do
                game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,10)
                game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,996)
                game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,9)
                game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,8)
                game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,996)
            end
        end
    end)

    other:NewButton("Kill Enemies (Recommended)", "Kills enemies", function()
        while wait() do 
        for i,v in pairs(game.Workspace.BadGuys:GetChildren()) do
            game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v, 8)
        end
    end
    end)

    other:NewButton("Basement Lights", "Turns on basement lights", function()
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.BasementMission
        Event:FireServer()

        local Event = game:GetService("ReplicatedStorage").RemoteFunctions.GetAmbient
        Event:InvokeServer()
    end)

    other:NewButton("Basement Key", "Gives you the basement key", function()
        game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Key")
    end)

    other:NewButton("Unlock Basement", "Unlocks basement", function()
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.UnlockDoor
        Event:FireServer()
    end)


    other:NewButton("Auto Heal", "Auto heals you", function()
        local Target = game:GetService("ReplicatedStorage").RemoteEvents.Cattery;
        Target:FireServer();
        for i = 1, 200 do
            wait(0.0001)
            local A_1 = "Cat"
            local Event = game:GetService("ReplicatedStorage").RemoteEvents.Energy
            Event:FireServer(A_1)
        end
    end)

    other:NewButton("Remove Tools", "Removes your tools", function()
        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                v:Destroy()
            end
        end
    end)

    other:NewButton("Open Safe", "Open safe", function()
        game.ReplicatedStorage.RemoteEvents.Safe:FireServer(game:GetService("Workspace").CodeNote.SurfaceGui.TextLabel.Text)
    end)
    
    other:NewButton("Find Safe", "Finds the safe behind paintings", function()
        
local A_1 = "http://www.roblox.com/asset/?id=3246691515"
local Event = game:GetService("ReplicatedStorage").RemoteEvents.PaintingClicked
Event:FireServer(A_1)

local A_1 = "rbxassetid://319s5645674"
local Event = game:GetService("ReplicatedStorage").RemoteEvents.PaintingClicked
Event:FireServer(A_1)

local A_1 = "http://www.roblox.com/asset/?id=363240671"
local Event = game:GetService("ReplicatedStorage").RemoteEvents.PaintingClicked
Event:FireServer(A_1)

local A_1 = "http://www.roblox.com/asset/?id=178210631"
local Event = game:GetService("ReplicatedStorage").RemoteEvents.PaintingClicked
Event:FireServer(A_1)

local A_1 = "rbxassetid://3195645922"
local Event = game:GetService("ReplicatedStorage").RemoteEvents.PaintingClicked
Event:FireServer(A_1)

    end)

    other:NewButton("Safe Code", "Gives you the safe code", function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Notification";
            Text = game:GetService("Workspace").CodeNote.SurfaceGui.TextLabel.Text;
        })
    end)
    
    other:NewButton("Search Attic", "Searches attic for you", function()
        local A_1 = 1
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.BloxyPack
        Event:FireServer(A_1)
    end)

    other:NewButton("Get Ladder", "Gets ladder for you", function()
        local A_1 = 1
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.Ladder
        Event:FireServer(A_1)
    end)

    
    local endingstab = Window:NewTab("Endings")
    local endingssec = endingstab:NewSection("Endings")
    
    endingssec:NewButton("Final Ending", "Gives you the final ending", function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Notification";
            Text = "Giving key...";
            Icon = "rbxassetid://3042225189";
        })
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.GetKeys
        Event:FireServer()
    end)
    
    endingssec:NewButton("Easter Ending", "ONLY WORKS WHEN THERE IS ICE", function()
        while true do
        wait(.5)
        local A_11 = 1
        local A_111 = "IcePart2"
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.EggHuntEvent
        Event:FireServer(A_11, A_111)

        local A_2 = 2
        local A_22 = "IcePart8"
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.EggHuntEvent
        Event:FireServer(A_2, A_22)

        local A_3 = 3
        local A_34 = "IcePart1"
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.EggHuntEvent
        Event:FireServer(A_3, A_34)
        end
    end)

    


               -- Misc
    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")

    PlayerSection:NewTextBox("Walkspeed", "How fast you want to walk", function(txt)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = txt
    end)

    PlayerSection:NewTextBox("Jumppower", "How high you want to jump", function(txt)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = txt
    end)

    PlayerSection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)

    PlayerSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end)
    
    PlayerSection:NewButton("Reset character", "Kills you lol", function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end)
    
    PlayerSection:NewButton("Infinite Jump", "Infinite jump", function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
        	if InfiniteJumpEnabled then
        		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        	end
        end)
    end)

    local Keybind = Window:NewTab("Keybind")
    local keybindsection = Keybind:NewSection("Keybind")

    keybindsection:NewKeybind("Click to set keybind", "Click to set keybind", Enum.KeyCode.F, function()
        Library:ToggleUI()
    end)


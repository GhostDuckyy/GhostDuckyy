--// Source is minified | url: https://goonlinetools.com/lua-beautifier/ ( optimize source )
if not game:IsLoaded()then game.Loaded:Wait()task.wait(4)end;do if game.PlaceId~=11746859781 then return end;local a=loadstring(game:HttpGet("https://github.com/GhostDuckyy/GhostDuckyy/blob/main/UI/Elerium%20V2.lua?raw=true"))()local b=a:AddWindow("Bubble Gum Simulator / Ghost-Ducky#7698",{main_color=Color3.fromRGB(200,0,0),min_size=Vector2.new(400,380),toggle_key=Enum.KeyCode.RightControl,can_resize=true})local c={main=b:AddTab("Main")}local d=game:GetService("Players")local e=d.LocalPlayer;local f=require(game:GetService("ReplicatedStorage"):WaitForChild("Nevermore"):WaitForChild("Library"))getgenv().Setting={autoblow=false,autocollect=false}c.main:AddLabel("Automatics")c.main:AddSwitch("Auto blow bubble gum",function(g)Setting.autoblow=g;if g then AutoBlow()end end)c.main:AddSwitch("Auto collect drops",function(g)Setting.autocollect=g;if g then task.spawn(function()local h=workspace:WaitForChild("Stuff"):WaitForChild("Pickups")if h~=nil and e.Character then for i,j in next,h:GetDescendants()do if j:IsA("MeshPart")then task.spawn(function()pcall(function()firetouchinterest(j,e.Character.PrimaryPart,0)task.wait(.1)firetouchinterest(j,e.Character.PrimaryPart,1)end)end)end end end end)end end)c.main:AddButton("Sell bubble",function()local k=workspace:WaitForChild("MAP"):WaitForChild("Activations"):WaitForChild("Sell 1")local l=nil;if k~=nil and e.Character~=nil then l=e.Character.PrimaryPart.CFrame;e.Character.PrimaryPart.CFrame=k.CFrame;task.wait(.1)if f.Network and type(f.Network)=="table"then f.Network.Fire("Sell Bubbles")end;task.wait(.1)e.Character.PrimaryPart.CFrame=l end end)c.main:AddButton("Claim all chests",function()local m=workspace:WaitForChild("MAP"):WaitForChild("Activations")local n=workspace:WaitForChild("MAP"):WaitForChild("Chests")if m~=nil and n~=nil and e.Character~=nil then local o=m:GetChildren()for i=1,#o do local j=o[i]if j.Name:find("Chest")and j.Name:sub(1,3):lower()~="vip"then if n:FindFirstChild(j.Name)then e.Character.PrimaryPart.CFrame=j.CFrame;task.wait(.2)if f.Network and type(f.Network)=="table"then f.Network.Fire("Collect Chest",j.Name)end;task.wait(.2)end end end end end)c.main:AddButton("Unlock all islands",function()local p=workspace:WaitForChild("MAP"):WaitForChild("Teleports")if p~=nil and e.Character~=nil then local o=p:GetChildren()for i=1,#o do if o[i]:IsA("Part")and o[i].Name:lower()~="spawn"then e.Character.PrimaryPart.CFrame=o[i].CFrame*CFrame.new(0,2,0)task.wait(.2)end end end end)c.main:AddLabel("Locations")local q=c.main:AddDropdown("[ Islands List ]",function(g)local r=workspace:WaitForChild("MAP"):WaitForChild("Teleports")if r~=nil and e.Character~=nil then for i,j in next,r:GetChildren()do if j:IsA("Part")and j.Name==g then e.Character.PrimaryPart.CFrame=j.CFrame*CFrame.new(0,2,0)end end end end)local s=c.main:AddDropdown("[ Eggs List ]",function(g)local t=workspace:WaitForChild("MAP"):WaitForChild("Eggs")if t~=nil and e.Character~=nil then for i,j in next,t:GetChildren()do if j:IsA("Model")and j.PrimaryPart~=nil then if j.Name==g then e.Character.PrimaryPart.CFrame=j.PrimaryPart.CFrame*CFrame.new(0,5,0)end end end end end)c.main:AddLabel("UI made by Singularity#5490")function AutoBlow()task.spawn(function()while task.wait(.1)do if not Setting.autoblow then return end;if f.Network and type(f.Network)=="table"then f.Network.Fire("Blow Bubble")end end end)end;do if workspace:WaitForChild("MAP"):WaitForChild("Teleports")~=nil then for i,j in next,workspace:WaitForChild("MAP"):WaitForChild("Teleports"):GetChildren()do if j:IsA("Part")then q:Add(j.Name)end end end;if workspace:WaitForChild("MAP"):WaitForChild("Eggs")~=nil then for i,j in next,workspace:WaitForChild("MAP"):WaitForChild("Eggs"):GetChildren()do if j:IsA("Model")and j.PrimaryPart~=nil then s:Add(j.Name)end end end;if workspace:WaitForChild("Stuff"):WaitForChild("Pickups")~=nil then workspace:WaitForChild("Stuff"):WaitForChild("Pickups").DescendantAdded:Connect(function(j)task.wait(.5)if e.Character==nil or Setting.autocollect then return end;if j:IsA("MeshPart")then task.spawn(function()pcall(function()firetouchinterest(j,e.Character.PrimaryPart,0)task.wait(.1)firetouchinterest(j,e.Character.PrimaryPart,1)end)end)end end)end;c.main:Show()a:FormatWindows()end end

-- @ScriptType: ModuleScript
local util = {}

local ts = game:GetService("TweenService")
function util.tweenModel(model :Model,tweenTime,frame)
	local val = Instance.new("CFrameValue",model)
	val.Value = model:GetPrimaryPartCFrame()

	val.Changed:Connect(function(new)
		model:SetPrimaryPartCFrame(new)
	end)
	local tween = ts:Create(val,TweenInfo.new(tweenTime,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Value=frame}) 
	tween:Play()
	tween.Completed:Wait()
	val:Destroy()
end

function Format(Int)
	return string.format("%02i", Int)
end
function util.deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = util.deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

local items = require(script.Parent:WaitForChild("Items"))
function util.LoadEquipment(plr)
	local GameBuffs = {
		RedBoost = 0,
		BlueBoost = 0,
		WhiteBoost = 0,
		WhiteHoney = 0,
		BlueHoney = 0,
		RedHoney = 0,
		["MovementCollection"] = 0,
		["PlayerMovespeed"] = 16,
		["PlayerJumpPower"] = 50,
		["Health"] = 100,
		["MaxHealth"] = 100,
		ConvertVisualGUIRate = 0
	}

	plr.Character.Humanoid:UnequipTools()
	plr.Backpack:ClearAllChildren()
	local equipment = _G.PlayerData[plr.Name].Equipment
	for _,v in pairs(plr.Character:GetChildren()) do
		if v:IsA("Accessory") and v:FindFirstChild("Update") then
			v:Destroy()
		end
	end
	for _,v in pairs(plr.Character:GetChildren()) do
		if v and v:IsA("Accessory") and v:FindFirstChild("Boots") and v.Name == "Left" or v and v:IsA("Accessory") and v:FindFirstChild("Boots") and v.Name == "Right" then
			_G.PlayerData[plr.Name].GameBuffs.MovementCollection -= ((items[v.Boots.Value].MovementCollection)/2)
			v:Destroy()
		end
	end
	local tools = game.ReplicatedStorage.Assets.Tools
	local bags = game.ReplicatedStorage.Assets.Bags
	if equipment["Tool"] ~= "" then
		local Tool = tools[equipment.Tool]:Clone()
		Tool.Parent = plr.Backpack
		for _,v in pairs(game.ServerStorage.ToolScripts:GetChildren()) do
			v:Clone().Parent = Tool
		end
	end
	if equipment["Bag"] ~= "" then
		local Tool = bags[equipment.Bag]:Clone()
		Tool.Parent = plr.Character
		for _,v in pairs(game.ServerStorage.BagScripts:GetChildren()) do
			v:Clone().Parent = Tool
		end
		plr.Cap.Value = items[equipment.Bag].Capacity
		_G.PlayerData[plr.Name].Stats.Capacity = items[equipment.Bag].Capacity
	end
	if equipment["Boots"] ~= "" then
		for i,v in pairs(game.ReplicatedStorage.Assets.Boots[equipment.Boots]:GetChildren()) do
			local Tool = v:Clone()
			Tool.Parent = plr.Character
		end
		_G.PlayerData[plr.Name].GameBuffs.MovementCollection += items[equipment.Boots].MovementCollection
	end
	if equipment["Mask"] ~= "" then
		local Tool = game.ReplicatedStorage.Assets.Masks[equipment.Mask]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["Belt"] ~= "" then
		local Tool = game.ReplicatedStorage.Assets.Belt[equipment.Belt]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["RightGuards"] ~= "" then
		local Tool = game.ReplicatedStorage.Assets.RightGuards[equipment.RightGuards]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["LeftGuards"] ~= "" then
		local Tool = game.ReplicatedStorage.Assets.LeftGuards[equipment.LeftGuards]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["Amulet"] ~= "" then
		local Tool = game.ReplicatedStorage.Assets.Amulets[equipment.Amulet]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["Parachutes"] ~= "" then
		local Tool = game.ReplicatedStorage.Assets.Parachutes[equipment.Parachutes]:Clone()
		Tool.Parent = plr.Character
	end
end
function util.Explosion(p,ExplosionColor)
	local pos = p-Vector3.new(0,3,0)
	local p1 = game.ReplicatedStorage.Assets.Misc.Explode_Template:Clone()
	p1.Position = pos
	p1.Parent = workspace.Debris.Misc
	p1.Size = Vector3.new(0.1,0.1,0.1)
	p1.Transparency = 0
	p1.Color = ExplosionColor
	ts:Create(p1,TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=Vector3.new(4*6,4*6,4*6),Transparency=1}):Play()
	local p2 = game.ReplicatedStorage.Assets.Misc.Explode_Template:Clone()
	p2.Position = pos
	p2.Size = Vector3.new(0.1,0.1,0.1)
	p2.Transparency = 0
	p2.Parent = workspace.Debris.Misc
	p2.Color = ExplosionColor
	ts:Create(p2,TweenInfo.new(0.65,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=Vector3.new(4*5,4*5,4*5),Transparency=1}):Play()
	game.Debris:AddItem(p1,0.6)
	game.Debris:AddItem(p2,0.71)
end
function util.Tweening(instance, Time, EasingStyle, EasingDirection, Property)
	game:GetService("TweenService"):Create(instance, TweenInfo.new(Time, EasingStyle, EasingDirection), Property)
end
function util.convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end
function util.AddTimer(plr,field)
	spawn(function()
		workspace.Fields[field].Spawner.Spawn.Time.Enabled = true
		local data = game.ReplicatedStorage.Remotes.GetData:InvokeServer()
		repeat wait(1)
			workspace.Fields[field].Spawner.Spawn.Time.Time.Text = util.convertToHMS(data.Bosses[field].EndTime-os.time())
		until data.Bosses[field].EndTime <= os.time()
		workspace.Fields[field].Spawner.Spawn.Time.Enabled = false
	end)
end
function util.Line(p1,p2,color)
	local m = (p1 - p2).Magnitude
	local p = Instance.new("Part",workspace)
	p.Name = "Line"
	p.Anchored = true
	p.CanCollide = false
	p.Material = Enum.Material.Neon
	local distance = (p1 - p2).Magnitude
	p.Size = Vector3.new(0.25, 0.25, distance)
	p.CFrame = CFrame.lookAt(p1, p2)*CFrame.new(0, 0, -distance/2)
	if color then
		p.Color = color
	else
		p.Color = Color3.fromRGB(255,255,255)
	end
	game.Debris:AddItem(p,0.6)
end


function util.comma(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
return util

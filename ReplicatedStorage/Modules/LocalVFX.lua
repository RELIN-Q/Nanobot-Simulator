-- @ScriptType: ModuleScript
local FX = {}

local rp = game:GetService("ReplicatedStorage")
local ts = game:GetService('TweenService')
local debris = game:GetService("Debris")
local library = require(rp.Modules:WaitForChild("Items"))
local flowermodule = require(rp.Modules:WaitForChild("FlowerScript"))

function Format(Int)
	return string.format("%02i", Int)
end

function convertToMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	return Format(Minutes)..":"..Format(Seconds)
end
function Pick2(tab,luck)
	local tw = 0
	for _,v in pairs(tab) do
		tw += v[1]	
	end
	print(luck)
	local R = Random.new():NextInteger(1,tw-Random.new():NextNumber(0,luck*10))
	local Chance = 0
	for i,v in pairs(tab) do
		Chance += v[1]
		if R <= Chance then
			return i,math.random(v[2],v[3])
		end
	end
end
function arrangePuffshroomLoot(luckfactor)
	local loot = {}
	for i = 1,math.random(5,15) do
		local item,amnt = Pick2(library.Puffdrops,luckfactor)
		if item ~= nil then
			table.insert(loot,{item,amnt})
		end
	end
	return loot
end
function getCloseFlowerToPlayer(root,field)
	local flrs = {}
	if field ~= "" then
		for _,v in pairs(workspace.Fields[field]:GetChildren()) do
			if v and v:FindFirstChild("Amnt") then
				if v and (v.Position-root).magnitude <= 20 then
					table.insert(flrs,v)
				end
			end
		end
	end
	if #flrs >= 1 then
		return flrs[math.random(1,#flrs)]
	end
end
function spawnLoot(loot,field,pos)
	for i,v in pairs(loot) do
		local flr = getCloseFlowerToPlayer(pos,field)
		require(script.Parent:WaitForChild("TokenModule")).new("All",Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y-0.3+.7+3.323,flr.Position.Z),v[1],nil,v[2])
	end
end
function getClosestFieldToPuff(root)
	for _,v in pairs(workspace.Fields:GetChildren()) do
		if root and (root-v.FieldBox.Position).magnitude <= 110 then
			return v.Name
		end
	end
end
FX["Puffshroom"] = function(data)
	local shroom = data.Puffshroom
	local level = data.Level
	local pos = data.CFrame
	local _time_ = data.Time
	if level > 13 then
		level = 13
	end
	if level <= 0 then
		level = 1
	end
	local levelScaleFactor = (level+1)/2
	
	if levelScaleFactor < 1 then levelScaleFactor = 1 end
	local puffshroom = rp.Assets.Puffshrooms[shroom]:Clone()
	puffshroom.Parent = workspace.Puffshrooms
	puffshroom.Name = shroom
	puffshroom:ScaleTo(0.25)
	puffshroom.PrimaryPart = puffshroom.Bottom
	puffshroom:SetPrimaryPartCFrame(pos)
	
	local puffdata = puffshroom.Top.Attachment.Puffdata
	local rairty = string.gsub(shroom," Puffshroom","")
	puffdata.Bar.Label.Text = "🌸 0/"..library[rairty][level]
	puffdata.BarTime.Label.Text = "⌛ "..convertToMS(_time_)
	puffdata.Puffname.Text = shroom.." (Lvl "..level..")"
	puffshroom.Time.Value = _time_
	puffdata.BarTime.Fill.Size = UDim2.fromScale(_time_/300,1)
	puffshroom.Time.Changed:Connect(function(new)
		puffdata.BarTime.Label.Text = "⌛ "..convertToMS(math.round(new))
	end)
	
	ts:Create(puffshroom.Time,TweenInfo.new(_time_,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Value=0}):Play()
	ts:Create(puffdata.BarTime.Fill,TweenInfo.new(_time_,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=UDim2.fromScale(0,1)}):Play()
	
	puffshroom.Level.Value = level
	puffshroom.MaxHealth.Value = library[rairty][level]
	puffshroom.Health.Value = 0

	local scale = Instance.new("NumberValue",puffshroom)
	scale.Name = "Scale"
	scale.Value = 0.25
	
	scale.Changed:Connect(function(value)
		if value <= 0 then
			value = 0.05
		end
		puffshroom:ScaleTo(value)
		puffshroom:SetPrimaryPartCFrame(pos*CFrame.new(0,puffshroom.PrimaryPart.Size.Y/2,0))
	end)
	
	local scaleTween = ts:Create(scale,TweenInfo.new(0.8,Enum.EasingStyle.Elastic,Enum.EasingDirection.In),{Value=levelScaleFactor})
	scaleTween:Play()
	local connection
	connection = scaleTween.Completed:Connect(function()
		connection:Disconnect()
		scale:Destroy()
	end)
	local breaked = false
	delay(_time_+0.1,function()
		puffshroom:Destroy()
		return
	end)
	puffshroom.Health.Changed:Connect(function(new)
		puffdata.Bar.Fill.Size = UDim2.fromScale(new/library[rairty][level],1)
		puffdata.Bar.Label.Text = "🌸 "..math.round(new).."/"..library[rairty][level]
		if new >= library[rairty][level] and breaked == false then
			breaked = true
			local loot = arrangePuffshroomLoot(library[shroom])
			
			local field = getClosestFieldToPuff(pos.Position)
			spawnLoot(loot,field,pos.Position)
			for i = 1,math.random(1,3) do
				local flower,field = flowermodule.GetRandomFlowerAndField()
				if flower and field then
					FX["Puffball"]({
						StartPos = pos.Position,
						EndPos = flower.Position,
						Level = level+math.random(-1,1),
			            Time = puffshroom.Time.Value
					})
				end
			end
			puffshroom:Destroy()
		end
	end)
	return
end

function lerp(a, b, t)
	return a + (b - a) * t
end

function quadraticBezier(t, p0, p1, p2)
	local l1 = lerp(p0, p1, t)
	local l2 = lerp(p1, p2, t)
	local quad = lerp(l1, l2, t)
	return quad
end
function Pick(tab)
	local tw = 0
	for _,v in pairs(tab) do
		tw += v		
	end

	local R = Random.new():NextInteger(1,tw)
	local Chance = 0
	for i,v in pairs(tab) do
		Chance += v
		if R <= Chance then
			return i
		end
	end
end
FX["Puffball"] = function(data)
	spawn(function()
		local _startpos_ = data.StartPos
		local _endPos_ = data.EndPos
		local _level_ = data.Level
		local _time_ = data.Time
		local _magnitude_ = (_startpos_-_endPos_).Magnitude
		local _shroom_ = Pick(library.PuffChance)
		if _shroom_ == nil then
			_shroom_ = "Common Puffshroom"
		end
		local puffball = rp.Assets.Misc["Puffball"]:Clone()
		puffball.Parent = workspace.Debris
		print(_magnitude_)
		puffball.Position = _startpos_
		local direction = (_startpos_-_endPos_)
		ts:Create(puffball,TweenInfo.new(8,Enum.EasingStyle.Linear,Enum.EasingDirection.In,50),{Orientation=Vector3.new(361,361,361)}):Play()
		for i = 1,50 do
			local position = quadraticBezier(i/50,_startpos_,_startpos_+(-direction/2)+Vector3.new(0,direction.Magnitude/2,0),_endPos_)
			local t = ts:Create(puffball,TweenInfo.new((puffball.Position-position).Magnitude/24,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Position=position})
			t:Play()
			t.Completed:Wait()
		end
		FX["Puffshroom"]({
			CFrame = CFrame.new(_endPos_),
			Level = _level_,
			Puffshroom =_shroom_,
			Time=_time_
		})
		puffball:Destroy()
	end)
	return
end

return FX

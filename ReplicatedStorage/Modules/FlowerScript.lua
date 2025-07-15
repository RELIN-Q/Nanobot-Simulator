-- @ScriptType: ModuleScript
local flower = {}
flower.Amount = {
	Small = 1,
	Low = 2,
	Medium = 3,
	Big = 4,
	Huge = 10
}
flower.Fields = {
	["Clover Field"] = {
		FlowerSize = {
			Small = 51,
			Low = 49,
			Medium = 0,
			Big = 0,
			Huge = 0
		},
		FlowerColor = {
			White = 16,
			Red = 18,
			Blue = 17
		}
	},
	["Pepper Field"] = {
		FlowerSize = {
			Small = 0,
			Low = 40,
			Medium = 60,
			Big = 0,
			Huge = 0
		},
		FlowerColor = {
			White = 25,
			Red = 75,
			Blue = 0
		}
	},
	["Bamboo Field"] = {
		FlowerSize = {
			Small = 36,
			Low = 54,
			Medium = 10,
			Big = 0,
			Huge = 0
		},
		FlowerColor = {
			White = 30,
			Red = 0,
			Blue = 70
		}
	}
}

function flower.Pick(tab)
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

function flower.LoadField(fieldName)
	local fieldFolder = workspace.Fields[fieldName]
	local fieldTable = flower.Fields[fieldName]
	local Box = fieldFolder.FieldBox
	if Box.GenerateType.Value == "Box" then
	local XSize = (Box.Size.X)
	local ZSize = (Box.Size.Z)
	local StartPos = Box.Position+Vector3.new((Box.Size.X/2),0,(Box.Size.Z/2))
	XSize = math.abs(XSize)
	ZSize = math.abs(ZSize)
	
	for x = 0,ZSize/4 do
		for z = 0,XSize/4 do
			local ChosenFlowerSize = flower.Pick(fieldTable.FlowerSize)
			local ChosenFlowerColor = flower.Pick(fieldTable.FlowerColor)
			if ChosenFlowerSize and ChosenFlowerColor then
				local part = game.ReplicatedStorage.Assets.Flowers[ChosenFlowerColor][ChosenFlowerSize]:Clone()
				part.Parent = fieldFolder
				part.Name = "FlowerPart"
				local Amount = Instance.new("IntValue",part) Amount.Name = "Amnt" Amount.Value = flower.Amount[ChosenFlowerSize]
				local FlowerColor = Instance.new("StringValue",part) FlowerColor.Name = "FlowerColor" FlowerColor.Value = ChosenFlowerColor
				part.Position = StartPos-Vector3.new(z*4,0,x*4)
			end
		end 
		end
	elseif Box.GenerateType.Value == "Index" then
		local startPos = Box.Position
		local T = Instance.new("Part",workspace.Debris)
		T.Anchored = true
		T.Name = "FieldLoader"
		T.CanCollide = false
		T.Position = startPos
		T.Transparency = 1
		T.Size = Vector3.new(4,2.5,4)
		--Create Flower
		for i,v in pairs(Box:GetChildren()) do
			if v.Name == "index_pos" then
				local ChosenFlowerSize = flower.Pick(fieldTable.FlowerSize)
				local ChosenFlowerColor = flower.Pick(fieldTable.FlowerColor)
				if ChosenFlowerSize and ChosenFlowerColor then
					local part = game.ReplicatedStorage.Assets.Flowers[ChosenFlowerColor][ChosenFlowerSize]:Clone()
					part.Parent = fieldFolder
					part.Name = "FlowerPart"
					local Amount = Instance.new("IntValue",part) Amount.Name = "Amnt" Amount.Value = flower.Amount[ChosenFlowerSize]
					local FlowerColor = Instance.new("StringValue",part) FlowerColor.Name = "FlowerColor" FlowerColor.Value = ChosenFlowerColor
					part.Position = Vector3.new(v.Position.X,startPos.Y,v.Position.Z)
				end 
				v:Destroy()
			end
		end
	end
	Box.Transparency = 1
end

function flower.LoadAllFields()
	for i,v in pairs(flower.Fields) do
		flower.LoadField(i)
	end
end
function flower.Spawner(func,...)
	local co = coroutine.wrap(func)
	co(...)
end
function flower.TriggerRegen()
	while true do
		for _,v in pairs(workspace.Fields:GetChildren()) do
			for _,flr in pairs(v:GetChildren()) do
				if flr:IsA("BasePart") and flr:FindFirstChild("FlowerColor") and flr:FindFirstChild("TopTexture") then
					if flr.Position.Y < v.FieldBox.Position.Y then
						flr.Position += Vector3.new(0,0.25,0)
						flr["TopTexture"].Transparency -= 0.1
						if flr.Position.Y >= v.FieldBox.Position.Y then
							flr["TopTexture"].Transparency = 0
							flr.Position = Vector3.new(flr.Position.X,v.FieldBox.Position.Y,flr.Position.Z)
						end
					else
						flr["TopTexture"].Transparency = 0
						flr.Position = Vector3.new(flr.Position.X,v.FieldBox.Position.Y,flr.Position.Z)
					end
				end
			end
		end
		task.wait(workspace.GameData.RegenSpeed.Value)
	end
end
local toolModule = require(script.Parent:WaitForChild("Items"))
function GetTouchingParts(part)
	local connection = part.Touched:Connect(function() end)
	local results = part:GetTouchingParts()
	connection:Disconnect()
	return results
end
function flower.Collect(plr,flr,power)
	local char = plr.Character
	local root = char.HumanoidRootPart
	local data = _G.PlayerData[plr.Name]
	local tool = data.Equipment.Tool
	local module = toolModule[tool]
	if flr and flr:FindFirstChild("FlowerColor") and flr:FindFirstChild("TopTexture") and flr.Position.Y > flr.Parent.FieldBox.Position.Y-2.14 then
		flr.Position -= Vector3.new(0,power,0)
		flr.TopTexture.Transparency += (power/2.2)

		if flr.Position.Y <= flr.Parent.FieldBox.Position.Y-2.14 then
			flr.Position = Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y-2.14,flr.Position.Z)
			flr.TopTexture.Transparency = 1
		end
		
		return flr.Amnt.Value*(power*10),flr.FlowerColor.Value
	end
end

function flower.PatternAngle(root)
	local number = root.Orientation.Y
	return math.round(number / 90) * 90
end
function getClosestPuffshroom(start,range,pollenMade)
	for _,v in pairs(workspace.Puffshrooms:GetChildren()) do
		if v and (v.PrimaryPart.Position-start).magnitude <= range then
			v.Health.Value += pollenMade
		end
	end
	return nil
end
function getClosestSprout(start, range, pollenMade)
	local closestSprout = nil
	local closestDistance = math.huge

	for _, sprout in pairs(workspace.Sprouts:GetChildren()) do
		if sprout and sprout:IsA("MeshPart") then
			local sproutPosition = sprout.Position
			local distance = (sproutPosition - start).magnitude

			if distance <= range and distance < closestDistance then
				closestSprout = sprout
				closestDistance = distance
			end
		end
	end

	if closestSprout then
		local health = closestSprout:FindFirstChild("Health")
		local billboardGui = closestSprout:FindFirstChild("BillboardGui1")
		if health and billboardGui then
			health.Value = math.max(health.Value - pollenMade, 0)
			local textLabel = billboardGui:FindFirstChild("TextLabel1")
			if textLabel then
				textLabel.Text = require(game.ReplicatedStorage.Modules.Utils).comma( health.Value).. "🌸"
			end
		end
	end

	return closestSprout
end
local library = require(game.ReplicatedStorage.Modules:WaitForChild("Items"))
local qModule = require(game.ReplicatedStorage.Modules:WaitForChild("QuestModule"))
local settingsmod = require(game.ReplicatedStorage.Modules:WaitForChild("Settings"))

function flower.CreatePattern(plr,pattern,obj,scale,patternName,Boosts)
	local char = plr.Character
	local root = char.HumanoidRootPart
	local data = _G.PlayerData[plr.Name]
	local tool = data.Equipment.Tool
	local module = toolModule[tool]
	local critical = false
	if plr and char.Humanoid.Health >= 1 and data.Stats.Pollen < data.Stats.Capacity then
		local model = game.ReplicatedStorage.Assets.Patterns[patternName]:Clone()
		model.Parent = workspace.Debris.Patterns
		model.Size = Vector3.new(model.Size.X*scale,model.Size.Y,model.Size.Z*scale)
		model.CFrame = CFrame.new(obj.Position.X,obj.Position.Y-2.7,obj.Position.Z)*CFrame.Angles(0,math.rad(flower.PatternAngle(obj)),0)*CFrame.new(0,0,-model.PivotOffset.Position.Z)
		game.Debris:AddItem(model,.5)
		local maskBoosts = {}
		local beltBoosts = {}
		local leftguardBoosts = {}
		local rightguardBoosts = {}
		local amuletsBoosts = {}
		local totals = {
			Total = 0,
			Honey = 0,
			BlueHoney = 0,
			WhiteHoney = 0,
			RedHoney = 0,
			White = 0,
			Red = 0,
			Blue = 0,
			Gum = 0,
			Damage = 0
		}
		local critchance = {
			["Mask"] = 0,
			["Belt"] = 0,
			["LeftGuards"] = 0,
			["RightGuards"] = 0,
			["Amulets"] = 0
		}
		local critPower = {
			["Mask"] = 1,
			["Belt"] = 1,
			["LeftGuards"] = 1,
			["RightGuards"] = 1,
			["Amulets"] = 1
		}
		if data.Equipment.Mask ~= "" then
			maskBoosts = library[data.Equipment.Mask]
			critchance.Mask = library[data.Equipment.Mask].CritChance
			critPower.Mask = library[data.Equipment.Mask].CritPower
		end
		if data.Equipment.Belt ~= "" then
			beltBoosts = library[data.Equipment.Belt]
			critchance.Belt = library[data.Equipment.Belt].CritChance
			critPower.Belt = library[data.Equipment.Belt].CritPower
		end
		if data.Equipment.LeftGuards ~= "" then
			leftguardBoosts = library[data.Equipment.LeftGuards]
			critchance.LeftGuards = library[data.Equipment.LeftGuards].CritChance
			critPower.LeftGuards = library[data.Equipment.LeftGuards].CritPower
		end
		if data.Equipment.RightGuards ~= "" then
			rightguardBoosts = library[data.Equipment.RightGuards]
			critchance.RightGuards = library[data.Equipment.RightGuards].CritChance
			critPower.RightGuards = library[data.Equipment.RightGuards].CritPower
		end
		if data.Equipment.Amulet ~= "" then
			amuletsBoosts = library[data.Equipment.Amulet]
			critchance.Amulet = library[data.Equipment.Amulet].CritChance
			critPower.Amulet = library[data.Equipment.Amulet].CritPower
		end
		local flowers = GetTouchingParts(model)
		for _,flr in pairs(flowers) do
			if flr and flr:FindFirstChild("FlowerColor") then
				local amnt,clr = flower.Collect(plr,flr,Boosts.Power)
				if amnt and clr then
					local MoveBoost = data.GameBuffs["MovementCollection"]
					if pattern ~= "Boots" then
						MoveBoost = 1
					end
					local totalPercentPollen = (Boosts[clr.."Rate"]+data.GameBuffs[clr.."Boost"])
					if data.Equipment.Mask ~= "" then
						totalPercentPollen = (Boosts[clr.."Rate"]+data.GameBuffs[clr.."Boost"]+maskBoosts[clr.."Rate"])
					end
					if data.Equipment.Belt ~= "" then
						totalPercentPollen = (Boosts[clr.."Rate"]+data.GameBuffs[clr.."Boost"]+beltBoosts[clr.."Rate"])
					end
					if data.Equipment.LeftGuards ~= "" then
						totalPercentPollen = (Boosts[clr.."Rate"]+data.GameBuffs[clr.."Boost"]+leftguardBoosts[clr.."Rate"])
					end
					if data.Equipment.RightGuards ~= "" then
						totalPercentPollen = (Boosts[clr.."Rate"]+data.GameBuffs[clr.."Boost"]+rightguardBoosts[clr.."Rate"])
					end
					if data.Equipment.Amulet ~= "" then
						totalPercentPollen = (Boosts[clr.."Rate"]+data.GameBuffs[clr.."Boost"]+amuletsBoosts[clr.."Rate"])
					end
					local pollenMade = ((math.round(amnt)/100)*totalPercentPollen)+math.round(amnt*MoveBoost)
					local defaultCritChance = 1000
					if math.random(1,defaultCritChance)<=1+critchance.Amulets+critchance.Mask+critchance.Belt+critchance.LeftGuards+critchance.RightGuards then
						critical = true
						pollenMade*=(critPower.Mask+critPower.Amulets+critPower.Belt+critPower.LeftGuards+critPower.RightGuards)
					end
					if obj and obj:FindFirstChild("Owner") and obj:FindFirstChild("Level") and obj:FindFirstChild("Wings") and  obj:FindFirstChild("Gifted") then
						if obj:FindFirstChild("Gifted").Value then
							pollenMade *= settingsmod.GiftedBeesSettings.GiftedBeePollenBuff
						end
					end
					print(pollenMade)
					if data.FieldBoosts and plr.Field.Value ~= "" then
						if data.FieldBoosts[plr.Field.Value] then
							pollenMade *= data.FieldBoosts[plr.Field.Value]
							print(pollenMade.. " After")
						end
					end
					totals[clr] += pollenMade
					totals.Total += pollenMade
					if flr:FindFirstChild("Gum") then
						totals["Gum"] += pollenMade
					end
					getClosestPuffshroom(model.Position,24,pollenMade)
					getClosestSprout(model.Position,50,pollenMade)
					local totalPercent = (Boosts[clr.."ConvertRate"]+data.PlayerBuffs["InstantConvertionRate"]+data.GameBuffs[clr.."Honey"]+Boosts["ConvertionRate"])
					if totalPercent > 0 then
						local honeyMade = ((pollenMade/100)*totalPercent)+pollenMade
						if flr:FindFirstChild("Gum") then
							honeyMade = ((pollenMade/100)*(totalPercent+40))+pollenMade
						end
						totals[clr.."Honey"] += honeyMade
					end
				end
			end
		end
		totals.Honey = math.round(totals.RedHoney+totals.BlueHoney+totals.WhiteHoney)
		local rc = data.Stats.Capacity - data.Stats.Pollen
		if totals.Total > rc then
			totals.Total = rc
		end
		data.Stats.Pollen += totals.Total
		data.Stats.Honey += totals.Honey
		qModule.Update(plr,{Field=plr.Field.Value,Pollen=totals.Total,Red=totals.Red,Blue=totals.Blue,White=totals.White,Gum=totals.Gum,Mob="",Token=""})
		game.ReplicatedStorage.Remotes.VisualPopUp:FireClient(plr,totals,model.Position,false,nil,nil,critical)
	end
end
local flowerColors = {
	Blue = Color3.fromRGB(0, 157, 255),
	Red = Color3.fromRGB(255, 44, 44),
	White = Color3.fromRGB(255, 255, 255),
	Honey = Color3.fromRGB(255, 191, 0),
	Damage = Color3.fromRGB(204, 0, 0)
}
local ts = game:GetService("TweenService")
local function formatNumber(value)
	if value >= 1e33 then
		return string.format("%.1fDD", value / 1e33)
	elseif value >= 1e30 then
		return string.format("%.1fUnD", value / 1e30)
	elseif value >= 1e27 then
		return string.format("%.1fDe", value / 1e27)
	elseif value >= 1e24 then
		return string.format("%.1fNo", value / 1e24)
	elseif value >= 1e21 then
		return string.format("%.1fSx", value / 1e21)
	elseif value >= 1e18 then
		return string.format("%.1fQn", value / 1e18)
	elseif value >= 1e15 then
		return string.format("%.1fQd", value / 1e15)
	elseif value >= 1e12 then
		return string.format("%.1fT", value / 1e12)
	elseif value >= 1e9 then
		return string.format("%.1fB", value / 1e9)
	elseif value >= 1e6 then
		return string.format("%.1fM", value / 1e6)
	elseif value >= 1e3 then
		return string.format("%.1fK", value / 1e3)
	else
		return tostring(value)
	end
end
function flower.PopUp(plr, array, patternPos, ontop)
	local char = plr.Character
	local root = char.HumanoidRootPart
	local clrs = {}
	clrs["Blue"] = array.Blue
	clrs["Red"] = array.Red
	clrs["White"] = array.White
	clrs["Honey"] = array.Honey
	clrs["Damage"] = array.Damage
	table.sort(clrs, function(a, b)
		return b > a
	end)
	local index = 0
	for i, v in pairs(clrs) do
		if v > 0 then
			index += 1
			local p = script.FlowerPopUp:Clone()
			local size = 0
			p.Parent = workspace
			if v >= 9 then
				size = 9
			else
				size = string.len(tostring(math.round(v)))
			end
			p.BillboardGui.Size = UDim2.new(0, 0, 0, 0)
			p.BillboardGui.AlwaysOnTop = ontop
			spawn(function()
				local ns = size / 4
				if size <= 1 then
					ns = size
				else
					ns = size / 6
				end
				local scaleFactor = math.min(2.5, 1 + (math.log10(v) / 7))
				p.BillboardGui.Size = UDim2.new(2 + (ns) / 1.6 * scaleFactor, 0, 0.5 + (ns) / 1.6 * scaleFactor, 0)
				local t1 = ts:Create(p.BillboardGui, TweenInfo.new(0.5), { Size = UDim2.new(2 + (ns) * scaleFactor, 0, 0.5 + (ns) * scaleFactor, 0) }, Enum.EasingDirection.In, Enum.EasingStyle.Quad)
				t1:Play()
				t1.Completed:Wait()
				task.wait(0.1)
				local t2 = ts:Create(p.BillboardGui, TweenInfo.new(0.5), { Size = UDim2.new(0, 0, 0, 0) }, Enum.EasingDirection.In, Enum.EasingStyle.Quad)
				t2:Play()
				t2.Completed:Wait()
			end)
			if i == "Damage" then
				p.BillboardGui.Amnt.Text = "-" .. formatNumber(math.round(v))
			else
				p.BillboardGui.Amnt.Text = "+" .. formatNumber(math.round(v))
			end
			p.BillboardGui.Amnt.TextColor3 = flowerColors[i]
			p.Position = patternPos + Vector3.new(0, 3.7 + ((index) * ((size / 4.6) + 1)), 0) + Vector3.new(0, 1, 0)
			game.Debris:AddItem(p, 1.2)
		end
	end
end
function flower.DamagePopUp(plr,dmg,ontop,StackObject)
	local p = script.FlowerPopUp.BillboardGui:Clone()
	local size = 0
	p.Parent = StackObject.DmgStack
	if dmg >= 9 then
		size = 9
	else
		size = string.len(tostring(math.round(dmg)))
	end
	p.Size = UDim2.new(0,0,0,0)
	p.AlwaysOnTop = ontop
	local stack = #StackObject.DmgStack:GetChildren()
	stack = #StackObject.DmgStack:GetChildren() % 13
	p.Name = "DMG_"..#StackObject.DmgStack:GetChildren()
	spawn(function()
		local ns = size/2
		if size <= 1 then
			ns = size
		else
			ns = size/4
		end
		p.Size = UDim2.new(2+(ns)/1.6, 0,0.5+(ns)/1.6, 0)
		local t1 = ts:Create(p,TweenInfo.new(0.5),{Size=UDim2.new(2+(ns*1.3), 0,0.5+(ns*1.3), 0)},Enum.EasingDirection.In,Enum.EasingStyle.Quad)
		t1:Play()
		t1.Completed:Wait()
		task.wait(0.9)
		local t2 = ts:Create(p,TweenInfo.new(0.5),{Size=UDim2.new(0,0,0,0)},Enum.EasingDirection.In,Enum.EasingStyle.Quad)
		t2:Play()
		t2.Completed:Wait()
	end)
	p.StudsOffsetWorldSpace = StackObject.Health.StudsOffsetWorldSpace + Vector3.new(0,(p.Size.Y.Scale+3)+(stack+1)*2,0)
	p.Amnt.Text = "-"..require(script.Parent:WaitForChild("Utils")).comma(math.round(dmg))
	p.Amnt.TextColor3 = flowerColors["Damage"]
	game.Debris:AddItem(p,1.9)
end

function flower.GetRandomFlowerAndField()
	local field = workspace.Fields:GetChildren()[math.random(1,#workspace.Fields:GetChildren())]
	local flower = nil
	repeat wait()
 flower = field:GetChildren()[math.random(1,#field:GetChildren())]
	until flower ~= nil and flower:FindFirstChild("FlowerColor")
	return flower,field
end

return flower

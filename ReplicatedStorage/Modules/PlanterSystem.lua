-- @ScriptType: ModuleScript
local planter = {}
local rp = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local library = require(rp.Modules:WaitForChild("Items"))
local notify = require(rp.Modules:WaitForChild("NotificationModule"))
function planter.FindSameFieldPlanter(tab,field)
	for i,v in pairs(tab) do
		if v.Field == field then
			return i
		end
end
return nil
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
function planter.Plant(plr,item)
	local field = plr.Field.Value
	if field ~= "" then
	local pos = Vector3.new(plr.Character.PrimaryPart.Position.X,workspace.Fields[field].FieldBox.Position.Y+rp.Assets.Planters[item].PrimaryPart.Size.Y/2,plr.Character.PrimaryPart.Position.Z)
	local PData = _G.PlayerData[plr.Name]
		local PlanterData = PData.Planters
		print(field,planter.FindSameFieldPlanter(PlanterData,field))
		if planter.FindSameFieldPlanter(PlanterData,field) ~= nil then notify.Create(plr,{Message="There is already a planter in this field",Type="Error"}) return end
		if PlanterData[item].Field ~= "" then notify.Create(plr,{Message="There is already a "..item.." in a field",Type="Error"}) return end

		
		
		PlanterData[item].Position.X = pos.X
		PlanterData[item].Position.Y = pos.Y
		PlanterData[item].Position.Z = pos.Z
PData.Inventory[item] -= 1
		PlanterData[item].Field = field
		local p = rp.Assets.Planters[item]:Clone()
		p.Parent = workspace.Planters
		p.Field.Value = field
		PlanterData[item].Level = 0
		p:SetPrimaryPartCFrame(CFrame.new(pos))
		local platform = rp.Assets.Planters.Platform:Clone()
		platform.Parent = p 
		platform:SetPrimaryPartCFrame(CFrame.new((p.PrimaryPart.CFrame*CFrame.new(0,-p.PrimaryPart.Size.Y/2,0).Position))*CFrame.Angles(0,0,math.rad(90)))
		platform.Top.Proxy.ObjectText = plr.Name
		ts:Create(p.Soil.BulbAttach.Progress.Bar.Fill,TweenInfo.new((library[item].Time*3600),Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=UDim2.new(1,0,1,0)}):Play()
		ts:Create(p.Level,TweenInfo.new((library[item].Time*3600),Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Value=100}):Play()
		p.Soil.BulbAttach.Progress.Bar.Label.Text = p.Name.." ("..(0*100).."%"..")"
		p.Level.Changed:Connect(function(new)
			if new > 100 then
				new = 100
			end
			PlanterData[item].Level = new
			p.Soil.BulbAttach.Progress.Bar.Label.Text = p.Name.." ("..new.."%"..")"
		end)
		p.Player.Value = plr.Name
		local plant = rp.Assets.Planters.Plant:Clone()
		local size = 0.1
		if size >= 0 then
			plant.Size = Vector3.new(size,size,size)
			plant.CFrame = p.Soil.BulbAttach.WorldCFrame*CFrame.new(0,plant.Size.Y/2,0)
			ts:Create(plant,TweenInfo.new((library[item].Time*3600),Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=Vector3.new(6,6,6),CFrame=p.Soil.BulbAttach.WorldCFrame*CFrame.new(0,6/2,0)}):Play()
		end
		plant.Parent = p

	end
end
function getCloseFlowerToPlayer(root,field)
	local flrs = {}
	if field ~= "" then
		for _,v in pairs(workspace.Fields[field]:GetChildren()) do
			if v and v:FindFirstChild("Amnt") then
				if (v.Position-root).magnitude <= 20 then
					table.insert(flrs,Vector3.new(v.Position.X,v.Parent.FieldBox.Position.Y,v.Position.Z))
				end
			end
		end
	end
	if #flrs >= 1 then
		return flrs[1]
	end
	return nil
end
local Updater = require(rp.Modules:WaitForChild("Update"))
local FX = require(rp.Modules:WaitForChild("LocalVFX"))


function getCloseFlowerToPlayerRand(root,field)
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
		local flr = getCloseFlowerToPlayerRand(pos,field)
		require(script.Parent:WaitForChild("TokenModule")).new("All",Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y-0.3+.7+3.323,flr.Position.Z),v[1],nil,v[2])
	end
end



function planter.Claim(plr,plantere)
	if plr.Field.Value == "" then return end
	for _,v in pairs(workspace.Planters:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("Player") and v.Player.Value == plr.Name and v.Name == plantere then
			v:Destroy()
		end
	end
	local PData = _G.PlayerData[plr.Name]
	local PlanterData = PData.Planters
	local loot = library[plantere].Loot[plr.Field.Value]
	local puffs = Pick(library[plantere]["Loot"]["Chances"])
	local flr = getCloseFlowerToPlayer(Vector3.new(PlanterData[plantere].Position.X,PlanterData[plantere].Position.Y,PlanterData[plantere].Position.Z),PlanterData[plantere].Field)
	if PlanterData[plantere]["Level"] >= 100 and puffs == "Puffs" then
		FX["Puffshroom"]({
			CFrame = CFrame.new(flr),
			Level=1,
			Puffshroom="Common Puffshroom",
			Time=300
		})
	end
	local field = PlanterData[plantere].Field
	local pos = Vector3.new(PlanterData[plantere].Position.X,PlanterData[plantere].Position.Y,PlanterData[plantere].Position.Z)
	PlanterData[plantere].EndTime = 0
	PlanterData[plantere].Field = ""
	PlanterData[plantere].Position.X = 0
	PlanterData[plantere].Position.Y = 0
	PlanterData[plantere].Position.Z = 0
	

	
	local trueloot = library[plantere].Loot["LootReturn100%"]
	for i,v in pairs(trueloot) do
		if i then
			PData.Inventory[i] += v
			notify.Create(plr,{Message="+"..v.." "..i,Type="Default"})
		end
	end
	if PlanterData[plantere].Level < 100 then return end
	for i = 1,20 do
		local item,amnt = planter.getLoot(loot)
		if item then
			local flr = getCloseFlowerToPlayerRand(pos,field)
			require(script.Parent:WaitForChild("TokenModule")).new("All",Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y-0.3+.7+3.323,flr.Position.Z),item,nil,amnt)
		end
		task.wait(0.03)
	end
	Updater.Inventory(plr)
end

function planter.getLoot(tab)
	local rng = Random.new():NextNumber(0.00001,100)
	local c = 0
	for i,v in pairs(tab) do
		c += v[1]
		if c >= rng then
			return i,math.random(v[2],v[3])
		end
	end
end

function planter.Load(plr)
	local PData = _G.PlayerData[plr.Name]
	local PlanterData = PData.Planters
	for i,v in pairs(PlanterData) do
		if v.Field ~= "" then
			local p = rp.Assets.Planters[i]:Clone()
			p.Parent = workspace.Planters
			p.Field.Value = v.Field
			p:SetPrimaryPartCFrame(CFrame.new(v.Position.X,v.Position.Y,v.Position.Z))
			if not v.Level then
				v.Level = 0
			end
			local plant = rp.Assets.Planters.Plant:Clone()
			local left = v.Level/100 
			local size = 6*left
			local platform = rp.Assets.Planters.Platform:Clone()
			platform.Parent = p 
			p.Player.Value = plr.Name
			platform:SetPrimaryPartCFrame(CFrame.new((p.PrimaryPart.CFrame*CFrame.new(0,-p.PrimaryPart.Size.Y/2,0).Position))*CFrame.Angles(0,0,math.rad(90)))
			platform.Top.Proxy.ObjectText = plr.Name
			p.Level.Value = v.Level
			p.Soil.BulbAttach.Progress.Bar.Fill.Size = UDim2.new(v.Level/100,0,1,0)
			local timeleft = (library[i].Time*3600)-(((library[i].Time*3600)*(p.Level.Value*0.01)))
			ts:Create(p.Soil.BulbAttach.Progress.Bar.Fill,TweenInfo.new(timeleft,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=UDim2.new(1,0,1,0)}):Play()
			ts:Create(p.Level,TweenInfo.new(timeleft,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Value=100}):Play()
			p.Soil.BulbAttach.Progress.Bar.Label.Text = p.Name.." ("..v.Level.."%"..")"
			p.Level.Changed:Connect(function(new)
				if new > 100 then
					new = 100
				end
				v.Level = new
				p.Soil.BulbAttach.Progress.Bar.Label.Text = p.Name.." ("..new.."%"..")"
			end)
			if size >= 0 then
				plant.Size = Vector3.new(size,size,size)
				ts:Create(plant,TweenInfo.new(timeleft,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size=Vector3.new(6,6,6),CFrame=p.Soil.BulbAttach.WorldCFrame*CFrame.new(0,6/2,0)}):Play()
			end
			plant.CFrame = p.Soil.BulbAttach.WorldCFrame*CFrame.new(0,plant.Size.Y/2,0)
			plant.Parent = p
		end
	end
end

return planter

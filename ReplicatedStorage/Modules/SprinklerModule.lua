-- @ScriptType: ModuleScript
local sprinkler = {}

sprinkler.Sprinklers = {
	["Basic Sprinkler"] = {WaveDelay=5,Radius=7,Max=1},
	["Silver Soakers"] = {WaveDelay=4.5,Radius=7,Max=2},
	["Golden Gushers"] = {WaveDelay=4.5,Radius=8,Max=3},
	["Diamond Drenchers"] = {WaveDelay=4,Radius=8,Max=4},
	["The Supreme Saturator"] = {WaveDelay=1,Radius=16,Max=1},
}
local rp = game:GetService("ReplicatedStorage")
local notify = require(rp.Modules:WaitForChild("NotificationModule"))

function spawner(func,v1,v2)
	local co = coroutine.wrap(func)
	co(v1,v2)
end

local ts = game:GetService("TweenService")

function regenFlowers(f,radius,basepos)
	local field = workspace.Fields[f]
	for _,flr in pairs(field:GetChildren()) do
			if flr:IsA("BasePart") and flr:FindFirstChild("FlowerColor") and flr:FindFirstChild("TopTexture") and (flr.Position-basepos).magnitude <= radius then
			if flr.Position.Y < flr.Parent.FieldBox.Position.Y then
					flr.Position += Vector3.new(0,0.25,0)
					flr["TopTexture"].Transparency -= 0.1
				if flr.Position.Y >= flr.Parent.FieldBox.Position.Y then
						flr["TopTexture"].Transparency = 0
					flr.Position = Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y,flr.Position.Z)
					end
				else
				flr["TopTexture"].Transparency = 0
				flr.Position = Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y,flr.Position.Z)
				end
		end
	end
end

function sprinkler.start(model,name)
	local base = model.Base
	local sprinklerName = model.Name
	local radius = sprinkler.Sprinklers[name].Radius*4
	local deb = sprinkler.Sprinklers[name].WaveDelay
	while true do
		if not workspace.Sprinklers:FindFirstChild(sprinklerName) then
			break
		end
		if model and workspace.Sprinklers:FindFirstChild(sprinklerName) then
			local wave = script.Wave:Clone()
			wave.Size = Vector3.new(0.1,0.1,0.1)
			wave.Parent = workspace.Debris
			wave.Position = base.Position+Vector3.new(0,1,0)
			base.Sound:Play()
			ts:Create(wave,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Transparency=1,Size=Vector3.new(2*radius,2*radius,radius*0.2)}):Play()
			game.Debris:AddItem(wave,2.1)
			regenFlowers(model.Field.Value,radius,base.Position)
		end
		task.wait(deb)
	end
	print('Loop Sprinkler Broken')
end

function sprinkler.New(plr,s)
	local char = plr.Character
	local root = char.PrimaryPart
	local field = plr.Field.Value
	local fieldBox = workspace.Fields[field].FieldBox
	if field == "" then
		notify.Create(plr,{Message="You must be in a field to place a sprinkler",Type="Error"})
		return
	end
	if s ~= "" then
	else
		notify.Create(plr,{Message="You do not own a sprinkler",Type="Error"})
		return
	end
	if field ~= "" then
	if not workspace.Sprinklers:FindFirstChild(s.."-"..plr.Name) then
		for _,v in pairs(workspace.Sprinklers:GetChildren()) do
			if v:IsA("Model") and string.find(v.Name,plr.Name) then 
				v:Destroy()
			end
		end
	end 
	local amountPlaced = 0
	for _,v in pairs(workspace.Sprinklers:GetChildren()) do
		if v:IsA("Model") and v.Name == s.."-"..plr.Name then
	        amountPlaced += 1		
		end
	end
	if amountPlaced < sprinkler.Sprinklers[s].Max then
		local newSprinkler = rp.Assets.Sprinklers[s]:Clone()
		newSprinkler.Parent = workspace.Sprinklers
		newSprinkler.Name = s.."-"..plr.Name
		newSprinkler:SetPrimaryPartCFrame(CFrame.new(root.Position.X,fieldBox.Position.Y-2.5/2,root.Position.Z))
			newSprinkler.Base.RigSound:Play()
			local fieldVal = Instance.new("StringValue",newSprinkler)
			fieldVal.Name = "Field"
			fieldVal.Value = field
			spawner(sprinkler.start,newSprinkler,s)
	else
		for _,v in pairs(workspace.Sprinklers:GetChildren()) do
			if v:IsA("Model") and v.Name == s.."-"..plr.Name then
				v:Destroy()	
			end
		end
		end
	end
end

return sprinkler

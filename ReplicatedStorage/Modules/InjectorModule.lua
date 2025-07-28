-- @ScriptType: ModuleScript
local injector = {}

injector.Injectors = {
	["Basic Data Injector"] = {WaveDelay=5,Radius=7,Max=1},
	["Silver Data Injectors"] = {WaveDelay=4.5,Radius=7,Max=2},
	["Golden Data Injectors"] = {WaveDelay=4.5,Radius=8,Max=3},
	["Diamond Data Injectors"] = {WaveDelay=4,Radius=8,Max=4},
	["Supreme Data Injector"] = {WaveDelay=1,Radius=16,Max=1},
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

function injector.start(model,name)
	local base = model.Base
	local injectorName = model.Name
	local radius = injector.Injectors[name].Radius*4
	local deb = injector.Injectors[name].WaveDelay
	while true do
		if not workspace.Injectors:FindFirstChild(injectorName) then
			break
		end
		if model and workspace.Injectors:FindFirstChild(injectorName) then
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
	print('Loop Injector Broken')
end

function injector.New(plr,s)
	local char = plr.Character
	local root = char.PrimaryPart
	local field = plr.Field.Value
	local fieldBox = workspace.Fields[field].FieldBox
	if field == "" then
		notify.Create(plr,{Message="You must be in a field to place an injector",Type="Error"})
		return
	end
	if s ~= "" then
	else
		notify.Create(plr,{Message="You do not own an injector",Type="Error"})
		return
	end
	if field ~= "" then
		if not workspace.Injectors:FindFirstChild(s.."-"..plr.Name) then
			for _,v in pairs(workspace.Injectors:GetChildren()) do
			if v:IsA("Model") and string.find(v.Name,plr.Name) then 
				v:Destroy()
			end
		end
	end 
	local amountPlaced = 0
		for _,v in pairs(workspace.Injectors:GetChildren()) do
		if v:IsA("Model") and v.Name == s.."-"..plr.Name then
	        amountPlaced += 1		
		end
	end
		if amountPlaced < injector.Injectors[s].Max then
			local newInjector = rp.Assets.Injectors[s]:Clone()
			newInjector.Parent = workspace.Injectors
			newInjector.Name = s.."-"..plr.Name
			newInjector:SetPrimaryPartCFrame(CFrame.new(root.Position.X,fieldBox.Position.Y-2.5/2,root.Position.Z))
			newInjector.Base.RigSound:Play()
			local fieldVal = Instance.new("StringValue",newInjector)
			fieldVal.Name = "Field"
			fieldVal.Value = field
			spawner(injector.start,newInjector,s)
	else
			for _,v in pairs(workspace.Injectors:GetChildren()) do
			if v:IsA("Model") and v.Name == s.."-"..plr.Name then
				v:Destroy()	
			end
		end
		end
	end
end

return injector

-- @ScriptType: ModuleScript
local dCor = {}
dCor.Colors = {
	[1] = Color3.fromRGB(255, 0, 0),
	[2] = Color3.fromRGB(212, 0, 255),
	[3] = Color3.fromRGB(30, 255, 250),
	[4] = Color3.fromRGB(0, 255, 0)
}
local rp = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
function getCloseFlowerToPlayer(root,field)
	local flrs = {}
	if field ~= "" then
		for _,v in pairs(workspace.Fields[field]:GetChildren()) do
			if v and v:FindFirstChild("Amnt") then
				if (v.Position-root.Position).magnitude <= 15*4 and v.Position.Y > v.Parent.FieldBox.Position.Y-2.14 then
					table.insert(flrs,v)
				end
			end
		end
	end
	if #flrs >= 1 then
		return flrs[math.random(1,#flrs)]
	end
end

function dCor.Spread(field,flr)
	local f = workspace.Fields[field]
	for _,v in pairs(f:GetChildren()) do
		if v:IsA("BasePart") and v:FindFirstChild("TopTexture") and (v.Position-flr.Position).magnitude <= 3*4 then
			if v:FindFirstChild("Gum") then
				v.Gum:Destroy()
			end
			local dCorDrop = script.Gum:Clone()
			dCorDrop.Color = dCor.Colors[math.random(1,#dCor.Colors)]
			dCorDrop.Position = v.Position
			dCorDrop.Parent = v
			ts:Create(dCorDrop,TweenInfo.new(15),{Transparency=1}):Play()
			game.Debris:AddItem(dCorDrop,15)
		end
	end
end

function dCor.SpawnGum(plr)
	local field = plr.Field.Value
	local char = plr.Character
	local root = char.PrimaryPart
	
	for i = 1,3 do
		local gumdrop = script.Drop:Clone()
		local flr = getCloseFlowerToPlayer(root,field)
		gumdrop.Parent = workspace.Debris
		gumdrop.Position = flr.Position+Vector3.new(0,math.random(16,22),0)
		gumdrop.Color = dCor.Colors[math.random(1,#dCor.Colors)]
		local t = ts:Create(gumdrop,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=flr.Position})
		t:Play()
		game.Debris:AddItem(gumdrop,4)
		t.Completed:Connect(function()
			gumdrop:Destroy()
			dCor.Spread(field,flr)
		end)
		task.wait(0.3)
	end
end

return dCor

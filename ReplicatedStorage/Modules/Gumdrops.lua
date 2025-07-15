-- @ScriptType: ModuleScript
local gum = {}
gum.Colors = {
	[1] = Color3.fromRGB(0, 255, 225),
	[2] = Color3.fromRGB(255, 125, 255)
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

function gum.Spread(field,flr)
	local f = workspace.Fields[field]
	for _,v in pairs(f:GetChildren()) do
		if v:IsA("BasePart") and v:FindFirstChild("TopTexture") and (v.Position-flr.Position).magnitude <= 3*4 then
			if v:FindFirstChild("Gum") then
				v.Gum:Destroy()
			end
			local gummy = script.Gum:Clone()
			gummy.Color = gum.Colors[math.random(1,#gum.Colors)]
			gummy.Position = v.Position
			gummy.Parent = v
			ts:Create(gummy,TweenInfo.new(15),{Transparency=1}):Play()
			game.Debris:AddItem(gummy,15)
		end
	end
end

function gum.SpawnGum(plr)
	local field = plr.Field.Value
	local char = plr.Character
	local root = char.PrimaryPart
	
	for i = 1,3 do
		local gumdrop = script.Drop:Clone()
		local flr = getCloseFlowerToPlayer(root,field)
		gumdrop.Parent = workspace.Debris
		gumdrop.Position = flr.Position+Vector3.new(0,math.random(16,22),0)
		gumdrop.Color = gum.Colors[math.random(1,#gum.Colors)]
		local t = ts:Create(gumdrop,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=flr.Position})
		t:Play()
		game.Debris:AddItem(gumdrop,4)
		t.Completed:Connect(function()
			gumdrop:Destroy()
			gum.Spread(field,flr)
		end)
		task.wait(0.3)
	end
end

return gum

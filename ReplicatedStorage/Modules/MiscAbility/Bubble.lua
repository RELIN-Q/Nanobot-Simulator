-- @ScriptType: ModuleScript
local module = {}

local ts = game:GetService("TweenService")
function getPlayerTool(plr)
		if #plr.Backpack:GetChildren() >= 1 then
			if plr.Backpack:GetChildren()[1]then
			return 	plr.Backpack:GetChildren()[1]
		end
			if plr.Character:FindFirstChildOfClass("Tool") then
				return plr.Character:FindFirstChildOfClass("Tool")
			end
	end 
end
function module.Pop(bubble,field)
	if field ~= "" then
	for _,v in pairs(workspace.Fields:FindFirstChild(field):GetChildren()) do
		if v and v:FindFirstChild("Amnt") and (v.Position-bubble.Position).magnitude <= 11 then
			v.TopTexture.Transparency = 0
			v.Position = Vector3.new(v.Position.X,v.Parent.FieldBox.Position.Y,v.Position.Z)
		end
	end
	local sfxPart = Instance.new("Part",workspace)
	sfxPart.Position = bubble.Position
	sfxPart.Transparency = 1
	sfxPart.CanCollide = false
	sfxPart.Size = Vector3.new(1,1,1)
	sfxPart.Anchored = true
	sfxPart.Name = "SFX"
	local sfx = script.SFX:Clone()
	sfx.Parent = sfxPart
	sfx:Play()
	game.Debris:AddItem(sfxPart,sfx.TimeLength+0.1)
		bubble:Destroy()
		end
end
function getClosestFieldToToken(root)
	for _,v in pairs(workspace.Fields:GetChildren()) do
		if root and (root.Position-v.FieldBox.Position).magnitude <= 110 then
			return v.Name
		end
	end
end
function module.Start(field,position)
	local bubble = game.ReplicatedStorage.Assets.Misc.Bubble:Clone()
	bubble.Parent = workspace.Debris.Misc
	bubble.Position = position
	ts:Create(bubble,TweenInfo.new(11.5),{Transparency=1}):Play()
	game.Debris:AddItem(bubble,10)
	bubble.Touched:Connect(function(hit)
		if hit and hit.Parent:FindFirstChild("Humanoid") then
			local plr = game.Players:GetPlayerFromCharacter(hit.Parent) 
			if plr then
				for _,v in pairs(workspace.Fields:FindFirstChild(getClosestFieldToToken(bubble)):GetChildren()) do
					if v and v:FindFirstChild("Amnt") and (v.Position-bubble.Position).magnitude <= 11 then
						v.TopTexture.Transparency = 0
						v.Position = Vector3.new(v.Position.X,v.Parent.FieldBox.Position.Y,v.Position.Z)
					end
				end
				local sfxPart = Instance.new("Part",workspace)
				sfxPart.Position = bubble.Position
				sfxPart.Transparency = 1
				sfxPart.CanCollide = false
				sfxPart.Size = Vector3.new(1,1,1)
				sfxPart.Anchored = true
				sfxPart.Name = "SFX"
				local sfx = script.SFX:Clone()
				sfx.Parent = sfxPart
				sfx:Play()
				game.Debris:AddItem(sfxPart,sfx.TimeLength+0.1)
				bubble:Destroy()
			end
		end
	end)
end

return module

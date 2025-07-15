-- @ScriptType: ModuleScript
local module = {}
local ts = game:GetService("TweenService")
function tweenModel(model :Model,t,frame)
	local val = Instance.new("CFrameValue",model)
	val.Value = model:GetPrimaryPartCFrame()
	
	val.Changed:Connect(function(new)
		model:SetPrimaryPartCFrame(new)
	end)
	local tween = ts:Create(val,TweenInfo.new(t),{Value=frame},Enum.EasingDirection.In,Enum.EasingStyle.Quart) 
	tween:Play()
	tween.Completed:Wait()
	val:Destroy()
end
local BuffModule = require(script.Parent.Parent:WaitForChild("BuffVisual"))
local itemModule = require(script.Parent.Parent:WaitForChild("Items"))["Tide Popper"]
local flrModule = require(script.Parent.Parent:WaitForChild("FlowerScript"))
function module.Spawn(plr,stack)
	local tool = stack.Parent
	if stack.Value < itemModule.Stack then
	else
		stack.Value = 0
		BuffModule.Delete(plr,"Tidal Power")
		BuffModule.Create(plr,"Tidal Surge",Color3.fromRGB(97, 147, 255),"rbxassetid://11504519241")
	end
	local wave = game.ReplicatedStorage.Assets.Misc["Tidal Wave"]:Clone()
	wave.Parent = workspace.Debris.Misc
	wave.SFX:Play()
	local char = plr.Character
	local root = char.HumanoidRootPart
	local Owner = Instance.new("StringValue",wave) Owner.Name = "Owner" Owner.Value = plr.Name
	local fieldVal = Instance.new("StringValue",wave) fieldVal.Name = "Field" fieldVal.Value = plr.Field.Value
	wave.CFrame = root.CFrame
	wave.CFrame *= CFrame.new(0,wave.Size.Y/3.7,0)
	local stop = false
	ts:Create(wave,TweenInfo.new(((wave.CFrame*CFrame.new(0,0,-90)).Position-root.Position).Magnitude/32),{CFrame = wave.CFrame*CFrame.new(0,0,-90),Transparency=0.75},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
	spawn(function()
		wait(1.3)
		stop = true
	end)
	spawn(function()
		repeat wait()
			if stop == true then
				break
			end
			if plr == nil then
				break
			end
			if wave then
				flrModule.CreatePattern(plr,"Tidal Wave",wave,1,"Tidal Wave",itemModule)
				for _,v in pairs(workspace.Debris.Misc:GetChildren()) do
					if fieldVal.Value ~= "" and v and wave and v.Name == "Bubble" and plr.PlayerGui.Main.Buffs:FindFirstChild("Tidal Power") and (v.Position-wave.Position).magnitude <= 10.2 then
						stack.Value += 1
						plr.PlayerGui.Main.Buffs["Tidal Power"].Stack.Value = stack.Value
						BuffModule.Reset(plr,plr.PlayerGui.Main.Buffs["Tidal Power"])
						require(game.ReplicatedStorage.Modules.MiscAbility:WaitForChild("Bubble")).Pop(v,plr.Field.Value)
					end
				end
				end
			task.wait(0.2)
		until wave == nil
	end)
	game.Debris:AddItem(wave,1.3)
end

return module

-- @ScriptType: LocalScript
local plr = game.Players.LocalPlayer
wait(1) -- Script For Scripting Entity Discord Server (Credits to Rip_Frost)
repeat wait() until plr.Character or plr.CharacterAdded
local tool = require(game.ReplicatedStorage.Modules:WaitForChild("Items"))[script.Parent.Name]
local char = plr.Character
local root = char.HumanoidRootPart
local hum = char.Humanoid
local speed = script.Parent:WaitForChild("Speed")
local mouse = plr:GetMouse()
local anim = hum:LoadAnimation(script.Parent.Click)
local eq = false
local clicks = 0
local can = false
local holding = false
local db = false

speed.Value = tool.ClickSpeed
local buffModule = require(game.ReplicatedStorage.Modules:WaitForChild("BuffVisual"))

script.Parent.Unequipped:Connect(function()
	eq = false
	holding = false
end)

script.Parent.Equipped:Connect(function()
	eq = true
end)

mouse.Button1Down:Connect(function()
	if eq and not holding and not db then
		holding = true
		db = true
		while holding do
			anim:Play()
			if tool.Passive then
				if clicks >= tool.EachClick - 1 then
					clicks = 0
					can = true
				else
					clicks += 1
				end
			end
			script.Parent.ToolRemote:FireServer(can)
			can = false
			task.wait(speed.Value)
		end
		db = false 
	end
end)

mouse.Button1Up:Connect(function()
	holding = false
end)

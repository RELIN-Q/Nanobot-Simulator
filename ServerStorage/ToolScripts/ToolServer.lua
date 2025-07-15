-- @ScriptType: Script
local tool = require(game.ReplicatedStorage.Modules:WaitForChild("Items"))[script.Parent.Name]
local buffModule = require(game.ReplicatedStorage.Modules:WaitForChild("BuffVisual"))
script.Parent:WaitForChild("ToolRemote").OnServerEvent:Connect(function(plr,can)
	local char = plr.Character
	local root = char.HumanoidRootPart
	require(game.ReplicatedStorage.Modules:WaitForChild("FlowerScript")).CreatePattern(plr,script.Parent.Name,root,1,script.Parent.Name,tool)
	
	if can == true then
		if tool.Passive == true then
			if game.ReplicatedStorage.Modules.Passives:FindFirstChild(script.Parent.Name) then
				
				buffModule.Create(plr,tool.BuffName,tool.BuffColor,tool.BuffIcon)
				require(game.ReplicatedStorage.Modules.Passives:WaitForChild(script.Parent.Name)).Spawn(plr,script.Parent:WaitForChild("Stack"))
			end
		end
	end
end)
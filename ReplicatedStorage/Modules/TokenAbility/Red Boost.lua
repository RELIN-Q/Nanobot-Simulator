-- @ScriptType: ModuleScript
local module = {}
local utils = require(script.Parent.Parent:WaitForChild("Utils"))
local BuffModule = require(game.ReplicatedStorage.Modules:WaitForChild("BuffVisual"))
function module.Collect(plr,pos)
	if plr.PlayerGui.Main.Buffs:FindFirstChild("Red Boost") then
		BuffModule.AddStack(plr,"Red Boost","")
	else
		BuffModule.Create(plr,"Red Boost",Color3.fromRGB(146, 255, 142),"rbxassetid://5029422474")
		end
end

return module

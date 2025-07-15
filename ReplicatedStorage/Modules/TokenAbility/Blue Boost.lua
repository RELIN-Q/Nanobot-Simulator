-- @ScriptType: ModuleScript
local module = {}
local utils = require(script.Parent.Parent:WaitForChild("Utils"))
local BuffModule = require(game.ReplicatedStorage.Modules:WaitForChild("BuffVisual"))
function module.Collect(plr,pos)
	if plr.PlayerGui.Main.Buffs:FindFirstChild("Blue Boost") then
		BuffModule.AddStack(plr,"Blue Boost","")
	else
		BuffModule.Create(plr,"Blue Boost",Color3.fromRGB(146, 255, 142),"rbxassetid://5029415876")
		end
end

return module

-- @ScriptType: ModuleScript
local module = {}
local utils = require(script.Parent.Parent:WaitForChild("Utils"))
function module.Collect(plr,pos)
	for i,v in pairs(workspace.Debris.Tokens:GetChildren()) do
		if v and v:FindFirstChild("TokenName") and v.TokenName.Value ~= "TokenLink" and v.Name == plr.Name then
			utils.Line(pos,v.Position)
			require(game.ReplicatedStorage.Modules:WaitForChild("TokenModule")).Collect(plr,v)
		end
	end
end

return module

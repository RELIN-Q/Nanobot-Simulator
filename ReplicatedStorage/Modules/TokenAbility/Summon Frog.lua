-- @ScriptType: ModuleScript
local module = {}

function module.Collect(plr,pos)
	require(script.Parent.Parent.MiscAbility:WaitForChild("Frog")).Start(plr.Field.Value,pos)
end

return module

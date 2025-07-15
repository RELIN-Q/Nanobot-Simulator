-- @ScriptType: ModuleScript
local update = {}

function update.Inventory(plr)
	local data = _G.PlayerData[plr.Name]
	for i,v in pairs(data.Inventory) do
		plr.Inventory[i].Value = v
	end
end

return update

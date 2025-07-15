-- @ScriptType: ModuleScript
local reward = {}

local notiModule = require(game.ReplicatedStorage.Modules:WaitForChild("NotificationModule"))
local updater = require(game.ReplicatedStorage.Modules:WaitForChild("Update"))
function reward.RewardPlayer(plr,items)
	if plr then
		local data = _G.PlayerData[plr.Name]
		for i,v in pairs(items) do
			if v.Item == "Honey" then
				data.Stats[v.Item] += v.Amount
			else
				data.Inventory[v.Item] += v.Amount
			end
			notiModule.Create(plr,{Message=v.Mark..""..v.Amount.." "..v.Item,Type=v.MessageType})
		end
		updater.Inventory(plr)
	end
end


return reward

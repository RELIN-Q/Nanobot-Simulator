-- @ScriptType: ModuleScript
local tokene = {}


local rp = game:GetService("ReplicatedStorage")
local Updater = require(rp.Modules:WaitForChild("Update"))
local notify = require(rp.Modules:WaitForChild("NotificationModule"))
function tokene.Collect(plr,pos,bee,token)
	local pdata = _G.PlayerData[plr.Name]
	local inv = pdata.Inventory
	local stats = pdata.Stats
	notify.Create(plr,{Message="+"..token.Amount.Value.." Blueberry",Type="Default"})
	inv["Blueberry"] += token.Amount.Value
	Updater.Inventory(plr)
end

return tokene

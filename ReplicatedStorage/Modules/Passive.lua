-- @ScriptType: ModuleScript
local passive = {}

local rp = game:GetService("ReplicatedStorage")
local library = require(rp.Modules:WaitForChild("Items"))
passive["Honey Mask"] = function(plr,token)
	local UI = plr.PlayerGui.Main
	local char = plr.Character
	if not char:FindFirstChild("Honey Mask") then return end
	if token == "TokenLink" and not plr:FindFirstChild("Coin Scatter") then
		if not UI.Buffs:FindFirstChild("Honey Mask") then
			local buff = script.Buff:Clone()
			buff.Visible = true
			buff.Icon.Image = library["Honey Mask"].Icon
			buff.Stack.Value += 1
			buff.amount.Text = "x"..buff.Stack.Value
			buff.Parent = UI.Buffs
			buff.Name = "Honey Mask" 
		else
			UI.Buffs["Honey Mask"].Stack.Value += 1
			UI.Buffs["Honey Mask"].amount.Text = "x"..UI.Buffs["Honey Mask"].Stack.Value
		end
		if UI.Buffs["Honey Mask"].Stack.Value >= 20 then
			UI.Buffs["Honey Mask"]:Destroy()
			local deb = Instance.new("BoolValue",plr)
			deb.Name = "Coin Scatter"
			delay(120,function()
				deb:Destroy()
			end)
			if rp.Modules.Passives:FindFirstChild("Coin Scatter") then
				require(rp.Modules.Passives:WaitForChild("Coin Scatter")).Spawn(plr)
			end
		end
	end
end
passive["UpdatePassives"] = function(plr,token)
	for i,v in pairs(passive) do
		if i == "UpdatePassives" then continue end
		v(plr,token)
	end
end

return passive

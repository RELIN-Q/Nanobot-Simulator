-- @ScriptType: Script
game.ReplicatedStorage.Remotes.RedeemCode.OnServerEvent:Connect(function(plr, code)
	local rp = game:GetService("ReplicatedStorage")
	local Updater = require(rp.Modules:WaitForChild("Update"))
	local notify = require(rp.Modules:WaitForChild("NotificationModule"))
	local code = string.lower(code)
	local pdata = _G.PlayerData[plr.Name]
	local inv = pdata.Inventory
	local stats = pdata.Stats
	if script.Codes:FindFirstChild(code) and plr.Codes:FindFirstChild(code) then		
		local currentCode = plr.Codes:FindFirstChild(code)
		if currentCode.Value == 0 then			
			currentCode.Value += 1
			game.ReplicatedStorage.Remotes.RedeemCode:FireClient(plr, "Code successfully redeemed!")			
			if code == "test" then --Rewards					
				notify.Create(plr,{Message="+1 Red Extract",Type="Default"})
				inv["Red Extract"] += 1
				Updater.Inventory(plr)	
			elseif code == "test2" then
				notify.Create(plr,{Message="+1 Basic Egg",Type="Default"})
				inv["Basic Egg"] += 1
				Updater.Inventory(plr)
		    end
		else
			
			game.ReplicatedStorage.Remotes.RedeemCode:FireClient(plr, "Code already redeemed!")			
		end		
	else	
		game.ReplicatedStorage.Remotes.RedeemCode:FireClient(plr, "Invalid code!")	
	end
end)
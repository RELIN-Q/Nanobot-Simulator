-- @ScriptType: Script
game.Players.PlayerRemoving:Connect(function(plr)	
	local datastore = game:GetService("DataStoreService"):GetDataStore(plr.Name.."Codes")	
	local statstorage = plr:FindFirstChild("Codes"):GetChildren()
	for i = 1, #statstorage do		
		datastore:SetAsync(statstorage[i].Name, statstorage[i].Value)		
	end	
end)

game.Players.PlayerAdded:Connect(function(plr)	
	local datastore = game:GetService("DataStoreService"):GetDataStore(plr.Name.."Codes")	
	plr:WaitForChild("Codes")
	wait(1)	
	local stats = plr:FindFirstChild("Codes"):GetChildren()	
	for i = 1, #stats do
		stats[i].Value = datastore:GetAsync(stats[i].Name)		
	end	
end)

game:BindToClose(function()	
	wait(3)
end)
-- @ScriptType: Script
game.Players.PlayerAdded:Connect(function(plr)
	local codesFolder = Instance.new("Folder", plr)
	codesFolder.Name = "Codes"
	for _, codes in pairs(game.ServerScriptService.Codes.CodesHandler.Codes:GetChildren()) do	
		local code = Instance.new("IntValue", codesFolder)
		code.Name = codes.Name
		code.Value = 0	
	end
end)
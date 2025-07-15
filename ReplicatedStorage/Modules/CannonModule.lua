-- @ScriptType: ModuleScript
local cannon = {}

cannon.Cannons = {
	["Red Cannon"] = {BeesAmnt=10,Power=200}
}

function cannon.Fire(plr,c)
	local char = plr.Character
	local data = _G.PlayerData[plr.Name]
	
	local bees = #data.Bees
	
	if bees >= cannon.Cannons[c].BeesAmnt then
		workspace.Cannon[c].Model.Barrel.Backplate.Sound:Play()
		char:SetPrimaryPartCFrame(workspace.Cannon[c].Model.Barrel.Backplate.ExplodePos.WorldCFrame)
		local bf = Instance.new("BodyForce",char.PrimaryPart)
		bf.Force = workspace.Cannon[c].Model.Barrel.Backplate.ExplodePos.WorldCFrame.LookVector * cannon.Cannons[c].Power * workspace.Gravity
		game.Debris:AddItem(bf,0.1)
	end
end

return cannon

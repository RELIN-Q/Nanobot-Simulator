-- @ScriptType: ModuleScript
local module = {}
function findClosestNPC(root,username)
	local npc = nil
	for _,v in pairs(workspace.Debris.Entity:GetChildren()) do
		if v and v:FindFirstChild("BeeEnemy") and v.BeeEnemy.Health >= 1 and v.Name == username and (v.PrimaryPart.Position-root).magnitude <= 90 then
			npc = v
		end
	end
	return npc
end
local bee = require(script.Parent.Parent:WaitForChild("BeeModule"))
local ts = game:GetService("TweenService")
function module.Collect(plr,pos,beee)
	if plr then
		local enemy = findClosestNPC(pos,plr.Name)
		for i = 1,10 do
			if enemy and enemy.PrimaryPart then
				local spike = game.ReplicatedStorage.Assets.Misc.Thorn:Clone()
				spike.Parent = workspace.Debris.Misc
				spike.Name = "Spike_"..plr.Name
				spike.Position = enemy.PrimaryPart.Position
				local r = math.random(1,4)
				game.ReplicatedStorage.Remotes.VisualPopUp:FireClient(plr,bee.BeeInfo["Vicious Bee"].Damage*10*r*beee.Level.Value,enemy.PrimaryPart.Position+Vector3.new(0,(enemy.PrimaryPart.Size.Y+5)+(i*1.5),0),true,"Damage",enemy.PrimaryPart)
				spike.Position -= Vector3.new(0,spike.Size.Y/2,0)			
				spike.Hit:Play()
				ts:Create(spike,TweenInfo.new(0.23),{Position=spike.Position+Vector3.new(0,spike.Size.Y,0)},"In","Linear"):Play()
				game.Debris:AddItem(spike,0.3+spike.Hit.TimeLength)
				enemy.BeeEnemy.Health -= bee.BeeInfo["Vicious Bee"].Damage*10*r*beee.Level.Value
			end
			wait(0.2)
		end
	end
end

return module

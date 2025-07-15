-- @ScriptType: ModuleScript
local mobModule = {}

function spawner(func,...)
	local co = coroutine.wrap(func)
	co(...)
end
local Mob = "Ladybug"
local rewarder = require(game.ServerScriptService:WaitForChild("RewardModule"))
local MobData = require(script.Parent.Parent:WaitForChild("Mobs"))["Ladybug"]
local ts = game:GetService("TweenService")
local utils = require(script.Parent.Parent:WaitForChild("Utils"))

function getReward()
	local tw = 0
	for i,v in pairs(MobData.Loot) do
		tw += v.Chance
	end
	local RNG = Random.new():NextNumber(0,tw)
	local chance = 0
	for i,v in pairs(MobData.Loot) do
		chance += v.Chance
		if chance >= RNG then
			return i,v
		end
	end
end

function getRewards()
	local rewards = {}
	for i = 1,3 do
		local rName,rData = getReward()
		table.insert(rewards,{Item=rName,Mark="+",Amount=rData.Amount,MessageType="Default"})
	end
	return rewards
end

function mobModule.CreateArc(p1,p2,objectFollow)
	spawn(function()
		local p3 = Instance.new("Part",workspace) p3.Transparency = 1 p3.Name = "LerpPart" p3.CanCollide = false
		p3.Anchored = true
		local stopArc = false
		p3.Position = p1+Vector3.new(0,10,0)
		spawn(function()
			repeat wait()
				if objectFollow == nil then
					break
				end
				if stopArc == true then
					break
				end
				if objectFollow and objectFollow.PrimaryPart then
					local succ,err = pcall(function()
					spawn(function() utils.tweenModel(objectFollow,0.25,CFrame.new(p3.Position)*CFrame.Angles(math.rad(objectFollow.PrimaryPart.Orientation.X),math.rad(objectFollow.PrimaryPart.Orientation.Y),math.rad(objectFollow.PrimaryPart.Orientation.Z))) end)
					end)
					if not succ then
						print(err)
					end
					end
			until stopArc == true
			return nil
		end)
		local t = ts:Create(p3,TweenInfo.new(.25,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Position=p2})
		t:Play()
		t.Completed:Wait()
		p3:Destroy()
		stopArc = true
	end)
end
function mobModule.Animate(mob)
	local legs = mob.Legs
	local animSave = {
		["Left Leg1"] = -35,
		["Left Leg2"] = -35,
		["Left Leg3"] = -35,
		["Right Leg1"] = -35,
		["Right Leg2"] = -35,
		["Right Leg3"] = -35,
	}
	while true do
		if mob and mob:FindFirstChild("BeeEnemy") and mob.BeeEnemy.Health <= 0 then
			break
		end
		if mob and mob:FindFirstChild("Legs") then
			local leg = math.random(1,3)
			legs["Left Leg"..leg]:SetPrimaryPartCFrame(legs["Left Leg"..leg]:GetPrimaryPartCFrame()*CFrame.Angles(0,0,math.rad(animSave["Left Leg"..leg])))
			animSave["Left Leg"..leg] = -animSave["Left Leg"..leg]
			leg = math.random(1,3)
			legs["Right Leg"..leg]:SetPrimaryPartCFrame(legs["Right Leg"..leg]:GetPrimaryPartCFrame()*CFrame.Angles(0,0,math.rad(animSave["Right Leg"..leg])))
			animSave["Right Leg"..leg] = -animSave["Right Leg"..leg]
		end
		if mob == nil then
			break
		end
		wait(0.15)
	end	
end
function mobModule.AI(mob)
	local plr = game.Players:FindFirstChild(mob.Name)
	local char = plr.Character
	for _,v in pairs(mob:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
	local AttackCharge = 0
	wait(0.1)
	spawner(mobModule.Animate,mob)
	repeat wait()
		if mob == nil then
			break
		end
		if mob and mob:FindFirstChild("BeeEnemy") and mob.BeeEnemy.Health <= 0 then 
			break
		end
		if mob and mob:FindFirstChild("BeeEnemy") and mob.BeeEnemy.Health > 0 then
			if (mob.PrimaryPart.Position-char.HumanoidRootPart.Position).magnitude <= 55 then
				mob:SetPrimaryPartCFrame(CFrame.lookAt(mob.PrimaryPart.Position,Vector3.new(char.HumanoidRootPart.Position.X,mob.PrimaryPart.Position.Y,char.HumanoidRootPart.Position.Z)))
				if AttackCharge >= 40 then
					AttackCharge = 0
					mob:SetPrimaryPartCFrame(CFrame.lookAt(mob.PrimaryPart.Position,Vector3.new(char.HumanoidRootPart.Position.X,mob.PrimaryPart.Position.Y,char.HumanoidRootPart.Position.Z)))
					wait(0.3)
					local origin = mob.PrimaryPart.Position
					mobModule.CreateArc(mob.PrimaryPart.Position,char.HumanoidRootPart.Position,mob)
					wait(0.4)
					mobModule.CreateArc(mob.PrimaryPart.Position,origin,mob)
					wait(0.3)
				else
					AttackCharge += 1
				end
			else
				repeat wait()
					if mob then
						mob:SetPrimaryPartCFrame(CFrame.lookAt(mob.PrimaryPart.Position,Vector3.new(char.HumanoidRootPart.Position.X,mob.PrimaryPart.Position.Y,char.HumanoidRootPart.Position.Z)))
						spawn(function() utils.tweenModel(mob,(mob.PrimaryPart.Position-char.HumanoidRootPart.Position).magnitude/mob.BeeEnemy.WalkSpeed,CFrame.new(char.HumanoidRootPart.Position)*CFrame.Angles(math.rad(mob.PrimaryPart.Orientation.X),math.rad(mob.PrimaryPart.Orientation.Y),math.rad(mob.PrimaryPart.Orientation.Z)))	 end)
					end
					
					if mob == nil then
						break
					end
						wait(0.2)
until (mob.PrimaryPart.Position-char.HumanoidRootPart.Position).magnitude <= 55
			end
		end
		wait(0.1)
	until plr.Field.Value ~= script.Name or mob == nil
	wait(0.1)
	if mob then
		mob:Destroy()
	end
	return
end
local qModule = require(game.ReplicatedStorage.Modules:WaitForChild("QuestModule"))
function mobModule.new(plr: Player)
	if workspace.Debris.Entity:FindFirstChild(plr.Name) or _G.PlayerData[plr.Name].Bosses[script.Name].EndTime > os.time() then
	else
		local enemy = game.ReplicatedStorage.Assets.Ladybug:Clone()
		enemy.Parent = workspace.Debris.Entity
		enemy.Name = plr.Name
		enemy:SetPrimaryPartCFrame(workspace.Fields[script.Name].Spawner.Spawn.CFrame)
		enemy:SetPrimaryPartCFrame(CFrame.lookAt(enemy.PrimaryPart.Position,Vector3.new(plr.Character.HumanoidRootPart.Position.X,enemy.PrimaryPart.Position.Y,plr.Character.HumanoidRootPart.Position.Z)))
		enemy.BeeEnemy.HealthChanged:Connect(function(nh)
			if nh <= 0 then
				_G.PlayerData[plr.Name].Bosses[script.Name].EndTime = os.time()+300
				game.ReplicatedStorage.Remotes.RunFunctionClient:FireClient(plr,"AddTimerToMob",script.Name)
				if MobData.LootType == "Instant" then
					local rewards = getRewards()
					rewarder.RewardPlayer(plr,rewards)
					qModule.Update(plr,{Field="",Pollen=0,Red=0,Blue=0,White=0,Mob=Mob,Token="",Gum=0})
				end
			end
		end)
		spawner(mobModule.AI,enemy)
	end 	
end

return mobModule

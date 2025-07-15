-- @ScriptType: ModuleScript
local bee = {}

bee.Eggs = {
	["Basic Egg"] = {
		["Basic Bee"] = 75,
		["Honey Bee"] = 2,
		["Hasty Bee"] = 5,
		["Brave Bee"] = 5,
		["Cool Bee"] = 5,
		["Rad Bee"] = 5,
		["Tadpole Bee"] = 0.05
	},
	["Royal Jelly"] = {
		["Honey Bee"] = 15,
		["Hasty Bee"] = 35,
		["Brave Bee"] = 25,
		["Rad Bee"] = 35,
		["Diamond Basic Bee"] = 5,
		["Tadpole Bee"] = 1
	},
	["Star Jelly"] = {
		["Honey Bee"] = 15,
		["Hasty Bee"] = 35,
		["Brave Bee"] = 25,
		["Rad Bee"] = 35,
		["Cool Bee"] = 35,
		["Tadpole Bee"] = 1
	},
	["Mythic Egg"] = {
		["Tadpole Bee"] = 100
	},
	["Vicious Bee Egg"] = {
		["Vicious Bee"] = 100
	},
	["Primary Module"] = {
		["Primary Nanobot"] = 100
	},
	["Basic Nano-Mod"] = {
		["Basic Nanobot"] = 100
	}
}

bee.LevelBonds = {
	[1] = 0,
	[2] = 100,
	[3] = 500,
	[4] = 1500,
	[5] = 3500,
	[6] = 7500,
	[7] = 15000,
	[8] = 30000,
	[9] = 90000,
	[10] = 300000,
	[11] = 900000,
	[12] = 1900000,
	[13] = 3000000,
	[14] = 5900000,
	[15] = 8000000,
	[16] = 12000000,
	[17] = 15000000,
	[18] = 20000000,
	[19] = 25000000,
	[20] = 30000000
}

bee.BeeInfo = {
	["Basic Bee"] = {
		Icon = "rbxassetid://9749734105",
		Description = "A basic bee.",
		Rarity = "Basic",
		Speed = 13,
		Tokens = {},
		Convert = 25,
		Damage = 3,
		MaxEnergy = 25,
		Boost = {
			ConvertionRate = 0,
			BlueConvertRate = 0,
			RedConvertRate = 0,
			WhiteConvertRate = 0,
			WhiteRate = 0,
			RedRate = 0,
			BlueRate = 0,
			Power = 0.3,
		},
		WhenAttack = false
	},
	["Basic Nanobot"] = {
		Icon = "rbxassetid://9749734105",
		Description = "A basic Nanobot. One of many.",
		Rarity = "Basic",
		Speed = 100,
		Tokens = {},
		Convert = 25,
		Damage = 3,
		MaxEnergy = 25,
		Boost = {
			ConvertionRate = 0,
			BlueConvertRate = 0,
			RedConvertRate = 0,
			WhiteConvertRate = 0,
			WhiteRate = 0,
			RedRate = 0,
			BlueRate = 0,
			Power = 0.3,
		},
		WhenAttack = false
	},
	["Primary Nanobot"] = {
		Icon = "rbxassetid://9749734105",
		Description = "Your one and only.",
		Rarity = "Basic",
		Speed = 100,
		Tokens = {},
		Convert = 16,
		Damage = 4,
		MaxEnergy = 1000,
		Boost = {
			ConvertionRate = 0,
			BlueConvertRate = 0,
			RedConvertRate = 0,
			WhiteConvertRate = 0,
			WhiteRate = 0,
			RedRate = 0,
			BlueRate = 0,
			Power = 0.3,
		},
		WhenAttack = false,
		Primary = true
	},
	["Diamond Basic Bee"] = { --placeholder
		Icon = "rbxassetid://9749734105",
		Description = "A diamond basic bee.",
		Rarity = "Legendary",
		Speed = 13,
		Tokens = {},
		Convert = 25,
		Damage = 3,
		MaxEnergy = 25,
		Boost = {
			ConvertionRate = 0,
			BlueConvertRate = 0,
			RedConvertRate = 0,
			WhiteConvertRate = 0,
			WhiteRate = 0,
			RedRate = 0,
			BlueRate = 0,
			Power = 0.3,
		},
		WhenAttack = false
	},
	["Brave Bee"] = {
		Icon = "rbxassetid://11582345202",
		Description = "A very brave bee, this bee has no fears.",
		Rarity = "Rare",
		Speed = 15,
		Damage = 8,
		Convert = 40,
		MaxEnergy = 30,
		Tokens = {TokenLink=9,["White Bomb"]=5},
		Boost = {
			ConvertionRate = 7,
			BlueConvertRate = 6,
			RedConvertRate = 6,
			WhiteConvertRate = 11,
			WhiteRate = 12,
			Power = 0.3,
			RedRate = 7,
			BlueRate = 7,
		},
		WhenAttack = false
	},
	["Rad Bee"] = {
		Icon = "rbxassetid://9749824893",
		Description = "A Rad Bee, it loves Red flowers!",
		Rarity = "Rare",
		Speed = 12,
		Damage = 6,
		Convert = 43,
		MaxEnergy = 30,
		Tokens = {["Red Boost"]=8},
		Boost = {
			ConvertionRate = 13,
			BlueConvertRate = 3,
			RedConvertRate = 25,
			WhiteConvertRate = 13,
			WhiteRate = 13,
			Power = 0.3,
			RedRate = 50,
			BlueRate = 7,
		},
		WhenAttack = false
	},
	["Cool Bee"] = {
		Icon = "rbxassetid://5529265710",
		Description = "A cool bee, it loves blue flowers!",
		Rarity = "Rare",
		Speed = 11,
		Damage = 4,
		Convert = 43,
		MaxEnergy = 30,
		Tokens = {["Blue Boost"]=8},
		Boost = {
			ConvertionRate = 13,
			BlueConvertRate = 25,
			RedConvertRate = 3,
			WhiteConvertRate = 13,
			WhiteRate = 13,
			Power = 0.3,
			RedRate = 7,
			BlueRate = 50,
		},
		WhenAttack = false
	},
	["Honey Bee"] = {
		Icon = "rbxassetid://11473503723",
		Description = "A Honey Bee, very good for making honey.",
		Rarity = "Epic",
		Speed = 14,
		Damage = 10,
		Convert = 60,
		Tokens = {},
		MaxEnergy = 40,
		Boost = {
			ConvertionRate = 15,
			BlueConvertRate = 6,
			RedConvertRate = 6,
			WhiteConvertRate = 16,
			WhiteRate = 22,
			RedRate = 15,
			Power = 0.3,
			BlueRate = 15,
		},
		WhenAttack = false
	},
	["Tadpole Bee"] = {
		Icon = "rbxassetid://11557297111",
		Description = "A bee that wants to become a frog when it grows up.",
		Rarity = "Mythic",
		Speed = 11,
		Damage = 3,
		Convert = 32,
		Tokens = {["Summon Frog"] = 7},
		MaxEnergy = 35,
		Boost = {
			ConvertionRate = 25,
			BlueConvertRate = 36,
			RedConvertRate = 0,
			WhiteConvertRate = 16,
			WhiteRate = 25,
			RedRate = 0,
			Power = 0.3,
			BlueRate = 50,
		},
		WhenAttack = false
	},
	["Hasty Bee"] = {
		Icon = "rbxassetid://11473509076",
		Description = "A Hasty Bee, its very fast.",
		Rarity = "Rare",
		Speed = 19.6,
		Damage = 7,
		Tokens = {},
		Convert = 29,
		MaxEnergy = 35,
		Boost = {
			ConvertionRate = 9,
			BlueConvertRate = 4,
			RedConvertRate = 4,
			WhiteConvertRate = 8,
			WhiteRate = 8,
			Power = 0.3,
			RedRate = 5,
			BlueRate = 5,
		},
		WhenAttack = false
	},
	["Vicious Bee"] = {
		Icon = "rbxassetid://3970920905",
		Description = "A Vicious Bee, its very strong.",
		Rarity = "Rare",
		Speed = 15.6,
		Convert = 40,
		Damage = 12,
		WhenAttack = true,
		Tokens = {Impale=26},
		MaxEnergy = 45,
		Boost = {
			ConvertionRate = 15,
			BlueConvertRate = 22,
			RedConvertRate = 22,
			WhiteConvertRate = 22,
			WhiteRate = 9,
			RedRate = 9,
			Power = 0.3,
			BlueRate = 9,
		}
	},
}
function Randomer(tab)
	local tw = 0
	for _,v in pairs(tab) do
		tw += v
	end

	local rand = Random.new():NextNumber(0,tw)
	local chance = 0

	for i,v in pairs(tab) do
		chance += v
		if chance >= rand then
			return i
		end
	end
end
bee.SlotColors = {
	["Basic Bee"] = Color3.fromRGB(174, 121, 47),
	["Basic Nanobot"] = Color3.fromRGB(174, 121, 47),
	["Primary Nanobot"] = Color3.fromRGB(174, 121, 47),
	["Honey Bee"] = Color3.fromRGB(245, 205, 48),
	["Tadpole Bee"] = Color3.fromRGB(160, 105, 223),
	["Hasty Bee"] = Color3.fromRGB(230, 230, 230),
	["Brave Bee"] = Color3.fromRGB(230, 230, 230),
	["Cool Bee"] = Color3.fromRGB(230, 230, 230),
	["Rad Bee"] = Color3.fromRGB(230, 230, 230),
	["Vicious Bee"] = Color3.fromRGB(109, 155, 69),
	["Diamond Basic Bee"] = Color3.fromRGB(0, 242, 255),
}

function spawner(func,...)
	local co = coroutine.wrap(func)
	co(...)
end



--local NanoForms = require(script.Parent:WaitForChild("NanoForms"))
--local function getNanobotOffset(plr, pattern, index)
--	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
--	if not root then return Vector3.new() end

--	local rootCF = root.CFrame
--	local origin = root.Position

--	if index == 1 then
--		-- Absolute position behind & above
--		return origin + (-rootCF.LookVector * 6) + (rootCF.UpVector * 4)
--	end

--	local followerCount = #pattern
--	if followerCount < 1 then return origin end

--	local pat = pattern[((index - 2) % followerCount) + 1]
--	local baseCF = CFrame.new(origin + (-rootCF.LookVector * 6) + (rootCF.UpVector * 4), 
--		origin + rootCF.LookVector)
--	local worldPos = baseCF.Position + baseCF:VectorToWorldSpace(pat)
--	return worldPos
--end





local flrScript = require(script.Parent:WaitForChild("FlowerScript"))
function getCloseFlowerToPlayer(root,field)
	local flrs = {}
	if field ~= "" then
		for _,v in pairs(workspace.Fields[field]:GetChildren()) do
			if v and v:FindFirstChild("Amnt") then
				if (v.Position-root.Position).magnitude <= 20 and v.Position.Y > v.Parent.FieldBox.Position.Y-2.14 then
					table.insert(flrs,v)
				end
			end
		end
	end
	if #flrs >= 1 then
		return flrs[math.random(1,#flrs)]
	end
end
local settingsMod = require(script.Parent:WaitForChild("Settings"))
local ts = game:GetService("TweenService")

function IdleBee(Bee)
	while wait(1) do
		if Bee == nil then
			break
		end
		if Bee and Bee:FindFirstChild("Owner") and Bee:FindFirstChild("Owner").Value == nil then
			break
		end
		if Bee.Sleeping.Value == true then
			break
		end
		local plr = Bee.Owner.Value

		-- Check if this is a Primary Nanobot
		local isPrimary = Bee:FindFirstChild("Primary") ~= nil
		if Bee.Energy.Value <= 1 then
			require(game.ReplicatedStorage.Modules.NotificationModule).Create(plr, {Message=Bee.Name.." Is Going Go To Sleep😴", Type="Default"})
			Bee.Sleeping.Value = true
			local beeInfo = bee.BeeInfo[Bee.Name]
			Bee.Energy.Value = 0
			local t = ts:Create(Bee.BodyPosition,TweenInfo.new((Bee.Slot.Value.Position-Bee.Position).magnitude/Bee.Speed.Value),{Position=Bee.Slot.Value.Position},Enum.EasingDirection.In,Enum.EasingStyle.Linear)
			Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, Bee.Slot.Value.Position)
			t:Play()
			t.Completed:Wait()
			local zzpart = game.ReplicatedStorage.Assets.SleepParticle:Clone()
			zzpart.Parent = Bee
			while true do
				wait(1)
				local energyGain = math.random(1,3)
				Bee.Energy.Value += energyGain
				if Bee.Energy.Value >= beeInfo.MaxEnergy+math.round(Bee.Level.Value*1.5) then
					Bee.Sleeping.Value = false
					bee.RenewBee(plr,Bee.Slot.Value,Bee)
					break
				end
			end	
		end

		-- Primary Nanobot has different idle behavior
		if isPrimary then
			-- Primary Nanobot stays closer to player and moves more predictably
			if Bee and Bee:FindFirstChild("Owner") and Bee.Owner.Value and Bee.Owner.Value.Character and Bee.Owner.Value.MakingHoney.Value == false and Bee.Attacking.Value == false and Bee.Owner.Value.Character.Humanoid.Health >= 1 and Bee.Owner.Value.Character.Humanoid.MoveDirection.Magnitude == 0 and Bee.Owner.Value.Field.Value == "" then
				-- Primary stays in a fixed position relative to player using XR/YR/ZR values
				local targetPos = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				Bee.BodyPosition.Position = targetPos
				Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, Bee.Owner.Value.Character.HumanoidRootPart.Position)
			end
		else
			-- Regular nanobots use the original random positioning
			if Bee and Bee:FindFirstChild("Owner") and Bee.Owner.Value and Bee.Owner.Value.Character and Bee.Owner.Value.MakingHoney.Value == false and Bee.Attacking.Value == false and Bee.Owner.Value.Character.Humanoid.Health >= 1 and Bee.Owner.Value.Character.Humanoid.MoveDirection.Magnitude == 0 and math.random(1,2) == 1 and Bee.Owner.Value.Field.Value == "" then
				Bee.BodyPosition.Position = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (Bee.Owner.Value.Character.HumanoidRootPart.Position+Vector3.new(Bee.XR.Value,Bee.YR.Value,Bee.ZR.Value)))
			end
		end

		-- Field behavior (same for both types for now)
		if Bee and Bee:FindFirstChild("Owner") and Bee.Owner.Value and Bee.Attacking.Value == false and Bee.Owner.Value.Character and Bee.Owner.Value.Character.Humanoid.Health >= 1 and math.random(1,2) == 1 and Bee.Owner.Value.Field.Value ~= "" then
			local flr = getCloseFlowerToPlayer(Bee.Owner.Value.Character.PrimaryPart,Bee.Owner.Value.Field.Value)
			local t = ts:Create(Bee.BodyPosition,TweenInfo.new(((flr.Position+Vector3.new(0,1.2,0))-Bee.Position).magnitude/Bee.Speed.Value),{Position=flr.Position+Vector3.new(0,1.4,0)},Enum.EasingDirection.In,Enum.EasingStyle.Linear)
			t:Play()
			Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (flr.Position+Vector3.new(0,1.2,0)))
			t.Completed:Wait()
			task.wait(0.2)
			Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (flr.Position+Vector3.new(0,1.2,0)))
			local spawnToken = false
			local token = ""
			if bee.BeeInfo[Bee.Name].WhenAttack == false then
				for i,v in pairs(bee.BeeInfo[Bee.Name].Tokens) do
					if math.random(1,v) == 1 then
						token = i					
						spawnToken = true
						break
					end
				end
			end
			if spawnToken == true and Bee.Attacking.Value == true then
				spawnToken = false
			end
			if spawnToken == true then
				for i = 1,8 do
					Bee.BodyGyro.CFrame *= CFrame.Angles(0,math.rad(300),0)
					wait(0.2)
				end
				require(script.Parent:WaitForChild("TokenModule")).new(Bee.Owner.Value,Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y-0.3+.7+3.323,flr.Position.Z),token,Bee)
				Bee.Energy.Value -= 0.5
			end
			if spawnToken == false then
				for i = 1,3 do
					Bee.BodyGyro.CFrame *= CFrame.Angles(0,0,math.rad(16))
					wait(0.2)
					Bee.BodyGyro.CFrame *= CFrame.Angles(0,0,math.rad(-16))
					wait(0.2)
					flrScript.CreatePattern(Bee.Owner.Value,"Bee",Bee,1,"Bee",bee.BeeInfo[Bee.Name].Boost)
					Bee.Energy.Value -= 0.5
					Bee.BodyGyro.CFrame *= CFrame.Angles(0,0,math.rad(-16))
					wait(0.2)
					Bee.BodyGyro.CFrame *= CFrame.Angles(0,0,math.rad(16))
					wait(0.2)
				end
			end
			wait(.2)

			-- Different return behavior for Primary vs Regular
			if isPrimary then
				-- Primary returns to its designated position using XR/YR/ZR values
				local targetPos = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				Bee.BodyPosition.Position = targetPos
				Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, Bee.Owner.Value.Character.HumanoidRootPart.Position)
			else
				-- Regular nanobots use random positioning
				Bee.BodyPosition.Position = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (Bee.Owner.Value.Character.HumanoidRootPart.Position+Vector3.new(Bee.XR.Value,Bee.YR.Value,Bee.ZR.Value)))
			end
		end
	end
end
function findClosestNPC(root,username)
	local npc = nil
	for _,v in pairs(workspace.Debris.Entity:GetChildren()) do
		if v and v:FindFirstChild("BeeEnemy") and v.BeeEnemy.Health >= 1 and v.Name == username and (v.PrimaryPart.Position-root.Position).magnitude <= 90 or v and v:FindFirstChild("BeeEnemy") and v.BeeEnemy.Health >= 1 and v.Name == "All" and (v.PrimaryPart.Position-root.Position).magnitude <= 90 then
			npc = v
		end
	end
	return npc
end
function moveBee(Bee)
	while wait(0.01) do
		if Bee == nil then
			break
		end
		if Bee and Bee:FindFirstChild("Owner") and Bee:FindFirstChild("Owner").Value == nil then
			break
		end
		if Bee.Sleeping.Value == true then
			break
		end

		-- Check if this is a Primary Nanobot
		local isPrimary = Bee:FindFirstChild("Primary") ~= nil

		if Bee and Bee:FindFirstChild("Owner") and Bee.Owner.Value and Bee.Owner.Value.Character and Bee.Owner.Value.Character.Humanoid.Health >= 1 then
			if Bee.Owner.Value.MakingHoney.Value == true then
				if Bee.Attacking.Value == false then
					local t = ts:Create(Bee.BodyPosition,TweenInfo.new((Bee.Owner.Value.Character.HumanoidRootPart.Position-Bee.Position).magnitude/Bee.Speed.Value),{Position=Bee.Owner.Value.Character.HumanoidRootPart.Position},Enum.EasingDirection.In,Enum.EasingStyle.Linear)
					t:Play()
					Bee.BodyPosition.Position = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
					Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, Bee.Owner.Value.Character.HumanoidRootPart.Position)
					t.Completed:Wait()
					wait(0.05)
					local t = ts:Create(Bee.BodyPosition,TweenInfo.new((Bee.Slot.Value.Position-Bee.Position).magnitude/Bee.Speed.Value),{Position=Bee.Slot.Value.Position},Enum.EasingDirection.In,Enum.EasingStyle.Linear)
					t:Play()
					Bee.BodyPosition.Position = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
					Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, Bee.Slot.Value.Position)
					t.Completed:Wait()
					wait(0.12)
					local beam = game.ReplicatedStorage.Assets.Misc.HoneyBeam:Clone()
					beam.Parent = Bee
					beam.Attachment0 = Bee.Attachment0
					beam.Attachment1 = Bee.Owner.Value.Character.HumanoidRootPart.RootRigAttachment
					game.Debris:AddItem(beam,4)
					for i = 1,20 do
						Bee.BodyGyro.CFrame *= CFrame.Angles(0,math.rad(300),0)
						wait(0.2)
					end
					wait(0.1)
					if Bee and _G.PlayerData[Bee.Owner.Value.Name].Stats.Pollen >= bee.BeeInfo[Bee.Name].Convert*(_G.PlayerData[Bee.Owner.Value.Name].PlayerBuffs.InstantConvertionRate*0.01+1)*((Bee.Level.Value)) then
						_G.PlayerData[Bee.Owner.Value.Name].Stats.Pollen -= bee.BeeInfo[Bee.Name].Convert*(_G.PlayerData[Bee.Owner.Value.Name].PlayerBuffs.InstantConvertionRate*0.01+1)*((Bee.Level.Value))
						game.ReplicatedStorage.Remotes.VisualPopUp:FireClient(Bee.Owner.Value,{
							Total = 0,
							Honey = bee.BeeInfo[Bee.Name].Convert*(_G.PlayerData[Bee.Owner.Value.Name].PlayerBuffs.InstantConvertionRate*0.01+1)*((Bee.Level.Value)),
							BlueHoney = 0,
							WhiteHoney = 0,
							RedHoney = 0,
							White = 0,
							Red = 0,
							Blue = 0,
							Damage =0},Bee.Owner.Value.Character.HumanoidRootPart.Position,true,"Non",Bee.Owner.Value.Character.HumanoidRootPart)
						_G.PlayerData[Bee.Owner.Value.Name].Stats.Honey += bee.BeeInfo[Bee.Name].Convert*(_G.PlayerData[Bee.Owner.Value.Name].PlayerBuffs.InstantConvertionRate*0.01+1)*((Bee.Level.Value))
					else
						game.ReplicatedStorage.Remotes.VisualPopUp:FireClient(Bee.Owner.Value,{
							Total = 0,
							Honey = bee.BeeInfo[Bee.Name].Convert*(_G.PlayerData[Bee.Owner.Value.Name].PlayerBuffs.ConvertionRate*0.01+1)*((Bee.Level.Value)),
							BlueHoney = 0,
							WhiteHoney = 0,
							RedHoney = 0,
							White = 0,
							Red = 0,
							Blue = 0,
							Damage =0},Bee.Owner.Value.Character.HumanoidRootPart.Position,true,"Non",Bee.Owner.Value.Character.HumanoidRootPart)
						_G.PlayerData[Bee.Owner.Value.Name].Stats.Pollen -= _G.PlayerData[Bee.Owner.Value.Name].Stats.Pollen
						_G.PlayerData[Bee.Owner.Value.Name].Stats.Honey += bee.BeeInfo[Bee.Name].Convert*(_G.PlayerData[Bee.Owner.Value.Name].PlayerBuffs.ConvertionRate*0.01+1)*((Bee.Level.Value))
					end
					wait(1)
				end
			end

			-- Combat behavior
			if #workspace.Debris.Entity:GetChildren() < 1 and not workspace.Debris.Entity:FindFirstChild(Bee.Owner.Value.Name) then
				if Bee.Attacking.Value == true then
					Bee.Attacking.Value = false
				end
			end
			if #workspace.Debris.Entity:GetChildren() >= 1 and workspace.Debris.Entity:FindFirstChild(Bee.Owner.Value.Name) or #workspace.Debris.Entity:GetChildren() >= 1 and workspace.Debris.Entity:FindFirstChild("All") then
				local enemy = findClosestNPC(Bee.Owner.Value.Character.HumanoidRootPart,Bee.Owner.Value.Name)
				if enemy == nil and Bee.Attacking.Value == true then
					Bee.Attacking.Value = false
				end
				if enemy then
					if Bee.Attacking.Value == false then
						Bee.Attacking.Value = true
						if not isPrimary then
							-- Regular nanobots get random combat positioning
							Bee.XR.Value = math.random(-3,3)
							Bee.ZR.Value = math.random(-3,3)
							Bee.YR.Value = math.random(-3,3)
						else
							-- Primary Nanobot has more controlled combat positioning
							Bee.XR.Value = 0
							Bee.ZR.Value = 0
							Bee.YR.Value = 6
						end
					end
					local spawnToken = false
					local token = ""
					if not Bee:FindFirstChild("MadeToken") and bee.BeeInfo[Bee.Name].WhenAttack == true then
						for i,v in pairs(bee.BeeInfo[Bee.Name].Tokens) do
							if math.random(1,v) == 1 then
								token = i					
								spawnToken = true
								break
							end
						end
					end
					if enemy and Bee.Owner.Value.Field.Value ~= "" and Bee.Attacking.Value == true and bee.BeeInfo[Bee.Name].WhenAttack == true and spawnToken == true and not Bee:FindFirstChild("MadeToken") then
						local mT = Instance.new("BoolValue",Bee)
						mT.Name = "MadeToken"
						mT.Value = true
						game.Debris:AddItem(mT,25)
						local flr = getCloseFlowerToPlayer(Bee.Owner.Value.Character.PrimaryPart,Bee.Owner.Value.Field.Value)
						if flr then
							local t = ts:Create(Bee.BodyPosition,TweenInfo.new(((flr.Position+Vector3.new(0,1.2,0))-Bee.Position).magnitude/Bee.Speed.Value),{Position=flr.Position+Vector3.new(0,1.4,0)},Enum.EasingDirection.In,Enum.EasingStyle.Linear)
							t:Play()
							Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (flr.Position+Vector3.new(0,1.2,0)))
							t.Completed:Wait()
							task.wait(0.2)
							Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (flr.Position+Vector3.new(0,1.2,0)))
							for i = 1,8 do
								Bee.BodyGyro.CFrame *= CFrame.Angles(0,math.rad(300),0)
								wait(0.2)
							end
							spawnToken = false
							require(script.Parent:WaitForChild("TokenModule")).new(Bee.Owner.Value,Vector3.new(flr.Position.X,flr.Parent.FieldBox.Position.Y-0.3+.7+3.323,flr.Position.Z),token,Bee)
						end
					end
					if enemy and enemy.PrimaryPart and (Bee.Position-enemy.PrimaryPart.Position).magnitude > 11 and spawnToken == false then
						Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, enemy.PrimaryPart.Position+Vector3.new(Bee.XR.Value,Bee.YR.Value,Bee.ZR.Value))
					end
					if enemy and enemy.PrimaryPart and spawnToken == false then
						ts:Create(Bee.BodyPosition,TweenInfo.new((enemy.PrimaryPart.Position-Bee.Position).magnitude/Bee.Speed.Value),{Position=enemy.PrimaryPart.Position+Vector3.new(Bee.XR.Value,Bee.YR.Value,Bee.ZR.Value)},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
					end
					if enemy and enemy.PrimaryPart and (Bee.Position-enemy.PrimaryPart.Position).magnitude <= 11 and spawnToken == false then
						Bee.BodyGyro.CFrame *= CFrame.Angles(math.rad(36),0,0)
						if math.random(1,6) == 1 then
							enemy.BeeEnemy.Health -= bee.BeeInfo[Bee.Name].Damage
							local succ,err = pcall(function()
								game.ReplicatedStorage.Remotes.VisualPopUp:FireClient(Bee.Owner.Value,{
									Total = 0,
									Honey = 0,
									BlueHoney = 0,
									WhiteHoney = 0,
									RedHoney = 0,
									White = 0,
									Red = 0,
									Blue = 0,
									Damage = bee.BeeInfo[Bee.Name].Damage*Bee.Level.Value},enemy.PrimaryPart.Position+Vector3.new(0,enemy.PrimaryPart.Health.StudsOffsetWorldSpace.Y,0),true,"Non",enemy.PrimaryPart)
								require(script.Parent:WaitForChild("Utils")).Line(Bee.Position,enemy.PrimaryPart.Position,Color3.fromRGB(214, 0, 0))
							end)
							if not succ then
								print(err)
							end
						end
					end
				end
			end
		end

		-- Regular following behavior (when not in combat/field/making honey)
		if Bee and Bee:FindFirstChild("Owner") and Bee.Attacking.Value == false and Bee.Owner.Value and Bee.Owner.Value.Character and Bee.Owner.Value.Character.Humanoid.Health >= 1 and Bee.Owner.Value.Field.Value == "" then
			if isPrimary then
				-- Primary Nanobot follows in a fixed position
				local targetPos = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				Bee.BodyPosition.Position = targetPos
				if Bee and Bee.Owner and Bee.Owner.Value.Character.Humanoid.MoveDirection.Magnitude > 0 then
					Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, Bee.Owner.Value.Character.HumanoidRootPart.Position)
				end
			else
				-- Regular nanobots use random positioning
				Bee.BodyPosition.Position = Bee.Owner.Value.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				if Bee and Bee.Owner and Bee.Owner.Value.Character.Humanoid.MoveDirection.Magnitude > 0 then
					Bee.BodyGyro.CFrame = CFrame.lookAt(Bee.Position, (Bee.Owner.Value.Character.HumanoidRootPart.Position+Vector3.new(Bee.XR.Value,Bee.YR.Value,Bee.ZR.Value)))
				end
			end
		end
	end
end
local Notis = require(script.Parent:WaitForChild("NotificationModule"))
function bee.LevelUp(plr,Bee,slot)
	local i,beeData = bee.FindBee(plr,slot,Bee)
	if beeData then
		Notis.Create(plr,{Message="The "..Bee.Name.." has leveled up to level "..(beeData.Level+1),Type="Default"})
		_G.PlayerData[plr.Name].Bees[i].Level = beeData.Level+1
		bee.UpdateLevelHive(plr)
	end
end

function bee.Feed(plr,slot,Bee,Bond)
	local i,beeData = bee.FindBee(plr,slot,Bee)
	if beeData then
		if beeData.Level < 20 then
			_G.PlayerData[plr.Name].Bees[i].Bond += Bond
			Notis.Create(plr,{Message=Bee.Name.." bond increased by "..Bond.." (".._G.PlayerData[plr.Name].Bees[i].Bond.."/"..bee.LevelBonds[_G.PlayerData[plr.Name].Bees[i].Level+1]..")!",Type="Default"})
			repeat wait()
				if _G.PlayerData[plr.Name].Bees[i].Bond >= bee.LevelBonds[_G.PlayerData[plr.Name].Bees[i].Level+1] then
					bee.LevelUp(plr,Bee,slot)
				end
			until _G.PlayerData[plr.Name].Bees[i].Bond < bee.LevelBonds[_G.PlayerData[plr.Name].Bees[i].Level+1] or _G.PlayerData[plr.Name].Bees[i].Level >= 20
		end
	end
end

function bee.NewModel(plr,Bee,slot,lvle,gifted,isPrimary)
	if slot then
		local beeModel
		if gifted then
			beeModel = game.ReplicatedStorage.Assets.GiftedBees[Bee]:Clone()
		else
			beeModel = game.ReplicatedStorage.Assets.Bees[Bee]:Clone()
		end
		beeModel.Parent = workspace.Bees
		beeModel.BodyPosition.Position = slot.Position
		slot.Bee.Value = beeModel
		beeModel.Owner.Value = plr
		beeModel.Speed.Value = bee.BeeInfo[Bee].Speed
		local lvl = Instance.new("IntValue",beeModel) lvl.Name = "Level" lvl.Value = lvle

		-- Handle Primary Nanobot special setup
		if isPrimary then
			-- Create Primary tag
			local primaryTag = Instance.new("BoolValue", beeModel)
			primaryTag.Name = "Primary"
			primaryTag.Value = true

			-- Primary starts at a fixed position relative to player
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local startPos = plr.Character.HumanoidRootPart.Position + Vector3.new(Bee.XR.Value, Bee.YR.Value, Bee.ZR.Value)
				beeModel.BodyPosition.Position = startPos
				beeModel.XR.Value = 0
				beeModel.YR.Value = 8
				beeModel.ZR.Value = -10
			else
				-- Fallback if no character found
				beeModel.XR.Value = 0
				beeModel.YR.Value = 8
				beeModel.ZR.Value = -10
			end
		else
			-- Regular nanobots get random positioning
			beeModel.XR.Value = math.random(5,15)
			beeModel.ZR.Value = 0
			beeModel.YR.Value = 4
		end

		beeModel.Slot.Value = slot
		beeModel.BodyGyro.CFrame = CFrame.lookAt(beeModel.Position,slot.Position)
		beeModel.CFrame = slot.Cover.Face.CFrame
		beeModel.Energy.Value = bee.BeeInfo[Bee].MaxEnergy + math.round(lvle*1.5)
		local giftedBool = Instance.new("BoolValue",beeModel) giftedBool.Name = "Gifted" giftedBool.Value = gifted
		spawner(moveBee,beeModel)
		spawner(IdleBee,beeModel)
	end
end
function bee.NewBee(plr,slot,egg)
	local HatchedBee = Randomer(bee.Eggs[egg])
	local GiftedChance = math.random(1,settingsMod.GiftedBeesSettings.Chance)
	if HatchedBee then
		if GiftedChance == 1 then
			Notis.Create(plr,{Message="A "..egg.." has installed a Gifted "..HatchedBee..".",Type="Default"})
			local honeycomb = game.ReplicatedStorage.Assets.Misc.Hive_Cover:Clone()
			honeycomb.Parent = slot
			honeycomb:SetPrimaryPartCFrame(slot.CFrame*CFrame.new(0,0.5,0))
			honeycomb.Name = "Cover"
			honeycomb.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[HatchedBee].Color3
			honeycomb.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[HatchedBee].Texture
			slot.Occupied.Value = true
			honeycomb.Hive_Cover.Level.Level.Text = "1"
			honeycomb:WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 0
			slot.Transparency = 0
			slot.Color = bee.SlotColors[HatchedBee]
			game.ReplicatedStorage.Remotes.PopUpBee:FireClient(plr,HatchedBee)
			bee.NewModel(plr,HatchedBee,slot,1, true)
			table.insert(_G.PlayerData[plr.Name].Bees,{Slot=slot.Name,Bee=HatchedBee,Level=1,Bond=0,Gifted=true})
		else
			Notis.Create(plr,{Message="A "..egg.." has installed a "..HatchedBee..".",Type="Default"})
			local honeycomb = game.ReplicatedStorage.Assets.Misc.Hive_Cover:Clone()
			honeycomb.Parent = slot
			honeycomb:SetPrimaryPartCFrame(slot.CFrame*CFrame.new(0,0.5,0))
			honeycomb.Name = "Cover"
			honeycomb.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[HatchedBee].Color3
			honeycomb.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[HatchedBee].Texture
			slot.Occupied.Value = true
			honeycomb.Hive_Cover.Level.Level.Text = "1"
			honeycomb:WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 1
			slot.Transparency = 0
			slot.Color = bee.SlotColors[HatchedBee]
			game.ReplicatedStorage.Remotes.PopUpBee:FireClient(plr,HatchedBee)
			bee.NewModel(plr,HatchedBee,slot,1)
			table.insert(_G.PlayerData[plr.Name].Bees,{Slot=slot.Name,Bee=HatchedBee,Level=1,Bond=0,Gifted=false})
		end
	end
end
function bee.RenewBee(plr,slot,Bee)
	if plr.Hive.Value ~= nil and slot and slot.Occupied.Value == true then
		local newBee = Bee.Name
		if newBee then
			slot.Cover.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Texture
			slot.Cover.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Color3
			slot.Color = bee.SlotColors[newBee]
			local index,tab = bee.FindBee(plr,slot,slot.Bee.Value)
			slot.Bee.Value:Destroy()
			slot.Bee.Value = nil
			tab.Bee = newBee
			tab.Slot = slot.Name
			if tab.Gifted == true then
				slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 0
			else
				slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 1
			end
			bee.NewModel(plr,newBee,slot,tab.Level,tab.Gifted)
		end
	end
end

function bee.LoadBee(plr,beee)
	if plr.Hive.Value ~= nil then
		local slot = plr.Hive.Value.Slots[beee.Slot]
		slot.Occupied.Value = true
		local honeycomb = game.ReplicatedStorage.Assets.Misc.Hive_Cover:Clone()
		honeycomb.Parent = slot
		honeycomb:SetPrimaryPartCFrame(slot.CFrame*CFrame.new(0,0.5,0))
		honeycomb.Name = "Cover"
		honeycomb.Hive_Cover.Level.Level.Text = beee.Level
		honeycomb.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[beee.Bee].Color3
		honeycomb.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[beee.Bee].Texture
		if beee.Gifted then
			honeycomb:WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 0
		end
		slot.Transparency = 0
		slot.Color = bee.SlotColors[beee.Bee]
		bee.NewModel(plr,beee.Bee,slot,beee.Level,beee.Gifted)
	end
end


function bee.UpdateLevelHive(plr)
	if plr.Hive.Value ~= nil then
		for _,v in pairs(plr.Hive.Value.Slots:GetChildren()) do
			if v:FindFirstChild("Cover") then
				local i,b = bee.FindBee(plr,v,v.Bee.Value)
				if b then
					v.Bee.Value.Level.Value = b.Level
					v.Cover.Hive_Cover.Level.Level.Text = b.Level
				end
			end
		end
	end
end
function bee.FindBee(plr,slot,Bee)
	local data = _G.PlayerData[plr.Name].Bees
	for i,v in pairs(data) do
		if v.Slot == slot.Name and v.Bee == Bee.Name then
			return i,v
		end
	end
end
function bee.ReplaceBee(plr,slot,item,isGiftedOn)
	if plr.Hive.Value ~= nil and slot and slot.Occupied.Value == true then
		local newBee = Randomer(bee.Eggs[item])
		local GiftedChance = math.random(1,settingsMod.GiftedBeesSettings.Chance)
		if isGiftedOn then
			GiftedChance = 1
		end
		if newBee then
			if GiftedChance == 1 then
				Notis.Create(plr,{Message="The "..slot.Bee.Value.Name.." has converted into a Gifted "..newBee..".",Type="Default"})
				slot.Cover.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Texture
				slot.Cover.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Color3
				slot.Color = bee.SlotColors[newBee]
				slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 0
				local index,tab = bee.FindBee(plr,slot,slot.Bee.Value)
				slot.Bee.Value:Destroy()
				slot.Bee.Value = nil
				tab.Bee = newBee
				tab.Slot = slot.Name
				tab.Gifted = true
				game.ReplicatedStorage.Remotes.PopUpBee:FireClient(plr,newBee,item,slot)
				bee.NewModel(plr,newBee,slot,tab.Level,true)
			else
				Notis.Create(plr,{Message="The "..slot.Bee.Value.Name.." has converted into a "..newBee..".",Type="Default"})
				slot.Cover.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Texture
				slot.Cover.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Color3
				slot.Color = bee.SlotColors[newBee]
				slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 1
				local index,tab = bee.FindBee(plr,slot,slot.Bee.Value)
				slot.Bee.Value:Destroy()
				slot.Bee.Value = nil
				tab.Bee = newBee
				tab.Slot = slot.Name
				tab.Gifted = false
				game.ReplicatedStorage.Remotes.PopUpBee:FireClient(plr,newBee,item,slot)
				bee.NewModel(plr,newBee,slot,tab.Level,false)
			end
		end
	end
end
function bee.GiftBee(plr,slot)
	local Bee = slot.Bee.Value
	local i,beeData = bee.FindBee(plr,slot,Bee)
	if beeData then
		if beeData.Gifted == false then
			beeData.Gifted = true
			local success, error = pcall(function()
				slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 0
			end)
			if error then
				warn(error)
			end
			slot.Cover.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[beeData.Bee].Texture
			slot.Cover.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[beeData.Bee].Color3
			slot.Color = bee.SlotColors[Bee.Name]
			slot.Bee.Value:Destroy()
			slot.Bee.Value = nil

			local newBee = Bee.Name
			bee.NewModel(plr,newBee,slot,beeData.Level, true)
		end
	end
end
function bee.ReplaceBeeWithAuto(plr,slot,item,target,RarityAuto,Gifted)
	if plr.Hive.Value ~= nil and slot and slot.Occupied.Value == true then
		local AmountHasbeen = 0
		local data = _G.PlayerData[plr.Name]
		local newBee
		local giftedchance = math.random(1,require(game.ReplicatedStorage.Modules.Settings).GiftedBeesSettings.Chance)
		while true do
			if not Gifted and RarityAuto ~= "" then
				if data.Inventory["Royal Jelly"] >= AmountHasbeen then
					newBee = Randomer(bee.Eggs[item])
					AmountHasbeen +=1
				end
				if bee.BeeInfo[newBee].Rarity then
					if bee.BeeInfo[newBee].Rarity == RarityAuto then
						break
					end
				end
				if data.Inventory["Royal Jelly"] <= AmountHasbeen or data.Inventory["Royal Jelly"] <= 1 then
					break
				end
			elseif Gifted == true and not RarityAuto then
				if data.Inventory["Royal Jelly"] >= AmountHasbeen then
					giftedchance = math.random(1,require(game.ReplicatedStorage.Modules.Settings).GiftedBeesSettings.Chance)
					newBee = Randomer(bee.Eggs[item])
					AmountHasbeen +=1
				end
				if giftedchance == 1 then
					break
				end
				if data.Inventory["Royal Jelly"] <= AmountHasbeen or data.Inventory["Royal Jelly"] <= 1 then
					break
				end
			elseif Gifted == true and RarityAuto ~= "" then
				if data.Inventory["Royal Jelly"] >= AmountHasbeen then
					giftedchance = math.random(1,require(game.ReplicatedStorage.Modules.Settings).GiftedBeesSettings.Chance)
					newBee = Randomer(bee.Eggs[item])
					AmountHasbeen += 1
				end
				if giftedchance == 1 and bee.BeeInfo[newBee].Rarity == RarityAuto then
					break
				end
				if data.Inventory["Royal Jelly"] <= AmountHasbeen or data.Inventory["Royal Jelly"] <= 1 then
					break
				end
			end
		end
		if data.Inventory["Royal Jelly"] >= AmountHasbeen then
			data.Inventory["Royal Jelly"] -= AmountHasbeen
			require(game.ReplicatedStorage.Modules.Update).Inventory(plr)
			if bee.BeeInfo[newBee].Rarity == RarityAuto or giftedchance == 1 then
				if giftedchance == 1 then
					Notis.Create(plr,{Message="The "..slot.Bee.Value.Name.." has converted into a Gifted "..newBee.." With "..AmountHasbeen .. " Jellies",Type="Default"})
					slot.Cover.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Texture
					slot.Cover.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Color3
					slot.Color = bee.SlotColors[newBee]
					local index,tab = bee.FindBee(plr,slot,slot.Bee.Value)
					slot.Bee.Value:Destroy()
					slot.Bee.Value = nil
					slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 0
					tab.Bee = newBee
					tab.Slot = slot.Name
					tab.Gifted = true
					game.ReplicatedStorage.Remotes.PopUpBee:FireClient(plr,newBee,item,target)
					bee.NewModel(plr,newBee,slot,tab.Level)
				else
					Notis.Create(plr,{Message="The "..slot.Bee.Value.Name.." has converted into a "..newBee.." With "..AmountHasbeen .. " Jellies",Type="Default"})
					slot.Cover.Face.Decal.Texture = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Texture
					slot.Cover.Face.Decal.Color3 = game.ReplicatedStorage.Assets.Bee_Faces[newBee].Color3
					slot.Color = bee.SlotColors[newBee]
					local index,tab = bee.FindBee(plr,slot,slot.Bee.Value)
					slot.Bee.Value:Destroy()
					slot.Bee.Value = nil
					slot:WaitForChild("Cover"):WaitForChild("Hive_Cover"):WaitForChild("GiftedCover").Transparency = 1
					tab.Bee = newBee
					tab.Slot = slot.Name	
					tab.Gifted = false
					game.ReplicatedStorage.Remotes.PopUpBee:FireClient(plr,newBee,item,target)
					bee.NewModel(plr,newBee,slot,tab.Level)
				end
				AmountHasbeen = 0
			else
				bee.ReplaceBee(plr, slot, item, target)
			end	
		end
	end
end
function bee.Evict(plr,slot)
	if plr.Hive.Value ~= nil and slot and slot.Occupied.Value == true then
		Notis.Create(plr,{Message=slot.Bee.Value.Name.." was evicted.",Type="Error"})
		slot.Cover:Destroy()
		slot.Occupied.Value = false
		slot.Color = Color3.fromRGB(105, 64, 40)
		slot.Transparency = 0.3
		local index,tab = bee.FindBee(plr,slot,slot.Bee.Value)
		slot.Bee.Value:Destroy()
		slot.Bee.Value = nil
		table.remove(_G.PlayerData[plr.Name].Bees,index)
	end
end
return bee
-- @ScriptType: Script
local ds = game:GetService("DataStoreService"):GetDataStore("PlayerDataNQ2")
local BuffModule = require(game.ReplicatedStorage.Modules:WaitForChild("BuffVisual"))
_G.PlayerData = {}
local items = require(game.ReplicatedStorage.Modules:WaitForChild("Items"))
_G.CurrentBuffs = {}
require(game.ReplicatedStorage.Modules:WaitForChild("FlowerScript")).LoadAllFields()
local Zone = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("Zone"))
local flowerModule = require(game.ReplicatedStorage.Modules:WaitForChild("FlowerScript"))
flowerModule.Spawner(flowerModule.TriggerRegen)
local PlrLoader = require(script:WaitForChild("LoadPlayerBuffs"))
local notiModule = require(game.ReplicatedStorage.Modules:WaitForChild("NotificationModule"))
for _,v in pairs(workspace.Fields:GetChildren()) do
	local container = v.FieldBox
	local zone = Zone.new(container)

	zone.playerEntered:Connect(function(player)
		player.Field.Value = v.Name
		if game.ReplicatedStorage.Modules.Bosses:FindFirstChild(v.Name) then
			require(game.ReplicatedStorage.Modules.Bosses:WaitForChild(v.Name)).new(player)
		end
	end)

	zone.playerExited:Connect(function(player)
		player.Field.Value = ""
	end)
end
local rp = game:GetService("ReplicatedStorage")
local buffModule = require(game.ReplicatedStorage.Modules:WaitForChild("BuffVisual"))
local Players = game:GetService("Players")
local animNPC = require(rp.Modules:WaitForChild("AnimateNPC"))
local doorsModule = require(rp.Modules:WaitForChild("DoorModule"))
local planter = require(rp.Modules:WaitForChild("PlanterSystem"))
doorsModule.Init()
animNPC.Initiate()
local questModule = require(rp.Modules:WaitForChild("QuestModule"))
function loadEquipment(plr,equipment) --the most useless function yet... you can delete it
	local tools = game.ReplicatedStorage.Assets.Tools
	local bags = game.ReplicatedStorage.Assets.Bags
	if equipment["Tool"] ~= "" then
		local Tool = tools[equipment.Tool]:Clone()
		Tool.Parent = plr.Backpack
		for _,v in pairs(game.ServerStorage.ToolScripts:GetChildren()) do
			v:Clone().Parent = Tool
		end
	end
	if equipment["Bag"] ~= "" then
		local Tool = bags[equipment.Bag]:Clone()
		Tool.Parent = plr.Character
		for _,v in pairs(game.ServerStorage.BagScripts:GetChildren()) do
			v:Clone().Parent = Tool
		end
		plr.Cap.Value = items[equipment.Bag].Capacity + items[equipment.Mask].Capacity 
		_G.PlayerData[plr.Name].Stats.Capacity = items[equipment.Bag].Capacity + items[equipment.Mask].Capacity
	end
	if equipment["Boots"] ~= "" then
		for i,v in pairs(rp.Assets.Boots[equipment.Boots]:GetChildren()) do
			local Tool = v:Clone()
			Tool.Parent = plr.Character
		end
		_G.PlayerData[plr.Name].GameBuffs.MovementCollection += (items[equipment.Boots].MovementCollection)
	end
	if equipment["Mask"] ~= "" then
		local Tool =  game.ReplicatedStorage.Assets.Masks[equipment.Mask]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["Belt"] ~= "" then
		local Tool =  game.ReplicatedStorage.Assets.Belt[equipment.Belt]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["RightGuards"] ~= "" then
		local Tool =  game.ReplicatedStorage.Assets.RightGuards[equipment.RightGuards]:Clone()
		Tool.Parent = plr.Character
	end
	if equipment["LeftGuards"] ~= "" then
		local Tool =  game.ReplicatedStorage.Assets.LeftGuards[equipment.LeftGuards]:Clone()
		Tool.Parent = plr.Character
	end
end
Players.PlayerAdded:Connect(function(plr)
	_G.CurrentBuffs[plr.Name] = {}
	_G.PlayerData[plr.Name] = {
		Bosses = {
			["Clover Field"] = {EndTime=0},
			["Pepper Field"] = {EndTime=0},
		},
		ShopDispenserPrice = {
			["Basic Egg"] = 0,
			["SlotShop"] = 0

		},
		["EquipmentOwned"] = {
			["Scooper"] = true,
			["Honey Hammer"] = false,
			["Pouch"] = true,
			["Basic Boots"] = false,
			["Basic Sprinkler"] = false,
			["Silver Soakers"] = false,
			["Golden Gushers"] = false,
			["Diamond Drenchers"] = false,
			["The Supreme Saturator"] = false,
			["Honey Mask"] = false,
			["Belt Bag"] = false,
			["Red Guard"] = false,
			["Blue Guard"] = false,
			["Glider"] = false,
			["Star Amulet"] = false,
		},
		PlayerBuffs = {
			ConvertionRate = 0,
			InstantConvertionRate = 0
		},
		["Planters"] = {
			["Ticket Planter"] = {Position={X=0,Y=0,Z=0},EndTime=0,Field="",Level=0},
			["Paper Planter"] = {Position={X=0,Y=0,Z=0},EndTime=0,Field="",Level=0},
			["Plastic Planter"] = {Position={X=0,Y=0,Z=0},EndTime=0,Field="",Level=0}
		},
		ActiveBuffs = {
			["Science Enhancement"] = {Stack=0,TimeOfStart="never",EndTime="never"},
		},
		Stats = {
			Honey = 0,
			Pollen = 0,
			Capacity = 100
		},
		Bees = {},
		Quests = {},
		Badges = {
			["Honey Badge"] = {
				["Rank"] = "Cadet",
				["Collected"] = 0,
				["Claimed"] = false,
			}	
		},
		NPCData = {
			["Black Bear"] = {Quests=1,Completed=false,Claimed=false}
		},
		GameBuffs = {
			RedBoost = 0,
			BlueBoost = 0,
			WhiteBoost = 0,
			WhiteHoney = 0,
			BlueHoney = 0,
			RedHoney = 0,
			["MovementCollection"] = 0,
			["PlayerMovespeed"] = 35,
			["PlayerJumpPower"] = 50,
			ConvertVisualGUIRate = 0
		},
		FieldBoosts = {
			["Clover Field"] = 1,
			["Bamboo Field"] = 1,
			["Pepper Field"] = 1,
		},
		Inventory = {
			["Basic Egg"] = 0,
			["Basic Nano-Mod"] = 24,
			["Primary Module"] = 1,
			["Vicious Bee Egg"] = 0,
			["Mythic Egg"] = 0,
			["Royal Jelly"] = 0,
			["Eviction"] = 0,
			["Ticket"] = 0,
			["Treat"] = 0,
			["Sunflower Seed"] = 0,
			["Red Extract"] = 0,
			["Blue Extract"] = 0,
			["Micro Converter"] = 0,
			["Strawberry"] = 0,
			["Blueberry"] = 0,
			["Pineapple"] = 0,
			["Sprinkler"] = 1,
			["Gumdrops"] = 0,
			["Ticket Planter"] = 0,
			["Plastic Planter"] = 0,
			["Paper Planter"] = 0,
			["Sprout"] = 0,
			["Star Treat"] = 0,
			["Star Jelly"] = 0,
			["Field Dice"] = 0,
		},
		Equipment = {
			Tool = "Scooper",
			Bag = "Pouch",
			Boots = "",
			Sprinkler = "",
			Mask = "",
			Belt = "",
			LeftGuards = "",
			RightGuards = "",
			Amulet = "",
			Parachutes = "",
		},
		BoxClaimed = {
			["All Items"] = false,
			["All Buffs"] = false
		},
		HiveSlotsOwn ={
			["Slot_26"] = false,
			["Slot_27"] = false,
			["Slot_28"] = false,
			["Slot_29"] = false,
			["Slot_30"] = false,
			["Slot_31"] = false,
			["Slot_32"] = false,
			["Slot_33"] = false,
			["Slot_34"] = false,
			["Slot_35"] = false,
		}
	}
	local data = _G.PlayerData[plr.Name]
	local Inventory = Instance.new("Folder",plr)
	Inventory.Name = "Inventory"
	local IsSaved = Instance.new("BoolValue",plr)
	IsSaved.Name = "Saved"
	IsSaved.Value = false
	local MakingHoney = Instance.new("BoolValue",plr)
	MakingHoney.Name = "MakingHoney"
	MakingHoney.Value = false
	local Honey = Instance.new("NumberValue",plr)
	Honey.Name = "Honey"
	Honey.Value = 0
	local Pollen = Instance.new("NumberValue",plr)
	Pollen.Name = "Pollen"
	Pollen.Value = 0
	local Cap = Instance.new("NumberValue",plr)
	Cap.Name = "Cap"
	Cap.Value = 0
	local Field = Instance.new("StringValue",plr)
	Field.Name = "Field"
	Field.Value = ""
	plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading").Visible = true
	local Hive = Instance.new("ObjectValue",plr) Hive.Name = "Hive" Hive.Value = nil
	local save = ds:GetAsync(plr.UserId)
		if save then
		for i,v in pairs(save.Stats) do
			data.Stats[i] = v
		end
		for i,v in pairs(save.Bees) do
			data.Bees[i] = v
		end
		for i,v in pairs(save.Inventory) do
			data.Inventory[i] = v
		end
		for i,v in pairs(save.Equipment) do
			data.Equipment[i] = v
		end
		if save.ActiveBuffs then
			for i,v in pairs(save.ActiveBuffs) do
				data.ActiveBuffs[i] = v
			end
		end
		if save.BoxClaimed then
			for i,v in pairs(save.BoxClaimed) do
				data.BoxClaimed[i] = v
			end
		end
		if save.HiveSlotsOwn then
			for i,v in pairs(save.HiveSlotsOwn) do
				data.HiveSlotsOwn[i] = v
			end
		end
		if save.Bosses then
			for i,v in pairs(save.Bosses) do
				data.Bosses[i] = v
			end
		end
		if save.ShopDispenserPrice then
			for i,v in pairs(save.ShopDispenserPrice) do
				data.ShopDispenserPrice[i] = v
			end
		end
		if save.Quests then
			for i,v in pairs(save.Quests) do
				data.Quests[i] = v
			end
		end
		if save.Badges then
			for i,v in pairs(save.Badges) do
				data.Badges[i] = v
			end
		end
		if save.NPCData then
			for i,v in pairs(save.NPCData) do
				data.NPCData[i] = v
			end
		end
		if save.EquipmentOwned then
			for i,v in pairs(save.EquipmentOwned) do
				data.EquipmentOwned[i] = v
			end
		end
		if save.Planters then
			for i,v in pairs(save.Planters) do
				data.Planters[i] = v
			end
		end
	end
	
	
	plr.CharacterAdded:Connect(function(char)
		require(rp.Modules:WaitForChild("Utils")).LoadEquipment(plr)
		PlrLoader.Load(plr,data.GameBuffs)
		
	end)
	plr:LoadCharacter()
	for i,v in pairs(data.Quests) do
		questModule.CreateQuestGUI(plr,v.Required,v.QuestName)
	end
	plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading").Visible = false
	for e,v in pairs(data.Inventory) do
		local val = Instance.new("IntValue",Inventory) val.Name = e val.Value = v
	end
	wait(1.5)
	for i,v in pairs(data.ActiveBuffs) do
		if v.Stack >= 1 then
			for e = 1,v.Stack do
				if e <= 1 then
					buffModule.Create(plr,i,items[i].Clr,items[i].Icon,"")
				else
					buffModule.AddStack(plr,i,"")
				end
			end
		end
	end
	--Updates 
	for i,v in pairs(data.Bosses) do
		if v.EndTime ~= 0 or v.EndTime >= os.time() then
			rp.Remotes.RunFunctionClient:FireClient(plr,"AddTimerToMob",i)
		end
	end
	planter.Load(plr)
	local char = plr.Character
	spawn(function()
		while plr do 
			wait(50)
			if not plr then
				break
			end
			local success, error = pcall(function()
				ds:SetAsync(plr.UserId, data)
			end)
			if success then
				notiModule.Create(plr, {Message = "Saved Data!", Type = "Festive"})
			else
				notiModule.Create(plr, {Message="ERROR CANT SAVE DUE: " .. error, Type="Error"})
			end
		end
	end)

	while true do
		Honey.Value = data.Stats.Honey
		Pollen.Value = data.Stats.Pollen
		Cap.Value = items[data.Equipment.Bag].Capacity
		if MakingHoney.Value == true and Pollen.Value <= 0 then
			MakingHoney.Value = false
		end
		if data.Equipment.Mask ~= "" then
			Cap.Value = items[data.Equipment.Bag].Capacity + items[data.Equipment.Mask].Capacity
		else
			Cap.Value = items[data.Equipment.Bag].Capacity
		end
		if char and data.GameBuffs["MovementCollection"] > 1 and char.Humanoid.MoveDirection.Magnitude > 0 then
			flowerModule.CreatePattern(plr,"Boots",char.PrimaryPart,1,"Boots",items[data.Equipment.Boots])
		end
		if not plr then
			break
		end
		wait(0.15)
	end
end)
--HiveClaimer--
local hiveModule = require(game.ReplicatedStorage.Modules:WaitForChild("Hive"))
rp.Remotes.ClaimHive.OnServerEvent:Connect(function(plr,hive)
	if plr.Hive.Value == nil then
		hiveModule.Claim(plr,hive)
	end
end)
rp.Remotes.TalkToNPC.OnServerEvent:Connect(function(plr,NPC)
	if workspace.QuestNPCS:FindFirstChild(NPC) then
		questModule.Talk(plr,NPC)
	end
end)
local Updater = require(game.ReplicatedStorage.Modules:WaitForChild("Update"))
Players.PlayerRemoving:Connect(function(plr)
	local save = ds:GetAsync(plr.UserId)
	_G.CurrentBuffs[plr.Name] = nil
	hiveModule.Reset(plr)
	for i,v in pairs(workspace.Debris.Entity:GetChildren()) do
		if v.Name == plr.Name then
			v:Destroy()
		end
	end
	if save ~= _G.PlayerData[plr.Name] and plr.Saved.Value == false then
		plr.Saved.Value = true
		ds:SetAsync(plr.UserId,_G.PlayerData[plr.Name])
		print("Saved-Leaving")
	end
	_G.PlayerData[plr.Name] = nil
	for _,v in pairs(workspace.Sprinklers:GetChildren()) do
		if v:IsA("Model") and string.find(v.Name,plr.Name) then
			v:Destroy()
		end
	end
end)


game:BindToClose(function()
	task.wait(1)
end)

game.ReplicatedStorage.Remotes.OpenShop.OnServerEvent:Connect(function(plr,shop,interaction)
	if game.ReplicatedStorage.Modules.Shops:FindFirstChild(shop) then
		if interaction == true then
			require(game.ReplicatedStorage.Modules.Shops:WaitForChild(shop)).Open(plr)
		else
			require(game.ReplicatedStorage.Modules.Shops:WaitForChild(shop)).Close(plr)
		end
	end
end)
local gumModule = require(rp.Modules:WaitForChild("Gumdrops"))
local sprinklerModule = require(rp.Modules:WaitForChild("SprinklerModule"))
local BeeModule = require(game.ReplicatedStorage.Modules:WaitForChild("BeeModule"))
game.ReplicatedStorage.Remotes.UseItem.OnServerEvent:Connect(function(plr,item,target,AutoRarity,AutoGifted,amnt)
	local data = _G.PlayerData[plr.Name]
	if amnt == nil or amnt and amnt <= 0 then
		amnt = 1
	end
	if data.Inventory[item] >= amnt then
		if BeeModule.Eggs[item] then
			if target and plr.Hive.Value ~= nil and target.Parent == plr.Hive.Value.Slots and target.Occupied.Value == false then
				data.Inventory[item] -= amnt
				BeeModule.NewBee(plr,target,item)
			elseif target and plr.Hive.Value ~= nil and target.Parent == plr.Hive.Value.Slots and target.Occupied.Value == true and target.Bee.Value then
				data.Inventory[item] -= amnt
				BeeModule.ReplaceBee(plr,target,item)
			end
		end
		if string.find(tostring(item),"Planter") and plr.Field.Value ~= "" then
			if target then
				planter.Plant(plr,item)
			end
		end
		if item == "Red Extract" then
			data.Inventory[item] -= 1
			if plr.PlayerGui.Main.Buffs:FindFirstChild("Red Extract Buff") then
				BuffModule.AddStack(plr,"Red Extract Buff","")
			else
				BuffModule.Create(plr,"Red Extract Buff",Color3.fromRGB(254, 198, 80),"rbxassetid://2495935291")
			end
		end
		if item == "Blue Extract" then
			data.Inventory[item] -= 1
			if plr.PlayerGui.Main.Buffs:FindFirstChild("Blue Extract Buff") then
				BuffModule.AddStack(plr,"Blue Extract Buff","")
			else
				BuffModule.Create(plr,"Blue Extract Buff",Color3.fromRGB(254, 198, 80),"rbxassetid://5916120072")
			end
		end
		if item == "Micro Converter" then
			data.Inventory[item] -= 1
			notiModule.Create(plr,{Message="+"..math.round(_G.PlayerData[plr.Name].Stats.Pollen).." Honey",Type="Default"})
			_G.PlayerData[plr.Name].Stats.Honey += _G.PlayerData[plr.Name].Stats.Pollen
			_G.PlayerData[plr.Name].Stats.Pollen = 0
		end
		if item == "Sprinkler" then
			if plr.Field.Value ~= "" then
				data.Inventory[item] -= 0
				sprinklerModule.New(plr,data.Equipment.Sprinkler)
			end
		end
		if item == "Gumdrops" then
			if plr.Field.Value ~= "" then
				data.Inventory[item] -= 1
				gumModule.SpawnGum(plr)
			end
		end
		if items[item].FeedBee == true then
			if target and plr.Hive.Value ~= nil and target.Parent.Parent.Parent == plr.Hive.Value.Slots and target.Parent.Parent.Occupied.Value == true then
				local FeedUI = plr.PlayerGui.Main.FeedUI:Clone()
				FeedUI.Parent = plr.PlayerGui.Main.FakeUI
				FeedUI.Visible = true
				FeedUI.Menu.TextLabel.Text = "How many "..item.." will you feed to "..target.Parent.Parent.Bee.Value.Name.."?"
				FeedUI.Menu.Cancel.MouseButton1Click:Connect(function()
					FeedUI:Destroy()
				end)
				if data.Inventory[item] < 50 then
					FeedUI.Menu.Feed50.Visible = false
				end
				if data.Inventory[item] < 1 then
					FeedUI.Menu.Feed1.Visible = false
					FeedUI.Menu.FeedAll.Visible = false
				end
				FeedUI.Menu.Feed1.MouseButton1Click:Connect(function()
					if data.Inventory[item] >= 1 then
				data.Inventory[item] -= 1
					BeeModule.Feed(plr,target.Parent.Parent,target.Parent.Parent.Bee.Value,items[item].Bond*1)
					FeedUI:Destroy()
						Updater.Inventory(plr)
						end
				end)
				FeedUI.Menu.Feed50.MouseButton1Click:Connect(function()
					if data.Inventory[item] >= 50 then
					data.Inventory[item] -= 50
					BeeModule.Feed(plr,target.Parent.Parent,target.Parent.Parent.Bee.Value,items[item].Bond*50)
					FeedUI:Destroy()
						Updater.Inventory(plr)
						end
				end)
				FeedUI.Menu.FeedAll.MouseButton1Click:Connect(function()
					if data.Inventory[item] >= 1 then
					BeeModule.Feed(plr,target.Parent.Parent,target.Parent.Parent.Bee.Value,items[item].Bond*data.Inventory[item])
					data.Inventory[item] = 0
					FeedUI:Destroy()
						Updater.Inventory(plr)
						end
				end)
			end
		end
		if item == "Star Treat" then
			if target and plr.Hive.Value ~= nil and target.Parent.Parent.Parent == plr.Hive.Value.Slots and target.Parent.Parent.Occupied.Value == true then
				data.Inventory[item] -= amnt
				BeeModule.Feed(plr,target.Parent.Parent,target.Parent.Parent.Bee.Value,items[item].Bond)
				BeeModule.GiftBee(plr, target.Parent.Parent)
			end
		end
		if item == "Royal Jelly" then
			if target and plr.Hive.Value ~= nil and target.Parent.Parent.Parent == plr.Hive.Value.Slots and target.Parent.Parent.Occupied.Value == true then
				data.Inventory[item] -= amnt
				if AutoRarity ~= "" or AutoGifted == true then
					if AutoGifted == true then
						if AutoRarity == "Mythic" then
							BeeModule.ReplaceBeeWithAuto(plr, target.Parent.Parent, item, target, "Mythic", true)
						elseif AutoRarity == "Legendary" then
							BeeModule.ReplaceBeeWithAuto(plr, target.Parent.Parent, item, target, "Legendary", true)	
						elseif AutoRarity == "" then
							BeeModule.ReplaceBeeWithAuto(plr, target.Parent.Parent, item, target, nil, true)	
						end
					else
						if AutoRarity == "Mythic" then
							BeeModule.ReplaceBeeWithAuto(plr, target.Parent.Parent, item, target, "Mythic", false)
						elseif AutoRarity == "Legendary" then
							BeeModule.ReplaceBeeWithAuto(plr, target.Parent.Parent, item, target, "Legendary", false)							
						end
					end
				else
					BeeModule.ReplaceBee(plr,target.Parent.Parent,item)
				end
			end
		end
		if item == "Star Jelly" then
			if target and plr.Hive.Value ~= nil and target.Parent.Parent.Parent == plr.Hive.Value.Slots and target.Parent.Parent.Occupied.Value == true then
				data.Inventory[item] -= amnt
				BeeModule.ReplaceBee(plr,target.Parent.Parent,item,true)
			end
		end
		if item == "Eviction" and plr.Hive.Value ~= nil then
			if target and target.Parent.Parent.Parent == plr.Hive.Value.Slots and target.Parent.Parent.Occupied.Value == true then
				data.Inventory[item] -= amnt
				BeeModule.Evict(plr,target.Parent.Parent)
			end
		end
		if item == "Sprout" then
			if plr.Field.Value ~= "" then
				if require(game.ReplicatedStorage.Modules.Sprout).PlrSpawnSprout(plr,plr.Field.Value) == true then
					data.Inventory[item] -= 1
					spawn(function()
						require(game.ReplicatedStorage.Modules.Sprout).PlrSpawnSprout(plr,plr.Field.Value)
					end)
				end
			else
				notiModule.Create(plr,{Message= "You Are Not In Pollen",Type="Error"})
			end
		end
		if item == "Field Dice" then
			local fieldChildrens = workspace.Fields:GetChildren()
			local randomNumber = math.random(1,#fieldChildrens) 
			local randomField = fieldChildrens[randomNumber].Name
			local boostName = randomField.. " Boost"
			data.Inventory[item] -= 1
			notiModule.Create(plr, {Message="Rolled "..boostName, Type = "Default"})
			if plr.PlayerGui.Main.Buffs:FindFirstChild(boostName) then
				BuffModule.AddStack(plr,boostName,"")
			else
				BuffModule.Create(plr,boostName,items[boostName].Clr,boostName,items[boostName].Icon)
			end
		end
		Updater.Inventory(plr)
	end
end)
rp.Remotes.GetData.OnServerInvoke = function(plr)
	return _G.PlayerData[plr.Name]
end
rp.Remotes.ModifyItemData.OnServerEvent:Connect(function(plr,item,amount)
	local data = _G.PlayerData[plr.Name]
	if amount >= 0 then
		data.Inventory[item] += amount
	end
	Updater.Inventory(plr)
end)
rp.Remotes.MakeHoney.OnServerEvent:Connect(function(plr,make)
	plr.MakingHoney.Value = make
end)
local cannonModule = require(rp.Modules:WaitForChild("CannonModule"))
rp.Remotes.ShootCannon.OnServerEvent:Connect(function(plr,cannon)
	cannonModule.Fire(plr,cannon)
end)
rp.Remotes.ClaimPlanter.OnServerEvent:Connect(function(plr,plantere)
	planter.Claim(plr,plantere)
end)
rp.Remotes.OpenSlotShop.OnServerEvent:Connect(function(plr)
	rp.Remotes.OpenSlotShop:FireClient(plr, _G.PlayerData[plr.Name])
end)
rp.Remotes.BuySlot.OnServerEvent:Connect(function(plr, code, price, hiveslotown, slotFind)
	_G.PlayerData[plr.Name].Stats.Honey -= price
	_G.PlayerData[plr.Name].HiveSlotsOwn[slotFind.Name] = true
	_G.PlayerData[plr.Name].ShopDispenserPrice.SlotShop += 1.5
	hiveModule.SlotUpdate(plr)
end)
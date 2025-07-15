-- @ScriptType: ModuleScript
local shop = {}
local shopData = {
	Name = "Starter Shop",
	Items = 4,
}
local ShopItems = {
	[1] = {
		Name = "Scooper",
		Currency = "Honey",
		ItemLocation = "EquipmentOwned",
		CurrencyLocation = "Stats",
		Amount = true,
		CurrencyCost = 0,
		Type = "Tool",
		Materials = {}	
	},
	[2] = {
		Name = "Pouch",
		Currency = "Honey",
		ItemLocation = "EquipmentOwned",
		CurrencyLocation = "Stats",
		Amount = true,
		CurrencyCost = 0,
		Type = "Bag",
		Materials = {}	
	},
	[3] = {
		Name = "Glider",
		Currency = "Honey",
		ItemLocation = "EquipmentOwned",
		CurrencyLocation = "Stats",
		Amount = true,
		CurrencyCost = 5000000,
		Type = "Parachutes",
		Materials = {}	
	},
	[4] = {
		Name = "Basic Boots",
		Currency = "Honey",
		ItemLocation = "EquipmentOwned",
		CurrencyLocation = "Stats",
		Amount = true,
		CurrencyCost = 4400,
		Type = "Boots",
		Materials = {
			[1] = {ItemName="Sunflower Seed",Amount=3},
			[2] = {ItemName="Blueberry",Amount=3},
		}	
	},
}

local itemModule = require(script.Parent.Parent:WaitForChild("Items"))
local util = require(script.Parent.Parent:WaitForChild("Utils"))
function meetReq(plr,price,item)
	local itemData = ShopItems[item]
	local data = _G.PlayerData[plr.Name]
	if #itemData.Materials >= 1 then
		local meetsFirstReq = false
		if data[itemData.CurrencyLocation][itemData.Currency] >= price then
			meetsFirstReq = true
		end
		local meetsAll = false
		local AllMats = {}
		for i,v in pairs(itemData.Materials) do
			if data["Inventory"][v.ItemName] >= v.Amount then
				table.insert(AllMats,true)
			else
				table.insert(AllMats,false)
			end
		end

		for _,v in pairs(AllMats) do
			if v == true then
				meetsAll = true
			elseif v == false then
				meetsAll = false
				break
			end
		end
		local rllyAll = false
		if meetsFirstReq == true and meetsAll == true then
			rllyAll = true
		end
		return rllyAll
	elseif itemData.Materials ~= {} then
		local meetsFirstReq = false
		if data[itemData.CurrencyLocation][itemData.Currency] >= price then
			meetsFirstReq = true
		end
		return meetsFirstReq
	end
end
local Update = require(script.Parent.Parent:WaitForChild("Update"))
local noti = require(script.Parent.Parent:WaitForChild("NotificationModule"))
function update(item,camType,plr,gui)
	local itemData = {}
	local price = 0
	local data = _G.PlayerData[plr.Name]
	local info = gui.Info
	itemData = ShopItems[item]
	price = itemData.CurrencyCost
	info.ItemName.Text = itemData["Name"]
	info.ItemPrice.Text = util.comma(price).." "..itemData.Currency
	info.ItemDesc.Text = itemModule[itemData.Name].Description
	if data.EquipmentOwned[itemData.Name] == true and data.Equipment[itemData.Type] ~= itemData.Name then
		gui.PurchaseMenu.Buy.Text = "Equip"
		gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
	end
	if data.EquipmentOwned[itemData.Name] == true and data.Equipment[itemData.Type] == itemData.Name then
		gui.PurchaseMenu.Buy.Text = "Equipped"
		gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
	end
	if data.EquipmentOwned[itemData.Name] == false then
		gui.PurchaseMenu.Buy.Text = "Purchase"
		gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
	end
	if shopData.Items <= 1 then
		gui.PurchaseMenu.Left.Visible = false
		gui.PurchaseMenu.Right.Visible = false
	else
		gui.PurchaseMenu.Left.Visible = true
		gui.PurchaseMenu.Right.Visible = true
	end
	gui.Materials.Mats:ClearAllChildren()
	script.UIListLayout:Clone().Parent = gui.Materials.Mats
	if #itemData.Materials <= 0 then
		gui.Materials.Visible = false
	elseif #itemData.Materials >= 1 then
		gui.Materials.Visible = true
		for i,v in pairs(itemData.Materials) do
			local template = game.ReplicatedStorage.Assets.Misc.Item:Clone()
			template.Visible = true
			template.Parent = gui.Materials.Mats
			template.Name = v.ItemName
			template.Image = itemModule[v.ItemName].Icon
			template.TextLabel.Text = "x"..v.Amount
		end
	end
	local req = meetReq(plr,price,item)
	if data.EquipmentOwned[itemData.Name] == false then
		if req == true then
			gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
			gui.PurchaseMenu.Buy.Text = "Purchase"
		else
			gui.PurchaseMenu.Buy.Text = "Can't afford"
			gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(209, 0, 0)
		end
	end
	return price,itemData
end
function shop.Open(plr :Player)
	local data = _G.PlayerData[plr.Name]
	local UI = plr.PlayerGui
	local gui = UI.Main.ShopTemplate:Clone()
	plr.Character.HumanoidRootPart.Anchored = true
	gui.Visible = true
	gui.Name = script.Name
	gui.Parent = UI.Main.FakeUI
	local info = gui.Info
	local price = 0 
	local itemData = {}
	local CurrentItem = 1
	gui.ProximityButton.MouseButton1Click:Connect(function()
		shop.Close(plr)
	end)
	local p, iData = update(1,"tween",plr,gui)
	itemData = iData
	price = p
	game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.Shops[script.Name].Items[itemData.Name].Cam,"tween")
	gui.PurchaseMenu.Right.MouseButton1Click:Connect(function()
		CurrentItem += 1
		if CurrentItem > shopData.Items then
			CurrentItem = 1
		end
		p, iData = update(CurrentItem,"tween",plr,gui)
		itemData = iData
		price = p
		game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.Shops[script.Name].Items[itemData.Name].Cam,"smooth")
	end)
	gui.PurchaseMenu.Left.MouseButton1Click:Connect(function()
		CurrentItem -= 1
		if CurrentItem < 1 then
			CurrentItem = shopData.Items
		end
		p, iData = update(CurrentItem,"tween",plr,gui)
		itemData = iData
		price = p
		game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.Shops[script.Name].Items[itemData.Name].Cam,"smooth")
	end)
	gui.PurchaseMenu.Buy.MouseButton1Click:Connect(function()
		local meets = meetReq(plr,price,CurrentItem)
		if data.EquipmentOwned[itemData.Name] == true and data.Equipment[itemData.Type] ~= itemData.Name then
			gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
			gui.PurchaseMenu.Buy.Text = "Equipped"
			_G.PlayerData[plr.Name]["Equipment"][itemData.Type] = itemData.Name
			noti.Create(plr,{Message="Equipped".." "..itemData.Name,Type="Default"})
		end
		if meets == true and data.EquipmentOwned[itemData.Name] == false then
			game.ReplicatedStorage.Remotes.PlaySoundClient:FireClient(plr,script.SFX)
			_G.PlayerData[plr.Name][itemData.ItemLocation][itemData.Name] = itemData.Amount
			_G.PlayerData[plr.Name]["Equipment"][itemData.Type] = itemData.Name
			shop.UseItems(plr,price,meets,CurrentItem)
			Update.Inventory(plr)
			meets = meetReq(plr,price,CurrentItem)
			noti.Create(plr,{Message="Purchased".." "..itemData.Name,Type="Default"})
			gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
			gui.PurchaseMenu.Buy.Text = "Equipped"
			if data.EquipmentOwned[itemData.Name] == false then
				if meets == true then
					gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
					gui.PurchaseMenu.Buy.Text = "Purchase"
				else
					gui.PurchaseMenu.Buy.Text = "Can't afford"
					gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(209, 0, 0)
				end
			end
			info.ItemPrice.Text = util.comma(price).." "..itemData.Currency
		end
		util.LoadEquipment(plr)
	end)
end
function shop.UseItems(plr,price,meets,item)
	if meets == true then
		local itemData = ShopItems[item]
		local data = _G.PlayerData[plr.Name]
		data[itemData.CurrencyLocation][itemData.Currency] -= price
		for _,v in pairs(itemData.Materials) do
			if data.Inventory[v.ItemName] >= v.Amount then
				data.Inventory[v.ItemName] -= v.Amount
			end
		end
	end
end
function shop.Close(plr :Player)
	local UI = plr.PlayerGui
	local gui = UI.Main
	plr.Character.HumanoidRootPart.Anchored = false
	game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.Shops["Basic Egg"]["Basic Egg"].Camera,"fixed")
	if gui.FakeUI:FindFirstChild(script.Name) then
		gui.FakeUI[script.Name]:Destroy()
	end
end

return shop

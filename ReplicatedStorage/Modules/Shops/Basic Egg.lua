-- @ScriptType: ModuleScript
local shop = {}
local shopData = {
	Name = "Basic Egg",
	Items = 1,
}
local itemData = {
	Name = "Basic Egg",
	Currency = "Honey",
	ItemLocation = "Inventory",
	CurrencyLocation = "Stats",
	Amount = 1,
	Materials = {}
}
function shop.GetPrice(plr)
	local data = _G.PlayerData[plr.Name].ShopDispenserPrice
	local base = 1000
	local cost = 0
	cost = base
	local i = 0
	local N = 0
	local max = 10000000
	local maxN = 22
	N = data[itemData.Name]+1
	if N >= maxN then
		N = maxN
	end
	while i < N-1 do
		cost = 1.5*cost + base/(i+1)
		i = i + 1
	end
	if cost >= max then
		cost = max
	end
    return math.round(cost)
end

local itemModule = require(script.Parent.Parent:WaitForChild("Items"))
local util = require(script.Parent.Parent:WaitForChild("Utils"))
function meetReq(plr,price)
	local data = _G.PlayerData[plr.Name]
	if itemData.Materials == {} then
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
local update = require(script.Parent.Parent:WaitForChild("Update"))
local noti = require(script.Parent.Parent:WaitForChild("NotificationModule"))
function shop.Open(plr :Player)
	local data = _G.PlayerData[plr.Name]
	local UI = plr.PlayerGui
	local gui = UI.Main.ShopTemplate:Clone()
	plr.Character.HumanoidRootPart.Anchored = true
	gui.Visible = true
	gui.Name = script.Name
	game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.Shops["Basic Egg"]["Basic Egg"].Camera,"tween")
	gui.Parent = UI.Main.FakeUI
	local price = shop.GetPrice(plr)
	local info = gui.Info
	info.ItemName.Text = itemData["Name"]
	info.ItemPrice.Text = util.comma(price).." "..itemData.Currency
	info.ItemDesc.Text = itemModule[itemData.Name].Description
	gui.ProximityButton.MouseButton1Click:Connect(function()
		shop.Close(plr)
	end)
	local item = 0
	if shopData.Items <= 1 then
		gui.PurchaseMenu.Left.Visible = false
		gui.PurchaseMenu.Right.Visible = false
	else
		gui.PurchaseMenu.Left.Visible = true
		gui.PurchaseMenu.Right.Visible = true
	end
	local req = meetReq(plr,price)
	if req == true then
		gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
		gui.PurchaseMenu.Buy.Text = "Purchase"
	else
		gui.PurchaseMenu.Buy.Text = "Can't afford"
		gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(209, 0, 0)
	end
	if itemData.Materials ~= {} then
		gui.Materials.Visible = false
	elseif itemData.Materials == {} then
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
	gui.PurchaseMenu.Buy.MouseButton1Click:Connect(function()
		local meets = meetReq(plr,price)
		if meets == true then
			game.ReplicatedStorage.Remotes.PlaySoundClient:FireClient(plr,script.SFX)
			_G.PlayerData[plr.Name][itemData.ItemLocation][itemData.Name] += itemData.Amount
			_G.PlayerData[plr.Name].ShopDispenserPrice[itemData.Name] += itemData.Amount
			shop.UseItems(plr,price,meets)
			update.Inventory(plr)
			price = shop.GetPrice(plr)
			meets = meetReq(plr,price)
			if meets == true then
				gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(30, 209, 20)
				gui.PurchaseMenu.Buy.Text = "Purchase"
			else
				gui.PurchaseMenu.Buy.Text = "Can't afford"
				gui.PurchaseMenu.Buy.BackgroundColor3 = Color3.fromRGB(209, 0, 0)
			end
			noti.Create(plr,{Message="+"..itemData.Amount.." "..itemData.Name,Type="Default"})
			info.ItemPrice.Text = util.comma(price).." "..itemData.Currency
		end
	end)
end
function shop.UseItems(plr,price,meets)
	if meets == true then
		local data = _G.PlayerData[plr.Name]
		data[itemData.CurrencyLocation][itemData.Currency] -= price
		for _,v in pairs(itemData.Materials) do
			if data.Invenotry[v.ItemName] >= v.Amount then
				data.Invenotry[v.ItemName] -= v.Amount
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

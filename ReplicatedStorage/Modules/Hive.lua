-- @ScriptType: ModuleScript
local Hive = {}


local beeModule = require(script.Parent:WaitForChild("BeeModule"))
function Hive.SlotUpdate(plr)
	local hive = plr.Hive.Value
	for index, value in pairs(_G.PlayerData[plr.Name].HiveSlotsOwn) do
		if value == true then
			local slotsFind = hive.Slots[index]
			if slotsFind and slotsFind:FindFirstChild("Owned") then
				slotsFind.Transparency = 0.3
				slotsFind.Color = Color3.fromRGB(105, 64, 40)
				slotsFind.Owned.Value = true
			end
		end
	end
end
function Hive.Claim(plr,hive)
	if plr.Hive.Value == nil then
		plr.Hive.Value = hive
		hive.Platform.Top.Username.User.Text = plr.Name
		hive.Claimed.Value = true
		for index, value in pairs(_G.PlayerData[plr.Name].HiveSlotsOwn) do
			if value == true then
				local slotsFind = hive.Slots[index]
				if slotsFind and slotsFind:FindFirstChild("Owned") then
					slotsFind.Transparency = 0.3
					slotsFind.Color = Color3.fromRGB(105, 64, 40)
					slotsFind.Owned.Value = true
				end
			end
		end
		for _,v in pairs(_G.PlayerData[plr.Name].Bees) do
			beeModule.LoadBee(plr,v)
		end
	end
end
function Hive.Reset(plr)
	print("reseting")
	if plr.Hive.Value ~= nil then
		local hive = plr.Hive.Value
		hive.Claimed.Value = false
		hive.Platform.Top.Username.User.Text = ""
		for _,v in pairs(hive.Slots:GetChildren()) do
			if v:FindFirstChild("Cover") then
				v.Cover:Destroy()
				v.Occupied.Value = false
				v.Bee.Value:Destroy()
				v.Bee.Value = nil
				v.Color = Color3.fromRGB(105, 64, 40)
				v.Transparency = 0.3
			end
		end
		for i=26,35 do
			local slotsFind = hive.Slots["Slot_"..i]
			if slotsFind and slotsFind:FindFirstChild("Owned") then
				print(slotsFind.Name)
				slotsFind.Transparency = 1
				slotsFind.Color = Color3.fromRGB(105, 64, 40)
				slotsFind.Owned.Value = false
			end
		end
	end
end
return Hive

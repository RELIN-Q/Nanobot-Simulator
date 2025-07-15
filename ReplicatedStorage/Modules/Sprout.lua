-- @ScriptType: ModuleScript
local module = {}
local cooldown = false

local gui = script.BillboardGui


local SproutsChance = {
	["BasicSprout"] = 75,
	["SupremeSprout"] = 2,
	["RareSprout"] = 45,
	["EpicSprout"] = 20,
	["LegendarySprout"] = 10,

}
local Health = {
	["BasicSprout"] = 100000,
	["SupremeSprout"] = 5000000,
	["RareSprout"] = 400000,
	["EpicSprout"] = 650000,
	["LegendarySprout"] = 1000000,
}

local fieldchance = {
	["Clover Field"] = 100

}
local ActiveSprout = {}

function Pick(tab)
	local tw = 0
	for _,v in pairs(tab) do
		tw += v		
	end

	local R = Random.new():NextInteger(1,tw)
	local Chance = 0
	for i,v in pairs(tab) do
		Chance += v
		if R <= Chance then
			return i
		end
	end
end

function module.PlrSpawnSprout(plr,field)

	local sproutchance = Pick(SproutsChance)

	local fieldchance = field
	if ActiveSprout[fieldchance] then 
		return false
	else
	

		local clone = game:GetService("ReplicatedStorage").Assets.Sprout[sproutchance]:Clone()
		clone.Size = Vector3.new(0,0,0) 
		local guiclone = clone:WaitForChild("BillboardGui1")
		
		game:GetService("TweenService"):Create(clone,TweenInfo.new(1,Enum.EasingStyle.Bounce),{Size = Vector3.new(10.379, 9.942, 4.488)}):Play()

		clone.Appear:Play()
		for _,ple in pairs(game.Players:GetChildren()) do
			require(game.ReplicatedStorage.Modules.NotificationModule).Create(ple,{Message = plr.Name .. " Has Spawned " .. clone.Name  ,Type = "Default"})

		end
		game.ReplicatedStorage.Remotes.SendMessage:FireAllClients(string.format("%s has spawned  %s ",plr.Name,clone.Name),Color3.fromRGB(255, 255, 0))
		ActiveSprout[fieldchance] = fieldchance

		local sproutHealt = Health[sproutchance]
		local fieldbox = workspace.Fields[fieldchance].FieldBox





		clone.Parent = workspace.Sprouts
		guiclone.Parent = clone

		guiclone.TextLabel1.Text = require(game.ReplicatedStorage.Modules.Utils).comma( sproutHealt).. "🌸"

		clone.Field.Value = fieldchance
		clone.Health.Value = sproutHealt

		clone.Aura.Position = fieldbox.Position 
		clone.Position = fieldbox.Position + Vector3.new(0,5,0)   
		wait(1)
		clone.Stages.Enabled = true
		
		spawn(function()
			wait(300)
			if clone then
				clone:Destroy()
				ActiveSprout[clone.Field.Value] = nil
			end
		end)
return true
	end
end
local tokenmodule = require(game:GetService("ReplicatedStorage").Modules:FindFirstChild("TokenModule"))
function module.Destroy(Sprout)
	local ItemModule = require(game.ReplicatedStorage.Modules.Items)
	local field = workspace.Fields[Sprout.Field.Value]
	local fieldbox = field.FieldBox
	Sprout.Destroyed:Play()

	  ActiveSprout[Sprout.Field.Value] = nil
	
	for ind,v in pairs(ItemModule[Sprout.Name].Loot) do
		Sprout:Destroy()
		for i=1,10 do
			wait(0.03)
			spawn(function()
				local chance = Pick(ItemModule[Sprout.Name].Loot[field.Name])

				local amount = ItemModule[Sprout.Name].Amount[field.Name][chance]
				local position = Vector3.new(math.random(fieldbox.Position.X-fieldbox.Size.X/2,fieldbox.Position.X+fieldbox.Size.X/2) ,fieldbox.Position.Y+2, math.random(fieldbox.Position.Z-fieldbox.Size.Z/2,fieldbox.Position.Z+fieldbox.Size.Z/2))
				
				if chance == "Festive Pollen" or chance == "Festive Honey" then
					tokenmodule.new("All",position,chance,nil,nil)

				else
					tokenmodule.new("All",position,chance,nil,amount)

				end
				
			end)

	end
	
	end
	
end

return module

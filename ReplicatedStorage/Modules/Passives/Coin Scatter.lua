-- @ScriptType: ModuleScript
local module = {}


local rp = game:GetService("ReplicatedStorage")
local tokenModule = require(rp.Modules:WaitForChild("TokenModule"))

function getFlowerfromField(field)
	local flowers = workspace.Fields[field]:GetChildren()
	local flower = nil
	repeat wait()
		flower = flowers[math.random(1,#flowers)]
	until flower ~= nil and flower:FindFirstChild("Amnt")
	return flower
end

function module.Spawn(plr)
	local field = plr.Field.Value
	local PData = _G.PlayerData[plr.Name]
	if field == "" then return end
	local pollen = PData.Stats.Pollen/2
	PData.Stats.Pollen -= pollen
	for i = 1,25 do
		if field == "" then break end
		local flower = getFlowerfromField(field)
		if flower then
			local MadePercent = ((math.round(pollen)/100)*(300/25))+math.round(pollen)
			tokenModule.new(plr,Vector3.new(flower.Position.X,flower.Parent.FieldBox.Position.Y-0.3+.7+3.323,flower.Position.Z),"Honey",nil,MadePercent)
		end
	end
	return
end

return module

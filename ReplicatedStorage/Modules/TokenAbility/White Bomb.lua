-- @ScriptType: ModuleScript
local bomb = {}

local flrModule = require(script.Parent.Parent:WaitForChild("FlowerScript"))

function getClosestFieldToToken(pos)
	for _,v in pairs(workspace.Fields:GetChildren()) do
		if pos and (pos-v.FieldBox.Position).magnitude <= 110 then
			return v.Name
		end
	end
end
local Boost = {
	ConvertionRate = 0,
	BlueConvertRate = 0,
	RedConvertRate = 0,
	WhiteConvertRate = 0,
	WhiteRate = 250,
	RedRate = 50,
	Power = 0.3,
	BlueRate = 50,
}
function bomb.Collect(plr,pos)
	local field = getClosestFieldToToken(pos)
	if field then
		local p = Instance.new("Part",workspace)
		p.Name = "PosTest"
		p.Anchored = true
		p.CanCollide = false
		p.Transparency = 1
		p.Size = Vector3.new(1,1,1)
		p.Position = pos
		require(game.ReplicatedStorage.Modules:WaitForChild("Utils")).Explosion(pos,Color3.fromRGB(255, 255, 255))
		game.Debris:AddItem(p,0.2)
		flrModule.CreatePattern(plr,script.Name,p,1,script.Name,Boost)
	end
end

return bomb

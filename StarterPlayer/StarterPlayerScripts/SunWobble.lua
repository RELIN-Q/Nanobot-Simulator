-- @ScriptType: LocalScript
local RunService = game:GetService("RunService")

local Sun = game.Workspace:WaitForChild("Fake Sun")
local Moon = game.Workspace:WaitForChild("Fake Moon")
local eTime = 0
local OriginalSize = Sun.Size

RunService.PreRender:Connect(function(dt)
	eTime += dt
	
	local SizeX = 1 + math.noise(eTime, 0, 0) * 0.1
	local SizeY = 1 + math.noise(0, eTime, 0) * 0.1
	local SizeZ = 1 + math.noise(0, 0, eTime) * 0.1
	
	Sun.Size = vector.create(OriginalSize.X * SizeX, OriginalSize.Y * SizeY, OriginalSize.Z * SizeZ)
end)
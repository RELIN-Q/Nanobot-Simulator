-- @ScriptType: ModuleScript
local module = {}

function module.Load(plr :Player,buffs)
	local char = plr.Character
	local hum = char:WaitForChild("Humanoid")
	hum.WalkSpeed = buffs.PlayerMovespeed
	hum.JumpPower = buffs.PlayerJumpPower
end

return module

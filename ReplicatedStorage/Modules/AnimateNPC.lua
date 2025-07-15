-- @ScriptType: ModuleScript
local npc = {}

local npcs = workspace.QuestNPCS

npc.Animations = {
	["Black Bear"] = {
		[1] = "rbxassetid://742637544"
	}
}


function npc.Initiate()
	for _,e in pairs(npcs:GetChildren()) do
		local v = e.NPC
		if v and v:FindFirstChild("Humanoid") then
			local anim = Instance.new("Animation",v.Humanoid)
			anim.AnimationId = npc.Animations[e.Name][1]
			local loadedAnimation = v.Humanoid:LoadAnimation(anim)
			loadedAnimation.Looped = true
			loadedAnimation:Play()
		end
	end
end

return npc
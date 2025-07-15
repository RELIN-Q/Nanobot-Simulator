-- @ScriptType: Script
plrs = game:GetService("Players") -- Get Players; this service allows us to know when a player joins the game and other player-related things
ps = game:GetService("PhysicsService") -- Get PhysicsService; this service allows us to manage collision groups

ps:RegisterCollisionGroup("plrs") -- Create collision group for players only
ps:CollisionGroupSetCollidable("plrs","plrs",false) -- Make the group not collide with other parts in that same group (This is why we create a new, seperate collision group for players; if we did this with the normal collision group, the players would fall through the world!)

plrs.PlayerAdded:Connect(function(plr) -- When a player joins,
	plr.CharacterAdded:Connect(function(chr) -- wait for their character to load. Once it does,
		for key,value in pairs(chr:GetDescendants()) do -- loop through the character's descendants/parts.
			if value:IsA("BasePart") then -- If a descendant is found to be eligable for collision groups (If this part of the character is a body part),
				value.CollisionGroup = "plrs" -- set its collision group to the players only group
			end
		end
	end)
end)
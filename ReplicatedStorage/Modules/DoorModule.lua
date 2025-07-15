-- @ScriptType: ModuleScript
local door = {}
local doors = workspace.Doors
local barriers = workspace.AreaBarriers
function door.Init()
	for _,v in pairs(barriers:GetChildren()) do
		local beeNr = tostring(v.Name):match("%d+")
		v.Touched:Connect(function(hit)
			if hit and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("HumanoidRootPart") then
				local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
				if plr then
					local Pdata = _G.PlayerData[plr.Name]
					local bees = #Pdata.Bees
					if bees < tonumber(beeNr) then
						local spawner = workspace:FindFirstChildWhichIsA("SpawnLocation")
						if spawner then
							hit.Parent:SetPrimaryPartCFrame(spawner.CFrame*CFrame.new(0,2.5,0))
						end
					end
				end
			end
		end)
	end
end

return door

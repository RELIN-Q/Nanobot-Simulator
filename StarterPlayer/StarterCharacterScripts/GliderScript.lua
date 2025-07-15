-- @ScriptType: LocalScript
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local heaLoopmodel
local gliding = false
wait(1)
if UIS.TouchEnabled then
	UIS.JumpRequest:Connect(function()
		local character = player.Character
		local Humanoid = character:WaitForChild("Humanoid")
		local state = Humanoid:GetState()
		
			if state == Enum.HumanoidStateType.Freefall then
				if gliding == false then
					gliding = true
				elseif gliding == true then
					gliding = false
				end
			else
				gliding = false
			end
	end)
else
	UIS.InputBegan:Connect(function(key)
		local character = player.Character
		local Humanoid = character:WaitForChild("Humanoid")

		if key.KeyCode == Enum.KeyCode.Space then
			if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				if gliding == false then
					gliding = true
				elseif gliding == true then
					gliding = false
				end
			else
				gliding = false
			end
		end
	end)
end

--UIS.JumpRequest:Connect(function()
--	local character = player.Character
--	local Humanoid = character:WaitForChild("Humanoid")

--	if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
--		if gliding == false then
--			gliding = true
--		elseif gliding == true then
--			gliding = false
--		end
--	else
--		gliding = false
--	end
--end)

while wait() do
	local character = player.Character
	local Humanoid = character:WaitForChild("Humanoid")
	local RootPart = character:WaitForChild("HumanoidRootPart")
	if gliding == true and player.Character:FindFirstChild("Glider") then
		if not RootPart:FindFirstChild("GliderVelocity") then
			local bodyVel = Instance.new("BodyVelocity")
			bodyVel.Name = "GliderVelocity"
			bodyVel.MaxForce = Vector3.new(3500, 3500, 3500)
			bodyVel.P = 1250

			bodyVel.Velocity = RootPart.CFrame.lookVector * 80 + Vector3.new(0, -16, 0)
			bodyVel.Parent = RootPart

			local model = game.ReplicatedStorage:WaitForChild("GliderDebris"):Clone()
			model.Parent = character
			heaLoopmodel = game:GetService("RunService").RenderStepped:Connect(function()
				model.Handle.CFrame = player.Character:FindFirstChild("HumanoidRootPart").CFrame
			end)
		else
			local bodyVel = RootPart:FindFirstChild("GliderVelocity")
			bodyVel.Name = "GliderVelocity"
			bodyVel.MaxForce = Vector3.new(3500, 3500, 3500)
			bodyVel.P = 1250

			bodyVel.Velocity = RootPart.CFrame.lookVector * 80 + Vector3.new(0, -16, 0)
			bodyVel.Parent = RootPart
		end
	else
		if RootPart:FindFirstChild("GliderVelocity") then
			RootPart:FindFirstChild("GliderVelocity"):Destroy()
			character:FindFirstChild("GliderDebris"):Destroy()
			heaLoopmodel:Disconnect()
		end
	end

	if Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
		if RootPart:FindFirstChild("GliderVelocity") then
			RootPart:FindFirstChild("GliderVelocity"):Destroy()
			character:FindFirstChild("GliderDebris"):Destroy()
			heaLoopmodel:Disconnect()
		end
	end
end
-- @ScriptType: LocalScript
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local function hideBackpack()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
end

local function getFirstTool()
	local backpack = player:WaitForChild("Backpack")
	for _, tool in ipairs(backpack:GetChildren()) do
		if tool:IsA("Tool") then
			return tool
		end
	end
	return nil
end

local function equipFirstTool()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local tool = getFirstTool()
	if tool then
		humanoid:EquipTool(tool)
	end
end

local function onCharacterLoaded(character)
	hideBackpack()
	character:WaitForChild("Humanoid")
	equipFirstTool()
end

-- Unified CharacterAdded connection
player.CharacterAdded:Connect(onCharacterLoaded)

-- One-time check in case character is already loaded
if player.Character then
	onCharacterLoaded(player.Character)
end

-- Keep hiding default backpack GUI clone (just in case)
RunService.RenderStepped:Connect(function()
	for _, gui in ipairs(player.PlayerGui:GetChildren()) do
		if gui.Name == "Backpack" then
			gui.Enabled = false
		end
	end
end)
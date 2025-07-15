-- @ScriptType: Script
wait(1)
local plr = game.Players[script.Parent.Parent.Name]
local display = script.Parent.Display
local UI = display.Gui

while wait(0.3) do
	UI.ProgressLabel.Text = math.round(_G.PlayerData[plr.Name].Stats.Pollen).."/".._G.PlayerData[plr.Name].Stats.Capacity
	UI.ProgressBar.Size = UDim2.new(math.round(_G.PlayerData[plr.Name].Stats.Pollen)/_G.PlayerData[plr.Name].Stats.Capacity,0,1,0)
	if math.round(_G.PlayerData[plr.Name].Stats.Pollen) >= _G.PlayerData[plr.Name].Stats.Capacity then
		UI.ProgressBar.Size = UDim2.new(1,0,1,0)
	end
end
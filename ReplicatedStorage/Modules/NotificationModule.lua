-- @ScriptType: ModuleScript
local noti = {}

noti.Types = {
	["Default"] = Color3.fromRGB(0, 123, 238),
	["Error"] = Color3.fromRGB(255, 0, 0),
	["Festive"] = Color3.fromRGB(11, 255, 166),
}
local ts = game:GetService("TweenService")
function noti.Create(plr,notificationData)
	local notiColor = noti.Types[notificationData.Type]
	local msg = notificationData.Message
	local plrUI = plr.PlayerGui
	local Menu = plrUI.Main
	local notis = Menu.Notifications
	local notiBtn = script.Popup:Clone()
	notiBtn.Name = msg
	notiBtn.Parent = notis
	notiBtn.Visible = true
	notiBtn.Text = msg	
	notiBtn.BackgroundColor3 = notiColor
	game.Debris:AddItem(notiBtn,5)
	spawn(function()
		task.wait(4)
		if notiBtn then
			ts:Create(notiBtn,TweenInfo.new(0.8),{BackgroundTransparency=1,TextTransparency=1},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
		end
	end)
end

return noti

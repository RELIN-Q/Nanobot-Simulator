-- @ScriptType: ModuleScript
local Buff = {}
Buff.Buffs = {
	["Tidal Power"] = {
		Stack = 500,
		Time = 100,
		ToolStats = {
			Stack = 0,
		},
		ToolBuffs = {
		},
		PlayerStats = {},
		PlayerStatsValue = {},
		PlayerBuffs = {},
		FieldBoosts = {},
	},
	["Tidal Surge"] = {
		Stack = 1,
		Time = 10,
		ToolStats = {
			Speed = 0.4
		},
		ToolBuffs = {
			Speed = 0.1
		},
		PlayerStats = {},
		PlayerStatsValue = {},
		PlayerBuffs = {},
		FieldBoosts = {},
	},
	["Red Extract Buff"] = {
		Stack = 1,
		Time = 600,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {
			["RedBoost"] = 150	
		},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {},
	},
	["Blue Boost"] = {
		Stack = 10,
		Time = 15,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {
		["BlueBoost"] = 15	
		},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {},
	},
	["Red Boost"] = {
		Stack = 10,
		Time = 15,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {
			["RedBoost"] = 15	
		},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {},
	},
	["Honey Hammer Boost"] = {
		Stack = 0,
		Time = 0,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {
		},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {},
	},
	["Science Enhancement"] = {
		Stack = 31,
		Time = "Forever",
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerStats = {
			["ConvertionRate"] = 25
		},
		PlayerStatsValue = {
		},
		PlayerBuffs = {
			ConvertVisualGUIRate = 25
		},
		FieldBoosts = {},
	},
	["Clover Field Boost"] = {
		Stack = 4,
		Time = 600,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {
			["Clover Field"] = 1	
		},
	},
	["Bamboo Field Boost"] = {
		Stack = 4,
		Time = 600,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {
			["Bamboo Field"] = 1	
		},
	},
	["Pepper Field Boost"] = {
		Stack = 4,
		Time = 600,
		ToolStats = {
		},
		ToolBuffs = {
		},
		PlayerBuffs = {},
		PlayerStats = {},
		PlayerStatsValue = {},
		FieldBoosts = {
			["Pepper Field"] = 1	
		},
	},
}
local ts = game:GetService("TweenService")
local items = require(script.Parent:WaitForChild("Items"))
function spawner(func,e1,e2)
	local co = coroutine.wrap(func)
	co(e1,e2)
end
function Buff.Reset(plr,UIElement)
	if _G.CurrentBuffs[plr.Name][UIElement.Name] then
		if tonumber(Buff.Buffs[UIElement.Name].Time) ~= nil then
		UIElement.Bar.Size = UDim2.new(1,0,_G.CurrentBuffs[plr.Name][UIElement.Name].Time/Buff.Buffs[UIElement.Name].Time,0)
		_G.CurrentBuffs[plr.Name][UIElement.Name].Time = Buff.Buffs[UIElement.Name].Time
			UIElement.Time.Value = Buff.Buffs[UIElement.Name].Time
			end
	end
	return
end
function Buff.Delete(plr,buffName)
	if _G.CurrentBuffs[plr.Name][buffName] then
		_G.CurrentBuffs[plr.Name][buffName].Time = 0
	end
	return
end
function Buff.TweenValue(plr,value,tim,x)
	ts:Create(value,TweenInfo.new(tim),{Value=x},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
end
function Buff.Update(plr,buffname)
	--[[
	for i,v in pairs(Buff.Buffs[buffname].ToolBuffs) do
		if #plr.Backpack:GetChildren() >= 1 and plr.Backpack:GetChildren()[1]:FindFirstChild(i) then
			if plr.Backpack:GetChildren()[1][i].Value < Buff.Buffs[buffname].ToolCap[i] then
				plr.Backpack:GetChildren()[1][i].Value += v
				end
		end 
		if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild(i) then
			if plr.Character:FindFirstChildOfClass("Tool")[i].Value < Buff.Buffs[buffname].ToolCap[i] then
				plr.Character:FindFirstChildOfClass("Tool")[i].Value += v
				end
		end 
	end 
	]]
	for i,v in pairs(Buff.Buffs[buffname].PlayerStatsValue) do
		if plr[i] then
			plr[i].Value += v
		end
	end 
	for i,v in pairs(Buff.Buffs[buffname].PlayerBuffs) do
			_G.PlayerData[plr.Name].GameBuffs[i] += v
	end 
	for i,v in pairs(Buff.Buffs[buffname].PlayerStats) do
		if _G.PlayerData[plr.Name].PlayerBuffs[i] then
			_G.PlayerData[plr.Name].PlayerBuffs[i] += v
			end
	end 
	for i,v in pairs(Buff.Buffs[buffname].FieldBoosts) do
		_G.PlayerData[plr.Name].FieldBoosts[i] += v
	end 
end
function Buff.AddStack(plr,buff,e)
	local UI = plr.PlayerGui
	local BuffUI = UI.Main.Buffs[buff]
	if BuffUI.Stack.Value >= Buff.Buffs[buff].Stack then
	else
		BuffUI.Stack.Value += 1
		if e == "ChangeData" then
			_G.PlayerData[plr.Name].ActiveBuffs[buff].Stack += 1
		end
		Buff.Update(plr,buff)
	end
	Buff.Reset(plr,BuffUI)
end
function Buff.Start(plr,UIElement)
	local buffname = UIElement.Name
	playBuffAnim(UIElement)
	for i,v in pairs(Buff.Buffs[buffname].ToolBuffs) do
		if #plr.Backpack:GetChildren() >= 1 and plr.Backpack:GetChildren()[1]:FindFirstChild(i) then
			Buff.TweenValue(plr,plr.Backpack:GetChildren()[1][i],Buff.Buffs[buffname].Time,v)
		end 
		if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild(i) then
			Buff.TweenValue(plr,plr.Character:FindFirstChildOfClass("Tool")[i],Buff.Buffs[buffname].Time,v)
		end 
	end 
	for i,v in pairs(Buff.Buffs[buffname].PlayerBuffs) do
		if _G.PlayerData[plr.Name].GameBuffs[i] then
			_G.PlayerData[plr.Name].GameBuffs[i] += v
		end
	end
	for i,v in pairs(Buff.Buffs[buffname].FieldBoosts) do
		_G.PlayerData[plr.Name].FieldBoosts[i] += v
	end 
	while wait(1) do
		if UIElement == nil then
			break
		end
		if UIElement and _G.CurrentBuffs[plr.Name] and _G.CurrentBuffs[plr.Name][UIElement.Name] and _G.CurrentBuffs[plr.Name][UIElement.Name].Time ~= "Forever" then
		if _G.CurrentBuffs[plr.Name][UIElement.Name].Time <= 0 then
			break
			end
			if UIElement and UIElement:FindFirstChild("Bar") and _G.CurrentBuffs[plr.Name] and _G.CurrentBuffs[plr.Name][UIElement.Name] then
				local Time = _G.CurrentBuffs[plr.Name][UIElement.Name].Time
				UIElement.Bar.Size = UDim2.new(1,0,Time/Buff.Buffs[UIElement.Name].Time,0)
			_G.CurrentBuffs[plr.Name][UIElement.Name].Time -= 1
				UIElement.Time.Value = Time
				if UIElement.Stack.Value > 1 then
					UIElement.amount.Text = "x"..UIElement.Stack.Value
				else
					UIElement.amount.Text = ""
				end
			end
		else
			if UIElement and UIElement:FindFirstChild("Time") and _G.CurrentBuffs[plr.Name] and _G.CurrentBuffs[plr.Name][UIElement.Name] then
				UIElement.Time.Value = 252165120
				if UIElement.Stack.Value > 1 then
					UIElement.amount.Text = "x"..UIElement.Stack.Value
				else
					UIElement.amount.Text = ""
				end
			end
			end
	end
	for i,v in pairs(Buff.Buffs[UIElement.Name].ToolStats) do
		if #plr.Backpack:GetChildren() >= 1 and plr.Backpack:GetChildren()[1]:FindFirstChild(i) then
			plr.Backpack:GetChildren()[1][i].Value = v
		end 
		if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild(i) then
			plr.Character:FindFirstChildOfClass("Tool")[i].Value = v
		end 
	end
	for i,v in pairs(Buff.Buffs[buffname].PlayerBuffs) do
		if _G.PlayerData[plr.Name].GameBuffs[i] then
			_G.PlayerData[plr.Name].GameBuffs[i] -= v*UIElement.Stack.Value
		end
	end 
	_G.CurrentBuffs[plr.Name][UIElement.Name] = nil
	if _G.PlayerData[plr.Name].ActiveBuffs[UIElement.Name] then
		_G.PlayerData[plr.Name].ActiveBuffs[UIElement.Name].Stack = 0
	end
	for i,v in pairs(Buff.Buffs[buffname].PlayerStats) do
		if _G.PlayerData[plr.Name].PlayerBuffs[i] then
			_G.PlayerData[plr.Name].PlayerBuffs[i] = 0
		end
	end
	for i,v in pairs(Buff.Buffs[buffname].FieldBoosts) do
		if _G.PlayerData[plr.Name].FieldBoosts[i] then
			_G.PlayerData[plr.Name].FieldBoosts[i] -= v*UIElement.Stack.Value
		end
	end 
	UIElement:Destroy()
	return
end
function playBuffAnim(frame :Frame)
	--Not In Use
end
function Buff.Create(plr :Player,buffName,BarColor,Icon,e)
	local UI = plr.PlayerGui
	local Buffs = UI:WaitForChild("Main"):WaitForChild("Buffs")
	local Tool = plr.Backpack:GetChildren()[1]
	local toolmodule = items[Tool]
	if Buffs:FindFirstChild(buffName) then
	
	else
		local buffUI = script.Buff:Clone()
		buffUI.Parent = Buffs
		buffUI.Name = buffName
		buffUI.Visible = true
		if e == "ChangeData" then
			_G.PlayerData[plr.Name].ActiveBuffs[buffName].Stack = 1
		end
		buffUI.Stack.Value = 1
		_G.CurrentBuffs[plr.Name][buffName] = {
			Time = Buff.Buffs[buffName].Time
		}
		buffUI.Icon.Image = Icon
		buffUI.BackgroundColor3 = BarColor
		buffUI.Bar.BackgroundColor3 = BarColor
		buffUI.Bar.Size = UDim2.new(1,0,1,0)
		buffUI.amount.Text = "x1"
		buffUI.Time.Value = Buff.Buffs[buffName].Time
		playBuffAnim(buffUI)
		spawner(Buff.Start,plr,buffUI)
	end
end


return Buff

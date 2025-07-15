-- @ScriptType: ModuleScript
local quest = {}
local util = require(game.ReplicatedStorage.Modules:WaitForChild("Utils"))
local noti = require(game.ReplicatedStorage.Modules:WaitForChild("NotificationModule"))
function quest.AssignQuest(plr,qT,qN,NPC)
	if plr then
		local questTable = {
			["QuestName"] = "",
			Required = {}
		}
		questTable.QuestName = qN
		questTable.Required = qT
		local data = _G.PlayerData[plr.Name]
		local deepCopy = util.deepCopy(questTable)
		data.Quests[NPC] = deepCopy
		data.NPCData[NPC].Claimed = true
		quest.CreateQuestGUI(plr,deepCopy.Required,qN)
	end
end

function quest.GetQuestText(playerQuestData,completed)
	local txt = ""
	if playerQuestData.QuestType == "CollectPollen" and playerQuestData.PollenType ~= "" then
		txt = "Collect "..playerQuestData.Amount.." Pollen from "..playerQuestData.PollenType..". "..util.comma(math.round(playerQuestData.Collected)).."/"..util.comma(playerQuestData.Amount)
	end
	if playerQuestData.QuestType == "CollectPollen" and playerQuestData.PollenType == "" then
		txt = "Collect "..playerQuestData.Amount.." Pollen. "..util.comma(math.round(playerQuestData.Collected)).."/"..util.comma(playerQuestData.Amount)
	end
	if playerQuestData.QuestType == "CollectColor" then
		txt = "Collect "..playerQuestData.Amount.." "..playerQuestData.PollenType.." Pollen. "..util.comma(math.round(playerQuestData.Collected)).."/"..util.comma(playerQuestData.Amount)
	end
	if playerQuestData.QuestType == "CollectGum" then
		txt = "Collect "..playerQuestData.Amount.." "..playerQuestData.PollenType..". "..util.comma(math.round(playerQuestData.Collected)).."/"..util.comma(playerQuestData.Amount)
	end
	if playerQuestData.QuestType == "Defeat" then
		txt = "Defeat "..playerQuestData.Amount.." "..playerQuestData.PollenType..". "..util.comma(math.round(playerQuestData.Collected)).."/"..util.comma(playerQuestData.Amount)
	end
	if playerQuestData.QuestType == "CollectToken" then
		txt = "Collect "..playerQuestData.Amount.." "..playerQuestData.PollenType.." Tokens. "..util.comma(math.round(playerQuestData.Collected)).."/"..util.comma(playerQuestData.Amount)
	end
	if completed == true then
		if playerQuestData.QuestType == "CollectPollen" and playerQuestData.PollenType ~= "" then
			txt = "Collect "..playerQuestData.Amount.." Pollen from "..playerQuestData.PollenType..". Completed"
		end
		if playerQuestData.QuestType == "CollectPollen" and playerQuestData.PollenType == "" then
			txt = "Collect "..playerQuestData.Amount.." Pollen. Completed"
		end
		if playerQuestData.QuestType == "CollectGum" then
			txt = "Collect "..playerQuestData.Amount.." "..playerQuestData.PollenType..". ".." Completed."
		end
		if playerQuestData.QuestType == "CollectColor" then
			txt = "Collect "..playerQuestData.Amount.." "..playerQuestData.PollenType.." Pollen. Completed."
		end
		if playerQuestData.QuestType == "Defeat" then
			txt = "Defeat "..playerQuestData.Amount.." "..playerQuestData.PollenType..". Completed."
		end
		if playerQuestData.QuestType == "CollectToken" then
			txt = "Collect "..playerQuestData.Amount.." "..playerQuestData.PollenType.." Tokens. Completed."
		end
	end
	return txt
end

function quest.CreateQuestGUI(plr :Player,playerQuestData,questName)
	local UI = plr.PlayerGui
	local frame = UI.Main.QuestFrame.Quests
	local QuestTemplate = script.Template:Clone()
	QuestTemplate.Parent = frame
	QuestTemplate.Visible = true
	QuestTemplate.Name = questName
	QuestTemplate.QuestName.Text = questName
	for i,v in pairs(playerQuestData) do
		local bar = script.Bar:Clone()
		bar.Visible = true
		bar.Parent = QuestTemplate
		bar.Name = v.PollenType
		bar.Label.Text = quest.GetQuestText(v,false)
		bar.Fill.Size = UDim2.new(math.round(v.Collected)/v.Amount,0,1,0)
		if v.Collected >= v.Amount then
			bar.Fill.Size = UDim2.new(1,0,1,0)
			bar.Label.Text = quest.GetQuestText(v,true)
		end
	end
	
end

function quest.Reward(plr,reward)
	local pData = _G.PlayerData[plr.Name]
	for i,v in pairs(reward) do
		pData[v.StatLocation][v.StatName] += v.Amount
		noti.Create(plr,{Message="+"..v.Amount.." "..v.StatName,Type="Default"})
	end
	require(game.ReplicatedStorage.Modules:WaitForChild("Update")).Inventory(plr)
end

function quest.CheckCompletion(plr,qData)
	local completed = false
	for i,v in pairs(qData) do
		if v.Collected >= v.Amount then
			completed = true
		else
			completed = false
			break
		end
	end
	return completed
end
function quest.UpdateUI(plr)
	local data = _G.PlayerData[plr.Name]
	local qData = data.Quests
	local UI = plr.PlayerGui
	local frame = UI.Main.QuestFrame.Quests
	for _,int in pairs(frame:GetChildren()) do
		if int:IsA("Frame") then
			int:Destroy()
		end
	end
	for i,v in pairs(qData) do
		quest.CreateQuestGUI(plr,v.Required,v.QuestName)
	end
end
function quest.Update(plr,QuestData)
	local data = _G.PlayerData[plr.Name]
	local array = {
		["Field"] = QuestData.Field,
		["Pollen"] = QuestData.Pollen, 
		["Red"] = QuestData.Red,
		["Blue"] = QuestData.Blue,
		["White"] = QuestData.White,
		["Token"] = QuestData.Token,
		["Mob"] = QuestData.Mob,
		["Gum"] = QuestData.Gum
	}
	local qData = data.Quests
	for i,v in pairs(qData) do
		local required = v.Required
		for i,req in pairs(required) do
		if req.QuestType == "CollectPollen" then
			if req.PollenType == array.Field then
				req.Collected += array.Pollen
				end
				if array.Field == "" then
					req.Collected += array.Pollen
				end
			end
			if req.QuestType == "CollectGum" then
				if req.PollenType == "Goo" then
					req.Collected += array.Gum
				end
			end
		if req.QuestType == "CollectColor" then
			if req.PollenType == "Red" then
				req.Collected += array.Red
			end
			if req.PollenType == "Blue" then
				req.Collected += array.Blue
			end
			if req.PollenType == "White" then
				req.Collected += array.White
			end
		end
		if req.QuestType == "CollectToken" then
			if req.PollenType == array.Token then
				req.Collected += 1
			end
		end
		if req.QuestType == "Defeat" then
			if req.PollenType == array.Mob then
				req.Collected += 1
			 end
		  end
	   end
	end
	--UpdateUI--
	quest.UpdateUI(plr)
end
function quest.Talk(plr :Player,Npc)
	local npcModule = require(script:WaitForChild(Npc))
	local data = npcModule.Data
	local quests = npcModule.Dialog
	local PData = _G.PlayerData[plr.Name]
	local QuestData = PData.Quests
	local NPCData = PData.NPCData[Npc]
	local UI = plr.PlayerGui
	if NPCData.Quests > data.Quests then
		print(plr.Name.." has completed all of the quests from "..Npc..".")
		return
	end
	local gui = UI.Main.QuestTemplate:Clone()
	gui.Visible = true
	gui.Parent = UI.Main.FakeUI
	local tab = gui.Tab
	game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.QuestNPCS[Npc].Platform.Cam,"tween")
	tab.NPC.Text = Npc
		local currentLine = 1
	local Dialog = {}
	if NPCData.Claimed == true then
		local c = quest.CheckCompletion(plr,QuestData[Npc].Required)
		NPCData.Completed = c
	end
		if NPCData.Claimed == false then
			Dialog=quests[NPCData.Quests].Dialog["UnClaimed"]
		end
		if NPCData.Claimed == true and NPCData.Completed == false then
		Dialog=quests[NPCData.Quests].Dialog["Claimed"]
		end
		if NPCData.Completed == true then
			Dialog=quests[NPCData.Quests].Dialog["Completed"]
		end
	if Dialog[currentLine].Type == "Continue" then
			tab.Dialog.Text = Dialog[currentLine].Text
		tab.Continue.MouseButton1Click:Connect(function()
			if data.Quests > 0 and currentLine >= #Dialog then
				currentLine = 1
				if NPCData.Claimed == false then
					noti.Create(plr,{Message="Quest Recieved",Type="Default"})
					quest.AssignQuest(plr,quests[NPCData.Quests].QuestRequirement,quests[NPCData.Quests].QuestName,Npc)
				end
				if NPCData.Completed == true then
					if quest.CheckCompletion(plr,QuestData[Npc].Required) == true then
						quest.Reward(plr,quests[NPCData.Quests].Rewards)
						NPCData.Completed = false
						NPCData.Claimed = false
						QuestData[Npc] = nil
						quest.UpdateUI(plr)
						NPCData.Quests += 1
					end
				end
				gui:Destroy()
				game.ReplicatedStorage.Remotes.TweenCamera:FireClient(plr,workspace.QuestNPCS[Npc].Platform.Cam,"fixed")
					return
			end
				currentLine += 1
				if tab and tab:FindFirstChild("Dialog") then
					tab.Dialog.Text = Dialog[currentLine].Text
				end
		end)
		end	
end

return quest

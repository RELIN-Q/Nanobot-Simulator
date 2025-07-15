-- @ScriptType: ModuleScript
local token = {}

function spawner(func,...)
	local co = coroutine.wrap(func)
	co(...)
end
local ts = game:GetService("TweenService")
function token.Anim(tokene)
		tokene.Anchored = true
		tokene.Parent.Collect:Play()
		tokene.Transparency = 0
		tokene.Decal1.Transparency = 0
		tokene.Decal.Transparency = 0
		local t1 = ts:Create(tokene,TweenInfo.new(.2),{CFrame=tokene.CFrame*CFrame.new(0,0.5,0)*CFrame.Angles(0,0,math.rad(90))},"In","Linear")
		t1:Play()
		task.wait(.15+.7+0.1+tokene.Parent.Collect.TimeLength)
		if tokene and tokene.Parent then
			tokene.Parent:Destroy()
		end
end
token.TokenTime = {
	["Summon Frog"] = 10,
	["TokenLink"] = 6,
	["Impale"] = 10,
	["White Bomb"] = 8,
	["Blue Boost"] = 8,
	["Red Boost"] = 8,
}
local qModule = require(game.ReplicatedStorage.Modules:WaitForChild("QuestModule"))
function token.Collect(plr,tokene,bee)
	if tokene and tokene:FindFirstChild("Token") and tokene.Token.Anchored == false then
		if game.ReplicatedStorage.Modules.TokenAbility:FindFirstChild(tokene.TokenName.Value) then
			require(game.ReplicatedStorage.Modules:WaitForChild("Passive")).UpdatePassives(plr,tokene.TokenName.Value)
			require(game.ReplicatedStorage.Modules.TokenAbility:WaitForChild(tokene.TokenName.Value)).Collect(plr,tokene.Position,tokene.Bee.Value,tokene)
		end
		if tokene and tokene:FindFirstChild("Token") then
			spawner(token.Anim,tokene.Token)
			end
	end
end
function token.new(tokenowner,position,tokene,bee,amnt)
	local tokenpart = game.ReplicatedStorage.Assets.Tokens[tokene]:Clone()
	tokenpart.Position = position
	local originSize = tokenpart.Token.Size
	local b = Instance.new("ObjectValue",tokenpart)
	b.Name = "Bee"
	b.Value = bee
	local amntVal = Instance.new("NumberValue",tokenpart)
	amntVal.Name = "Amount"
	if amnt == nil then amnt = 0 end
	amntVal.Value = amnt
	tokenpart.Token.Position = position
	tokenpart.TokenName.Value = tokene
	if typeof(tokenowner) == "string" then
		tokenpart.Name = tokenowner
	else
		tokenpart.Name = tokenowner.Name
	end
	tokenpart.Parent = workspace.Debris.Tokens
	tokenpart.Token.Size = originSize/3
	local tokentime = token.TokenTime[tokene]
	if tokentime == nil then
		tokentime = 15
	end
	ts:Create(tokenpart.Token,TweenInfo.new(0.2,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{Size=originSize}):Play()
	game.Debris:AddItem(tokenpart,tokentime+2)
	spawn(function()
		task.wait(tokentime)
		if tokenpart and tokenpart:FindFirstChild("Token") then
			local succ,err = pcall(function()
			ts:Create(tokenpart.Token.Decal1,TweenInfo.new(2),{Transparency=1},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
			ts:Create(tokenpart.Token.Decal,TweenInfo.new(2),{Transparency=1},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
				ts:Create(tokenpart.Token,TweenInfo.new(2),{Transparency=1},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
			end)
			if not succ then
				print("Error inside "..script.Name..": "..err)
			end
		end
	end)
	tokenpart.Touched:Connect(function(hit)
		if hit and hit.Parent:FindFirstChild("Humanoid") and tokenpart.Token.Anchored == false then
			local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
			tokenpart.Token.Anchored = true
			if plr and tokenpart.Name == "All" then
				spawn(function()
					if game.ReplicatedStorage.Modules.TokenAbility:FindFirstChild(tokene) then
						require(game.ReplicatedStorage.Modules:WaitForChild("Passive")).UpdatePassives(plr,tokene)
						require(game.ReplicatedStorage.Modules.TokenAbility:WaitForChild(tokene)).Collect(plr,tokenpart.Position,bee,tokenpart)
					end
				end)
			end
			if plr and tokenpart.Name ~= "All" and tokenpart.Name == plr.Name then
				spawn(function()
					qModule.Update(plr,{Field="",Pollen=0,Red=0,Blue=0,White=0,Mob="",Gum=0,Token=tostring(tokenpart.TokenName.Value)})
					if game.ReplicatedStorage.Modules.TokenAbility:FindFirstChild(tokene) then
						require(game.ReplicatedStorage.Modules:WaitForChild("Passive")).UpdatePassives(plr,tokene)
						require(game.ReplicatedStorage.Modules.TokenAbility:WaitForChild(tokene)).Collect(plr,tokenpart.Position,bee,tokenpart)
					end
				end)
			end
			spawner(token.Anim,tokenpart.Token)
		end
	end)
end

return token

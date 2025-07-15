-- @ScriptType: ModuleScript
local module = {}
local ts = game:GetService("TweenService")


function module.CreateArc(p1,p2,objectFollow)
	spawn(function()
		local p3 = Instance.new("Part",workspace) p3.Transparency = 1 p3.Name = "LerpPart" p3.CanCollide = false
		p3.Anchored = true
		local stopArc = false
		p3.Position = p1+Vector3.new(0,25,0)
		spawn(function()
			repeat wait()
				if objectFollow == nil then
					break
				end
				if stopArc == true then
					break
				end
				if objectFollow then
					ts:Create(objectFollow,TweenInfo.new(.6),{Position=p3.Position},Enum.EasingDirection.In,Enum.EasingStyle.Linear):Play()
				end
			until stopArc == true
		end)
		local t = ts:Create(p3,TweenInfo.new(.6),{Position=p2},Enum.EasingDirection.In,Enum.EasingStyle.Linear)
		t:Play()
		t.Completed:Wait()
		p3:Destroy()
		stopArc = true
	end)
end
function spawner(func,ee,e)
	local co = coroutine.wrap(func)
	co(ee,e)
end
function getClosestFieldToToken(root)
	for _,v in pairs(workspace.Fields:GetChildren()) do
		if root and (root.Position-v.FieldBox.Position).magnitude <= 110 then
			return v.Name
		end
	end
end
function getCloseFlowerToPlayer(root,field)
		local flrs = {}
		for _,v in pairs(workspace.Fields[field]:GetChildren()) do
			if v and v:FindFirstChild("Amnt") then
				if (v.Position-root.Position).magnitude <= 25 and v.Position.Y > v.Parent.FieldBox.Position.Y-2.4-0.3 then
					table.insert(flrs,v)
				end
			end
	end
	if #flrs >= 1 then
		return flrs[math.random(1,#flrs)]
		end
end
function module.FrogAI(frog,hb)
	if frog and hb then
		spawn(function()
			while true do
				if frog and frog:FindFirstChild("Field") and frog.Field.Value == "" then
					frog:Destroy()
					break
				end
				if frog == nil then
					break
				end
				if hb == nil then
					break
				end
				if frog and frog.PrimaryPart then
					frog:SetPrimaryPartCFrame(hb.CFrame)
				end
				task.wait(0.03)
			end
		end)
		for loops = 1,5 do
			local flr = getCloseFlowerToPlayer(hb,frog.Field.Value)
			hb.CFrame = CFrame.lookAt(hb.Position,Vector3.new(flr.Position.X,hb.Position.Y,flr.Position.Z))
			frog.LeftLeg.CFrame = frog.LeftLegPos2.CFrame
			frog.RightLeg.CFrame = frog.RightLegPos2.CFrame
			module.CreateArc(hb.Position,Vector3.new(flr.Position.X,(flr.Parent.FieldBox.Position.Y-0.3)+(frog:GetModelSize().Y/2.5),flr.Position.Z),hb)
			wait(0.63)
			frog.LeftLeg.CFrame = frog.LeftLegPos.CFrame
			frog.RightLeg.CFrame = frog.RightLegPos.CFrame
			wait(3)
			for bb = 1,3 do 
				local flr2 = getCloseFlowerToPlayer(hb,frog.Field.Value)
				hb.CFrame = CFrame.lookAt(hb.Position,Vector3.new(flr2.Position.X,hb.Position.Y,flr2.Position.Z))
				frog.LeftLeg.CFrame = frog.LeftLegPos2.CFrame
				frog.RightLeg.CFrame = frog.RightLegPos2.CFrame
				module.CreateArc(hb.Position,Vector3.new(flr2.Position.X,(flr2.Parent.FieldBox.Position.Y-0.3)+(frog:GetModelSize().Y/2.5),flr2.Position.Z),hb)
				wait(0.63)
				frog.LeftLeg.CFrame = frog.LeftLegPos.CFrame
				frog.RightLeg.CFrame = frog.RightLegPos.CFrame
				wait(0.1)
				require(script.Parent:WaitForChild("Bubble")).Start(frog.Field.Value,Vector3.new(flr2.Position.X,flr2.Parent.FieldBox.Position.Y-0.3,flr2.Position.Z))
				wait(0.6)
			end
			wait(1)
		end
		frog:Destroy()
		hb:Destroy()
	end
end

function module.CreateFrog(field,pos)
	local frog = game.ReplicatedStorage.Assets.Misc.Frog:Clone()
	frog.Parent = workspace.Debris.Entity
	frog.Name = game:GetService("HttpService"):GenerateGUID(false)
	frog:SetPrimaryPartCFrame(CFrame.new(pos))
	frog.Field.Value = getClosestFieldToToken(frog.PrimaryPart)
	local hb = Instance.new("Part",workspace.Debris.Entity)
	hb.Name = frog.Name
	hb.Size = frog:GetModelSize()
	hb.Transparency = 1
	hb.Position = pos
	hb.CanCollide = false
	hb.Anchored = true
	spawner(module.FrogAI,frog,hb)
end
function module.Start(field,position)
	spawn(function()
			module.CreateFrog(field,position)
			wait(0.03)
	end)
end

return module

-- @ScriptType: ModuleScript
local module = {}
local ts = game:GetService("TweenService")
function tweenModel(model :Model,t,frame)
	local val = Instance.new("CFrameValue",model)
	val.Value = model:GetPrimaryPartCFrame()
	
	val.Changed:Connect(function(new)
		model:SetPrimaryPartCFrame(new)
	end)
	local tween = ts:Create(val,TweenInfo.new(t,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{Value=frame}) 
	tween:Play()
	tween.Completed:Wait()
	val:Destroy()
end
local Boost = {
	ConvertionRate = 100000,
	BlueConvertRate = 100000,
	RedConvertRate = 100000,
	WhiteConvertRate = 200000,
	WhiteRate = 100000,
	RedRate = 50000,
	Power = 0.8,
	BlueRate = 50000,
}
local rp = game:GetService("ReplicatedStorage")
local BuffModule = require(script.Parent.Parent:WaitForChild("BuffVisual"))
local itemModule = require(script.Parent.Parent:WaitForChild("Items"))["Honey Hammer"]
local flrModule = require(script.Parent.Parent:WaitForChild("FlowerScript"))
function module.Spawn(plr,stack)
	stack.Value = 0
	local tool = stack.Parent
	local char = plr.Character
	local root = char.PrimaryPart
	local hammer = rp.Assets.Misc["Honey Hammer"]:Clone()
	hammer.Parent = workspace.Debris
	hammer:SetPrimaryPartCFrame(root.CFrame*CFrame.new(0,7,0))
	hammer.Box.Sound:Play()
	tweenModel(hammer,1.2,root.CFrame*CFrame.new(0,7,-8.5)*CFrame.Angles(math.rad(-90),0,0))
	local p = Instance.new("Part",workspace.Debris)
	p.Size = Vector3.new(1,1,1)
	p.Anchored = true
	p.CanCollide = false
	p.Transparency = 1
	game.Debris:AddItem(p,0.2)
	p.CFrame = CFrame.new(hammer.Head.Position.X,root.Position.Y,hammer.Head.Position.Z)
	flrModule.CreatePattern(plr,"Honey Hammer Passive",p,1,"Honey Hammer Passive",Boost)
	wait(0.2)
	hammer:Destroy()
end

return module

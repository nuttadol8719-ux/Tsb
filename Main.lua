local Players = game:GetService("Players")

local RunService = game:GetService("RunService")


local player = Players.LocalPlayer


local Rayfield = loadstring(game:HttpGet(

'https://sirius.menu/rayfield'

))()


local Window = Rayfield:CreateWindow({

Name = "น้องปอนด์ Hub",

LoadingTitle = "by pond",

LoadingSubtitle = "Thai edition",


ConfigurationSaving = {

Enabled = false

}

})


local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")


local ConfirmGui = Instance.new("ScreenGui")

ConfirmGui.Name = "AutoSkillConfirm"

ConfirmGui.ResetOnSpawn = false

ConfirmGui.Enabled = false

ConfirmGui.Parent = playerGui


local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(0,300,0,160)

Frame.Position = UDim2.new(0.5,-150,0.5,-80)

Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

Frame.Parent = ConfirmGui


Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)


local Text = Instance.new("TextLabel")

Text.Size = UDim2.new(1,-20,0,80)

Text.Position = UDim2.new(0,10,0,10)

Text.BackgroundTransparency = 1

Text.TextScaled = true

Text.TextWrapped = true

Text.TextColor3 = Color3.new(1,1,1)

Text.Text = "⚠️ Auto Skill อาจทำให้มือถือบัค\nแน่ใจหรือไม่?"

Text.Parent = Frame


local Yes = Instance.new("TextButton")

Yes.Size = UDim2.new(0.4,0,0,35)

Yes.Position = UDim2.new(0.08,0,0.72,0)

Yes.Text = "ยืนยัน"

Yes.BackgroundColor3 = Color3.fromRGB(0,170,0)

Yes.TextColor3 = Color3.new(1,1,1)

Yes.Parent = Frame


local No = Instance.new("TextButton")

No.Size = UDim2.new(0.4,0,0,35)

No.Position = UDim2.new(0.52,0,0.72,0)

No.Text = "ยกเลิก"

No.BackgroundColor3 = Color3.fromRGB(170,0,0)

No.TextColor3 = Color3.new(1,1,1)

No.Parent = Frame


local Tab = Window:CreateTab("Main",4483362458)


--


local enabled = false

local remoteEnabled = false


local Vim = game:GetService("VirtualInputManager")


local AutoSkill = false



local selectedPlayer = nil


local distance = 5


local mode = "เข้าหลัง💦"


local orbitAngle = 0

local orbitSpeed = 2


--


local function GetPlayers()


local t = {}


for _,v in pairs(Players:GetPlayers()) do


if v ~= player then


table.insert(t,v.Name)


end


end


return t


end


--


local PlayerDropdown = Tab:CreateDropdown({


Name = "เลือกผู้เล่น",


Options = GetPlayers(),


CurrentOption = {},


MultipleOptions = false,


Callback = function(Value)


selectedPlayer = Players:FindFirstChild(Value[1])


end


})


--


Tab:CreateButton({


Name = "รีเซ็ตผู้เล่น",


Callback = function()


PlayerDropdown:Refresh(GetPlayers())


end


})


--


Tab:CreateToggle({


Name = "เข้าหลัง💦",


CurrentValue = false,


Callback = function(Value)


enabled = Value


end


})


--


Tab:CreateToggle({


Name = "ต่อย",


CurrentValue = false,


Callback = function(Value)


remoteEnabled = Value


end


})


Tab:CreateToggle({

Name = "สกิว",

CurrentValue = false,

Callback = function(Value)


if Value then

ConfirmGui.Enabled = true

else

AutoSkill = false

end


end

})


--


Tab:CreateSlider({


Name = "ระยะ",


Range = {1,20},


Increment = 1,


CurrentValue = 5,


Callback = function(Value)


distance = Value


end


})


--


Tab:CreateDropdown({


Name = "โหมด",


Options = {


"เข้าหลัง💦",


"หน้า",


"ซ้าย",


"ขวา",


"หมุนตริ้ว"


},


CurrentOption = {


"เข้าหลัง💦"


},


MultipleOptions = false,


Callback = function(Value)


mode = Value[1]


end


})


--


Tab:CreateSlider({


Name = "ความเร็วหมุนตริ้ว",


Range = {1,20},


Increment = 1,


CurrentValue = 2,


Callback = function(Value)


orbitSpeed = Value


end


})


--


task.spawn(function()


while task.wait(0.1) do


if remoteEnabled then


local char = player.Character


if char and char:FindFirstChild("Communicate") then


char.Communicate:FireServer({


Goal = "LeftClick",


Mobile = true


})


end


end


end


end)


task.spawn(function()

while task.wait(0.5) do


local char = player.Character

local hum = char and char:FindFirstChild("Humanoid")


if AutoSkill

and char

and hum

and hum.Health > 0 then


for _,key in ipairs({"One","Two","Three","Four"}) do


if not AutoSkill then

break

end


if hum.Health <= 0 then

break

end


Vim:SendKeyEvent(

true,

Enum.KeyCode[key],

false,

game

)


task.wait(0.05)


Vim:SendKeyEvent(

false,

Enum.KeyCode[key],

false,

game

)


task.wait(0.3)


end

end

end

end)



--


RunService.RenderStepped:Connect(function()


if enabled and selectedPlayer then


local target = selectedPlayer.Character

local me = player.Character


if target and me then


local tHRP = target:FindFirstChild("HumanoidRootPart")

local mHRP = me:FindFirstChild("HumanoidRootPart")


if tHRP and mHRP then


local targetPos


if mode == "เข้าหลัง💦" then


targetPos =

(tHRP.CFrame *

CFrame.new(0,0,distance)).Position


elseif mode == "หน้า" then


targetPos =

(tHRP.CFrame *

CFrame.new(0,0,-distance)).Position


elseif mode == "ซ้าย" then


targetPos =

(tHRP.CFrame *

CFrame.new(-distance,0,0)).Position


elseif mode == "ขวา" then


targetPos =

(tHRP.CFrame *

CFrame.new(distance,0,0)).Position


elseif mode == "หมุนตริ้ว" then


orbitAngle += orbitSpeed * 0.05


local x =

math.cos(orbitAngle) * distance


local z =

math.sin(orbitAngle) * distance


targetPos =

tHRP.Position +

Vector3.new(x,0,z)


end


mHRP.CFrame = CFrame.lookAt(


targetPos,


tHRP.Position


)


end


end


end


end)


--


Players.PlayerAdded:Connect(function()


PlayerDropdown:Refresh(GetPlayers())


end)


Players.PlayerRemoving:Connect(function()


PlayerDropdown:Refresh(GetPlayers())


end)


player.CharacterAdded:Connect(function()


task.wait(1)


Vim:SendKeyEvent(

false,

Enum.KeyCode.One,

false,

game

)


Vim:SendKeyEvent(

false,

Enum.KeyCode.Two,

false,

game

)


Vim:SendKeyEvent(

false,

Enum.KeyCode.Three,

false,

game

)


Vim:SendKeyEvent(

false,

Enum.KeyCode.Four,

false,

game

)


end)

Yes.MouseButton1Click:Connect(function()

AutoSkill = true

ConfirmGui.Enabled = false

end)


No.MouseButton1Click:Connect(function()

AutoSkill = false

ConfirmGui.Enabled = false

end)

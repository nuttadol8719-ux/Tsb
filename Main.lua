local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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

local Tab = Window:CreateTab("Main",4483362458)

--

local enabled = false
local remoteEnabled = false
local AutoSkill = false
local flyEnabled = false

local selectedPlayer = nil
local selectedPlayerName = nil

local distance = 5
local flySpeed = 50

local mode = "เข้าหลัง💦"

local orbitAngle = 0
local orbitSpeed = 0.5

-- Fly Objects
local BV = nil
local BG = nil

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

selectedPlayerName = Value[1]
selectedPlayer = Players:FindFirstChild(selectedPlayerName)

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
Name = "สกิว(หัวไข่เท่านั้น)",
CurrentValue = false,
Callback = function(Value)
AutoSkill = Value
end
})

Tab:CreateToggle({
Name = "เทพเจ้าลอยฟ้า (คีย์ลัด: C)",
CurrentValue = false,
Callback = function(Value)
flyEnabled = Value
if not Value then
-- Clean up fly objects
if BV then
BV:Destroy()
BV = nil
end
if BG then
BG:Destroy()
BG = nil
end
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

Tab:CreateSlider({

Name = "ความเร็วบิน",

Range = {10,200},

Increment = 10,

CurrentValue = 50,

Callback = function(Value)

flySpeed = Value

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

Range = {0.1,5},

Increment = 0.1,

CurrentValue = 0.5,

Callback = function(Value)

orbitSpeed = Value

end

})

--

Tab:CreateLabel("💡 คีย์ลัดเทพเจ้าลอยฟ้า: กด C")
Tab:CreateLabel("✈️ W/S = บินไปข้างหน้า/หลัง (ตามกล้อง)")
Tab:CreateLabel("✈️ A/D = บินไปซ้าย/ขวา")

-- Keybind Handler (Fixed to C key)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

if input.KeyCode == Enum.KeyCode.C then
flyEnabled = not flyEnabled
if not flyEnabled then
-- Clean up fly objects
if BV then
BV:Destroy()
BV = nil
end
if BG then
BG:Destroy()
BG = nil
end
end
Rayfield:Notify({
Title = "เทพเจ้าลอยฟ้า",
Content = flyEnabled and "เปิด ✨" or "ปิด",
Duration = 2,
Image = 4483362458
})
end
end)

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

-- Auto Skill Loop
task.spawn(function()
while task.wait() do
if AutoSkill then
local char = player.Character
local hum = char and char:FindFirstChild("Humanoid")
local backpack = player:FindFirstChild("Backpack")

if char and hum and hum.Health > 0 and backpack then
local communicate = char:FindFirstChild("Communicate")
if communicate then

-- Skill 1: Normal Punch
local skill1 = backpack:FindFirstChild("Normal Punch")
if skill1 and AutoSkill then
local args = {
{
IsAutoActivate = true,
Goal = "Console Move",
Tool = skill1,
ToolName = "Normal Punch"
}
}
communicate:FireServer(unpack(args))
task.wait(0.5)
end

-- Skill 2: Consecutive Punches
local skill2 = backpack:FindFirstChild("Consecutive Punches")
if skill2 and AutoSkill then
local args = {
{
IsAutoActivate = true,
Goal = "Console Move",
Tool = skill2,
ToolName = "Consecutive Punches"
}
}
communicate:FireServer(unpack(args))
task.wait(0.5)
end

-- Skill 3: Shove
local skill3 = backpack:FindFirstChild("Shove")
if skill3 and AutoSkill then
local args = {
{
IsAutoActivate = true,
Goal = "Console Move",
Tool = skill3,
ToolName = "Shove"
}
}
communicate:FireServer(unpack(args))
task.wait(0.5)
end

-- Skill 4: Uppercut
local skill4 = backpack:FindFirstChild("Uppercut")
if skill4 and AutoSkill then
local args = {
{
IsAutoActivate = true,
Goal = "Console Move",
Tool = skill4,
ToolName = "Uppercut"
}
}
communicate:FireServer(unpack(args))
task.wait(0.5)
end

end
end
end
end
end)

-- Target Lock System (Auto-enabled)
task.spawn(function()
while task.wait(0.5) do
if selectedPlayerName then
local targetPlayer = Players:FindFirstChild(selectedPlayerName)
if targetPlayer then
selectedPlayer = targetPlayer
else
selectedPlayer = nil
end
end
end
end)

-- Fly System (Full 3D Freedom with WASD only)
RunService.Heartbeat:Connect(function()
local char = player.Character
if char then
local hrp = char:FindFirstChild("HumanoidRootPart")
if hrp then
if flyEnabled then
-- Create fly objects if they don't exist
if not BV then
BV = Instance.new("BodyVelocity")
BV.Parent = hrp
BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
end
if not BG then
BG = Instance.new("BodyGyro")
BG.Parent = hrp
BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
BG.P = 10000
BG.D = 500
end

local cam = workspace.CurrentCamera
local moveDirection = Vector3.new(0, 0, 0)

-- Get movement input (WASD follows camera direction in 3D)
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
-- Move in the direction camera is looking (includes up/down)
moveDirection = moveDirection + cam.CFrame.LookVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
-- Move opposite to camera direction
moveDirection = moveDirection - cam.CFrame.LookVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
-- Move left relative to camera
moveDirection = moveDirection - cam.CFrame.RightVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
-- Move right relative to camera
moveDirection = moveDirection + cam.CFrame.RightVector
end

-- Normalize direction
if moveDirection.Magnitude > 0 then
moveDirection = moveDirection.Unit
end

-- Apply velocity (full 3D movement)
BV.Velocity = moveDirection * flySpeed

-- Keep camera orientation
BG.CFrame = cam.CFrame

else
-- Clean up when fly is disabled
if BV then
BV:Destroy()
BV = nil
end
if BG then
BG:Destroy()
BG = nil
end
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

Players.PlayerAdded:Connect(function(newPlayer)

PlayerDropdown:Refresh(GetPlayers())

-- Auto re-lock target when they rejoin
if newPlayer.Name == selectedPlayerName then
task.wait(0.5)
selectedPlayer = newPlayer
end

end)

Players.PlayerRemoving:Connect(function()

PlayerDropdown:Refresh(GetPlayers())

end)

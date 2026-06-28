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


AutoSkill = Value


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


if AutoSkill then


for _,key in ipairs({


"One",


"Two",


"Three",


"Four"


}) do


if not AutoSkill then

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


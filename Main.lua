local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- =========================================================
-- WINDUI
-- =========================================================
local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "น้องปอนด์ Hub",
    Author = "by pond",
    Icon = "gamepad-2",
    Folder = "PondHub",

    Size = UDim2.fromOffset(560, 500),
    Transparent = false,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 180,

    HideSearchBar = false,
    ScrollBarEnabled = true,

    User = {
        Enabled = false,
        Anonymous = true,
    },

    OpenButton = {
        Enabled = true,
        Title = "เปิด น้องปอนด์ Hub",
        Draggable = true,
        OnlyMobile = false,
        Scale = 0.7,
    },
})

-- =========================================================
-- SCRIPT TAB
-- =========================================================
ScriptTab:Paragraph({
    Title = "📜 สคริปต์เพิ่มเติม",
    Description = "แตะปุ่มเพื่อโหลดและรันสคริปต์"
})

-- Supa V2
ScriptTab:Button({
    Title = "Supa V2",
    Desc = "แตะเพื่อรัน Supa V2",
    Callback = function()
        WindUI:Notify({
            Title = "Supa V2",
            Content = "กำลังโหลดสคริปต์...",
            Duration = 2
        })

        task.spawn(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet(
                    "https://api.getpolsec.com/scripts/hosted/2753546c83053761e44664d36ffe5035d6e20fc8aee1d19f0eb7b933974ae537.lua"
                ))()
            end)

            if success then
                WindUI:Notify({
                    Title = "Supa V2",
                    Content = "รันสคริปต์สำเร็จแล้ว ✅",
                    Duration = 3
                })
            else
                WindUI:Notify({
                    Title = "Supa V2",
                    Content = "รันไม่สำเร็จ ❌",
                    Duration = 4
                })
                warn("[Supa V2 Error]:", err)
            end
        end)
    end
})

-- Hitbox
ScriptTab:Button({
    Title = "hitbox",
    Desc = "แตะเพื่อรัน Hitbox",
    Callback = function()
        WindUI:Notify({
            Title = "hitbox",
            Content = "กำลังโหลดสคริปต์...",
            Duration = 2
        })

        task.spawn(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet(
                    "https://raw.githubusercontent.com/Cyborg883/HitboxExpander/refs/heads/main/Release"
                ))()
            end)

            if success then
                WindUI:Notify({
                    Title = "hitbox",
                    Content = "รันสคริปต์สำเร็จแล้ว ✅",
                    Duration = 3
                })
            else
                WindUI:Notify({
                    Title = "hitbox",
                    Content = "รันไม่สำเร็จ ❌",
                    Duration = 4
                })
                warn("[Hitbox Error]:", err)
            end
        end)
    end
})

-- ดีด
ScriptTab:Button({
    Title = "ดีด",
    Desc = "แตะเพื่อรันสคริปต์ดีด",
    Callback = function()
        WindUI:Notify({
            Title = "ดีด",
            Content = "กำลังโหลดสคริปต์...",
            Duration = 2
        })

        task.spawn(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet(
                    "https://raw.githubusercontent.com/RovlixTinProject/NeverX/refs/heads/main/mfr.lua"
                ))()
            end)

            if success then
                WindUI:Notify({
                    Title = "ดีด",
                    Content = "รันสคริปต์สำเร็จแล้ว ✅",
                    Duration = 3
                })
            else
                WindUI:Notify({
                    Title = "ดีด",
                    Content = "รันไม่สำเร็จ ❌",
                    Duration = 4
                })
                warn("[ดีด Error]:", err)
            end
        end)
    end
})

-- อีโมต
ScriptTab:Button({
    Title = "อีโมต",
    Desc = "แตะเพื่อรันสคริปต์ Emotes",
    Callback = function()
        WindUI:Notify({
            Title = "อีโมต",
            Content = "กำลังโหลดสคริปต์...",
            Duration = 2
        })

        task.spawn(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet(
                    "https://raw.githubusercontent.com/thefinalstandofizaan-droid/Script-for-me/main/All%20Emotes"
                ))()
            end)

            if success then
                WindUI:Notify({
                    Title = "อีโมต",
                    Content = "รันสคริปต์สำเร็จแล้ว ✅",
                    Duration = 3
                })
            else
                WindUI:Notify({
                    Title = "อีโมต",
                    Content = "รันไม่สำเร็จ ❌",
                    Duration = 4
                })
                warn("[Emotes Error]:", err)
            end
        end)
    end
})

-- =========================================================
-- ⚙️ อื่นๆ
-- =========================================================

local OtherTab = Window:Tab({
    Title = "อื่นๆ",
    Icon = "settings-2",
})

-- =========================================================
-- VARIABLES
-- =========================================================

local enabled = false
local remoteEnabled = false
local AutoSkill = false
local flyEnabled = false
local freezeAnimEnabled = false
local fakeBugEnabled = false
local showFlyButton = true

local selectedPlayer = nil
local selectedPlayerName = nil

local distance = 5
local flySpeed = 50
local orbitSpeed = 0.5
local mode = "เข้าหลัง💦"
local orbitAngle = 0
local predictionTime = 0.3

local BV = nil
local BG = nil
local FakeBugGyro = nil
local previousPosition = nil

local moveThreshold = 0.05
local tiltActive = false
local tiltTimer = 0
local tiltDuration = 0.5

local animationConnection = nil

-- =========================================================
-- AUTO BLOCK + COUNTER
-- =========================================================

local autoBlockEnabled = false
local blockDistance = 10
local blockDuration = 0.35
local isBlocking = false
local autoUnblock = true

local counterEnabled = true
local counterDelay = 0.05
local isCountering = false

-- =========================================================
-- TARGET ANIMATION IDS
-- =========================================================

local targetAnimationIds = {
    ["10469493270"] = true,
    ["10469630950"] = true,
    ["10469639222"] = true,
    ["10503381238"] = true,
    ["10479335397"] = true,
    ["10466974800"] = true,
    ["10468665991"] = true,

    ["13532562418"] = true,
    ["13532600125"] = true,
    ["13532604085"] = true,
    ["13294471966"] = true,

    ["12296882427"] = true,
    ["13380255751"] = true,
    ["13370310513"] = true,
    ["13390230973"] = true,

    ["13378751717"] = true,
    ["13378708199"] = true,
    ["10470104242"] = true,
    ["13379003796"] = true,

    ["13294790250"] = true,
    ["13376962659"] = true,
    ["14004222985"] = true,
    ["13997092940"] = true,

    ["14001963401"] = true,
    ["14136436157"] = true,
    ["14046756619"] = true,
    ["14004235777"] = true,

    ["15259161390"] = true,
    ["15240216931"] = true,
    ["15240176873"] = true,
    ["15162694192"] = true,

    ["15290930205"] = true,
    ["15295895753"] = true,

    ["16515503507"] = true,
    ["16515448089"] = true,
    ["16515520431"] = true,
    ["16552234590"] = true,

    ["16139108718"] = true,
    ["16139402582"] = true,

    ["17799224866"] = true,
    ["17857788598"] = true,
    ["17857880283"] = true,
    ["18179181663"] = true,

    ["77509627104305"] = true,
    ["123005629431309"] = true,
}

-- =========================================================
-- PLAYER LIST
-- =========================================================

local function GetPlayers()
    local t = {}

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player then
            table.insert(t, v.Name)
        end
    end

    table.sort(t)

    return t
end

-- =========================================================
-- PUNCH
-- =========================================================

local function PerformSinglePunchRemote()

    local char = player.Character

    if not char then
        return
    end

    local communicate = char:FindFirstChild("Communicate")
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if communicate then

        pcall(function()

            local currentCF =
                hrp and hrp.CFrame or CFrame.new()

            communicate:FireServer({
                Mobile = true,
                Goal = "LeftClick",
                MousePos = currentCF
            })

            task.wait(0.03)

            communicate:FireServer({
                Goal = "LeftClickRelease"
            })

        end)
    end
end

-- =========================================================
-- BLOCK
-- =========================================================

local function TriggerBlockRemote()

    if isBlocking then
        return
    end

    local char = player.Character

    if not char then
        return
    end

    local communicate = char:FindFirstChild("Communicate")
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if not communicate then
        return
    end

    isBlocking = true

    pcall(function()

        local currentCF =
            hrp and hrp.CFrame or CFrame.new()

        communicate:FireServer({
            Goal = "KeyPress",
            Key = Enum.KeyCode.F,
            MousePos = currentCF
        })

    end)

    task.delay(blockDuration, function()

        if isBlocking and autoUnblock then

            pcall(function()

                communicate:FireServer({
                    Goal = "KeyRelease",
                    Key = Enum.KeyCode.F
                })

            end)

            isBlocking = false

            -- =================================================
            -- COUNTER
            -- =================================================

            if counterEnabled and not isCountering then

                isCountering = true

                task.wait(counterDelay)

                PerformSinglePunchRemote()

                task.wait(0.1)

                isCountering = false

            end
        end
    end)
end

-- =========================================================
-- FLOATING FLY BUTTON
-- =========================================================

local PlayerGui = player:WaitForChild("PlayerGui")

local FlyButtonGui = Instance.new("ScreenGui")

FlyButtonGui.Name = "FlyButtonGui"
FlyButtonGui.ResetOnSpawn = false
FlyButtonGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FlyButtonGui.Parent = PlayerGui
FlyButtonGui.Enabled = true

local FlyButton = Instance.new("TextButton")

FlyButton.Name = "FlyButton"
FlyButton.Size = UDim2.new(0, 80, 0, 80)
FlyButton.Position = UDim2.new(1, -100, 0.5, -40)
FlyButton.BackgroundColor3 =
    Color3.fromRGB(40, 40, 40)

FlyButton.BorderSizePixel = 0
FlyButton.Text = "✈️"
FlyButton.TextColor3 =
    Color3.fromRGB(255, 255, 255)

FlyButton.TextSize = 40
FlyButton.Font = Enum.Font.GothamBold
FlyButton.Parent = FlyButtonGui

local Corner = Instance.new("UICorner")

Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = FlyButton

local function UpdateButtonColor()

    if flyEnabled then

        FlyButton.BackgroundColor3 =
            Color3.fromRGB(0, 170, 255)

        FlyButton.Text = "✈️ ON"
        FlyButton.TextSize = 24

    else

        FlyButton.BackgroundColor3 =
            Color3.fromRGB(40, 40, 40)

        FlyButton.Text = "✈️"
        FlyButton.TextSize = 40

    end
end

FlyButton.MouseButton1Click:Connect(function()

    flyEnabled = not flyEnabled

    UpdateButtonColor()

    if not flyEnabled then

        if BV then
            BV:Destroy()
            BV = nil
        end

        if BG then
            BG:Destroy()
            BG = nil
        end
    end

    if FlyToggle then

        pcall(function()
            FlyToggle:Set(flyEnabled)
        end)

    end
end)

-- =========================================================
-- DRAG FLY BUTTON
-- =========================================================

local dragging = false
local dragInput
local mousePos
local framePos

FlyButton.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        dragging = true
        mousePos = input.Position
        framePos = FlyButton.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End then

                dragging = false

            end
        end)
    end
end)

FlyButton.InputChanged:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        dragInput = input

    end
end)

UserInputService.InputChanged:Connect(function(input)

    if input == dragInput and dragging then

        local delta =
            input.Position - mousePos

        FlyButton.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )

    end
end)

-- =========================================================
-- MAIN TAB
-- =========================================================

local PlayerDropdown = MainTab:Dropdown({

    Title = "เลือกผู้เล่น",
    Desc = "เลือกผู้เล่นที่ต้องการติดตาม",

    Values = GetPlayers(),
    Value = nil,
    AllowNone = true,

    Callback = function(option)

        selectedPlayerName = option
        selectedPlayer =
            Players:FindFirstChild(option)

    end
})

MainTab:Button({

    Title = "รีเซ็ตผู้เล่น",
    Desc = "อัปเดตรายชื่อผู้เล่น",
    Icon = "refresh-cw",

    Callback = function()

        PlayerDropdown:Refresh(
            GetPlayers()
        )

        WindUI:Notify({

            Title = "รีเซ็ตสำเร็จ",
            Content = "รายชื่อผู้เล่นถูกอัปเดตแล้ว",
            Duration = 3,

        })

    end
})

MainTab:Toggle({

    Title = "เข้าหลัง💦",
    Desc = "ติดตามตำแหน่งด้านหลังของผู้เล่น",

    Default = false,

    Callback = function(Value)

        enabled = Value

    end
})

MainTab:Slider({

    Title = "ติดหนึบ",
    Desc = "Prediction",

    Step = 0.01,

    Value = {
        Min = 0,
        Max = 0.5,
        Default = 0.3
    },

    Callback = function(Value)

        predictionTime = Value

    end
})

MainTab:Toggle({

    Title = "ต่อย",
    Desc = "ต่อยอัตโนมัติ",

    Default = false,

    Callback = function(Value)

        remoteEnabled = Value

    end
})

MainTab:Toggle({

    Title = "สกิว (หัวไข่เท่านั้น)",
    Desc = "ใช้สกิลอัตโนมัติ",

    Default = false,

    Callback = function(Value)

        AutoSkill = Value

    end
})

FlyToggle = MainTab:Toggle({

    Title = "เทพเจ้าลอยฟ้า",
    Desc = "กด C เพื่อเปิด/ปิด",

    Default = false,

    Callback = function(Value)

        flyEnabled = Value

        UpdateButtonColor()

        if not Value then

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

MainTab:Toggle({

    Title = "แสดงปุ่มลอย ✈️",
    Desc = "แสดงหรือซ่อนปุ่มบิน",

    Default = true,

    Callback = function(Value)

        showFlyButton = Value
        FlyButtonGui.Enabled = Value

    end
})

MainTab:Toggle({

    Title = "อนิเมชั่นเพิ่มดาเมจ",
    Desc = "หยุดอนิเมชั่น",

    Default = false,

    Callback = function(Value)

        freezeAnimEnabled = Value

        local char = player.Character

        if not char then
            return
        end

        local humanoid =
            char:FindFirstChildOfClass("Humanoid")

        if not humanoid then
            return
        end

        if Value then

            if animationConnection then

                animationConnection:Disconnect()
                animationConnection = nil

            end

            animationConnection =
                humanoid.AnimationPlayed:Connect(
                    function(track)

                        pcall(function()

                            track:AdjustSpeed(0)
                            track.TimePosition = 0

                        end)

                    end
                )

            WindUI:Notify({

                Title = "อนิเมชั่นเพิ่มดาเมจ เปิด",
                Content =
                    "หยุดอนิเมชั่นทั้งหมดเพื่อเพิ่มดาเมจ",
                Duration = 3,

            })

        else

            if animationConnection then

                animationConnection:Disconnect()
                animationConnection = nil

            end

            local animator =
                humanoid:FindFirstChildOfClass(
                    "Animator"
                )

            if animator then

                for _, track in ipairs(
                    animator:GetPlayingAnimationTracks()
                ) do

                    pcall(function()
                        track:AdjustSpeed(1)
                    end)

                end
            end

            WindUI:Notify({

                Title = "อนิเมชั่นเพิ่มดาเมจ ปิด",
                Content =
                    "อนิเมชั่นกลับมาปกติแล้ว",
                Duration = 3,

            })
        end
    end
})

MainTab:Toggle({

    Title = "🌀 บัคปลอม",
    Desc = "แหงนขึ้น 35° เมื่อเคลื่อนไหว",

    Default = false,

    Callback = function(Value)

        fakeBugEnabled = Value

        if not Value then

            if FakeBugGyro then

                FakeBugGyro:Destroy()
                FakeBugGyro = nil

            end

            previousPosition = nil
            tiltActive = false
            tiltTimer = 0

            WindUI:Notify({

                Title = "บัคปลอม ปิด",
                Content = "กลับสู่ปกติแล้ว",
                Duration = 3,

            })

        else

            WindUI:Notify({

                Title = "บัคปลอม เปิด",
                Content =
                    "ตัวจะแหงนขึ้น 35° เมื่อเคลื่อนไหว",
                Duration = 3,

            })

        end
    end
})

MainTab:Slider({

    Title = "ระยะ",
    Desc = "ระยะห่างจากเป้าหมาย",

    Step = 1,

    Value = {
        Min = 1,
        Max = 20,
        Default = 5
    },

    Callback = function(Value)

        distance = Value

    end
})

MainTab:Slider({

    Title = "ความเร็วบิน",
    Desc = "ความเร็วของระบบบิน",

    Step = 1,

    Value = {
        Min = 10,
        Max = 200,
        Default = 50
    },

    Callback = function(Value)

        flySpeed = Value

    end
})

MainTab:Dropdown({

    Title = "โหมด",
    Desc = "ตำแหน่งรอบเป้าหมาย",

    Values = {
        "เข้าหลัง💦",
        "หน้า",
        "ซ้าย",
        "ขวา",
        "หมุนตริ้ว"
    },

    Value = "เข้าหลัง💦",

    Callback = function(option)

        mode = option

    end
})

MainTab:Slider({

    Title = "ความเร็วหมุนตริ้ว",
    Desc = "ความเร็วในการ Orbit",

    Step = 0.1,

    Value = {
        Min = 0.1,
        Max = 5,
        Default = 0.5
    },

    Callback = function(Value)

        orbitSpeed = Value

    end
})

-- =========================================================
-- AUTO BLOCK TAB
-- =========================================================

BlockTab:Paragraph({

    Title = "🛡️ ระบบ Auto Block",

    Description =
        "ตรวจจับ Animation ของคู่ต่อสู้และบล็อกอัตโนมัติ"

})

BlockTab:Toggle({

    Title = "🛡️ เปิดใช้งาน Auto Block",

    Desc = "ตรวจจับ Animation ของคู่ต่อสู้",

    Default = false,

    Callback = function(Value)

        autoBlockEnabled = Value

        if not Value and isBlocking then

            local char =
                player.Character

            if char and
                char:FindFirstChild(
                    "Communicate"
                ) then

                pcall(function()

                    char.Communicate:FireServer({

                        Goal = "KeyRelease",
                        Key = Enum.KeyCode.F

                    })

                end)
            end

            isBlocking = false

        end
    end
})

BlockTab:Slider({

    Title = "ระยะตรวจจับการโจมตี",

    Desc = "ระยะตรวจจับ Animation",

    Step = 1,

    Value = {
        Min = 4,
        Max = 20,
        Default = 10
    },

    Callback = function(Value)

        blockDistance = Value

    end
})

BlockTab:Slider({

    Title = "ระยะเวลาค้างบล็อก",

    Desc = "เวลาที่ถือบล็อก",

    Step = 0.05,

    Value = {
        Min = 0.1,
        Max = 1.2,
        Default = 0.35
    },

    Callback = function(Value)

        blockDuration = Value

    end
})

BlockTab:Paragraph({

    Title = "⚔️ ระบบต่อยสวน",

    Description =
        "หลังปล่อยบล็อก จะต่อยสวนกลับ 1 ครั้ง"

})

BlockTab:Toggle({

    Title = "⚔️ เปิดใช้งานต่อยสวน",

    Desc = "ต่อยสวนอัตโนมัติหลังปล่อยบล็อก",

    Default = true,

    Callback = function(Value)

        counterEnabled = Value

    end
})

BlockTab:Slider({

    Title = "ดีเลย์ก่อนต่อยสวน",

    Desc = "เวลาหน่วงก่อนปล่อย M1",

    Step = 0.01,

    Value = {
        Min = 0,
        Max = 0.3,
        Default = 0.05
    },

    Callback = function(Value)

        counterDelay = Value

    end
})

-- =========================================================
-- OTHER TAB
-- =========================================================

OtherTab:Paragraph({

    Title = "ℹ️ ข้อมูล UI",

    Description =
        "UI Library: WindUI\n" ..
        "Created by: pond\n" ..
        "WindUI by Footagesus"

})

OtherTab:Button({

    Title = "แจ้งเตือนทดสอบ",
    Icon = "bell",

    Callback = function()

        WindUI:Notify({

            Title = "น้องปอนด์ Hub",

            Content =
                "WindUI ทำงานปกติแล้ว!",

            Duration = 3,

        })

    end
})

-- =========================================================
-- KEYBIND C
-- =========================================================

UserInputService.InputBegan:Connect(
    function(input, gameProcessed)

        if gameProcessed then
            return
        end

        if input.KeyCode ==
            Enum.KeyCode.C then

            flyEnabled = not flyEnabled

            UpdateButtonColor()

            if not flyEnabled then

                if BV then

                    BV:Destroy()
                    BV = nil

                end

                if BG then

                    BG:Destroy()
                    BG = nil

                end
            end

            if FlyToggle then

                pcall(function()

                    FlyToggle:Set(
                        flyEnabled
                    )

                end)

            end
        end
    end
)

-- =========================================================
-- SYSTEM ENGINE
-- =========================================================

RunService.Heartbeat:Connect(function(dt)

    local char = player.Character

    if not char then
        return
    end

    local hrp =
        char:FindFirstChild(
            "HumanoidRootPart"
        )

    local hum =
        char:FindFirstChildOfClass(
            "Humanoid"
        )

    if not hrp or not hum then
        return
    end

    -- =====================================================
    -- FREEZE ANIMATION
    -- =====================================================

    if freezeAnimEnabled then

        local animator =
            hum:FindFirstChildOfClass(
                "Animator"
            )

        if animator then

            for _, track in ipairs(
                animator:GetPlayingAnimationTracks()
            ) do

                pcall(function()

                    track.TimePosition = 0
                    track:AdjustSpeed(0)

                end)

            end
        end
    end

    -- =====================================================
    -- FLY
    -- =====================================================

    if flyEnabled then

        if not BV then

            BV = Instance.new("BodyVelocity")
            BV.Parent = hrp

            BV.MaxForce =
                Vector3.new(
                    9e9,
                    9e9,
                    9e9
                )

        end

        if not BG then

            BG = Instance.new("BodyGyro")
            BG.Parent = hrp

            BG.MaxTorque =
                Vector3.new(
                    9e9,
                    9e9,
                    9e9
                )

            BG.P = 10000
            BG.D = 500

        end

        local cam =
            workspace.CurrentCamera

        local moveDirection =
            Vector3.zero

        if UserInputService:IsKeyDown(
            Enum.KeyCode.W
        ) then

            moveDirection +=
                cam.CFrame.LookVector

        end

        if UserInputService:IsKeyDown(
            Enum.KeyCode.S
        ) then

            moveDirection -=
                cam.CFrame.LookVector

        end

        if UserInputService:IsKeyDown(
            Enum.KeyCode.A
        ) then

            moveDirection -=
                cam.CFrame.RightVector

        end

        if UserInputService:IsKeyDown(
            Enum.KeyCode.D
        ) then

            moveDirection +=
                cam.CFrame.RightVector

        end

        if UserInputService.TouchEnabled then

            local moveDir =
                hum.MoveDirection

            if moveDir.Magnitude > 0 then

                local camCF =
                    cam.CFrame

                local camLook =
                    camCF.LookVector

                local camRight =
                    camCF.RightVector

                local flatLook =
                    Vector3.new(
                        camLook.X,
                        0,
                        camLook.Z
                    )

                local flatRight =
                    Vector3.new(
                        camRight.X,
                        0,
                        camRight.Z
                    )

                if flatLook.Magnitude > 0 then

                    flatLook =
                        flatLook.Unit

                end

                if flatRight.Magnitude > 0 then

                    flatRight =
                        flatRight.Unit

                end

                local forwardAmount =
                    moveDir:Dot(
                        flatLook
                    )

                local rightAmount =
                    moveDir:Dot(
                        flatRight
                    )

                moveDirection =
                    (
                        camLook *
                        forwardAmount
                    )
                    +
                    (
                        camRight *
                        rightAmount
                    )

            end
        end

        if moveDirection.Magnitude > 0 then

            moveDirection =
                moveDirection.Unit

        end

        BV.Velocity =
            moveDirection * flySpeed

        BG.CFrame =
            CFrame.new(
                hrp.Position,
                hrp.Position +
                    cam.CFrame.LookVector
            )

    else

        if BV then

            BV:Destroy()
            BV = nil

        end

        if BG then

            BG:Destroy()
            BG = nil

        end
    end

    -- =====================================================
    -- FAKE BUG
    -- =====================================================

    if fakeBugEnabled then

        if not FakeBugGyro
            or FakeBugGyro.Parent ~= hrp then

            FakeBugGyro =
                Instance.new("BodyGyro")

            FakeBugGyro.MaxTorque =
                Vector3.new(
                    9e9,
                    9e9,
                    9e9
                )

            FakeBugGyro.P = 10000
            FakeBugGyro.D = 500
            FakeBugGyro.Parent = hrp

            previousPosition =
                hrp.Position

        end

        local currentState =
            hum:GetState()

        local isDown =
            hum.Health <= 0
            or currentState ==
                Enum.HumanoidStateType.Dead
            or currentState ==
                Enum.HumanoidStateType.Ragdoll
            or currentState ==
                Enum.HumanoidStateType.FallingDown
            or currentState ==
                Enum.HumanoidStateType.Physics

        local isGettingUp =
            currentState ==
                Enum.HumanoidStateType.GettingUp

        if isDown then

            FakeBugGyro.MaxTorque =
                Vector3.zero

        elseif isGettingUp then

            FakeBugGyro.MaxTorque =
                Vector3.new(
                    1e5,
                    1e5,
                    1e5
                )

            FakeBugGyro.CFrame =
                CFrame.new(
                    hrp.Position,
                    hrp.Position +
                        hrp.CFrame.LookVector
                )

        else

            FakeBugGyro.MaxTorque =
                Vector3.new(
                    9e9,
                    9e9,
                    9e9
                )

            if previousPosition then

                local distanceMoved =
                    (
                        hrp.Position -
                        previousPosition
                    ).Magnitude

                if distanceMoved >
                    moveThreshold then

                    tiltActive = true
                    tiltTimer = tiltDuration

                else

                    if tiltTimer > 0 then

                        tiltTimer -= dt

                    else

                        tiltActive = false

                    end
                end

                previousPosition =
                    hrp.Position

            else

                previousPosition =
                    hrp.Position

            end

            if tiltActive then

                local lookVector =
                    hrp.CFrame.LookVector

                local tiltCF =
                    CFrame.new(
                        hrp.Position,
                        hrp.Position +
                            lookVector
                    )
                    *
                    CFrame.Angles(
                        math.rad(35),
                        0,
                        0
                    )

                FakeBugGyro.CFrame =
                    tiltCF

            else

                FakeBugGyro.CFrame =
                    CFrame.new(
                        hrp.Position,
                        hrp.Position +
                            hrp.CFrame.LookVector
                    )

            end
        end

    else

        if FakeBugGyro then

            FakeBugGyro:Destroy()
            FakeBugGyro = nil

        end
    end

    -- =====================================================
    -- AUTO BLOCK ENGINE
    -- =====================================================

    if autoBlockEnabled then

        for _, otherPlayer in ipairs(
            Players:GetPlayers()
        ) do

            if otherPlayer ~= player
                and otherPlayer.Character then

                local targetChar =
                    otherPlayer.Character

                local targetHRP =
                    targetChar:FindFirstChild(
                        "HumanoidRootPart"
                    )

                local targetHum =
                    targetChar:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if targetHRP and targetHum then

                    local dist =
                        (
                            hrp.Position -
                            targetHRP.Position
                        ).Magnitude

                    if dist <= blockDistance then

                        local animator =
                            targetHum:FindFirstChildOfClass(
                                "Animator"
                            )

                        if animator then

                            for _, track in ipairs(
                                animator:GetPlayingAnimationTracks()
                            ) do

                                if track.IsPlaying
                                    and track.Animation then

                                    local animId =
                                        tostring(
                                            track.Animation.AnimationId
                                            or ""
                                        ):match("%d+")

                                    if animId
                                        and targetAnimationIds[animId]
                                        and track.TimePosition < 0.35 then

                                        TriggerBlockRemote()

                                        break

                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- TELEPORT ENGINE
-- =========================================================

local function UpdatePosition()

    if not enabled
        or not selectedPlayer then

        return
    end

    local target =
        selectedPlayer.Character

    local me =
        player.Character

    if not target or not me then
        return
    end

    local tHRP =
        target:FindFirstChild(
            "HumanoidRootPart"
        )

    local mHRP =
        me:FindFirstChild(
            "HumanoidRootPart"
        )

    if not tHRP or not mHRP then
        return
    end

    local predictedTargetPos =
        tHRP.Position +
        (
            tHRP.Velocity *
            predictionTime
        )

    local predictedCFrame =
        CFrame.new(
            predictedTargetPos
        )
        *
        (
            tHRP.CFrame -
            tHRP.Position
        )

    local finalTargetPos

    if mode == "เข้าหลัง💦" then

        finalTargetPos =
            (
                predictedCFrame *
                CFrame.new(
                    0,
                    0,
                    distance
                )
            ).Position

    elseif mode == "หน้า" then

        finalTargetPos =
            (
                predictedCFrame *
                CFrame.new(
                    0,
                    0,
                    -distance
                )
            ).Position

    elseif mode == "ซ้าย" then

        finalTargetPos =
            (
                predictedCFrame *
                CFrame.new(
                    -distance,
                    0,
                    0
                )
            ).Position

    elseif mode == "ขวา" then

        finalTargetPos =
            (
                predictedCFrame *
                CFrame.new(
                    distance,
                    0,
                    0
                )
            ).Position

    elseif mode == "หมุนตริ้ว" then

        orbitAngle +=
            orbitSpeed * 0.05

        local x =
            math.cos(orbitAngle) *
            distance

        local z =
            math.sin(orbitAngle) *
            distance

        finalTargetPos =
            predictedTargetPos +
            Vector3.new(
                x,
                0,
                z
            )
    end

    if finalTargetPos then

        mHRP.CFrame =
            CFrame.lookAt(
                finalTargetPos,
                predictedTargetPos
            )

    end
end

RunService.RenderStepped:Connect(
    UpdatePosition
)

-- =========================================================
-- PUNCH LOOP
-- =========================================================

task.spawn(function()

    while task.wait(0.1) do

        if remoteEnabled then

            local char =
                player.Character

            local communicate =
                char and
                char:FindFirstChild(
                    "Communicate"
                )

            if communicate then

                pcall(function()

                    communicate:FireServer({

                        Goal = "LeftClick",
                        Mobile = true

                    })

                end)
            end
        end
    end
end)

-- =========================================================
-- AUTO SKILL LOOP
-- =========================================================

task.spawn(function()

    while task.wait(0.5) do

        if AutoSkill then

            local char =
                player.Character

            local hum =
                char and
                char:FindFirstChild(
                    "Humanoid"
                )

            local backpack =
                player:FindFirstChild(
                    "Backpack"
                )

            if char
                and hum
                and hum.Health > 0
                and backpack then

                local communicate =
                    char:FindFirstChild(
                        "Communicate"
                    )

                if communicate then

                    local skills = {

                        "Normal Punch",
                        "Consecutive Punches",
                        "Shove",
                        "Uppercut"

                    }

                    for _, skillName in ipairs(
                        skills
                    ) do

                        if not AutoSkill then
                            break
                        end

                        local skill =
                            backpack:FindFirstChild(
                                skillName
                            )

                        if skill then

                            local args = {{

                                IsAutoActivate = true,
                                Goal = "Console Move",
                                Tool = skill,
                                ToolName = skillName

                            }}

                            pcall(function()

                                communicate:FireServer(
                                    unpack(args)
                                )

                            end)

                            task.wait(0.5)

                        end
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- PLAYER EVENTS
-- =========================================================

Players.PlayerAdded:Connect(function(newPlayer)

    PlayerDropdown:Refresh(
        GetPlayers()
    )

    if newPlayer.Name ==
        selectedPlayerName then

        task.wait(0.5)

        selectedPlayer =
            newPlayer

    end
end)

Players.PlayerRemoving:Connect(function(
    leavingPlayer
)

    PlayerDropdown:Refresh(
        GetPlayers()
    )

    if leavingPlayer ==
        selectedPlayer then

        selectedPlayer = nil
        selectedPlayerName = nil

    end
end)

-- =========================================================
-- START NOTIFY
-- =========================================================

WindUI:Notify({

    Title = "น้องปอนด์ Hub",

    Content =
        "โหลดสำเร็จ! Main → Auto Block → สคริปด๋มดุย → อื่นๆ",

    Duration = 5,

})

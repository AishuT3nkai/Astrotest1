-- StarterGui > KeySystem > LocalScript
-- Nama: KeySystemClient

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==========================================================
-- CONFIG
-- ==========================================================
local DISCORD_LINK = "https://discord.gg/5s2NCSUK26"        -- Change to your Discord
local ACCENT       = Color3.fromRGB(130, 90, 255)        -- Theme color
local BG_DARK      = Color3.fromRGB(18, 15, 30)
local BG_PANEL     = Color3.fromRGB(28, 24, 45)
local LOGO_ID      = "rbxassetid://103830295366233"      -- Your logo

local NORMAL_SIZE  = UDim2.new(0, 420, 0, 380)
local NORMAL_POS   = UDim2.new(0.5, -210, 0.5, -190)
local MAX_SIZE     = UDim2.new(0, 700, 0, 600)
local MAX_POS      = UDim2.new(0.5, -350, 0.5, -300)
local SMALL_SIZE   = UDim2.new(0, 320, 0, 300)
local SMALL_POS    = UDim2.new(0.5, -160, 0.5, -150)
-- ==========================================================

--------------------------------------------------
-- MAIN GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "KeySystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--------------------------------------------------
-- FLOATING BUTTON
--------------------------------------------------
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 60, 0, 60)
floatBtn.Position = UDim2.new(0, 30, 0.5, -30)
floatBtn.BackgroundColor3 = BG_PANEL
floatBtn.BorderSizePixel = 0
floatBtn.Text = ""
floatBtn.AutoButtonColor = false
floatBtn.Visible = false
floatBtn.Active = true
floatBtn.Parent = gui

local fbCorner = Instance.new("UICorner")
fbCorner.CornerRadius = UDim.new(1, 0)
fbCorner.Parent = floatBtn

local fbStroke = Instance.new("UIStroke")
fbStroke.Color = ACCENT
fbStroke.Thickness = 2
fbStroke.Transparency = 0.3
fbStroke.Parent = floatBtn

local fbGradient = Instance.new("UIGradient")
fbGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 40)),
}
fbGradient.Rotation = 45
fbGradient.Parent = floatBtn

local fbLogo = Instance.new("ImageLabel")
fbLogo.Size = UDim2.new(0.7, 0, 0.7, 0)
fbLogo.Position = UDim2.new(0.15, 0, 0.15, 0)
fbLogo.BackgroundTransparency = 1
fbLogo.Image = LOGO_ID
fbLogo.Parent = floatBtn

floatBtn.MouseEnter:Connect(function()
    TweenService:Create(fbStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
end)
floatBtn.MouseLeave:Connect(function()
    TweenService:Create(fbStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
end)

-- Drag floating button
local draggingFB, dragStartFB, startPosFB = false, nil, nil

floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingFB = true
        dragStartFB = input.Position
        startPosFB = floatBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingFB and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartFB
        floatBtn.Position = UDim2.new(
            startPosFB.X.Scale, startPosFB.X.Offset + delta.X,
            startPosFB.Y.Scale, startPosFB.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingFB = false
    end
end)

--------------------------------------------------
-- OVERLAY
--------------------------------------------------
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.5
overlay.BorderSizePixel = 0
overlay.Visible = true
overlay.Parent = gui

--------------------------------------------------
-- PANEL
--------------------------------------------------
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 0, 0, 0)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)
panel.BackgroundColor3 = BG_DARK
panel.BorderSizePixel = 0
panel.Active = true
panel.Visible = true
panel.Parent = gui

local pCorner = Instance.new("UICorner")
pCorner.CornerRadius = UDim.new(0, 14)
pCorner.Parent = panel

local pStroke = Instance.new("UIStroke")
pStroke.Color = ACCENT
pStroke.Thickness = 1.5
pStroke.Transparency = 0.4
pStroke.Parent = panel

local pGradient = Instance.new("UIGradient")
pGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 22, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 12, 25)),
}
pGradient.Rotation = 90
pGradient.Parent = panel

-- Drag panel via header
local draggingPanel, dragStartPanel, startPosPanel = false, nil, nil

UserInputService.InputChanged:Connect(function(input)
    if draggingPanel and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPanel
        panel.Position = UDim2.new(
            startPosPanel.X.Scale, startPosPanel.X.Offset + delta.X,
            startPosPanel.Y.Scale, startPosPanel.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingPanel = false
    end
end)

--------------------------------------------------
-- HEADER
--------------------------------------------------
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = BG_PANEL
header.BorderSizePixel = 0
header.Parent = panel

local hCorner = Instance.new("UICorner")
hCorner.CornerRadius = UDim.new(0, 14)
hCorner.Parent = header

local hFix = Instance.new("Frame")
hFix.Size = UDim2.new(1, 0, 0, 20)
hFix.Position = UDim2.new(0, 0, 1, -20)
hFix.BackgroundColor3 = BG_PANEL
hFix.BorderSizePixel = 0
hFix.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔑  KEY SYSTEM"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingPanel = true
        dragStartPanel = input.Position
        startPosPanel = panel.Position
    end
end)

--------------------------------------------------
-- BUTTON: — (MINIMIZE)
--------------------------------------------------
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -145, 0, 10)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 60)
minBtn.BorderSizePixel = 0
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.Parent = header

local mCorner = Instance.new("UICorner")
mCorner.CornerRadius = UDim.new(0, 8)
mCorner.Parent = minBtn

--------------------------------------------------
-- BUTTON: ☐ (RESIZE)
--------------------------------------------------
local resizeBtn = Instance.new("TextButton")
resizeBtn.Size = UDim2.new(0, 30, 0, 30)
resizeBtn.Position = UDim2.new(1, -110, 0, 10)
resizeBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
resizeBtn.BorderSizePixel = 0
resizeBtn.Text = "☐"
resizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resizeBtn.Font = Enum.Font.GothamBold
resizeBtn.TextSize = 16
resizeBtn.Parent = header

local rsCorner = Instance.new("UICorner")
rsCorner.CornerRadius = UDim.new(0, 8)
rsCorner.Parent = resizeBtn

--------------------------------------------------
-- BUTTON: ✕ (CLOSE / KICK)
--------------------------------------------------
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -75, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = header

local cCorner = Instance.new("UICorner")
cCorner.CornerRadius = UDim.new(0, 8)
cCorner.Parent = closeBtn

--------------------------------------------------
-- BUTTON: ▁ (HIDE)
--------------------------------------------------
local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 30, 0, 30)
hideBtn.Position = UDim2.new(1, -40, 0, 10)
hideBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 110)
hideBtn.BorderSizePixel = 0
hideBtn.Text = "▁"
hideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 14
hideBtn.Parent = header

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 8)
hbCorner.Parent = hideBtn

--------------------------------------------------
-- STATUS
--------------------------------------------------
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 22)
statusLabel.Position = UDim2.new(0, 20, 0, 65)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Not Authenticated"
statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 13
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = panel

--------------------------------------------------
-- KEY INPUT
--------------------------------------------------
local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, -40, 0, 50)
inputFrame.Position = UDim2.new(0, 20, 0, 105)
inputFrame.BackgroundColor3 = BG_PANEL
inputFrame.BorderSizePixel = 0
inputFrame.Parent = panel

local iCorner = Instance.new("UICorner")
iCorner.CornerRadius = UDim.new(0, 8)
iCorner.Parent = inputFrame

local iStroke = Instance.new("UIStroke")
iStroke.Color = ACCENT
iStroke.Thickness = 1
iStroke.Transparency = 0.6
iStroke.Parent = inputFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -20, 1, 0)
keyInput.Position = UDim2.new(0, 10, 0, 0)
keyInput.BackgroundTransparency = 1
keyInput.Text = ""
keyInput.PlaceholderText = "Enter your key here..."
keyInput.PlaceholderColor3 = Color3.fromRGB(130, 130, 150)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 13
keyInput.TextXAlignment = Enum.TextXAlignment.Left
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputFrame

--------------------------------------------------
-- VERIFY BUTTON
--------------------------------------------------
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(1, -40, 0, 48)
verifyBtn.Position = UDim2.new(0, 20, 0, 170)
verifyBtn.BackgroundColor3 = ACCENT
verifyBtn.BorderSizePixel = 0
verifyBtn.Text = "VERIFY KEY"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 14
verifyBtn.AutoButtonColor = false
verifyBtn.Parent = panel

local vCorner = Instance.new("UICorner")
vCorner.CornerRadius = UDim.new(0, 8)
vCorner.Parent = verifyBtn

local vGradient = Instance.new("UIGradient")
vGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, ACCENT),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 60, 200)),
}
vGradient.Parent = verifyBtn

verifyBtn.MouseEnter:Connect(function()
    TweenService:Create(verifyBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(150, 110, 255)
    }):Play()
end)
verifyBtn.MouseLeave:Connect(function()
    TweenService:Create(verifyBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = ACCENT
    }):Play()
end)

--------------------------------------------------
-- DISCORD INFO
--------------------------------------------------
local infoBox = Instance.new("Frame")
infoBox.Size = UDim2.new(1, -40, 0, 100)
infoBox.Position = UDim2.new(0, 20, 0, 235)
infoBox.BackgroundColor3 = BG_PANEL
infoBox.BorderSizePixel = 0
infoBox.Parent = panel

local ibCorner = Instance.new("UICorner")
ibCorner.CornerRadius = UDim.new(0, 8)
ibCorner.Parent = infoBox

local ibStroke = Instance.new("UIStroke")
ibStroke.Color = ACCENT
ibStroke.Thickness = 1
ibStroke.Transparency = 0.7
ibStroke.Parent = infoBox

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -20, 0, 50)
infoText.Position = UDim2.new(0, 10, 0, 5)
infoText.BackgroundTransparency = 1
infoText.Text = "Don't have a key? Join our Discord and purchase one there!"
infoText.TextColor3 = Color3.fromRGB(220, 220, 240)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 12
infoText.TextWrapped = true
infoText.Parent = infoBox

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, -20, 0, 32)
discordBtn.Position = UDim2.new(0, 10, 0, 60)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.BorderSizePixel = 0
discordBtn.Text = "💬  JOIN DISCORD"
discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 13
discordBtn.AutoButtonColor = false
discordBtn.Parent = infoBox

local dCorner = Instance.new("UICorner")
dCorner.CornerRadius = UDim.new(0, 6)
dCorner.Parent = discordBtn

discordBtn.MouseEnter:Connect(function()
    TweenService:Create(discordBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(110, 125, 255)
    }):Play()
end)
discordBtn.MouseLeave:Connect(function()
    TweenService:Create(discordBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    }):Play()
end)

discordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        statusLabel.Text = "✅ Discord link copied! Paste it in your browser."
        statusLabel.TextColor3 = Color3.fromRGB(100, 220, 150)
    else
        statusLabel.Text = "Link: " .. DISCORD_LINK
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 100)
    end
end)

--------------------------------------------------
-- TASKBAR (appears on minimize)
--------------------------------------------------
local taskbar = Instance.new("Frame")
taskbar.Size = UDim2.new(0, 200, 0, 45)
taskbar.Position = UDim2.new(0.5, -100, 1, -60)
taskbar.BackgroundColor3 = BG_PANEL
taskbar.BorderSizePixel = 0
taskbar.Visible = false
taskbar.Parent = gui

local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 10)
tbCorner.Parent = taskbar

local tbStroke = Instance.new("UIStroke")
tbStroke.Color = ACCENT
tbStroke.Thickness = 1.5
tbStroke.Transparency = 0.3
tbStroke.Parent = taskbar

local tbGradient = Instance.new("UIGradient")
tbGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 40)),
}
tbGradient.Rotation = 45
tbGradient.Parent = taskbar

local tbIcon = Instance.new("ImageLabel")
tbIcon.Size = UDim2.new(0, 30, 0, 30)
tbIcon.Position = UDim2.new(0, 8, 0.5, -15)
tbIcon.BackgroundTransparency = 1
tbIcon.Image = LOGO_ID
tbIcon.Parent = taskbar

local tbLabel = Instance.new("TextLabel")
tbLabel.Size = UDim2.new(1, -90, 1, 0)
tbLabel.Position = UDim2.new(0, 45, 0, 0)
tbLabel.BackgroundTransparency = 1
tbLabel.Text = "Key System"
tbLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
tbLabel.Font = Enum.Font.GothamMedium
tbLabel.TextSize = 13
tbLabel.TextXAlignment = Enum.TextXAlignment.Left
tbLabel.Parent = taskbar

local restoreBtn = Instance.new("TextButton")
restoreBtn.Size = UDim2.new(0, 30, 0, 30)
restoreBtn.Position = UDim2.new(1, -38, 0.5, -15)
restoreBtn.BackgroundColor3 = ACCENT
restoreBtn.BorderSizePixel = 0
restoreBtn.Text = "▲"
restoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.TextSize = 12
restoreBtn.AutoButtonColor = false
restoreBtn.Parent = taskbar

local rbCorner = Instance.new("UICorner")
rbCorner.CornerRadius = UDim.new(0, 8)
rbCorner.Parent = restoreBtn

restoreBtn.MouseEnter:Connect(function()
    TweenService:Create(restoreBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(150, 110, 255)
    }):Play()
end)
restoreBtn.MouseLeave:Connect(function()
    TweenService:Create(restoreBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = ACCENT
    }):Play()
end)

--------------------------------------------------
-- STATE
--------------------------------------------------
local panelOpen = true
local minimized = false
local resizeState = 1
local savedSize = NORMAL_SIZE
local savedPos = NORMAL_POS

--------------------------------------------------
-- HIDE / SHOW
--------------------------------------------------
local function setPanelOpen(state)
    panelOpen = state
    if state then
        floatBtn.Visible = false
        taskbar.Visible = false
        overlay.Visible = true
        panel.Visible = true

        panel.Size = UDim2.new(0, 0, 0, 0)
        panel.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = NORMAL_SIZE,
            Position = NORMAL_POS,
        }):Play()
    else
        floatBtn.Visible = true
        overlay.Visible = false
        panel.Visible = false
        taskbar.Visible = false
    end
end

floatBtn.MouseButton1Click:Connect(function()
    setPanelOpen(true)
end)

hideBtn.MouseButton1Click:Connect(function()
    setPanelOpen(false)
end)

--------------------------------------------------
-- MINIMIZE TO TASKBAR
--------------------------------------------------
local function setMinimized(state)
    minimized = state
    if state then
        savedSize = panel.Size
        savedPos = panel.Position

        TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 100, 0, 30),
            Position = UDim2.new(0.5, -50, 1, -30),
            BackgroundTransparency = 0.5,
        }):Play()
        task.wait(0.3)

        panel.Visible = false
        overlay.Visible = false
        taskbar.Visible = true

        taskbar.Position = UDim2.new(0.5, -100, 1, -30)
        taskbar.BackgroundTransparency = 1
        TweenService:Create(taskbar, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -100, 1, -60),
            BackgroundTransparency = 0,
        }):Play()
    else
        TweenService:Create(taskbar, TweenInfo.new(0.2), {
            Position = UDim2.new(0.5, -100, 1, -30),
            BackgroundTransparency = 1,
        }):Play()
        task.wait(0.2)

        taskbar.Visible = false
        panel.Visible = true
        overlay.Visible = true

        panel.Size = UDim2.new(0, 100, 0, 30)
        panel.Position = UDim2.new(0.5, -50, 1, -30)
        panel.BackgroundTransparency = 0.5

        TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = savedSize,
            Position = savedPos,
            BackgroundTransparency = 0,
        }):Play()
    end
end

minBtn.MouseButton1Click:Connect(function()
    setMinimized(true)
end)

restoreBtn.MouseButton1Click:Connect(function()
    setMinimized(false)
end)

taskbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        setMinimized(false)
    end
end)

--------------------------------------------------
-- RESIZE
--------------------------------------------------
local function applyResize()
    local targetSize, targetPos, icon

    if resizeState == 1 then
        targetSize, targetPos, icon = NORMAL_SIZE, NORMAL_POS, "☐"
    elseif resizeState == 2 then
        targetSize, targetPos, icon = MAX_SIZE, MAX_POS, "❐"
    else
        targetSize, targetPos, icon = SMALL_SIZE, SMALL_POS, "☐"
    end

    resizeBtn.Text = icon

    TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = targetSize,
        Position = targetPos,
    }):Play()
end

resizeBtn.MouseButton1Click:Connect(function()
    resizeState += 1
    if resizeState > 3 then resizeState = 1 end
    applyResize()
end)

--------------------------------------------------
-- CLOSE → KICK + DISCORD
--------------------------------------------------
closeBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
    end

    local kickMsg = Instance.new("TextLabel")
    kickMsg.Size = UDim2.new(1, 0, 1, 0)
    kickMsg.Position = UDim2.new(0, 0, 0, 0)
    kickMsg.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
    kickMsg.BorderSizePixel = 0
    kickMsg.Text = "❌  Key not verified.\n\nThe Discord link has been copied.\nYou will be removed from the game.\n\nJoin our Discord to purchase a key:\n" .. DISCORD_LINK
    kickMsg.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickMsg.Font = Enum.Font.Gotham
    kickMsg.TextSize = 16
    kickMsg.TextWrapped = true
    kickMsg.ZIndex = 10
    kickMsg.Parent = gui

    task.wait(3)
    player:Kick("Key not verified! Join our Discord: " .. DISCORD_LINK)
end)

--------------------------------------------------
-- KEY VERIFICATION (placeholder)
--------------------------------------------------
local function verifyKey(key)
    task.wait(0.8)
    local dummyKeys = {
        ["TESTKEY"] = true,
        ["PREMIUM2026"] = true,
    }
    if dummyKeys[key] then
        return true, "Valid"
    else
        return false, "Key not found"
    end
end

verifyBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text:upper():gsub("%s+", "")
    if key == "" then
        statusLabel.Text = "❌ Key cannot be empty."
        statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
        return
    end

    statusLabel.Text = "⏳ Verifying..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)

    local ok, msg = verifyKey(key)

    if ok then
        statusLabel.Text = "✅ Authenticated! Enjoy the game."
        statusLabel.TextColor3 = Color3.fromRGB(100, 220, 150)
        task.wait(1)
        gui.Enabled = false
    else
        statusLabel.Text = "❌ " .. msg .. " — purchase one on our Discord!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
    end
end)

--------------------------------------------------
-- INTRO ANIMATION
--------------------------------------------------
panel.Size = UDim2.new(0, 0, 0, 0)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = NORMAL_SIZE,
    Position = NORMAL_POS,
}):Play()

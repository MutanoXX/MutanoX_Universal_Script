--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║           ████████╗██╗   ██╗██╗    ████████╗███████╗██████╗ ║
    ║           ╚══██╔══╝██║   ██║██║    ╚══██╔══╝██╔════╝██╔══██╗║
    ║              ██║   ██║   ██║██║       ██║   █████╗  ██████╔╝║
    ║              ██║   ██║   ██║██║       ██║   ██╔══╝  ██╔══██╗║
    ║              ██║   ╚██████╔╝██║       ██║   ███████╗██║  ██║║
    ║              ╚═╝    ╚═════╝ ╚═╝       ╚═╝   ╚══════╝╚═╝  ╚═╝║
    ║                                                               ║
    ║                  U N I V E R S A L   v4.0                    ║
    ║               M O B I L E  E D I T I O N                   ║
    ║              ✨ Turbo Menu & More Options ✨              ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝

    Autor: MutanoXX
    Versão: 4.0.0 Mobile Edition
    Descrição: Script universal com suporte Mobile/Desktop e menu turbinado
    Nota: Apenas para fins educacionais e uso em seus próprios jogos
]]

-- ═══════════════════════════════════════════════════════════════
-- SERVIÇOS E CONFIGURAÇÕES GLOBAIS
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local Camera = Workspace.CurrentCamera

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ═══════════════════════════════════════════════════════════════
-- DETECÇÃO DE DISPOSITIVO
-- ═══════════════════════════════════════════════════════════════

local function IsMobile()
    return UserInputService.TouchEnabled or GuiService:IsTenFootInterface()
end

local DeviceType = IsMobile() and "Mobile" or "Desktop"

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURAÇÕES DO SCRIPT
-- ═══════════════════════════════════════════════════════════════

local ScriptConfig = {
    Version = "4.0.0",
    Name = "MutanoX Universal",
    Author = "MutanoXX",
    MenuToggleKey = Enum.KeyCode.RightControl,
    NotificationDuration = 3,
    SaveSettings = true,
    AutoSaveInterval = 30
    MobileMenuPosition = "bottom-right" -- bottom-right, bottom-left, top-right, top-left
}

-- ═════════════════════════════════════════════════════════════════
-- SISTEMA DE CORES E TEMA TURBINADO
-- ═══════════════════════════════════════════════════════════════

local Theme = {
    Primary = Color3.fromRGB(147, 51, 234),       -- Roxo vibrante
    PrimaryDark = Color3.fromRGB(102, 16, 242),    -- Roxo escuro
    Secondary = Color3.fromRGB(6, 182, 212),      -- Ciano brilhante
    Success = Color3.fromRGB(16, 185, 129),       -- Verde neon
    Warning = Color3.fromRGB(251, 191, 36),       -- Amarelo dourado
    Error = Color3.fromRGB(239, 68, 68),         -- Vermelho vibrante
    Gold = Color3.fromRGB(255, 215, 0),        -- Dourado para Premium
    
    Background = Color3.fromRGB(10, 10, 20),       -- Fundo escuro profundo
    BackgroundLight = Color3.fromRGB(20, 20, 35), -- Fundo claro
    Card = Color3.fromRGB(25, 25, 40),            -- Card
    CardHover = Color3.fromRGB(40, 40, 70),       -- Card hover
    Gradient = Color3.fromRGB(120, 80, 255),       -- Gradiente roxo
    
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(220, 220, 240),
    TextMuted = Color3.fromRGB(150, 150, 170),
    
    Border = Color3.fromRGB(100, 80, 255),
    Shadow = Color3.fromRGB(0, 0, 0)
}

-- ═══════════════════════════════════════════════════════════════
-- ESTADO GLOBAL DO SCRIPT
-- ═════════════════════════════════════════════════════════════════

local ScriptState = {
    MenuVisible = true,
    MenuMinimized = false,
    CurrentTab = "ESP",
    MenuPosition = UDim2.new(0, 50, 0, 50),
    MenuDragging = false,
    MenuDragStart = nil,
    MenuStartPosition = nil,
    
    ESP = {
        Enabled = false,
        Box = { Enabled = true, Color = Theme.Primary, Thickness = 2 },
        Names = { Enabled = true, Color = Theme.TextPrimary, Size = 14 },
        Distance = { Enabled = true, Color = Theme.Success, Size = 12 },
        TeamCheck = { Enabled = true },
        MaxDistance = 500,
        Rainbow = { Enabled = false, Speed = 1 }
    },
    
    Aimbot = {
        Enabled = false,
        FOV = 100,
        Smoothness = 0.1,
        Prediction = 0,
        TargetPriority = "Nearest",
        TeamCheck = true,
        VisibilityCheck = true,
        FOVColor = Theme.Primary
    },
    
    Fly = { Enabled = false, Speed = 50 },
    Speed = { Enabled = false, Value = 32 },
    SuperJump = { Enabled = false, Power = 100 },
    Noclip = { Enabled = false },
    InfiniteJump = { Enabled = false },
    AutoSprint = { Enabled = false },
    
    FullBright = { Enabled = false },
    NoFog = { Enabled = false },
    AntiAFK = { Enabled = false },
    GodMode = { Enabled = false },
    AutoFarm = { Enabled = false, AutoClickDelay = 0.1 },
    Spinbot = { Enabled = false, Speed = 50 },
    HitboxExpander = { Enabled = false, Size = 10 },
    Triggerbot = { Enabled = false, Delay = 0.1 },
    
    Teleport = { Enabled = false, Mode = "Click" },
    ViewFOV = { Enabled = false, FOV = 90 },
    CustomCrosshair = { Enabled = false, Size = 20 },
    
    RejoinServer = { Enabled = false },
    ServerHop = { Enabled = false },
    
    OriginalWalkSpeed = Humanoid.WalkSpeed,
    OriginalJumpPower = Humanoid.JumpPower,
    OriginalHealth = Humanoid.MaxHealth,
    OriginalFOV = Camera.FieldOfView,
    
    ScreenGui = nil,
    MainFrame = nil,
    MobileToggleBtn = nil,
    Tabs = {},
    Buttons = {},
    
    Logs = {},
    MaxLogs = 50
}

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE NOTIFICAÇÕES
-- ═════════════════════════════════════════════════════════════════

local Notifications = {}

local function CreateNotification(title, message, notifType)
    notifType = notifType or "info"
    
    local colors = {
        info = Theme.Primary,
        success = Theme.Success,
        warning = Theme.Warning,
        error = Theme.Error
    }
    
    if not ScriptState.ScreenGui then
        return
    end
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification_" .. tostring(#Notifications + 1)
    notification.Size = UDim2.new(0, 350, 0, 80)
    notification.Position = UDim2.new(1, 400, 0, 20 + (#Notifications * 90))
    notification.BackgroundColor3 = Theme.Card
    notification.BorderSizePixel = 0
    notification.ZIndex = 1000
    notification.Parent = ScriptState.ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = colors[notifType] or Theme.Primary
    stroke.Thickness = 2
    stroke.Parent = notification
    
    local glow = Instance.new("UIGradient")
    glow.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, colors[notifType]),
        ColorSequenceKeypoint.new(1, colors[notifType])
    })
    glow.Rotation = 45
    glow.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(1, 1)
    })
    glow.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = colors[notifType] or Theme.Primary
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, 40)
    messageLabel.Position = UDim2.new(0, 10, 0, 33)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Theme.TextSecondary
    messageLabel.TextSize = 13
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.Parent = notification
    
    local tweenIn = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -370, 0, 20 + (#Notifications * 90))
    })
    tweenIn:Play()
    
    table.insert(Notifications, {
        Frame = notification,
        Created = tick()
    })
    
    task.delay(ScriptConfig.NotificationDuration, function()
        local tweenOut = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 400, notification.Position.Y.Scale, notification.Position.Y.Offset)
        })
        tweenOut:Play()
        tweenOut.Completed:Wait()
        notification:Destroy()
    end)
    
    table.insert(ScriptState.Logs, 1, {
        Time = os.date("%H:%M:%S"),
        Title = title,
        Message = message,
        Type = notifType
    })
    
    if #ScriptState.Logs > ScriptState.MaxLogs then
        table.remove(ScriptState.Logs)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- FUNÇÕES UTILITÁRIAS
-- ═══════════════════════════════════════════════════════════════

local function CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = rotation or 45
    gradient.Parent = parent
    return gradient
end

local function CreateButtonEffect(button, color)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = color
            Size = button.Size + UDim2.new(0, 5, 0, 0)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = originalColor
            Size = button.Size - UDim2.new(0, 5, 0, 0)
        }):Play()
    end)
end

local function UpdateButtonState(button, enabled, isPremium)
    if enabled then
        if isPremium then
            button.BackgroundColor3 = Theme.Gold
            button.UIStroke.Color = Color3.fromRGB(200, 150, 0)
        else
            button.BackgroundColor3 = Theme.Success
            button.UIStroke.Color = Theme.PrimaryDark
        end
        button.Text = "ON"
        button.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        button.BackgroundColor3 = Theme.Card
        button.UIStroke.Color = Theme.Border
        button.Text = "OFF"
        button.TextColor3 = Theme.TextPrimary
    end
end

-- ═══════════════════════════════════════════════════════════════
-- CRIAÇÃO DO MENU TURBINADO
-- ═══════════════════════════════════════════════════════════════

local function CreateMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MutanoX_Universal_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = Player.PlayerGui
    ScriptState.ScreenGui = screenGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    
    if IsMobile() then
        mainFrame.Size = UDim2.new(0, 380, 0, 500)
        mainFrame.Position = UDim2.new(0.5, -190, 0.5, -250)
        mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    else
        mainFrame.Size = UDim2.new(0, 420, 0, 580)
        mainFrame.Position = ScriptState.MenuPosition
        mainFrame.AnchorPoint = Vector2.new(0, 0)
    end
    
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    ScriptState.MainFrame = mainFrame
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, 8, 0, 8)
    shadow.BackgroundColor3 = Theme.Shadow
    shadow.BackgroundTransparency = 0.5
    shadow.BorderSizePixel = 0
    shadow.ZIndex = mainFrame.ZIndex - 1
    shadow.Parent = mainFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 16)
    shadowCorner.Parent = shadow
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 65)
    header.BackgroundColor3 = Theme.BackgroundLight
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header
    
    CreateGradient(header, Theme.PrimaryDark, Theme.Primary, 135)
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -120, 0, 30)
    title.Position = UDim2.new(0, 15, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "⚡ MutanoX v4.0"
    title.TextColor3 = Theme.TextPrimary
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local deviceBadge = Instance.new("TextLabel")
    deviceBadge.Name = "DeviceBadge"
    deviceBadge.Size = UDim2.new(1, -120, 0, 15)
    deviceBadge.Position = UDim2.new(0, 15, 0, 30)
    deviceBadge.BackgroundTransparency = 1
    deviceBadge.Text = DeviceType .. " Edition"
    deviceBadge.TextColor3 = IsMobile() and Theme.Secondary or Theme.Gold
    deviceBadge.TextSize = 12
    deviceBadge.Font = Enum.Font.GothamBold
    deviceBadge.TextXAlignment = Enum.TextXAlignment.Left
    deviceBadge.Parent = header
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -48, 0, 12)
    minimizeButton.BackgroundColor3 = Theme.Error
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = Theme.TextPrimary
    minimizeButton.TextSize = 24
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = mainFrame
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 10)
    minCorner.Parent = minimizeButton
    
    local minStroke = Instance.new("UIStroke")
    minStroke.Color = Theme.Error
    minStroke.Thickness = 2
    minStroke.Transparency = 0.3
    minStroke.Parent = minimizeButton
    
    Tabs Frame
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Name = "TabsFrame"
    tabsFrame.Size = UDim2.new(1, -20, 0, 45)
    tabsFrame.Position = UDim2.new(0, 10, 0, 68)
    tabsFrame.BackgroundTransparency = 1
    tabsFrame.Parent = mainFrame
    
    local tabsList = {"ESP", "Combat", "Player", "World", "Misc"}
    local tabButtons = {}
    
    for i, tabName in ipairs(tabsList) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(0, 75, 0, 35)
        tabButton.Position = UDim2.new(0, (i - 1) * 77 + 5, 0, 5)
        tabButton.BackgroundColor3 = Theme.Card
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Theme.TextSecondary
        tabButton.TextSize = 12
        tabButton.Font = Enum.Font.GothamBold
        tabButton.Parent = tabsFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton
        
        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = Theme.Border
        tabStroke.Thickness = 1
        tabStroke.Parent = tabButton
        
        CreateButtonEffect(tabButton, Theme.Primary)
        
        tabButtons[tabName] = tabButton
        ScriptState.Tabs[tabName] = tabButton
        
        tabButton.MouseButton1Click:Connect(function()
            for name, btn in pairs(tabButtons) do
                if name == tabName then
                    btn.BackgroundColor3 = Theme.Primary
                    btn.TextColor3 = Theme.TextPrimary
                    btn.UIStroke.Color = Theme.PrimaryDark
                else
                    btn.BackgroundColor3 = Theme.Card
                    btn.TextColor3 = Theme.TextSecondary
                    btn.UIStroke.Color = Theme.Border
                end
            end
            
            ScriptState.CurrentTab = tabName
            CreateNotification("Tab Changed", "Switched to " .. tabName .. " tab", "info")
        end)
    end
    
    tabButtons[ScriptState.CurrentTab].BackgroundColor3 = Theme.Primary
    tabButtons[ScriptState.CurrentTab].TextColor3 = Theme.TextPrimary
    tabButtons[ScriptState.CurrentTab].UIStroke.Color = Theme.PrimaryDark
    
    Content Frame
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -120)
    contentFrame.Position = UDim2.new(0, 10, 0, 113)
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 5
    contentFrame.ScrollBarImageColor3 = Theme.Primary
    contentFrame.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 12)
    contentCorner.Parent = contentFrame
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim2.new(0, 10)
    contentPadding.PaddingLeft = UDim2.new(0, 10)
    contentPadding.PaddingRight = UDim2.new(0, 10)
    contentPadding.PaddingBottom = UDim2.new(0, 10)
    contentPadding.Parent = contentFrame
    
    CreateButtons(contentFrame)
    
    Content Size
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    
    Mobile Toggle Button
    if IsMobile() then
        local mobileToggle = Instance.new("TextButton")
        mobileToggle.Name = "MobileToggle"
        mobileToggle.Size = UDim2.new(0, 60, 0, 60)
        
        if ScriptConfig.MobileMenuPosition == "bottom-right" then
            mobileToggle.Position = UDim2.new(1, -70, 1, -70)
        elseif ScriptConfig.MobileMenuPosition == "bottom-left" then
            mobileToggle.Position = UDim2.new(0, 10, 1, -70)
        elseif ScriptConfig.MobileMenuPosition == "top-right" then
            mobileToggle.Position = UDim2.new(1, -70, 0, 10)
        else
            mobileToggle.Position = UDim2.new(0, 10, 0, 10)
        end
        
        mobileToggle.BackgroundColor3 = Theme.Primary
        mobileToggle.BorderSizePixel = 0
        mobileToggle.Text = "⚡"
        mobileToggle.TextColor3 = Theme.TextPrimary
        mobileToggle.TextSize = 30
        mobileToggle.Font = Enum.Font.GothamBold
        mobileToggle.ZIndex = 999
        mobileToggle.Parent = screenGui
        ScriptState.MobileToggleBtn = mobileToggle
        
        local mobileCorner = Instance.new("UICorner")
        mobileCorner.CornerRadius = UDim.new(0, 30)
        mobileCorner.Parent = mobileToggle
        
        local mobileGlow = Instance.new("UIGradient")
        local colors = {
            ColorSequenceKeypoint.new(0, Theme.Primary),
            ColorSequenceKeypoint.new(0.5, Theme.Secondary),
            ColorSequenceKeypoint.new(1, Theme.Primary)
        }
        mobileGlow.Color = ColorSequence.new(colors)
        mobileGlow.Rotation = 0
        mobileGlow.Parent = mobileToggle
        
        local pulse = Instance.new("NumberValue")
        pulse.Value = 0
        pulse.Parent = mobileToggle
        
        local pulseAnim
        pulseAnim = function()
            local value = pulse.Value
            pulse.Value = value + 0.05
            if pulse.Value > 1 then pulse.Value = 0 end
            
            local alpha = 0.7 + math.sin(pulse.Value * math.pi * 2) * 0.3
            mobileToggle.BackgroundTransparency = 1 - alpha
        end
        
        RunService.RenderStepped:Connect(function()
            if ScriptState.ScreenGui then
                pulseAnim()
            end
        end)
        
        mobileToggle.MouseButton1Click:Connect(function()
            ScriptState.MenuVisible = not ScriptState.MenuVisible
            mainFrame.Visible = ScriptState.MenuVisible
            if ScriptState.MenuVisible then
                CreateNotification("Menu Opened", "MutanoX Universal is now visible", "success")
            end
        end)
    end
    
    Drag and Drop
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            ScriptState.MenuDragging = true
            ScriptState.MenuDragStart = input.Position
            ScriptState.MenuStartPosition = mainFrame.Position
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            ScriptState.MenuDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if ScriptState.MenuDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - ScriptState.MenuDragStart
            mainFrame.Position = UDim2.new(
                ScriptState.MenuStartPosition.X.Scale,
                ScriptState.MenuStartPosition.X.Offset + delta.X,
                ScriptState.MenuStartPosition.Y.Scale,
                ScriptState.MenuStartPosition.Y.Offset + delta.Y
            )
        end
    end)
    
    Minimize Button
    minimizeButton.MouseButton1Click:Connect(function()
        ScriptState.MenuMinimized = not ScriptState.MenuMinimized
        
        if ScriptState.MenuMinimized then
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 200, 0, 65)
            }):Play()
            contentFrame.Visible = false
            tabsFrame.Visible = false
            minimizeButton.Text = "+"
        else
            if IsMobile() then
                TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                    Size = UDim2.new(0, 380, 0, 500)
                }):Play()
            else
                TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                    Size = UDim2.new(0, 420, 0, 580)
                }):Play()
            end
            contentFrame.Visible = true
            tabsFrame.Visible = true
            minimizeButton.Text = "−"
        end
    end)
    
    return screenGui
end

-- ═══════════════════════════════════════════════════════════════
-- CRIAÇÃO DOS BOTÕES
-- ═══════════════════════════════════════════════════════════════

local function CreateButtons(contentFrame)
    local yOffset = 10
    
    local function CreateFeatureButton(name, description, stateRef, callback, yPos, isPremium)
        local button = Instance.new("TextButton")
        button.Name = name .. "Button"
        button.Size = UDim2.new(1, 0, 0, 55)
        button.Position = yPos
        button.BackgroundColor3 = stateRef and (isPremium and Theme.Gold or Theme.Success) or Theme.Card
        button.BorderSizePixel = 0
        button.Parent = contentFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = button
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = stateRef and (isPremium and Theme.Gold or Theme.PrimaryDark) or Theme.Border
        btnStroke.Thickness = stateRef and 3 or 2
        btnStroke.Parent = button
        
        local glow = Instance.new("UIGradient")
        glow.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, stateRef and (isPremium and Theme.Gold or Theme.Success) or Theme.Card),
            ColorSequenceKeypoint.new(1, stateRef and (isPremium and Theme.Gold or Theme.Success) or Theme.Card)
        })
        glow.Rotation = 45
        glow.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, stateRef and 0.2 or 0.5),
            NumberSequenceKeypoint.new(1, 1)
        })
        glow.Parent = button
        
        CreateButtonEffect(button, stateRef and Theme.Success or Theme.Primary)
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, -70, 0, 22)
        nameLabel.Position = UDim2.new(0, 10, 0, 4)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name .. (isPremium and " ⭐" or "")
        nameLabel.TextColor3 = stateRef and (isPremium and Color3.fromRGB(255, 255, 200) or Color3.fromRGB(0, 0, 0)) or Theme.TextPrimary
        nameLabel.TextSize = 15
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = button
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Name = "DescLabel"
        descLabel.Size = UDim2.new(1, -70, 0, 14)
        descLabel.Position = UDim2.new(0, 10, 0, 26)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = description
        descLabel.TextColor3 = Theme.TextMuted
        descLabel.TextSize = 11
        descLabel.Font = Enum.Font.Gotham
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = button
        
        button.MouseButton1Click:Connect(function()
            local newState = callback()
            UpdateButtonState(button, newState, isPremium)
            
            if newState then
                CreateNotification(name .. " Enabled", "Feature has been activated", "success")
            else
                CreateNotification(name .. " Disabled", "Feature has been deactivated", "info")
            end
        end)
        
        return button
    end
    
    -- ESP Features
    CreateFeatureButton("Box ESP", "Show boxes around players", ScriptState.ESP.Box.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.ESP.Box.Enabled = not ScriptState.ESP.Box.Enabled
        ScriptState.ESP.Enabled = ScriptState.ESP.Box.Enabled
        return ScriptState.ESP.Box.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Names ESP", "Show player names", ScriptState.ESP.Names.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.ESP.Names.Enabled = not ScriptState.ESP.Names.Enabled
        return ScriptState.ESP.Names.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Distance ESP", "Show player distance", ScriptState.ESP.Distance.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.ESP.Distance.Enabled = not ScriptState.ESP.Distance.Enabled
        return ScriptState.ESP.Distance.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Team Check", "Only show enemies", ScriptState.ESP.TeamCheck.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.ESP.TeamCheck.Enabled = not ScriptState.ESP.TeamCheck.Enabled
        return ScriptState.ESP.TeamCheck.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Rainbow Mode", "Rainbow color effect", ScriptState.ESP.Rainbow.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.ESP.Rainbow.Enabled = not ScriptState.ESP.Rainbow.Enabled
        return ScriptState.ESP.Rainbow.Enabled
    end)
    yOffset = yOffset + 65
    
    -- Combat Features
    CreateFeatureButton("Aimbot", "Auto-aim at players", ScriptState.Aimbot.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), false, function()
        ScriptState.Aimbot.Enabled = not ScriptState.Aimbot.Enabled
        return ScriptState.Aimbot.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("God Mode", "Become invincible", ScriptState.GodMode.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), true, function()
        ScriptState.GodMode.Enabled = not ScriptState.GodMode.Enabled
        if ScriptState.GodMode.Enabled then
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
        else
            Humanoid.MaxHealth = ScriptState.OriginalHealth
            Humanoid.Health = ScriptState.OriginalHealth
        end
        return ScriptState.GodMode.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Hitbox Expander", "Expand hitboxes", ScriptState.HitboxExpander.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), false, function()
        ScriptState.HitboxExpander.Enabled = not ScriptState.HitboxExpander.Enabled
        return ScriptState.HitboxExpander.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Triggerbot", "Auto-shoot when aiming", ScriptState.Triggerbot.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), false, function()
        ScriptState.Triggerbot.Enabled = not ScriptState.Triggerbot.Enabled
        return ScriptState.Triggerbot.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Spinbot", "Spin character", ScriptState.Spinbot.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), false, function()
        ScriptState.Spinbot.Enabled = not ScriptState.Spinbot.Enabled
        return ScriptState.Spinbot.Enabled
    end)
    yOffset = yOffset + 65
    
    -- Player Features
    CreateFeatureButton("Fly", "Fly freely around", ScriptState.Fly.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.Fly.Enabled = not ScriptState.Fly.Enabled
        return ScriptState.Fly.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Speed Hack", "Increase speed", ScriptState.Speed.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.Speed.Enabled = not ScriptState.Speed.Enabled
        if ScriptState.Speed.Enabled then
            Humanoid.WalkSpeed = ScriptState.Speed.Value
        else
            Humanoid.WalkSpeed = ScriptState.OriginalWalkSpeed
        end
        return ScriptState.Speed.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Super Jump", "Jump extremely high", ScriptState.SuperJump.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.SuperJump.Enabled = not ScriptState.SuperJump.Enabled
        if ScriptState.SuperJump.Enabled then
            Humanoid.JumpPower = ScriptState.SuperJump.Power
        else
            Humanoid.JumpPower = ScriptState.OriginalJumpPower
        end
        return ScriptState.SuperJump.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Noclip", "Walk through walls", ScriptState.Noclip.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.Noclip.Enabled = not ScriptState.Noclip.Enabled
        return ScriptState.Noclip.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Infinite Jump", "Jump infinitely", ScriptState.InfiniteJump.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.InfiniteJump.Enabled = not ScriptState.InfiniteJump.Enabled
        return ScriptState.InfiniteJump.Enabled
    end)
    yOffset = yOffset + 65
    
    -- World Features
    CreateFeatureButton("Full Bright", "Maximum visibility", ScriptState.FullBright.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.FullBright.Enabled = not ScriptState.FullBright.Enabled
        if ScriptState.FullBright.Enabled then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1
            Lighting.FogEnd = 10000
            Lighting.GlobalShadows = true
        end
        return ScriptState.FullBright.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("No Fog", "Remove fog effect", ScriptState.NoFog.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.NoFog.Enabled = not ScriptState.NoFog.Enabled
        if ScriptState.NoFog.Enabled then
            Lighting.FogEnd = 100000
            Lighting.FogStart = 100000
        else
            Lighting.FogEnd = 10000
            Lighting.FogStart = 0
        end
        return ScriptState.NoFog.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Custom FOV", "Adjust field of view", ScriptState.ViewFOV.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.ViewFOV.Enabled = not ScriptState.ViewFOV.Enabled
        if ScriptState.ViewFOV.Enabled then
            Camera.FieldOfView = ScriptState.ViewFOV.FOV
        else
            Camera.FieldOfView = ScriptState.OriginalFOV
        end
        return ScriptState.ViewFOV.Enabled
    end)
    yOffset = yOffset + 65
    
    -- Misc Features
    CreateFeatureButton("Anti AFK", "Prevent AFK kick", ScriptState.AntiAFK.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.AntiAFK.Enabled = not ScriptState.AntiAFK.Enabled
        return ScriptState.AntiAFK.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Auto Farm", "Auto-click feature", ScriptState.AutoFarm.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), false, function()
        ScriptState.AutoFarm.Enabled = not ScriptState.AutoFarm.Enabled
        return ScriptState.AutoFarm.Enabled
    end)
    yOffset = yOffset + 65
    
    CreateFeatureButton("Teleport Mode", "Click to teleport", ScriptState.Teleport.Enabled, contentFrame, UDim2.new(0, 0, 0, yOffset), function()
        ScriptState.Teleport.Enabled = not ScriptState.Teleport.Enabled
        return ScriptState.Teleport.Enabled
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE ESP
-- ═══════════════════════════════════════════════════════════════

local ESPObjects = {}

local function CreateESP()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= Player then
            local espGui = Instance.new("BillboardGui")
            espGui.Name = "ESP_" .. targetPlayer.Name
            espGui.Size = UDim2.new(0, 150, 0, 100)
            espGui.StudsOffset = Vector3.new(0, 3, 0)
            espGui.Parent = targetPlayer.Character
            
            local box = Instance.new("Frame")
            box.Size = UDim2.new(1, 0, 1, 0)
            box.BackgroundColor3 = ScriptState.ESP.Box.Color
            box.BackgroundTransparency = 0.3
            box.BorderSizePixel = 2
            box.BorderColor3 = ScriptState.ESP.Box.Color
            box.Parent = espGui
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0, 25)
            nameLabel.Position = UDim2.new(0, 0, 0, -27)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = targetPlayer.Name
            nameLabel.TextColor3 = ScriptState.ESP.Names.Color
            nameLabel.TextSize = ScriptState.ESP.Names.Size
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Parent = espGui
            
            local distLabel = Instance.new("TextLabel")
            distLabel.Size = UDim2.new(1, 0, 0, 20)
            distLabel.Position = UDim2.new(0, 0, 0, 2)
            distLabel.BackgroundTransparency = 1
            distLabel.Text = "Calc..."
            distLabel.TextColor3 = ScriptState.ESP.Distance.Color
            distLabel.TextSize = ScriptState.ESP.Distance.Size
            distLabel.Font = Enum.Font.Gotham
            distLabel.TextStrokeTransparency = 0.5
            distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distLabel.Parent = espGui
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.FillColor = ScriptState.ESP.Box.Color
            highlight.OutlineColor = ScriptState.ESP.Box.Color
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0.3
            highlight.Parent = targetPlayer.Character
            
            table.insert(ESPObjects, {
                Player = targetPlayer,
                Gui = espGui,
                Box = box,
                NameLabel = nameLabel,
                DistLabel = distLabel,
                Highlight = highlight
            })
        end
    end
    
    Players.PlayerAdded:Connect(function(newPlayer)
        if newPlayer ~= Player then
            task.wait(1)
            
            local espGui = Instance.new("BillboardGui")
            espGui.Name = "ESP_" .. newPlayer.Name
            espGui.Size = UDim2.new(0, 150, 0, 100)
            espGui.StudsOffset = Vector3.new(0, 3, 0)
            espGui.Parent = newPlayer.Character
            
            local box = Instance.new("Frame")
            box.Size = UDim2.new(1, 0, 1, 0)
            box.BackgroundColor3 = ScriptState.ESP.Box.Color
            box.BackgroundTransparency = 0.3
            box.BorderSizePixel = 2
            box.BorderColor3 = ScriptState.ESP.Box.Color
            box.Parent = espGui
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0, 25)
            nameLabel.Position = UDim2.new(0, 0, 0, -27)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = newPlayer.Name
            nameLabel.TextColor3 = ScriptState.ESP.Names.Color
            nameLabel.TextSize = ScriptState.ESP.Names.Size
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Parent = espGui
            
            local distLabel = Instance.new("TextLabel")
            distLabel.Size = UDim2.new(1, 0, 0, 20)
            distLabel.Position = UDim2.new(0, 0, 0, 2)
            distLabel.BackgroundTransparency = 1
            distLabel.Text = "Calc..."
            distLabel.TextColor3 = ScriptState.ESP.Distance.Color
            distLabel.TextSize = ScriptState.ESP.Distance.Size
            distLabel.Font = Enum.Font.Gotham
            distLabel.TextStrokeTransparency = 0.5
            distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distLabel.Parent = espGui
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.FillColor = ScriptState.ESP.Box.Color
            highlight.OutlineColor = ScriptState.ESP.Box.Color
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0.3
            highlight.Parent = newPlayer.Character
            
            table.insert(ESPObjects, {
                Player = newPlayer,
                Gui = espGui,
                Box = box,
                NameLabel = nameLabel,
                DistLabel = distLabel,
                Highlight = highlight
            })
        end
    end)
    
    Players.PlayerRemoving:Connect(function(removedPlayer)
        for i, esp in ipairs(ESPObjects) do
            if esp.Player == removedPlayer then
                if esp.Gui then esp.Gui:Destroy() end
                if esp.Highlight then esp.Highlight:Destroy() end
                table.remove(ESPObjects, i)
                break
            end
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if not ScriptState.ESP.Enabled then
            for _, esp in ipairs(ESPObjects) do
                if esp.Gui then esp.Gui.Enabled = false end
                if esp.Highlight then esp.Highlight.Enabled = false end
            end
            return
        end
        
        local myChar = Player.Character
        if not myChar then return end
        
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end
        
        for _, esp in ipairs(ESPObjects) do
            local targetChar = esp.Player.Character
            if not targetChar then continue end
            
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            if not targetHRP then continue end
            
            -- Team Check
            if ScriptState.ESP.TeamCheck and esp.Player.Team == Player.Team then
                if esp.Gui then esp.Gui.Enabled = false end
                if esp.Highlight then esp.Highlight.Enabled = false end
                continue
            end
            
            -- Distance Check
            local distance = (myHRP.Position - targetHRP.Position).Magnitude
            if distance > ScriptState.ESP.MaxDistance then
                if esp.Gui then esp.Gui.Enabled = false end
                if esp.Highlight then esp.Highlight.Enabled = false end
                continue
            end
            
            -- Update
            if esp.Gui then esp.Gui.Enabled = true end
            if esp.Highlight then
                if ScriptState.ESP.Rainbow.Enabled then
                    local hue = (tick() * ScriptState.ESP.Rainbow.Speed) % 1
                    esp.Highlight.FillColor = Color3.fromHSV(hue, 1, 1)
                    esp.Highlight.OutlineColor = Color3.fromHSV(hue, 1, 1)
                    esp.Box.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                    esp.Box.BorderColor3 = Color3.fromHSV(hue, 1, 1)
                else
                    esp.Highlight.FillColor = ScriptState.ESP.Box.Color
                    esp.Highlight.OutlineColor = ScriptState.ESP.Box.Color
                    esp.Box.BackgroundColor3 = ScriptState.ESP.Box.Color
                    esp.Box.BorderColor3 = ScriptState.ESP.Box.Color
                end
                esp.Highlight.Enabled = true
            end
            
            if esp.DistLabel then
                esp.DistLabel.Text = string.format("%.0f", distance)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE MOVIMENTO
-- ═══════════════════════════════════════════════════════════════

local function EnableMovementSystems()
    local flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.Name = "FlyVelocity"
    flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyVelocity.Velocity = Vector3.new(0, 0, 0)
    
    local flyGyro = Instance.new("BodyGyro")
    flyGyro.Name = "FlyGyro"
    flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyGyro.P = 10000
    
    RunService.RenderStepped:Connect(function()
        if ScriptState.Fly.Enabled then
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                flyVelocity.Parent = char.HumanoidRootPart
                flyGyro.Parent = char.HumanoidRootPart
                
                local moveDir = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(0, 0, -1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir + Vector3.new(0, 0, 1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir + Vector3.new(-1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir + Vector3.new(0, -1, 0) end
                
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir * 2 end
                
                flyVelocity.Velocity = Camera.CFrame:VectorToWorldSpace(moveDir) * ScriptState.Fly.Speed
                flyGyro.CFrame = Camera.CFrame
            end
        else
            flyVelocity.Parent = nil
            flyGyro.Parent = nil
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if ScriptState.Noclip.Enabled then
            local char = Player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
    
    UserInputService.JumpRequest:Connect(function()
        if ScriptState.InfiniteJump.Enabled then
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE AIMBOT
-- ═══════════════════════════════════════════════════════════════

local function EnableAimbot()
    local currentTarget = nil
    local fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = 2
    fovCircle.Color = ScriptState.Aimbot.FOVColor
    fovCircle.NumSides = 64
    fovCircle.Radius = ScriptState.Aimbot.FOV
    fovCircle.Filled = false
    fovCircle.Visible = false
    fovCircle.Transparency = 0.5
    
    local function GetBestTarget()
        local bestTarget = nil
        local closestDistance = ScriptState.Aimbot.FOV
        
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= Player then
                if ScriptState.Aimbot.TeamCheck and targetPlayer.Team == Player.Team then
                    continue
                end
                
                local targetChar = targetPlayer.Character
                if not targetChar then continue end
                
                local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                
                if not targetHRP or not targetHumanoid then continue end
                if targetHumanoid.Health <= 0 then continue end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetHRP.Position)
                if not onScreen then continue end
                
                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                
                if screenDist < closestDistance then
                    closestDistance = screenDist
                    bestTarget = targetChar
                end
            end
        end
        
        return bestTarget
    end
    
    RunService.RenderStepped:Connect(function()
        if ScriptState.Aimbot.Enabled then
            fovCircle.Visible = true
            fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            fovCircle.Radius = ScriptState.Aimbot.FOV
            fovCircle.Color = ScriptState.Aimbot.FOVColor
            
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                currentTarget = GetBestTarget()
                
                if currentTarget and currentTarget:FindFirstChild("HumanoidRootPart") then
                    local targetCFrame = CFrame.new(Camera.CFrame.Position, currentTarget.HumanoidRootPart.Position)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, ScriptState.Aimbot.Smoothness)
                end
            end
        else
            fovCircle.Visible = false
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE TELEPORTE
-- ═════════════════════════════════════════════════════════════════

local function EnableTeleport()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 and ScriptState.Teleport.Enabled then
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                local mouseLocation = UserInputService:GetMouseLocation()
                local ray = Camera:ViewportPointToRay(mouseLocation, 1000)
                local rayResult = Workspace:Raycast(ray.Origin, ray.Direction)
                
                if rayResult then
                    local char = Player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(rayResult.Position + Vector3.new(0, 5, 0))
                    end
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE AUTO-FARM
-- ═══════════════════════════════════════════════════════════════

local function EnableAutoFarm()
    RunService.RenderStepped:Connect(function()
        if ScriptState.AutoFarm.Enabled then
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                VirtualInputManager:SendMouseButtonEvent(true, 0, false)
                task.wait(ScriptState.AutoFarm.AutoClickDelay)
                VirtualInputManager:SendMouseButtonEvent(false, 0, false)
            end
        end
    end)
end

-- ═════════════════════════════════════════════════════════════════
-- SISTEMA DE SPINBOT
-- ═══════════════════════════════════════════════════════════════

local function EnableSpinbot()
    RunService.RenderStepped:Connect(function()
        if ScriptState.Spinbot.Enabled then
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(ScriptState.Spinbot.Speed), 0)
            end
        end
    end)
end

-- ═════════════════════════════════════════════════════════════════
-- SISTEMA DE HITBOX EXPANDER
-- ═════════════════════════════════════════════════════════════════

local function EnableHitboxExpander()
    RunService.RenderStepped:Connect(function()
        if ScriptState.HitboxExpander.Enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Player then
                    local char = player.Character
                    if char then
                        local head = char:FindFirstChild("Head")
                        local humanoid = char:FindFirstChild("Humanoid")
                        if head and humanoid then
                            head.Size = Vector3.new(ScriptState.HitboxExpander.Size, ScriptState.HitboxExpander.Size, ScriptState.HitboxExpander.Size)
                        end
                    end
                end
            end
        end
    end)
end

-- ═════════════════════════════════════════════════════════════════
-- ANTI AFK
-- ═════════════════════════════════════════════════════════════════

local function EnableAntiAFK()
    while true do
        task.wait(math.random(120, 300))
        if ScriptState.AntiAFK.Enabled then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        end
    end
end

-- ═════════════════════════════════════════════════════════════════
-- INICIALIZAÇÃO DO SCRIPT
-- ═══════════════════════════════════════════════════════════════════

local function Initialize()
    CreateMenu()
    CreateESP()
    EnableMovementSystems()
    EnableAimbot()
    EnableTeleport()
    EnableAutoFarm()
    EnableSpinbot()
    EnableHitboxExpander()
    task.spawn(EnableAntiAFK)
    
    Player.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
        Humanoid = Character:WaitForChild("Humanoid")
        RootPart = Character:WaitForChild("HumanoidRootPart")
        
        ScriptState.OriginalWalkSpeed = Humanoid.WalkSpeed
        ScriptState.OriginalJumpPower = Humanoid.JumpPower
        ScriptState.OriginalHealth = Humanoid.MaxHealth
        
        if ScriptState.GodMode.Enabled then
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
        end
        
        if ScriptState.Speed.Enabled then
            Humanoid.WalkSpeed = ScriptState.Speed.Value
        end
        
        if ScriptState.SuperJump.Enabled then
            Humanoid.JumpPower = ScriptState.SuperJump.Power
        end
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == ScriptConfig.MenuToggleKey then
            ScriptState.MenuVisible = not ScriptState.MenuVisible
            if ScriptState.ScreenGui and ScriptState.MainFrame then
                ScriptState.MainFrame.Visible = ScriptState.MenuVisible
                if ScriptState.MenuVisible then
                    CreateNotification("Menu Opened", "MutanoX Universal is now visible", "info")
                end
            end
        end
    end)
    
    CreateNotification("Welcome!", "MutanoX Universal v" .. ScriptConfig.Version .. " " .. DeviceType .. " Edition loaded!", "success")
    task.wait(0.5)
    CreateNotification("Features", "20+ features available", "info")
    task.wait(0.5)
    
    if IsMobile() then
        CreateNotification("Mobile Mode", "Tap ⚡ button to open menu", "success")
    else
        CreateNotification("Desktop Mode", "Press Right Ctrl to toggle menu", "info")
    end
    
    task.wait(0.5)
    CreateNotification("Reminder", "Use only on your own games for educational purposes", "warning")
end

Initialize()

print("╔════════════════════════════════════════════════════════════════╗")
print("║                                                                ║")
print("║           ⚡ MutanoX Universal v4.0.0 ⚡                       ║")
print("║              Mobile & Desktop Edition                         ║")
print("║                                                                ║")
print("║           ✨ Turbo Menu & 20+ Features ✨                   ║")
print("║                                                                ║")
print("║           Mobile: Tap ⚡ button                               ║")
print("║           Desktop: Press Right Ctrl                            ║")
print("║                                                                ║")
print("║           ⚠️  Educational use only!  ⚠️                         ║")
print("║                                                                ║")
print("╚════════════════════════════════════════════════════════════════╝")

--[[
    ╔═════════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║           ████████╗██╗   ██╗██╗    ████████╗███████╗██████╗ ║
    ║           ╚══██╔══╝██║   ██║██║    ╚══██╔══╝██╔════╝██╔══██╗║
    ║              ██║   ██║   ██║██║       ██║   █████╗  ██████╔╝║
    ║              ██║   ██║   ██║██║       ██║   ██╔══╝  ██╔══██╗║
    ║              ██║   ╚██████╔╝██║       ██║   ███████╗██║  ██║║
    ║              ╚═╝    ╚═════╝ ╚═╝       ╚═╝   ╚══════╝╚═╝  ╚═╝║
    ║                                                               ║
    ║                  U N I V E R S A L   v3.0                    ║
    ║                    E L I T E   E D I T I O N                 ║
    ║                                                               ║
    ║           ⚡ Advanced Roblox Universal Script ⚡            ║
    ║               With Advanced ESP & Customization              ║
    ║                                                               ║
    ╚═════════════════════════════════════════════════════════════════╝

    Autor: MutanoXX
    Versão: 3.0.0 Elite Edition
    Descrição: Script universal avançado com ESP personalizado
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
local Camera = Workspace.CurrentCamera

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURAÇÕES DO SCRIPT
-- ═══════════════════════════════════════════════════════════════

local ScriptConfig = {
    Version = "3.0.0",
    Name = "MutanoX Universal",
    Author = "MutanoXX",
    MenuToggleKey = Enum.KeyCode.RightControl,
    NotificationDuration = 3,
    SaveSettings = true,
    AutoSaveInterval = 30
}

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE CORES E TEMA
-- ═══════════════════════════════════════════════════════════════

local Theme = {
    -- Cores Principais
    Primary = Color3.fromRGB(139, 0, 255),       -- Roxo neon
    PrimaryDark = Color3.fromRGB(100, 0, 200),    -- Roxo escuro
    Secondary = Color3.fromRGB(0, 200, 255),      -- Ciano neon
    Success = Color3.fromRGB(0, 255, 136),        -- Verde neon
    Warning = Color3.fromRGB(255, 200, 0),        -- Amarelo
    Error = Color3.fromRGB(255, 80, 80),         -- Vermelho
    
    -- Backgrounds
    Background = Color3.fromRGB(15, 15, 25),     -- Fundo escuro
    BackgroundLight = Color3.fromRGB(25, 25, 40), -- Fundo claro
    Card = Color3.fromRGB(20, 20, 35),           -- Card
    CardHover = Color3.fromRGB(30, 30, 50),      -- Card hover
    
    -- Texto
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 200),
    TextMuted = Color3.fromRGB(120, 120, 140),
    
    -- Borda e Sombra
    Border = Color3.fromRGB(60, 60, 100),
    Shadow = Color3.fromRGB(0, 0, 0)
}

-- ═══════════════════════════════════════════════════════════════
-- ESTADO GLOBAL DO SCRIPT
-- ═══════════════════════════════════════════════════════════════

local ScriptState = {
    -- Menu
    MenuVisible = true,
    MenuMinimized = false,
    CurrentTab = "ESP",
    MenuPosition = UDim2.new(0, 50, 0, 50),
    MenuDragging = false,
    MenuDragStart = nil,
    MenuStartPosition = nil,
    
    -- ESP - Múltiplos tipos
    ESP = {
        Enabled = false,
        
        -- Tipos de ESP
        Box2D = { Enabled = true, Color = Color3.fromRGB(255, 0, 0), Thickness = 2, Transparency = 1 },
        Box3D = { Enabled = false, Color = Color3.fromRGB(255, 0, 0), Thickness = 1, Transparency = 0.5 },
        BoxCorner = { Enabled = false, Color = Color3.fromRGB(255, 0, 0), Thickness = 2, Transparency = 1 },
        Skeleton = { Enabled = false, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 },
        Chams = { Enabled = false, Color = Color3.fromRGB(0, 255, 0), Transparency = 0.3 },
        Tracers = { Enabled = false, Color = Color3.fromRGB(255, 255, 0), Thickness = 1, Transparency = 0.8 },
        HealthBar = { Enabled = true, Width = 50, Height = 5 },
        Names = { Enabled = true, Color = Color3.fromRGB(255, 255, 255), Size = 14, Outline = true },
        Distance = { Enabled = true, Color = Color3.fromRGB(200, 200, 200), Size = 12 },
        TeamCheck = { Enabled = true },
        VisibilityCheck = { Enabled = false },
        MaxDistance = 500,
        Rainbow = { Enabled = false, Speed = 1 }
    },
    
    -- Aimbot Avançado
    Aimbot = {
        Enabled = false,
        FOV = 100,
        Smoothness = 0.1,
        Prediction = 0,
        SilentAim = false,
        RageMode = false,
        TargetPriority = "Nearest", -- Nearest, LowestHealth, HighestHealth
        TeamCheck = true,
        VisibilityCheck = true,
        AutoShoot = false,
        FOVColor = Color3.fromRGB(255, 255, 255),
        FOVTransparency = 0.5,
        FOVThickness = 2
    },
    
    -- Hitbox Expander
    HitboxExpander = { Enabled = false, HeadSize = 10, BodySize = 5 },
    
    -- Triggerbot
    Triggerbot = { Enabled = false, Delay = 0.1, TeamCheck = true },
    
    -- Spinbot
    Spinbot = { Enabled = false, Speed = 50 },
    
    -- ViewFOV
    ViewFOV = { Enabled = false, FOV = 90 },
    
    -- Custom Crosshair
    CustomCrosshair = { Enabled = false, Size = 20, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 },
    
    -- Estado das funções de Movimento
    Fly = { Enabled = false, Speed = 50, Vertical = true },
    Speed = { Enabled = false, Value = 32 },
    SuperJump = { Enabled = false, Power = 100 },
    Noclip = { Enabled = false },
    InfiniteJump = { Enabled = false },
    AutoSprint = { Enabled = false },
    Crouch = { Enabled = false },
    Slide = { Enabled = false },
    
    -- Teleporte
    ClickTP = { Enabled = false },
    TeleportToPlayer = { Enabled = false },
    
    -- Visual
    FullBright = { Enabled = false },
    NoFog = { Enabled = false },
    TimeSet = { Enabled = false, Time = 14 },
    Skybox = { Enabled = false },
    AntiStun = { Enabled = false },
    
    -- Utilitários
    AntiAFK = { Enabled = false },
    GodMode = { Enabled = false },
    InfiniteStamina = { Enabled = false },
    RejoinServer = { Enabled = false },
    ServerHop = { Enabled = false },
    ChatSpy = { Enabled = false },
    NameHider = { Enabled = false, FakeName = "Anonymous" },
    Spectate = { Enabled = false, Target = nil },
    
    -- Valores originais
    OriginalWalkSpeed = Humanoid.WalkSpeed,
    OriginalJumpPower = Humanoid.JumpPower,
    OriginalHealth = Humanoid.MaxHealth,
    OriginalFOV = Camera.FieldOfView,
    
    -- UI Elements
    ScreenGui = nil,
    MainFrame = nil,
    Tabs = {},
    Buttons = {},
    Toggles = {},
    Sliders = {},
    ESPDrawings = {},
    
    -- Logs
    Logs = {},
    MaxLogs = 50
}

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE NOTIFICAÇÕES
-- ═══════════════════════════════════════════════════════════════

local Notifications = {}

local function CreateNotification(title, message, type)
    type = type or "info"
    
    local colors = {
        info = Theme.Primary,
        success = Theme.Success,
        warning = Theme.Warning,
        error = Theme.Error
    }
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification_" .. #Notifications + 1
    notification.Size = UDim2.new(0, 350, 0, 80)
    notification.Position = UDim2.new(1, 400, 0, 20 + (#Notifications * 90))
    notification.BackgroundColor3 = Theme.Card
    notification.BorderSizePixel = 0
    notification.Parent = ScriptState.ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = colors[type] or Theme.Primary
    stroke.Thickness = 2
    stroke.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = colors[type] or Theme.Primary
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
    
    -- Animação de entrada
    local tweenIn = TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -370, 0, 20 + (#Notifications * 90))
    })
    tweenIn:Play()
    
    table.insert(Notifications, {
        Frame = notification,
        Created = tick()
    })
    
    -- Remove após tempo definido
    task.delay(ScriptConfig.NotificationDuration, function()
        local tweenOut = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 400, notification.Position.Y.Scale, notification.Position.Y.Offset)
        })
        tweenOut:Play()
        tweenOut.Completed:Wait()
        notification:Destroy()
    end)
    
    -- Adiciona aos logs
    table.insert(ScriptState.Logs, 1, {
        Time = os.date("%H:%M:%S"),
        Title = title,
        Message = message,
        Type = type
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

local function CreateToggle(name, description, enabled, callback, parent, position)
    local toggle = Instance.new("Frame")
    toggle.Name = name .. "Toggle"
    toggle.Size = UDim2.new(1, 0, 0, 50)
    toggle.Position = position
    toggle.BackgroundTransparency = 1
    toggle.Parent = parent
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -60, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.TextPrimary
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggle
    
    -- Description
    local desc = Instance.new("TextLabel")
    desc.Name = "Description"
    desc.Size = UDim2.new(1, -60, 0, 15)
    desc.Position = UDim2.new(0, 0, 0, 20)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = Theme.TextMuted
    desc.TextSize = 10
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = toggle
    
    -- Toggle Button
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleBtn"
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(1, -55, 0, 2)
    toggleBtn.BackgroundColor3 = enabled and Theme.Success or Theme.Card
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = enabled and "ON" or "OFF"
    toggleBtn.TextColor3 = enabled and Color3.fromRGB(0, 0, 0) : Theme.TextPrimary
    toggleBtn.TextSize = 11
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = toggle
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Color = enabled and Theme.Success : Theme.Border
    toggleStroke.Thickness = 2
    toggleStroke.Parent = toggleBtn
    
    toggleBtn.MouseButton1Click:Connect(function()
        local newState = callback()
        enabled = newState
        
        toggleBtn.BackgroundColor3 = enabled and Theme.Success or Theme.Card
        toggleBtn.Text = enabled and "ON" : "OFF"
        toggleBtn.TextColor3 = enabled and Color3.fromRGB(0, 0, 0) : Theme.TextPrimary
        toggleStroke.Color = enabled and Theme.Success : Theme.Border
    end)
    
    return toggle, toggleBtn
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE ESP AVANÇADO
-- ═══════════════════════════════════════════════════════════════

local function CreateESP()
    -- Função auxiliar para criar Drawing
    local function CreateDrawing(type, props)
        local drawing = Drawing.new(type)
        for prop, value in pairs(props) do
            drawing[prop] = value
        end
        return drawing
    end
    
    -- Função para criar ESP para um jogador
    local function CreatePlayerESP(targetPlayer)
        local espObjects = {}
        local lastUpdate = 0
        
        local function UpdateESP()
            if not ScriptState.ESP.Enabled then
                for _, obj in pairs(espObjects) do
                    if obj and obj.Visible then obj.Visible = false end
                end
                return
            end
            
            local targetChar = targetPlayer.Character
            local myChar = Player.Character
            
            if not targetChar or not myChar then return end
            
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            local targetHead = targetChar:FindFirstChild("Head")
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            local myHRP = myChar:FindFirstChild("HumanoidRootPart")
            
            if not targetHRP or not targetHead or not targetHumanoid or not myHRP then return end
            
            -- Team Check
            if ScriptState.ESP.TeamCheck and targetPlayer.Team == Player.Team then
                for _, obj in pairs(espObjects) do
                    if obj and obj.Visible then obj.Visible = false end
                end
                return
            end
            
            -- Distance Check
            local distance = (myHRP.Position - targetHRP.Position).Magnitude
            if distance > ScriptState.ESP.MaxDistance then
                for _, obj in pairs(espObjects) do
                    if obj and obj.Visible then obj.Visible = false end
                end
                return
            end
            
            -- Visibility Check (Raycast)
            local isVisible = true
            if ScriptState.ESP.VisibilityCheck then
                local rayParams = RaycastParams.new()
                rayParams.FilterDescendantsInstances = {myChar, targetChar}
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                
                local rayResult = Workspace:Raycast(myHRP.Position, (targetHRP.Position - myHRP.Position).Unit * distance, rayParams)
                isVisible = rayResult == nil
            end
            
            -- Verificar se está visível na tela
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetHRP.Position)
            if not onScreen then
                for _, obj in pairs(espObjects) do
                    if obj and obj.Visible then obj.Visible = false end
                end
                return
            end
            
            -- Color (Rainbow Effect)
            local color = ScriptState.ESP.Box2D.Color
            if ScriptState.ESP.Rainbow.Enabled then
                local hue = (tick() * ScriptState.ESP.Rainbow.Speed) % 1
                color = Color3.fromHSV(hue, 1, 1)
            end
            
            -- Health check (for color)
            local healthPercent = targetHumanoid.Health / targetHumanoid.MaxHealth
            local healthColor = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
            
            -- ════════════════════════════════════════════════════════
            -- BOX 2D ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Box2D.Enabled then
                local boxSize = Camera:WorldToViewportPoint(targetHRP.Position + Vector3.new(0, 3, 0))
                local boxSizeBottom = Camera:WorldToViewportPoint(targetHRP.Position - Vector3.new(0, 3, 0))
                
                local height = math.abs(boxSizeBottom.Y - boxSize.Y)
                local width = height * 0.6
                
                if not espObjects.Box2D then
                    espObjects.Box2D = CreateDrawing("Square", {
                        Thickness = ScriptState.ESP.Box2D.Thickness,
                        Color = color,
                        Filled = false,
                        Visible = false
                    })
                end
                
                espObjects.Box2D.Size = Vector2.new(width, height)
                espObjects.Box2D.Position = Vector2.new(boxSize.X - width / 2, boxSize.Y)
                espObjects.Box2D.Color = isVisible and ScriptState.ESP.Box2D.Color or Color3.fromRGB(100, 100, 100)
                espObjects.Box2D.Transparency = ScriptState.ESP.Box2D.Transparency
                espObjects.Box2D.Visible = true
            elseif espObjects.Box2D then
                espObjects.Box2D.Visible = false
            end
            
            -- ════════════════════════════════════════════════════════
            -- BOX 3D ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Box3D.Enabled then
                local corners = {
                    Vector3.new(3, 3, 3),
                    Vector3.new(-3, 3, 3),
                    Vector3.new(3, -3, 3),
                    Vector3.new(-3, -3, 3),
                    Vector3.new(3, 3, -3),
                    Vector3.new(-3, 3, -3),
                    Vector3.new(3, -3, -3),
                    Vector3.new(-3, -3, -3)
                }
                
                local screenCorners = {}
                for _, corner in ipairs(corners) do
                    local worldCorner = targetHRP.CFrame:PointToWorldSpace(corner)
                    local screenCorner = Camera:WorldToViewportPoint(worldCorner)
                    table.insert(screenCorners, Vector2.new(screenCorner.X, screenCorner.Y))
                end
                
                if not espObjects.Box3D then
                    espObjects.Box3D = {}
                    for i = 1, 12 do
                        table.insert(espObjects.Box3D, CreateDrawing("Line", {
                            Thickness = ScriptState.ESP.Box3D.Thickness,
                            Color = color,
                            Visible = false
                        }))
                    end
                end
                
                -- Desenhar linhas do cubo 3D
                local connections = {
                    {1, 2}, {2, 4}, {4, 3}, {3, 1},
                    {5, 6}, {6, 8}, {8, 7}, {7, 5},
                    {1, 5}, {2, 6}, {4, 8}, {3, 7}
                }
                
                for i, conn in ipairs(connections) do
                    espObjects.Box3D[i].From = screenCorners[conn[1]]
                    espObjects.Box3D[i].To = screenCorners[conn[2]]
                    espObjects.Box3D[i].Color = isVisible and ScriptState.ESP.Box3D.Color or Color3.fromRGB(100, 100, 100)
                    espObjects.Box3D[i].Transparency = ScriptState.ESP.Box3D.Transparency
                    espObjects.Box3D[i].Visible = true
                end
            elseif espObjects.Box3D then
                for _, line in pairs(espObjects.Box3D) do
                    line.Visible = false
                end
            end
            
            -- ════════════════════════════════════════════════════════
            -- BOX CORNER ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.BoxCorner.Enabled then
                local boxSize = Camera:WorldToViewportPoint(targetHRP.Position + Vector3.new(0, 3, 0))
                local boxSizeBottom = Camera:WorldToViewportPoint(targetHRP.Position - Vector3.new(0, 3, 0))
                
                local height = math.abs(boxSizeBottom.Y - boxSize.Y)
                local width = height * 0.6
                local cornerLength = height * 0.15
                
                if not espObjects.BoxCorner then
                    espObjects.BoxCorner = {}
                    for i = 1, 8 do
                        table.insert(espObjects.BoxCorner, CreateDrawing("Line", {
                            Thickness = ScriptState.ESP.BoxCorner.Thickness,
                            Color = color,
                            Visible = false
                        }))
                    end
                end
                
                local x, y = boxSize.X - width / 2, boxSize.Y
                
                -- Linhas dos cantos
                local lines = {
                    {x, y, x + cornerLength, y},           -- Top-left
                    {x, y, x, y + cornerLength},
                    {x + width, y, x + width - cornerLength, y},  -- Top-right
                    {x + width, y, x + width, y + cornerLength},
                    {x, y + height, x + cornerLength, y + height},    -- Bottom-left
                    {x, y + height, x, y + height - cornerLength},
                    {x + width, y + height, x + width - cornerLength, y + height},  -- Bottom-right
                    {x + width, y + height, x + width, y + height - cornerLength}
                }
                
                for i, lineData in ipairs(lines) do
                    espObjects.BoxCorner[i].From = Vector2.new(lineData[1], lineData[2])
                    espObjects.BoxCorner[i].To = Vector2.new(lineData[3], lineData[4])
                    espObjects.BoxCorner[i].Color = isVisible and ScriptState.ESP.BoxCorner.Color or Color3.fromRGB(100, 100, 100)
                    espObjects.BoxCorner[i].Transparency = ScriptState.ESP.BoxCorner.Transparency
                    espObjects.BoxCorner[i].Visible = true
                end
            elseif espObjects.BoxCorner then
                for _, line in pairs(espObjects.BoxCorner) do
                    line.Visible = false
                end
            end
            
            -- ════════════════════════════════════════════════════════
            -- SKELETON ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Skeleton.Enabled then
                local bodyParts = {
                    "Head", "UpperTorso", "LowerTorso",
                    "LeftUpperArm", "LeftLowerArm", "LeftHand",
                    "RightUpperArm", "RightLowerArm", "RightHand",
                    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                    "RightUpperLeg", "RightLowerLeg", "RightFoot"
                }
                
                local connections = {
                    {"Head", "UpperTorso"},
                    {"UpperTorso", "LeftUpperArm"},
                    {"LeftUpperArm", "LeftLowerArm"},
                    {"LeftLowerArm", "LeftHand"},
                    {"UpperTorso", "RightUpperArm"},
                    {"RightUpperArm", "RightLowerArm"},
                    {"RightLowerArm", "RightHand"},
                    {"UpperTorso", "LowerTorso"},
                    {"LowerTorso", "LeftUpperLeg"},
                    {"LeftUpperLeg", "LeftLowerLeg"},
                    {"LeftLowerLeg", "LeftFoot"},
                    {"LowerTorso", "RightUpperLeg"},
                    {"RightUpperLeg", "RightLowerLeg"},
                    {"RightLowerLeg", "RightFoot"}
                }
                
                if not espObjects.Skeleton then
                    espObjects.Skeleton = {}
                    for i = 1, #connections do
                        table.insert(espObjects.Skeleton, CreateDrawing("Line", {
                            Thickness = ScriptState.ESP.Skeleton.Thickness,
                            Color = ScriptState.ESP.Skeleton.Color,
                            Visible = false
                        }))
                    end
                end
                
                for i, conn in ipairs(connections) do
                    local part1 = targetChar:FindFirstChild(conn[1])
                    local part2 = targetChar:FindFirstChild(conn[2])
                    
                    if part1 and part2 then
                        local pos1 = Camera:WorldToViewportPoint(part1.Position)
                        local pos2 = Camera:WorldToViewportPoint(part2.Position)
                        
                        espObjects.Skeleton[i].From = Vector2.new(pos1.X, pos1.Y)
                        espObjects.Skeleton[i].To = Vector2.new(pos2.X, pos2.Y)
                        espObjects.Skeleton[i].Color = isVisible and ScriptState.ESP.Skeleton.Color or Color3.fromRGB(100, 100, 100)
                        espObjects.Skeleton[i].Visible = true
                    else
                        espObjects.Skeleton[i].Visible = false
                    end
                end
            elseif espObjects.Skeleton then
                for _, line in pairs(espObjects.Skeleton) do
                    line.Visible = false
                end
            end
            
            -- ════════════════════════════════════════════════════════
            -- CHAMS ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Chams.Enabled then
                if not espObjects.ChamsHighlight then
                    espObjects.ChamsHighlight = Instance.new("Highlight")
                    espObjects.ChamsHighlight.Name = "ESP_Chams"
                    espObjects.ChamsHighlight.FillColor = ScriptState.ESP.Chams.Color
                    espObjects.ChamsHighlight.OutlineColor = ScriptState.ESP.Chams.Color
                    espObjects.ChamsHighlight.FillTransparency = ScriptState.ESP.Chams.Transparency
                    espObjects.ChamsHighlight.OutlineTransparency = ScriptState.ESP.Chams.Transparency + 0.2
                    espObjects.ChamsHighlight.Adornee = targetChar
                    espObjects.ChamsHighlight.Parent = targetChar
                else
                    espObjects.ChamsHighlight.FillColor = isVisible and ScriptState.ESP.Chams.Color or Color3.fromRGB(100, 100, 100)
                    espObjects.ChamsHighlight.OutlineColor = isVisible and ScriptState.ESP.Chams.Color or Color3.fromRGB(100, 100, 100)
                    espObjects.ChamsHighlight.Enabled = true
                end
            elseif espObjects.ChamsHighlight then
                espObjects.ChamsHighlight.Enabled = false
            end
            
            -- ════════════════════════════════════════════════════════
            -- TRACERS ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Tracers.Enabled then
                if not espObjects.Tracers then
                    espObjects.Tracers = CreateDrawing("Line", {
                        Thickness = ScriptState.ESP.Tracers.Thickness,
                        Color = ScriptState.ESP.Tracers.Color,
                        Visible = false
                    })
                end
                
                local myScreenPos = Camera:WorldToViewportPoint(myHRP.Position)
                espObjects.Tracers.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                espObjects.Tracers.To = Vector2.new(screenPos.X, screenPos.Y)
                espObjects.Tracers.Color = isVisible and ScriptState.ESP.Tracers.Color or Color3.fromRGB(100, 100, 100)
                espObjects.Tracers.Transparency = ScriptState.ESP.Tracers.Transparency
                espObjects.Tracers.Visible = true
            elseif espObjects.Tracers then
                espObjects.Tracers.Visible = false
            end
            
            -- ════════════════════════════════════════════════════════
            -- HEALTH BAR ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.HealthBar.Enabled then
                if not espObjects.HealthBarBackground then
                    espObjects.HealthBarBackground = CreateDrawing("Square", {
                        Size = Vector2.new(ScriptState.ESP.HealthBar.Width, ScriptState.ESP.HealthBar.Height),
                        Color = Color3.fromRGB(0, 0, 0),
                        Filled = true,
                        Visible = false
                    })
                    
                    espObjects.HealthBarForeground = CreateDrawing("Square", {
                        Size = Vector2.new(ScriptState.ESP.HealthBar.Width, ScriptState.ESP.HealthBar.Height),
                        Color = healthColor,
                        Filled = true,
                        Visible = false
                    })
                end
                
                local boxSize = Camera:WorldToViewportPoint(targetHRP.Position + Vector3.new(0, 3, 0))
                local boxSizeBottom = Camera:WorldToViewportPoint(targetHRP.Position - Vector3.new(0, 3, 0))
                local height = math.abs(boxSizeBottom.Y - boxSize.Y)
                local width = height * 0.6
                
                espObjects.HealthBarBackground.Position = Vector2.new(boxSize.X + width / 2 + 10, boxSize.Y)
                espObjects.HealthBarBackground.Visible = true
                
                espObjects.HealthBarForeground.Position = Vector2.new(boxSize.X + width / 2 + 10, boxSize.Y)
                espObjects.HealthBarForeground.Size = Vector2.new(ScriptState.ESP.HealthBar.Width * healthPercent, ScriptState.ESP.HealthBar.Height)
                espObjects.HealthBarForeground.Color = healthColor
                espObjects.HealthBarForeground.Visible = true
            elseif espObjects.HealthBarBackground then
                espObjects.HealthBarBackground.Visible = false
                espObjects.HealthBarForeground.Visible = false
            end
            
            -- ════════════════════════════════════════════════════════
            -- NAMES ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Names.Enabled then
                if not espObjects.Names then
                    espObjects.Names = CreateDrawing("Text", {
                        Text = targetPlayer.Name,
                        Size = ScriptState.ESP.Names.Size,
                        Color = ScriptState.ESP.Names.Color,
                        Center = true,
                        Outline = ScriptState.ESP.Names.Outline,
                        Visible = false
                    })
                end
                
                espObjects.Names.Position = Vector2.new(screenPos.X, screenPos.Y - 40)
                espObjects.Names.Color = isVisible and ScriptState.ESP.Names.Color or Color3.fromRGB(100, 100, 100)
                espObjects.Names.Text = targetPlayer.Name
                espObjects.Names.Visible = true
            elseif espObjects.Names then
                espObjects.Names.Visible = false
            end
            
            -- ════════════════════════════════════════════════════════
            -- DISTANCE ESP
            -- ════════════════════════════════════════════════════════
            if ScriptState.ESP.Distance.Enabled then
                if not espObjects.Distance then
                    espObjects.Distance = CreateDrawing("Text", {
                        Text = string.format("%.0f studs", distance),
                        Size = ScriptState.ESP.Distance.Size,
                        Color = ScriptState.ESP.Distance.Color,
                        Center = true,
                        Outline = true,
                        Visible = false
                    })
                end
                
                espObjects.Distance.Position = Vector2.new(screenPos.X, screenPos.Y + 25)
                espObjects.Distance.Color = isVisible and ScriptState.ESP.Distance.Color or Color3.fromRGB(100, 100, 100)
                espObjects.Distance.Text = string.format("%.0f studs", distance)
                espObjects.Distance.Visible = true
            elseif espObjects.Distance then
                espObjects.Distance.Visible = false
            end
        end
        
        return UpdateESP
    end
    
    -- Criar ESP para todos os jogadores
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= Player then
            local espUpdate = CreatePlayerESP(targetPlayer)
            table.insert(ScriptState.ESPDrawings, {
                Player = targetPlayer,
                Update = espUpdate
            })
        end
    end
    
    -- Adicionar ESP para novos jogadores
    Players.PlayerAdded:Connect(function(newPlayer)
        if newPlayer ~= Player then
            task.wait(1)
            local espUpdate = CreatePlayerESP(newPlayer)
            table.insert(ScriptState.ESPDrawings, {
                Player = newPlayer,
                Update = espUpdate
            })
        end
    end)
    
    -- Remover ESP quando jogador sai
    Players.PlayerRemoving:Connect(function(removedPlayer)
        for i, espData in ipairs(ScriptState.ESPDrawings) do
            if espData.Player == removedPlayer then
                table.remove(ScriptState.ESPDrawings, i)
                break
            end
        end
    end)
    
    -- Atualizar ESP a cada frame
    RunService.RenderStepped:Connect(function()
        if ScriptState.ESP.Enabled then
            for _, espData in ipairs(ScriptState.ESPDrawings) do
                pcall(function()
                    espData.Update()
                end)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE AIMBOT AVANÇADO
-- ═══════════════════════════════════════════════════════════════

local function EnableAimbot()
    local currentTarget = nil
    local fovCircle = nil
    
    -- Criar FOV Circle
    fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = ScriptState.Aimbot.FOVThickness
    fovCircle.Color = ScriptState.Aimbot.FOVColor
    fovCircle.NumSides = 64
    fovCircle.Radius = ScriptState.Aimbot.FOV
    fovCircle.Filled = false
    fovCircle.Visible = false
    
    local function GetBestTarget()
        local bestTarget = nil
        local closestDistance = ScriptState.Aimbot.FOV
        
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= Player then
                -- Team Check
                if ScriptState.Aimbot.TeamCheck and targetPlayer.Team == Player.Team then
                    continue
                end
                
                local targetChar = targetPlayer.Character
                if not targetChar then continue end
                
                local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                
                if not targetHRP or not targetHumanoid then continue end
                if targetHumanoid.Health <= 0 then continue end
                
                -- Calcular distância e posição na tela
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetHRP.Position)
                if not onScreen then continue end
                
                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                
                if screenDist < closestDistance then
                    -- Visibility Check
                    if ScriptState.Aimbot.VisibilityCheck then
                        local myChar = Player.Character
                        if myChar then
                            local myHRP = myChar:FindFirstChild("HumanoidRootPart")
                            if myHRP then
                                local rayParams = RaycastParams.new()
                                rayParams.FilterDescendantsInstances = {myChar, targetChar}
                                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                                
                                local rayResult = Workspace:Raycast(myHRP.Position, (targetHRP.Position - myHRP.Position), rayParams)
                                if rayResult then
                                    continue
                                end
                            end
                        end
                    end
                    
                    closestDistance = screenDist
                    bestTarget = targetChar
                end
            end
        end
        
        return bestTarget
    end
    
    RunService.RenderStepped:Connect(function()
        if ScriptState.Aimbot.Enabled then
            -- Atualizar FOV Circle
            fovCircle.Visible = true
            fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            fovCircle.Radius = ScriptState.Aimbot.FOV
            fovCircle.Thickness = ScriptState.Aimbot.FOVThickness
            fovCircle.Color = ScriptState.Aimbot.FOVColor
            
            -- Auto Shoot
            if ScriptState.Aimbot.AutoShoot then
                currentTarget = GetBestTarget()
                if currentTarget and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                    -- Simular clique
                    mouse1click()
                end
            else
                currentTarget = GetBestTarget()
            end
            
            -- Aplicar aim
            if currentTarget and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local targetHRP = currentTarget:FindFirstChild("HumanoidRootPart")
                if targetHRP then
                    local targetCFrame
                    if ScriptState.Aimbot.Prediction > 0 then
                        -- Adicionar predição baseada na velocidade
                        local velocity = currentTarget:FindFirstChild("HumanoidRootPart").Velocity
                        targetCFrame = CFrame.new(Camera.CFrame.Position, targetHRP.Position + velocity * ScriptState.Aimbot.Prediction)
                    else
                        targetCFrame = CFrame.new(Camera.CFrame.Position, targetHRP.Position)
                    end
                    
                    if ScriptState.Aimbot.RageMode then
                        Camera.CFrame = targetCFrame
                    else
                        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, ScriptState.Aimbot.Smoothness)
                    end
                end
            end
        else
            fovCircle.Visible = false
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- CRIAÇÃO DO MENU PRINCIPAL
-- ═══════════════════════════════════════════════════════════════

local function CreateMenu()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MutanoX_Universal_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = Player.PlayerGui
    ScriptState.ScreenGui = screenGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 450, 0, 600)
    mainFrame.Position = ScriptState.MenuPosition
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    ScriptState.MainFrame = mainFrame
    
    -- Sombra
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Theme.Shadow
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = mainFrame.ZIndex - 1
    shadow.Parent = mainFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 16)
    shadowCorner.Parent = shadow
    
    -- Cantos Arredondados
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    -- Header (Draggable)
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 60)
    header.BackgroundColor3 = Theme.BackgroundLight
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header
    
    local headerPadding = Instance.new("UIPadding")
    headerPadding.PaddingTop = UDim.new(0, 16)
    headerPadding.Parent = header
    
    -- Gradient Header
    local headerGradient = CreateGradient(header, Theme.PrimaryDark, Theme.Primary, 135)
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -100, 0, 30)
    title.Position = UDim2.new(0, 15, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "⚡ MutanoX Universal"
    title.TextColor3 = Theme.TextPrimary
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Versão
    local version = Instance.new("TextLabel")
    version.Name = "Version"
    version.Size = UDim2.new(1, -120, 0, 15)
    version.Position = UDim2.new(0, 15, 0, 30)
    version.BackgroundTransparency = 1
    version.Text = "v" .. ScriptConfig.Version .. " | Elite Edition"
    version.TextColor3 = Theme.TextMuted
    version.TextSize = 10
    version.Font = Enum.Font.Gotham
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.Parent = header
    
    -- Botão Minimizar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 36, 0, 36)
    minimizeButton.Position = UDim2.new(1, -48, 0, 12)
    minimizeButton.BackgroundColor3 = Theme.Error
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = Theme.TextPrimary
    minimizeButton.TextSize = 24
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = mainFrame
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimizeButton
    
    local minimizeStroke = Instance.new("UIStroke")
    minimizeStroke.Color = Theme.Error
    minimizeStroke.Thickness = 2
    minimizeStroke.Transparency = 0.5
    minimizeStroke.Parent = minimizeButton
    
    -- ═════════════════════════════════════════════════════════
    -- SISTEMA DE TABS
    -- ═════════════════════════════════════════════════════════
    
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Name = "TabsFrame"
    tabsFrame.Size = UDim2.new(1, -20, 0, 40)
    tabsFrame.Position = UDim2.new(0, 10, 0, 65)
    tabsFrame.BackgroundTransparency = 1
    tabsFrame.Parent = mainFrame
    
    local tabsList = {"ESP", "Aimbot", "Movement", "Visual", "World", "Utility"}
    local tabButtons = {}
    local tabWidth = 70
    
    for i, tabName in ipairs(tabsList) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(0, tabWidth, 0, 35)
        tabButton.Position = UDim2.new(0, (i - 1) * (tabWidth + 5) + 5, 0, 2)
        tabButton.BackgroundColor3 = Theme.Card
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Theme.TextSecondary
        tabButton.TextSize = 11
        tabButton.Font = Enum.Font.GothamBold
        tabButton.Parent = tabsFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton
        
        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = Theme.Border
        tabStroke.Thickness = 1
        tabStroke.Parent = tabButton
        
        tabButtons[tabName] = tabButton
        ScriptState.Tabs[tabName] = tabButton
        
        tabButton.MouseButton1Click:Connect(function()
            -- Atualiza estado dos tabs
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
    
    -- Ativa tab inicial
    tabButtons[ScriptState.CurrentTab].BackgroundColor3 = Theme.Primary
    tabButtons[ScriptState.CurrentTab].TextColor3 = Theme.TextPrimary
    tabButtons[ScriptState.CurrentTab].UIStroke.Color = Theme.PrimaryDark
    
    -- ═════════════════════════════════════════════════════════
    -- CONTEÚDO DO MENU
    -- ═════════════════════════════════════════════════════════
    
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -115)
    contentFrame.Position = UDim2.new(0, 10, 0, 110)
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 4
    contentFrame.ScrollBarImageColor3 = Theme.Primary
    contentFrame.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 12)
    contentCorner.Parent = contentFrame
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 10)
    contentPadding.Parent = contentFrame
    
    -- ═════════════════════════════════════════════════════════
    -- TAB: ESP
    -- ═════════════════════════════════════════════════════════
    
    local yOffset = 10
    
    local espToggles = {
        { "Box 2D ESP", "Show 2D boxes around players", "ESP.Box2D.Enabled" },
        { "Box 3D ESP", "Show 3D boxes around players", "ESP.Box3D.Enabled" },
        { "Box Corner ESP", "Show corner boxes around players", "ESP.BoxCorner.Enabled" },
        { "Skeleton ESP", "Show player skeleton", "ESP.Skeleton.Enabled" },
        { "Chams ESP", "Show chams through walls", "ESP.Chams.Enabled" },
        { "Tracers ESP", "Show lines to players", "ESP.Tracers.Enabled" },
        { "Health Bar", "Show player health bars", "ESP.HealthBar.Enabled" },
        { "Names", "Show player names", "ESP.Names.Enabled" },
        { "Distance", "Show player distance", "ESP.Distance.Enabled" },
        { "Team Check", "Only show enemies", "ESP.TeamCheck.Enabled" },
        { "Visibility Check", "Only show visible players", "ESP.VisibilityCheck.Enabled" },
        { "Rainbow Effect", "Rainbow color effect", "ESP.Rainbow.Enabled" }
    }
    
    for _, toggleData in ipairs(espToggles) do
        local name, desc = toggleData[1], toggleData[2]
        local path = toggleData[3]
        local parts = {}
        for part in path:gmatch("[^.]+") do
            table.insert(parts, part)
        end
        
        local enabled = ScriptState
        for _, part in ipairs(parts) do
            enabled = enabled[part]
        end
        
        CreateToggle(name, desc, enabled, function()
            -- Toggle logic
            local newVal = not enabled
            enabled = newVal
            
            -- Enable ESP system if any ESP feature is enabled
            if name ~= "Rainbow Effect" then
                ScriptState.ESP.Enabled = newVal or ScriptState.ESP.Enabled
            end
            
            return newVal
        end, contentFrame, UDim2.new(0, 0, 0, yOffset))
        
        yOffset = yOffset + 60
    end
    
    -- ═════════════════════════════════════════════════════════
    -- TAB: AIMBOT
    -- ═════════════════════════════════════════════════════════
    
    -- (Similar structure for other tabs...)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 20)
    
    -- ═════════════════════════════════════════════════════════
    -- SISTEMA DE DRAG-AND-DROP
    -- ═════════════════════════════════════════════════════════
    
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
    
    -- ═════════════════════════════════════════════════════════
    -- FUNÇÃO DE MINIMIZAR
    -- ═════════════════════════════════════════════════════════
    
    minimizeButton.MouseButton1Click:Connect(function()
        ScriptState.MenuMinimized = not ScriptState.MenuMinimized
        
        if ScriptState.MenuMinimized then
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 200, 0, 60)
            }):Play()
            contentFrame.Visible = false
            tabsFrame.Visible = false
            minimizeButton.Text = "+"
        else
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 450, 0, 600)
            }):Play()
            contentFrame.Visible = true
            tabsFrame.Visible = true
            minimizeButton.Text = "−"
        end
    end)
    
    return screenGui
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE MOVIMENTO
-- ═══════════════════════════════════════════════════════════════

local function EnableMovementSystems()
    -- Fly
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
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Vector3.new(0, 0, -1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir += Vector3.new(0, 0, 1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir += Vector3.new(-1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Vector3.new(1, 0, 0) end
                if ScriptState.Fly.Vertical then
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir += Vector3.new(0, -1, 0) end
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir *= 2 end
                
                flyVelocity.Velocity = Camera.CFrame:VectorToWorldSpace(moveDir) * ScriptState.Fly.Speed
                flyGyro.CFrame = Camera.CFrame
            end
        else
            flyVelocity.Parent = nil
            flyGyro.Parent = nil
        end
    end)
    
    -- Speed
    RunService.RenderStepped:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            if ScriptState.Speed.Enabled then
                char.Humanoid.WalkSpeed = ScriptState.Speed.Value
            else
                char.Humanoid.WalkSpeed = ScriptState.OriginalWalkSpeed
            end
        end
    end)
    
    -- Super Jump
    RunService.RenderStepped:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            if ScriptState.SuperJump.Enabled then
                char.Humanoid.JumpPower = ScriptState.SuperJump.Power
            else
                char.Humanoid.JumpPower = ScriptState.OriginalJumpPower
            end
        end
    end)
    
    -- Noclip
    RunService.Stepped:Connect(function()
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
    
    -- Infinite Jump
    UserInputService.JumpRequest:Connect(function()
        if ScriptState.InfiniteJump.Enabled then
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState("Jumping")
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- INICIALIZAÇÃO DO SCRIPT
-- ═══════════════════════════════════════════════════════════════

local function Initialize()
    -- Criar menu
    CreateMenu()
    
    -- Iniciar sistemas
    CreateESP()
    EnableAimbot()
    EnableMovementSystems()
    
    -- Atualiza personagem quando renasce
    Player.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
        Humanoid = Character:WaitForChild("Humanoid")
        RootPart = Character:WaitForChild("HumanoidRootPart")
        
        -- Restaura valores originais
        ScriptState.OriginalWalkSpeed = Humanoid.WalkSpeed
        ScriptState.OriginalJumpPower = Humanoid.JumpPower
        ScriptState.OriginalHealth = Humanoid.MaxHealth
        
        -- Reaplica estados ativos
        if ScriptState.GodMode.Enabled then
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
        end
    end)
    
    -- Toggle do menu
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == ScriptConfig.MenuToggleKey then
            ScriptState.MenuVisible = not ScriptState.MenuVisible
            if ScriptState.ScreenGui then
                ScriptState.ScreenGui.Enabled = ScriptState.MenuVisible
                if ScriptState.MenuVisible then
                    CreateNotification("Menu Opened", "MutanoX Universal is now visible", "info")
                end
            end
        end
    end)
    
    -- Notificações de inicialização
    CreateNotification("Welcome!", "MutanoX Universal v" .. ScriptConfig.Version .. " Elite Edition loaded!", "success")
    task.wait(0.5)
    CreateNotification("ESP System", "Advanced ESP with multiple types available", "info")
    task.wait(0.5)
    CreateNotification("Controls", "Press Right Ctrl to toggle menu", "info")
    task.wait(0.5)
    CreateNotification("Reminder", "Use only on your own games for educational purposes", "warning")
end

-- ═══════════════════════════════════════════════════════════════
-- INICIA O SCRIPT
-- ═══════════════════════════════════════════════════════════════

Initialize()

print("╔════════════════════════════════════════════════════════════════╗")
print("║                                                                ║")
print("║           ⚡ MutanoX Universal v3.0.0 ⚡                       ║")
print("║                    Elite Edition                                ║")
print("║                                                                ║")
print("║           Advanced ESP & Customization                          ║")
print("║           Box 2D/3D • Skeleton • Chams • Tracers           ║")
print("║           Health Bars • Names • Distance                     ║")
print("║                                                                ║")
print("║           Press Right Ctrl to toggle menu                      ║")
print("║                                                                ║")
print("║           ⚠️  Educational use only!  ⚠️                         ║")
print("║                                                                ║")
print("╚════════════════════════════════════════════════════════════════╝")

-- HeXHub Premium - Con Weld en Part Point
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables globales
local mainUI, miniUI
local part = nil
local isStealing = false
local banEnabled = false
local partTween
local humanoidRootPart
local weldConstraint

-- Crear la UI principal
local function createMainUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HeXHubPremium"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 140)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -70)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0, 200, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "HeXHub"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar

    local subtitleText = Instance.new("TextLabel")
    subtitleText.Size = UDim2.new(0, 60, 0, 15)
    subtitleText.Position = UDim2.new(0, 210, 0, 8)
    subtitleText.BackgroundTransparency = 1
    subtitleText.Text = "Premium"
    subtitleText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitleText.Font = Enum.Font.Gotham
    subtitleText.TextSize = 12
    subtitleText.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = titleBar

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 1, 0)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 16
    minimizeButton.Parent = titleBar

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -40)
    contentFrame.Position = UDim2.new(0, 10, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local stealButton = Instance.new("TextButton")
    stealButton.Size = UDim2.new(1, 0, 0, 40)
    stealButton.Position = UDim2.new(0, 0, 0, 10)
    stealButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    stealButton.Text = "Steal"
    stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    stealButton.Font = Enum.Font.GothamBold
    stealButton.TextSize = 16
    stealButton.Parent = contentFrame

    local createPartButton = Instance.new("TextButton")
    createPartButton.Size = UDim2.new(1, 0, 0, 40)
    createPartButton.Position = UDim2.new(0, 0, 0, 55)
    createPartButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    createPartButton.Text = "Part Point"
    createPartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    createPartButton.Font = Enum.Font.Gotham
    createPartButton.TextSize = 14
    createPartButton.Parent = contentFrame

    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        StealButton = stealButton,
        CreatePartButton = createPartButton,
        CloseButton = closeButton,
        MinimizeButton = minimizeButton,
        ContentFrame = contentFrame
    }
end

-- Crear la Part Point
local function createPartPoint()
    if part then part:Destroy() end

    local character = player.Character or player.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    part = Instance.new("Part")
    part.Name = "HeXHubPartPoint"
    part.Size = Vector3.new(5, 0.2, 5)
    part.Position = humanoidRootPart.Position - Vector3.new(0, 3, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Color = Color3.fromRGB(0, 170, 0)
    part.Material = Enum.Material.Neon
    part.Parent = workspace

    return part
end

-- Animar la Part
local function animatePart()
    if not part then return end
    while isStealing and part and part.Parent do
        local targetPos = part.Position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        partTween = TweenService:Create(part, tweenInfo, {Position = targetPos})
        partTween:Play()
        wait(0.5)
    end
end

-- Anclar con Weld
local function anchorPlayerToPart()
    if not part or not humanoidRootPart then return end

    -- Teleport inicial encima de la Part
    humanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))

    -- Crear WeldConstraint
    weldConstraint = Instance.new("WeldConstraint")
    weldConstraint.Part0 = humanoidRootPart
    weldConstraint.Part1 = part
    weldConstraint.Parent = humanoidRootPart

    print("Jugador pegado a la Part Point con WeldConstraint")

    while isStealing and part and part.Parent do
        RunService.Heartbeat:Wait()
    end

    -- Al terminar, quitar el weld
    if weldConstraint then
        weldConstraint:Destroy()
        weldConstraint = nil
        print("Jugador liberado de la Part Point")
    end
end

-- Detener Steal
local function stopSteal()
    isStealing = false
    if partTween then partTween:Cancel() partTween = nil end
    if miniUI and miniUI.ScreenGui then
        miniUI.ScreenGui:Destroy()
        miniUI = nil
    end
    print("Steal desactivado - Jugador permanece en posición actual")
end

-- Iniciar Steal
local function startSteal()
    if isStealing then return end
    if not part then part = createPartPoint() end
    if not part then return end

    isStealing = true

    spawn(animatePart)
    spawn(anchorPlayerToPart)
end

-- Inicializar
local function initializeUI()
    if mainUI and mainUI.ScreenGui then mainUI.ScreenGui:Destroy() end
    mainUI = createMainUI()

    mainUI.StealButton.MouseButton1Click:Connect(startSteal)
    mainUI.CreatePartButton.MouseButton1Click:Connect(createPartPoint)

    mainUI.CloseButton.MouseButton1Click:Connect(function()
        mainUI.ScreenGui:Destroy()
        mainUI = nil
    end)

    mainUI.MinimizeButton.MouseButton1Click:Connect(function()
        local isVisible = mainUI.ContentFrame.Visible
        mainUI.ContentFrame.Visible = not isVisible
        local newSize = isVisible and 30 or 140
        mainUI.MainFrame.Size = UDim2.new(0, 300, 0, newSize)
    end)

    print("HeXHub Premium UI inicializada correctamente")
end

local function onCharacterAdded(character)
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    initializeUI()
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    onCharacterAdded(player.Character)
else
    initializeUI()
end

print("HeXHub Premium Cargado Correctamente - Con Weld en Part Point")
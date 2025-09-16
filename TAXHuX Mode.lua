-- HeXHub Premium - Script Completo con Part Point
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables globales
local mainUI, miniUI
local part = nil
local isStealing = false
local banEnabled = true
local partTween, playerTween
local humanoidRootPart

-- Función para crear la UI principal
local function createMainUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HeXHubPremium"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    -- Marco principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 180)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    -- Barra de título
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    -- Título
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

    -- Subtítulo Premium
    local subtitleText = Instance.new("TextLabel")
    subtitleText.Size = UDim2.new(0, 60, 0, 15)
    subtitleText.Position = UDim2.new(0, 210, 0, 8)
    subtitleText.BackgroundTransparency = 1
    subtitleText.Text = "Premium"
    subtitleText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitleText.Font = Enum.Font.Gotham
    subtitleText.TextSize = 12
    subtitleText.Parent = titleBar

    -- Botón de cerrar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = titleBar

    -- Botón de minimizar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 1, 0)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 16
    minimizeButton.Parent = titleBar

    -- Marco de contenido
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -40)
    contentFrame.Position = UDim2.new(0, 10, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Botón Steal
    local stealButton = Instance.new("TextButton")
    stealButton.Size = UDim2.new(1, 0, 0, 40)
    stealButton.Position = UDim2.new(0, 0, 0, 10)
    stealButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    stealButton.Text = "Steal"
    stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    stealButton.Font = Enum.Font.GothamBold
    stealButton.TextSize = 16
    stealButton.Parent = contentFrame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = stealButton

    -- Botón adicional: Crear Part Point
    local createPartButton = Instance.new("TextButton")
    createPartButton.Size = UDim2.new(1, 0, 0, 40)
    createPartButton.Position = UDim2.new(0, 0, 0, 55)
    createPartButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    createPartButton.Text = "Part Point"
    createPartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    createPartButton.Font = Enum.Font.Gotham
    createPartButton.TextSize = 14
    createPartButton.Parent = contentFrame

    local buttonCorner2 = Instance.new("UICorner")
    buttonCorner2.CornerRadius = UDim.new(0, 6)
    buttonCorner2.Parent = createPartButton

    -- Botón adicional: Opciones
    local optionsButton = Instance.new("TextButton")
    optionsButton.Size = UDim2.new(1, 0, 0, 40)
    optionsButton.Position = UDim2.new(0, 0, 0, 100)
    optionsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    optionsButton.Text = "Opciones"
    optionsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    optionsButton.Font = Enum.Font.Gotham
    optionsButton.TextSize = 14
    optionsButton.Parent = contentFrame

    local buttonCorner3 = Instance.new("UICorner")
    buttonCorner3.CornerRadius = UDim.new(0, 6)
    buttonCorner3.Parent = optionsButton

    -- Devolver referencias a los elementos importantes
    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        StealButton = stealButton,
        CreatePartButton = createPartButton,
        OptionsButton = optionsButton,
        CloseButton = closeButton,
        MinimizeButton = minimizeButton,
        ContentFrame = contentFrame
    }
end

-- Función para crear la Mini UI durante el Steal
local function createMiniUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HeXHubMini"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    -- Marco principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 250, 0, 120)
    mainFrame.Position = UDim2.new(0, 50, 0, 50)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    -- Barra de título
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    -- Título
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

    -- Subtítulo Premium
    local subtitleText = Instance.new("TextLabel")
    subtitleText.Size = UDim2.new(0, 60, 0, 15)
    subtitleText.Position = UDim2.new(0, 210, 0, 8)
    subtitleText.BackgroundTransparency = 1
    subtitleText.Text = "Premium"
    subtitleText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitleText.Font = Enum.Font.Gotham
    subtitleText.TextSize = 12
    subtitleText.Parent = titleBar

    -- Botón de cerrar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = titleBar

    -- Botón de minimizar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 1, 0)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 16
    minimizeButton.Parent = titleBar

    -- Marco de contenido
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -40)
    contentFrame.Position = UDim2.new(0, 10, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Botón Off Ban
    local offBanButton = Instance.new("TextButton")
    offBanButton.Size = UDim2.new(1, 0, 0, 40)
    offBanButton.Position = UDim2.new(0, 0, 0, 10)
    offBanButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    offBanButton.Text = "Off Ban: " .. (banEnabled and "ON" or "OFF")
    offBanButton.TextColor3 = banEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    offBanButton.Font = Enum.Font.Gotham
    offBanButton.TextSize = 14
    offBanButton.Parent = contentFrame

    local buttonCorner1 = Instance.new("UICorner")
    buttonCorner1.CornerRadius = UDim.new(0, 6)
    buttonCorner1.Parent = offBanButton

    -- Botón Off Steal
    local offStealButton = Instance.new("TextButton")
    offStealButton.Size = UDim2.new(1, 0, 0, 40)
    offStealButton.Position = UDim2.new(0, 0, 0, 55)
    offStealButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    offStealButton.Text = "Off Steal"
    offStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    offStealButton.Font = Enum.Font.Gotham
    offStealButton.TextSize = 14
    offStealButton.Parent = contentFrame

    local buttonCorner2 = Instance.new("UICorner")
    buttonCorner2.CornerRadius = UDim.new(0, 6)
    buttonCorner2.Parent = offStealButton

    -- Devolver referencias a los elementos importantes
    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        OffBanButton = offBanButton,
        OffStealButton = offStealButton,
        CloseButton = closeButton,
        MinimizeButton = minimizeButton
    }
end

-- Función para crear la Part Point
local function createPartPoint()
    if part then
        part:Destroy()
    end

    local character = player.Character
    if not character then
        character = player.CharacterAdded:Wait()
    end
    
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

-- Función para animar la Part Point (efecto de baile)
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

-- Función para mostrar el contador de Steal
local function showCountdown()
    local countdownGui = Instance.new("ScreenGui")
    countdownGui.Name = "StealCountdown"
    countdownGui.ResetOnSpawn = false
    countdownGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    countdownGui.Parent = playerGui

    local countdownText = Instance.new("TextLabel")
    countdownText.Size = UDim2.new(0, 200, 0, 50)
    countdownText.Position = UDim2.new(0.5, -100, 0.2, 0)
    countdownText.BackgroundTransparency = 1
    countdownText.Text = "3..."
    countdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
    countdownText.Font = Enum.Font.GothamBold
    countdownText.TextSize = 24
    countdownText.TextStrokeTransparency = 0.5
    countdownText.Parent = countdownGui

    local function updateCountdown()
        countdownText.Text = "3..."
        wait(1)
        countdownText.Text = "2..."
        wait(1)
        countdownText.Text = "1..."
        wait(1)
        countdownText.Text = "Stealing..."
        wait(2)
        countdownGui:Destroy()
    end

    spawn(updateCountdown)
    return countdownGui
end

-- Función para anclar el jugador a la Part Point
local function anchorPlayerToPart()
    if not part or not humanoidRootPart then return end
    
    -- Mover al jugador a la Part Point
    humanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
    
    -- Anclar al jugador a la Part Point
    while isStealing and part and part.Parent do
        humanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
        RunService.Heartbeat:Wait()
    end
end

-- Función para detener el Steal
local function stopSteal()
    isStealing = false
    
    -- Cancelar tweens
    if partTween then
        partTween:Cancel()
        partTween = nil
    end
    
    if playerTween then
        playerTween:Cancel()
        playerTween = nil
    end
    
    -- Eliminar Mini UI
    if miniUI and miniUI.ScreenGui then
        miniUI.ScreenGui:Destroy()
        miniUI = nil
    end
    
    -- No eliminar la Part Point para mantenerla en su lugar
end

-- Función para iniciar el modo Steal
local function startSteal()
    if isStealing then return end
    
    -- Verificar si existe una Part Point
    if not part then
        -- Crear la Part Point si no existe
        part = createPartPoint()
        if not part then 
            return 
        end
    end
    
    isStealing = true
    
    -- Mostrar contador
    showCountdown()
    
    -- Crear Mini UI
    miniUI = createMiniUI()
    
    -- Animar la Part Point
    spawn(animatePart)
    
    -- Anclar el jugador a la Part Point
    spawn(anchorPlayerToPart)
    
    -- Configurar eventos de los botones de la Mini UI
    miniUI.OffBanButton.MouseButton1Click:Connect(function()
        banEnabled = not banEnabled
        miniUI.OffBanButton.Text = "Off Ban: " .. (banEnabled and "ON" or "OFF")
        miniUI.OffBanButton.TextColor3 = banEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)
    
    miniUI.OffStealButton.MouseButton1Click:Connect(function()
        stopSteal()
    end)
    
    miniUI.CloseButton.MouseButton1Click:Connect(function()
        if miniUI and miniUI.ScreenGui then
            miniUI.ScreenGui:Destroy()
            miniUI = nil
        end
    end)
end

-- Inicializar la UI principal cuando el personaje esté listo
player.CharacterAdded:Connect(function(character)
    wait(1) -- Esperar a que el personaje esté completamente cargado
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    if not mainUI then
        mainUI = createMainUI()
        
        -- Configurar eventos de la UI principal
        mainUI.StealButton.MouseButton1Click:Connect(startSteal)
        mainUI.CreatePartButton.MouseButton1Click:Connect(createPartPoint)
        
        mainUI.CloseButton.MouseButton1Click:Connect(function()
            mainUI.ScreenGui:Destroy()
            mainUI = nil
        end)

        mainUI.MinimizeButton.MouseButton1Click:Connect(function()
            local isVisible = mainUI.ContentFrame.Visible
            mainUI.ContentFrame.Visible = not isVisible
            local newSize = isVisible and 30 or 180
            mainUI.MainFrame.Size = UDim2.new(0, 300, 0, newSize)
        end)
    end
end)

-- Inicializar si el personaje ya existe
if player.Character then
    local character = player.Character
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    mainUI = createMainUI()
    
    -- Configurar eventos de la UI principal
    mainUI.StealButton.MouseButton1Click:Connect(startSteal)
    mainUI.CreatePartButton.MouseButton1Click:Connect(createPartPoint)

    mainUI.CloseButton.MouseButton1Click:Connect(function()
        mainUI.ScreenGui:Destroy()
        mainUI = nil
    end)

    mainUI.MinimizeButton.MouseButton1Click:Connect(function()
        local isVisible = mainUI.ContentFrame.Visible
        mainUI.ContentFrame.Visible = not isVisible
        local newSize = isVisible and 30 or 180
        mainUI.MainFrame.Size = UDim2.new(0, 300, 0, newSize)
    end)
end

print("HeXHub Premium Cargado Correctamente - Part Point activado")
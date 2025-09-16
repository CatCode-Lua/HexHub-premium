-- Script principal para HeXHub Premium en Roblox Lua
-- Nota: Este script es solo con fines educativos

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Crear la interfaz principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HeXHubPremium"
screenGui.Parent = player.PlayerGui

-- Función para crear ventanas con estilo consistente
local function createWindow(title, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0, 200, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
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
    contentFrame.Parent = frame
    
    return {
        Frame = frame,
        CloseButton = closeButton,
        MinimizeButton = minimizeButton,
        Content = contentFrame
    }
end

-- Crear UI principal
local mainWindow = createWindow("HeXHub", UDim2.new(0, 300, 0, 180), UDim2.new(0.5, -150, 0.5, -90))
mainWindow.Frame.Parent = screenGui

-- Botón Steal en la UI principal
local stealButton = Instance.new("TextButton")
stealButton.Size = UDim2.new(1, 0, 0, 40)
stealButton.Position = UDim2.new(0, 0, 0, 10)
stealButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
stealButton.Text = "Steal"
stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stealButton.Font = Enum.Font.GothamBold
stealButton.TextSize = 16
stealButton.Parent = mainWindow.Content

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = stealButton

-- Variables para el estado
local part = nil
local isStealing = false
local banEnabled = true
local tween = nil

-- Función para crear la Part
local function createPart()
    if part then part:Destroy() end
    
    part = Instance.new("Part")
    part.Size = Vector3.new(5, 0.2, 5)
    part.Position = humanoidRootPart.Position - Vector3.new(0, 3, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Color = Color3.fromRGB(0, 170, 0)
    part.Material = EnumMaterial.Neon
    part.Parent = workspace
    
    return part
end

-- Función para iniciar Steal
local function startSteal()
    if isStealing then return end
    
    isStealing = true
    
    -- Crear la Part si no existe
    if not part then
        part = createPart()
    end
    
    -- Crear Mini UI
    local miniWindow = createWindow("HeXHub", UDim2.new(0, 250, 0, 120), UDim2.new(0, 50, 0, 50))
    miniWindow.Frame.Parent = screenGui
    
    -- Botón Off Ban
    local offBanButton = Instance.new("TextButton")
    offBanButton.Size = UDim2.new(1, 0, 0, 40)
    offBanButton.Position = UDim2.new(0, 0, 0, 10)
    offBanButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    offBanButton.Text = "Off Ban: " .. (banEnabled and "ON" or "OFF")
    offBanButton.TextColor3 = banEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    offBanButton.Font = Enum.Font.Gotham
    offBanButton.TextSize = 14
    offBanButton.Parent = miniWindow.Content
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 6)
    corner1.Parent = offBanButton
    
    -- Botón Off Steal
    local offStealButton = Instance.new("TextButton")
    offStealButton.Size = UDim2.new(1, 0, 0, 40)
    offStealButton.Position = UDim2.new(0, 0, 0, 55)
    offStealButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    offStealButton.Text = "Off Steal"
    offStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    offStealButton.Font = Enum.Font.Gotham
    offStealButton.TextSize = 14
    offStealButton.Parent = miniWindow.Content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 6)
    corner2.Parent = offStealButton
    
    -- Contador en pantalla
    local countdownGui = Instance.new("ScreenGui")
    countdownGui.Name = "StealCountdown"
    countdownGui.Parent = player.PlayerGui
    
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
    
    -- Función para mover la Part suavemente (efecto de baile)
    local function animatePart()
        while isStealing and part do
            local targetPos = part.Position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(part, tweenInfo, {Position = targetPos})
            tween:Play()
            wait(0.5)
        end
    end
    
    -- Iniciar animación de la Part
    spawn(animatePart)
    
    -- Función para el contador
    local function runCountdown()
        countdownText.Text = "3..."
        wait(1)
        countdownText.Text = "2..."
        wait(1)
        countdownText.Text = "1..."
        wait(1)
        countdownText.Text = "Stealing..."
        
        -- Mover personaje a la Part
        if part and humanoidRootPart then
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))})
            tween:Play()
        end
        
        wait(2)
        countdownGui:Destroy()
    end
    
    -- Iniciar contador
    spawn(runCountdown)
    
    -- Evento para Off Ban
    offBanButton.MouseButton1Click:Connect(function()
        banEnabled = not banEnabled
        offBanButton.Text = "Off Ban: " .. (banEnabled and "ON" or "OFF")
        offBanButton.TextColor3 = banEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)
    
    -- Evento para Off Steal
    offStealButton.MouseButton1Click:Connect(function()
        isStealing = false
        if tween then tween:Cancel() end
        
        -- Regresar personaje a posición original
        if part and humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
        end
        
        miniWindow.Frame:Destroy()
        if countdownGui then countdownGui:Destroy() end
    end)
    
    -- Evento para cerrar la Mini UI
    miniWindow.CloseButton.MouseButton1Click:Connect(function()
        miniWindow.Frame.Visible = false
    end)
end

-- Conectar evento al botón Steal
stealButton.MouseButton1Click:Connect(startSteal)

-- Evento para cerrar la UI principal
mainWindow.CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Evento para minimizar la UI principal
mainWindow.MinimizeButton.MouseButton1Click:Connect(function()
    mainWindow.Content.Visible = not mainWindow.Content.Visible
    local newSize = mainWindow.Content.Visible and 180 or 30
    mainWindow.Frame.Size = UDim2.new(0, 300, 0, newSize)
end)
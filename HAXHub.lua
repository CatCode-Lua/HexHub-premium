-- HeXHub UI Script Final
-- LocalScript en StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HeXHubUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 200)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,30)
titleBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0,150,1,0)
title.Text = "HeXHub"
title.TextColor3 = Color3.fromRGB(0,255,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0,10,0,0)
title.Parent = titleBar

-- Botones Minimizar y Cerrar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0,30,1,0)
minimizeButton.Position = UDim2.new(1,-60,0,0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255,255,255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0,30,1,0)
closeButton.Position = UDim2.new(1,-30,0,0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255,255,255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = titleBar

-- Botones principales
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1,-20,1,-40)
buttonContainer.Position = UDim2.new(0,10,0,35)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

local stealButton = Instance.new("TextButton")
stealButton.Size = UDim2.new(1,0,0,50)
stealButton.Position = UDim2.new(0,0,0,0)
stealButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
stealButton.Text = "Steal"
stealButton.TextColor3 = Color3.fromRGB(255,255,255)
stealButton.Font = Enum.Font.Gotham
stealButton.TextSize = 16
stealButton.Parent = buttonContainer

local partPointButton = Instance.new("TextButton")
partPointButton.Size = UDim2.new(1,0,0,50)
partPointButton.Position = UDim2.new(0,0,0,60)
partPointButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
partPointButton.Text = "Part Point"
partPointButton.TextColor3 = Color3.fromRGB(255,255,255)
partPointButton.Font = Enum.Font.Gotham
partPointButton.TextSize = 16
partPointButton.Parent = buttonContainer

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1,0,0,20)
statusLabel.Position = UDim2.new(0,0,0,120)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Listo"
statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.Parent = buttonContainer

-- Mensaje STEALING
local stealMessage = Instance.new("TextLabel")
stealMessage.Size = UDim2.new(1,0,1,0)
stealMessage.BackgroundColor3 = Color3.fromRGB(0,0,0)
stealMessage.BackgroundTransparency = 0.5
stealMessage.Text = "STEALING..."
stealMessage.TextColor3 = Color3.fromRGB(0,255,0)
stealMessage.Font = Enum.Font.GothamBold
stealMessage.TextSize = 28
stealMessage.Visible = false
stealMessage.Parent = screenGui

local stealCounter = Instance.new("TextLabel")
stealCounter.Size = UDim2.new(0,100,0,50)
stealCounter.Position = UDim2.new(0.5,-50,0.4,0)
stealCounter.TextColor3 = Color3.fromRGB(255,0,0)
stealCounter.Font = Enum.Font.GothamBold
stealCounter.TextSize = 36
stealCounter.BackgroundTransparency = 1
stealCounter.Visible = false
stealCounter.Parent = screenGui

-- Variables
local partPoint = nil
local partPointPosition = nil
local originalPos = nil

-- Crear Part Point
local function createPartPoint()
	if partPoint then partPoint:Destroy() end
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	partPoint = Instance.new("Part")
	partPoint.Size = Vector3.new(5,1,5)
	partPoint.Anchored = true
	partPoint.CanCollide = false
	partPoint.Material = Enum.Material.Neon
	partPoint.Color = Color3.fromRGB(0,255,0)
	partPoint.Position = hrp.Position + Vector3.new(0,5,0)
	partPoint.Parent = workspace

	partPointPosition = partPoint.Position
	statusLabel.Text = "Part Point activo"
end

partPointButton.MouseButton1Click:Connect(createPartPoint)

-- Función Steal
stealButton.MouseButton1Click:Connect(function()
	if not partPointPosition then 
		statusLabel.Text = "Crea un Part Point primero"
		return 
	end
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- Guardar posición original
	originalPos = hrp.CFrame

	-- Mostrar mensaje
	stealMessage.Visible = true
	stealCounter.Visible = true
	hrp.Anchored = true

	-- Teleport al Part
	hrp.CFrame = CFrame.new(partPointPosition + Vector3.new(0,3,0))

	-- Contador regresivo 3 → 1
	for i = 3,1,-1 do
		stealCounter.Text = i
		wait(1)
	end

	-- Expulsar jugador (Ban)
	player:Kick("Has sido expulsado por HeXHub")
end)

-- Movible
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Minimizar y cerrar
local minimized = false
local originalSize = mainFrame.Size

minimizeButton.MouseButton1Click:Connect(function()
	if minimized then
		mainFrame.Size = originalSize
		minimizeButton.Text = "_"
		minimized = false
	else
		mainFrame.Size = UDim2.new(0,280,0,30)
		minimizeButton.Text = "+"
		minimized = true
	end
end)

closeButton.MouseButton1Click:Connect(function()
	screenGui.Enabled = false
end)

print("HeXHub UI cargada ✅")
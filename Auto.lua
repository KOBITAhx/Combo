local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Obtener la ID del servidor actual
local serverID = game.JobId

-- Crear el GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local CopyButton = Instance.new("TextButton")

-- Configurar el GUI
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TextLabel.Size = UDim2.new(0, 280, 0, 50)
TextLabel.Position = UDim2.new(0.5, 0, 0.3, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Server ID: " .. serverID
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextWrapped = true

CopyButton.Parent = Frame
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
CopyButton.Size = UDim2.new(0, 100, 0, 40)
CopyButton.Position = UDim2.new(0.5, 0, 0.7, 0)
CopyButton.AnchorPoint = Vector2.new(0.5, 0.5)
CopyButton.Font = Enum.Font.SourceSans
CopyButton.Text = "Copiar ID"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextScaled = true
CopyButton.TextWrapped = true

-- Función para copiar la ID al portapapeles
CopyButton.MouseButton1Click:Connect(function()
    setclipboard(serverID)
    CopyButton.Text = "ID Copiada!"
    wait(2)
    CopyButton.Text = "Copiar ID"
end)

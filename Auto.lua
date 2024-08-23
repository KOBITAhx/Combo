-- Variables Globales
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ConfirmButton = Instance.new("TextButton")
local IniciarButton = Instance.new("TextButton")
local AssignedKeys = {}

local isComboRunning = false
local comboConnection

-- Configuración del GUI
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -150, 0.5, -150)
Frame.Size = UDim2.new(0, 300, 0, 300)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Crear botones para asignar teclas
for i = 1, 6 do
    local KeyButton = Instance.new("TextButton")
    KeyButton.Parent = Frame
    KeyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    KeyButton.Position = UDim2.new(0.1, 0, 0.1 * i, 0)
    KeyButton.Size = UDim2.new(0, 100, 0, 30)
    KeyButton.Font = Enum.Font.SourceSans
    KeyButton.Text = "Asignar Tecla " .. i
    KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyButton.TextScaled = true
    KeyButton.TextWrapped = true
    KeyButton.MouseButton1Click:Connect(function()
        KeyButton.Text = "Presiona una tecla..."
        local inputConnection
        inputConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                AssignedKeys[i] = input.KeyCode
                KeyButton.Text = tostring(input.KeyCode)
                inputConnection:Disconnect()
            end
        end)
    end)
end

-- Confirmar botón para cambiar a modo iniciar
ConfirmButton.Parent = Frame
ConfirmButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
ConfirmButton.Position = UDim2.new(0.7, 0, 0.8, 0)
ConfirmButton.Size = UDim2.new(0, 100, 0, 40)
ConfirmButton.Font = Enum.Font.SourceSans
ConfirmButton.Text = "Confirmar"
ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmButton.TextScaled = true
ConfirmButton.TextWrapped = true
ConfirmButton.MouseButton1Click:Connect(function()
    Frame.Visible = false -- Ocultar el hub completo
    IniciarButton.Parent = ScreenGui
    IniciarButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
    IniciarButton.Position = UDim2.new(0.5, -50, 0.5, -20)
    IniciarButton.Size = UDim2.new(0, 100, 0, 40)
    IniciarButton.Font = Enum.Font.SourceSans
    IniciarButton.Text = "Iniciar"
    IniciarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    IniciarButton.TextScaled = true
    IniciarButton.TextWrapped = true

    -- Función para ejecutar el combo
    IniciarButton.MouseButton1Click:Connect(function()
        if isComboRunning then
            isComboRunning = false
            comboConnection:Disconnect()
            IniciarButton.Text = "Iniciar"
        else
            isComboRunning = true
            IniciarButton.Text = "Cancelar"

            -- Ejecutar el combo
            comboConnection = coroutine.wrap(function()
                for _, key in ipairs(AssignedKeys) do
                    if not isComboRunning then break end
                    UserInputService.InputBegan:Fire({
                        UserInputType = Enum.UserInputType.Keyboard,
                        KeyCode = key
                    })
                    wait(0.1) -- Simular la presión
                    UserInputService.InputEnded:Fire({
                        UserInputType = Enum.UserInputType.Keyboard,
                        KeyCode = key
                    })
                    wait(0.7) -- Esperar entre teclas
                end
                isComboRunning = false
                IniciarButton.Text = "Iniciar"
            end)
            comboConnection()
        end
    end)
end)

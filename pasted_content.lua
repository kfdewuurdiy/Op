-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "UCT_GUI"

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Size = UDim2.new(0, 550, 0, 300) -- Tamanho ajustado para dois painéis
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -150) -- Centralizar na tela
MainFrame.Active = true
MainFrame.Draggable = true

-- Título da GUI
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.Text = "UCT HUB / UCT ESP"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20

-- Botão Fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = MainFrame
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedGUI.Visible = true
end)


local MinimizedGUI = Instance.new("TextLabel")
MinimizedGUI.Parent = ScreenGui
MinimizedGUI.Text = "Kaio Hub"
MinimizedGUI.Size = UDim2.new(0, 100, 0, 30)
MinimizedGUI.Position = UDim2.new(0, 10, 0, 10) -- Posição no canto superior esquerdo
MinimizedGUI.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizedGUI.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedGUI.Font = Enum.Font.SourceSansBold
MinimizedGUI.TextSize = 16
MinimizedGUI.Visible = false
MinimizedGUI.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizedGUI.Visible = false
end)



-- Garante que a GUI não seja destruída ao morrer
ScreenGui.ResetOnSpawn = false

-- Painel UCT HUB
local UCTHubFrame = Instance.new("Frame")
UCTHubFrame.Parent = MainFrame
UCTHubFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UCTHubFrame.Size = UDim2.new(0.45, 0, 0.8, 0)
UCTHubFrame.Position = UDim2.new(0.03, 0, 0.15, 0)

local UCTHubTitle = Instance.new("TextLabel")
UCTHubTitle.Parent = UCTHubFrame
UCTHubTitle.Text = "UCT HUB"
UCTHubTitle.Size = UDim2.new(1, 0, 0, 25)
UCTHubTitle.Position = UDim2.new(0, 0, 0, 0)
UCTHubTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UCTHubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
UCTHubTitle.Font = Enum.Font.SourceSansBold
UCTHubTitle.TextSize = 18

-- Slider de WalkSpeed
local currentWalkSpeed = 16 -- Valor inicial

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Parent = UCTHubFrame
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
WalkSpeedLabel.Position = UDim2.new(0.05, 0, 0.2, 0) -- Posição ajustada
WalkSpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
WalkSpeedLabel.Text = "WalkSpeed: "..currentWalkSpeed

local WalkSpeedSliderFrame = Instance.new("Frame")
WalkSpeedSliderFrame.Parent = UCTHubFrame
WalkSpeedSliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
WalkSpeedSliderFrame.Position = UDim2.new(0.05, 0, 0.2 + 0.07, 0) -- Posição ajustada abaixo do label
WalkSpeedSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)

local WalkSpeedSliderButton = Instance.new("Frame")
WalkSpeedSliderButton.Parent = WalkSpeedSliderFrame
WalkSpeedSliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
WalkSpeedSliderButton.Size = UDim2.new(0, 10, 1, 0)
WalkSpeedSliderButton.Position = UDim2.new(0, 0, 0, 0)

local draggingWalkSpeedSlider = false

WalkSpeedSliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingWalkSpeedSlider = true
    end
end)

WalkSpeedSliderButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingWalkSpeedSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingWalkSpeedSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local posX = math.clamp(input.Position.X - WalkSpeedSliderFrame.AbsolutePosition.X, 0, WalkSpeedSliderFrame.AbsoluteSize.X)
        WalkSpeedSliderButton.Position = UDim2.new(0, posX, 0, 0)

        local alpha = posX / WalkSpeedSliderFrame.AbsoluteSize.X
        currentWalkSpeed = math.floor(16 + (100 - 16) * alpha) -- Min 16, Max 100
        WalkSpeedLabel.Text = "WalkSpeed: "..currentWalkSpeed

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentWalkSpeed
        end
    end
end)

-- Botão Infinity Jump
local infJump = false
local InfiniteJumpButton = Instance.new("TextButton")
InfiniteJumpButton.Parent = UCTHubFrame
InfiniteJumpButton.Text = "Infinity Jump: OFF"
InfiniteJumpButton.Size = UDim2.new(0.9, 0, 0, 40)
InfiniteJumpButton.Position = UDim2.new(0.05, 0, 0.4, 0) -- Posição ajustada
InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfiniteJumpButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- Cor vermelha como na imagem
InfiniteJumpButton.Font = Enum.Font.SourceSansBold
InfiniteJumpButton.TextSize = 16

InfiniteJumpButton.MouseButton1Click:Connect(function()
    infJump = not infJump
    if infJump then
        InfiniteJumpButton.Text = "Infinity Jump: ON"
        InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(100, 180, 100) -- Cor para ON
    else
        InfiniteJumpButton.Text = "Infinity Jump: OFF"
        InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(180, 100, 100) -- Cor para OFF
    end
end)

InfiniteJumpButton.MouseButton1Click:Connect(function()
    infJump = not infJump
    if infJump then
        InfiniteJumpButton.Text = "Infinity Jump: ON"
        InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(100, 180, 100) -- Cor para ON
        -- Garante que o humanoid não morra ao pular
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.BreakJointsOnDeath = false
            end
        end
    else
        InfiniteJumpButton.Text = "Infinity Jump: OFF"
        InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(180, 100, 100) -- Cor para OFF
        -- Restaura o comportamento padrão do humanoid
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.BreakJointsOnDeath = true
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Space and infJump then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then -- Verifica se o humanoid existe e está vivo
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                wait(0.2) -- Delay para um pulo por clique
            end
        end
    end
end)





-- Placeholder para outros botões do UCT HUB (mantidos para o layout)


local antiRagdoll = false
local AntiRagdollButton = Instance.new("TextButton")
AntiRagdollButton.Parent = UCTHubFrame
AntiRagdollButton.Text = "Anti-Ragdoll: OFF"
AntiRagdollButton.Size = UDim2.new(0.9, 0, 0, 40)
AntiRagdollButton.Position = UDim2.new(0.05, 0, 0.8, 0)
AntiRagdollButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AntiRagdollButton.TextColor3 = Color3.fromRGB(255, 0, 0)
AntiRagdollButton.Font = Enum.Font.SourceSansBold
AntiRagdollButton.TextSize = 16

AntiRagdollButton.MouseButton1Click:Connect(function()
    antiRagdoll = not antiRagdoll
    if antiRagdoll then
        AntiRagdollButton.Text = "Anti-Ragdoll: ON"
        AntiRagdollButton.BackgroundColor3 = Color3.fromRGB(100, 180, 100)
        -- Implementação do Anti-Ragdoll
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.BreakJointsOnDeath = false
            for i, v in pairs(character:GetChildren()) do
                if v:IsA("Part") and v.CanCollide == true then
                    v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 0.5, 0.5)
                end
            end
        end
    else
        AntiRagdollButton.Text = "Anti-Ragdoll: OFF"
        AntiRagdollButton.BackgroundColor3 = Color3.fromRGB(180, 100, 100)
        -- Reverter Anti-Ragdoll (se necessário, ou deixar como está para não resetar)
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.BreakJointsOnDeath = true
            for i, v in pairs(character:GetChildren()) do
                if v:IsA("Part") and v.CanCollide == true then
                    v.CustomPhysicalProperties = nil
                end
            end
        end
    end
end)


local ToggleSpeedJumpButton = Instance.new("TextButton")
ToggleSpeedJumpButton.Parent = UCTHubFrame
ToggleSpeedJumpButton.Text = "Toggle Speed + Jump"
ToggleSpeedJumpButton.Size = UDim2.new(0.9, 0, 0, 40)
ToggleSpeedJumpButton.Position = UDim2.new(0.05, 0, 0.7, 0) -- Posição ajustada
ToggleSpeedJumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
ToggleSpeedJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSpeedJumpButton.Font = Enum.Font.SourceSansBold
ToggleSpeedJumpButton.TextSize = 16

ToggleSpeedJumpButton.MouseButton1Click:Connect(function()
    SpeedJumpControlFrame.Visible = not SpeedJumpControlFrame.Visible
end)

-- Painel UCT ESP
local UCTEspFrame = Instance.new("Frame")
UCTEspFrame.Parent = MainFrame
UCTEspFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UCTEspFrame.Size = UDim2.new(0.45, 0, 0.8, 0)
UCTEspFrame.Position = UDim2.new(0.52, 0, 0.15, 0)

local UCTEspTitle = Instance.new("TextLabel")
UCTEspTitle.Parent = UCTEspFrame
UCTEspTitle.Text = "UCT ESP"
UCTEspTitle.Size = UDim2.new(1, 0, 0, 25)
UCTEspTitle.Position = UDim2.new(0, 0, 0, 0)
UCTEspTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UCTEspTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
UCTEspTitle.Font = Enum.Font.SourceSansBold
UCTEspTitle.TextSize = 18

-- Placeholder para botões do UCT ESP
local playerEspEnabled = false
local playerEspConnections = {}

local PlayerEspButton = Instance.new("TextButton")
PlayerEspButton.Parent = UCTEspFrame
PlayerEspButton.Text = "Player ESP: OFF"
PlayerEspButton.Size = UDim2.new(0.9, 0, 0, 40)
PlayerEspButton.Position = UDim2.new(0.05, 0, 0.2, 0)
PlayerEspButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlayerEspButton.TextColor3 = Color3.fromRGB(255, 0, 0)
PlayerEspButton.Font = Enum.Font.SourceSansBold
PlayerEspButton.TextSize = 16

PlayerEspButton.MouseButton1Click:Connect(function()
    playerEspEnabled = not playerEspEnabled
    if playerEspEnabled then
        PlayerEspButton.Text = "Player ESP: ON"
        PlayerEspButton.BackgroundColor3 = Color3.fromRGB(100, 180, 100)
        for i, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character or player.CharacterAdded:Wait()
                local head = char:FindFirstChild("Head")
                if head then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Parent = head
                    billboardGui.Size = UDim2.new(0, 100, 0, 50)
                    billboardGui.AlwaysOnTop = true
                    billboardGui.ExtentsOffset = Vector3.new(0, 2, 0)

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboardGui
                    textLabel.Text = player.Name
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo para destaque
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextSize = 18

                    playerEspConnections[player.UserId] = player.CharacterAdded:Connect(function(newChar)
                        billboardGui.Parent = newChar:FindFirstChild("Head")
                    end)
                end
            end
        end
    else
        PlayerEspButton.Text = "Player ESP: OFF"
        PlayerEspButton.BackgroundColor3 = Color3.fromRGB(180, 100, 100)
        for i, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    if head then
                        local billboardGui = head:FindFirstChildOfClass("BillboardGui")
                        if billboardGui then
                            billboardGui:Destroy()
                        end
                    end
                end
                if playerEspConnections[player.UserId] then
                    playerEspConnections[player.UserId]:Disconnect()
                    playerEspConnections[player.UserId] = nil
                end
            end
        end
    end
end)


local brainrotEspEnabled = false
local brainrotEspConnections = {}

local BrainrotEspButton = Instance.new("TextButton")
BrainrotEspButton.Parent = UCTEspFrame
BrainrotEspButton.Text = "Brainrot ESP: OFF"
BrainrotEspButton.Size = UDim2.new(0.9, 0, 0, 40)
BrainrotEspButton.Position = UDim2.new(0.05, 0, 0.4, 0)
BrainrotEspButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BrainrotEspButton.TextColor3 = Color3.fromRGB(255, 0, 0)
BrainrotEspButton.Font = Enum.Font.SourceSansBold
BrainrotEspButton.TextSize = 16

BrainrotEspButton.MouseButton1Click:Connect(function()
    brainrotEspEnabled = not brainrotEspEnabled
    if brainrotEspEnabled then
        BrainrotEspButton.Text = "Brainrot ESP: ON"
        BrainrotEspButton.BackgroundColor3 = Color3.fromRGB(100, 180, 100)
        -- Implementação do Brainrot ESP (exemplo com um objeto fictício 'MoneyBrainrot')
        -- Você precisará adaptar isso para o seu jogo específico, identificando os objetos 'brainrot' e seus valores.
        local highestValueBrainrot = nil
        local highestValue = 0

        -- Exemplo de como você pode iterar por objetos no workspace
        for i, v in pairs(workspace:GetChildren()) do
            -- Supondo que 'brainrot' são objetos com um valor numérico na propriedade 'Value'
            if v.Name == "MoneyBrainrot" and v:FindFirstChild("Value") and v.Value.Value > highestValue then
                highestValue = v.Value.Value
                highestValueBrainrot = v
            end
        end

        if highestValueBrainrot then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Parent = highestValueBrainrot
            billboardGui.Size = UDim2.new(0, 150, 0, 50)
            billboardGui.AlwaysOnTop = true
            billboardGui.ExtentsOffset = Vector3.new(0, 2, 0)
            billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local textLabel = Instance.new("TextLabel")
            textLabel.Parent = billboardGui
            textLabel.Text = "Melhor Brainrot: " .. highestValueBrainrot.Name .. " (" .. highestValue .. ")"
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Verde para destaque
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 16

            brainrotEspConnections[highestValueBrainrot.Name] = highestValueBrainrot.Destroying:Connect(function()
                billboardGui:Destroy()
                brainrotEspConnections[highestValueBrainrot.Name] = nil
            end)
        end
    else
        BrainrotEspButton.Text = "Brainrot ESP: OFF"
        BrainrotEspButton.BackgroundColor3 = Color3.fromRGB(180, 100, 100)
        for i, connection in pairs(brainrotEspConnections) do
            connection:Disconnect()
        end
        brainrotEspConnections = {}
        -- Remover todos os BillboardGuis de brainrot
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "MoneyBrainrot" then
                local billboardGui = v:FindFirstChildOfClass("BillboardGui")
                if billboardGui then
                    billboardGui:Destroy()
                end
            end
        end
    end
end)



local SpeedJumpControlFrame = Instance.new("Frame")
SpeedJumpControlFrame.Parent = MainFrame
SpeedJumpControlFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedJumpControlFrame.Size = UDim2.new(0, 200, 0, 150)
SpeedJumpControlFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
SpeedJumpControlFrame.Active = true
SpeedJumpControlFrame.Draggable = true
SpeedJumpControlFrame.Visible = false -- Começa invisível

local SpeedJumpControlTitle = Instance.new("TextLabel")
SpeedJumpControlTitle.Parent = SpeedJumpControlFrame
SpeedJumpControlTitle.Text = "Speed/Jump Control"
SpeedJumpControlTitle.Size = UDim2.new(1, 0, 0, 25)
SpeedJumpControlTitle.Position = UDim2.new(0, 0, 0, 0)
SpeedJumpControlTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedJumpControlTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedJumpControlTitle.Font = Enum.Font.SourceSansBold
SpeedJumpControlTitle.TextSize = 16

local CloseSpeedJumpButton = Instance.new("TextButton")
CloseSpeedJumpButton.Parent = SpeedJumpControlFrame
CloseSpeedJumpButton.Text = "X"
CloseSpeedJumpButton.Size = UDim2.new(0, 20, 0, 20)
CloseSpeedJumpButton.Position = UDim2.new(1, -25, 0, 0)
CloseSpeedJumpButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseSpeedJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSpeedJumpButton.MouseButton1Click:Connect(function()
    SpeedJumpControlFrame.Visible = false
end)

-- Slider de WalkSpeed na mini-tela
local currentCustomWalkSpeed = 16
local CustomWalkSpeedLabel = Instance.new("TextLabel")
CustomWalkSpeedLabel.Parent = SpeedJumpControlFrame
CustomWalkSpeedLabel.BackgroundTransparency = 1
CustomWalkSpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
CustomWalkSpeedLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
CustomWalkSpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
CustomWalkSpeedLabel.Text = "WalkSpeed: "..currentCustomWalkSpeed

local CustomWalkSpeedSliderFrame = Instance.new("Frame")
CustomWalkSpeedSliderFrame.Parent = SpeedJumpControlFrame
CustomWalkSpeedSliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CustomWalkSpeedSliderFrame.Position = UDim2.new(0.05, 0, 0.2 + 0.15, 0)
CustomWalkSpeedSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)

local CustomWalkSpeedSliderButton = Instance.new("Frame")
CustomWalkSpeedSliderButton.Parent = CustomWalkSpeedSliderFrame
CustomWalkSpeedSliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
CustomWalkSpeedSliderButton.Size = UDim2.new(0, 10, 1, 0)
CustomWalkSpeedSliderButton.Position = UDim2.new(0, 0, 0, 0)

local draggingCustomWalkSpeedSlider = false

CustomWalkSpeedSliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingCustomWalkSpeedSlider = true
    end
end)

CustomWalkSpeedSliderButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingCustomWalkSpeedSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingCustomWalkSpeedSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local posX = math.clamp(input.Position.X - CustomWalkSpeedSliderFrame.AbsolutePosition.X, 0, CustomWalkSpeedSliderFrame.AbsoluteSize.X)
        CustomWalkSpeedSliderButton.Position = UDim2.new(0, posX, 0, 0)

        local alpha = posX / CustomWalkSpeedSliderFrame.AbsoluteSize.X
        currentCustomWalkSpeed = math.floor(16 + (150 - 16) * alpha) -- Min 16, Max 150
        CustomWalkSpeedLabel.Text = "WalkSpeed: "..currentCustomWalkSpeed

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentCustomWalkSpeed
        end
    end
end)

-- Slider de JumpPower na mini-tela
local currentCustomJumpPower = 50
local CustomJumpPowerLabel = Instance.new("TextLabel")
CustomJumpPowerLabel.Parent = SpeedJumpControlFrame
CustomJumpPowerLabel.BackgroundTransparency = 1
CustomJumpPowerLabel.TextColor3 = Color3.fromRGB(255,255,255)
CustomJumpPowerLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
CustomJumpPowerLabel.Size = UDim2.new(0.9, 0, 0, 20)
CustomJumpPowerLabel.Text = "JumpPower: "..currentCustomJumpPower

local CustomJumpPowerSliderFrame = Instance.new("Frame")
CustomJumpPowerSliderFrame.Parent = SpeedJumpControlFrame
CustomJumpPowerSliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CustomJumpPowerSliderFrame.Position = UDim2.new(0.05, 0, 0.5 + 0.15, 0)
CustomJumpPowerSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)

local CustomJumpPowerSliderButton = Instance.new("Frame")
CustomJumpPowerSliderButton.Parent = CustomJumpPowerSliderFrame
CustomJumpPowerSliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
CustomJumpPowerSliderButton.Size = UDim2.new(0, 10, 1, 0)
CustomJumpPowerSliderButton.Position = UDim2.new(0, 0, 0, 0)

local draggingCustomJumpPowerSlider = false

CustomJumpPowerSliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingCustomJumpPowerSlider = true
    end
end)

CustomJumpPowerSliderButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingCustomJumpPowerSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingCustomJumpPowerSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local posX = math.clamp(input.Position.X - CustomJumpPowerSliderFrame.AbsolutePosition.X, 0, CustomJumpPowerSliderFrame.AbsoluteSize.X)
        CustomJumpPowerSliderButton.Position = UDim2.new(0, posX, 0, 0)

        local alpha = posX / CustomJumpPowerSliderFrame.AbsoluteSize.X
        currentCustomJumpPower = math.floor(50 + (250 - 50) * alpha) -- Min 50, Max 250
        CustomJumpPowerLabel.Text = "JumpPower: "..currentCustomJumpPower

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = currentCustomJumpPower
        end
    end
end)

-- Botão para abrir a mini-tela
local SpeedJumpControlButton = Instance.new("TextButton")
SpeedJumpControlButton.Parent = UCTHubFrame
SpeedJumpControlButton.Text = "Speed/Jump Control"
SpeedJumpControlButton.Size = UDim2.new(0.9, 0, 0, 40)
SpeedJumpControlButton.Position = UDim2.new(0.05, 0, 0.6, 0) -- Posição ajustada
SpeedJumpControlButton.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
SpeedJumpControlButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedJumpControlButton.Font = Enum.Font.SourceSansBold
SpeedJumpControlButton.TextSize = 16

SpeedJumpControlButton.MouseButton1Click:Connect(function()
    SpeedJumpControlFrame.Visible = not SpeedJumpControlFrame.Visible
end)



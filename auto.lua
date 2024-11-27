--// GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local AutoFarmChestButton = Instance.new("TextButton")
local FastAttackButton = Instance.new("TextButton")
local SummonDarkbeardButton = Instance.new("TextButton")

ScreenGui.Name = "CustomGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)

AutoFarmChestButton.Name = "AutoFarmChestButton"
AutoFarmChestButton.Parent = MainFrame
AutoFarmChestButton.Text = "Toggle AutoFarm Chest"
AutoFarmChestButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AutoFarmChestButton.Size = UDim2.new(0, 200, 0, 50)
AutoFarmChestButton.Position = UDim2.new(0.5, -100, 0.1, 0)

FastAttackButton.Name = "FastAttackButton"
FastAttackButton.Parent = MainFrame
FastAttackButton.Text = "Toggle Fast Attack"
FastAttackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
FastAttackButton.Size = UDim2.new(0, 200, 0, 50)
FastAttackButton.Position = UDim2.new(0.5, -100, 0.4, 0)

SummonDarkbeardButton.Name = "SummonDarkbeardButton"
SummonDarkbeardButton.Parent = MainFrame
SummonDarkbeardButton.Text = "Summon Darkbeard"
SummonDarkbeardButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SummonDarkbeardButton.Size = UDim2.new(0, 200, 0, 50)
SummonDarkbeardButton.Position = UDim2.new(0.5, -100, 0.7, 0)

--// Variables
getgenv().AutoFarmChest = false
getgenv().FastAttack = false
getgenv().SummonDarkbeard = false

--// Functions
AutoFarmChestButton.MouseButton1Click:Connect(function()
    getgenv().AutoFarmChest = not getgenv().AutoFarmChest
    AutoFarmChestButton.Text = getgenv().AutoFarmChest and "AutoFarm Chest: ON" or "AutoFarm Chest: OFF"
end)

FastAttackButton.MouseButton1Click:Connect(function()
    getgenv().FastAttack = not getgenv().FastAttack
    FastAttackButton.Text = getgenv().FastAttack and "Fast Attack: ON" or "Fast Attack: OFF"
end)

SummonDarkbeardButton.MouseButton1Click:Connect(function()
    getgenv().SummonDarkbeard = not getgenv().SummonDarkbeard
    SummonDarkbeardButton.Text = getgenv().SummonDarkbeard and "Summon Darkbeard: ON" or "Summon Darkbeard: OFF"
end)

--// Main Logic
spawn(function()
    while wait() do
        if getgenv().AutoFarmChest then
            -- Add AutoFarmChest logic here (from your previous code)
        end
        if getgenv().FastAttack then
            -- Add FastAttack logic here (from your previous code)
        end
        if getgenv().SummonDarkbeard then
            -- Add Summon Darkbeard logic here (from your previous code)
        end
    end
end)
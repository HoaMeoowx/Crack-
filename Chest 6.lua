-- Đợi game tải xong trước khi chạy script
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Khởi tạo các dịch vụ cần thiết
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    return warn("Không tìm thấy LocalPlayer!")
end

-- Kiểm tra và khởi tạo các biến toàn cục
getgenv().Setting = getgenv().Setting or {
    ModFarm = {
        StopItemLegendary = false,
        SummonKillDarkbeard = false,
    },
    TimeReset = 10,
    WhiteScreen = false,
}

local AutoFarmChest = true
local hopserver = false

-- Hàm kiểm tra và phá vỡ các hệ thống anti-cheat
local function CheckAntiCheatBypass()
    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
        if v:IsA("LocalScript") then
            local forbidden = {
                "General", "Shiftlock", "FallDamage", "4444", "CamBob",
                "JumpCD", "Looking", "Run"
            }
            if table.find(forbidden, v.Name) then
                v:Destroy()
            end
        end
    end
    for _, v in pairs(LocalPlayer.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") then
            local forbiddenScripts = {
                "RobloxMotor6DBugFix", "Clans", "Codes", "CustomForceField",
                "MenuBloodSp", "PlayerList"
            }
            if table.find(forbiddenScripts, v.Name) then
                v:Destroy()
            end
        end
    end
end

-- Hàm tự động chọn team
local function AutoJoinTeam()
    local gui = LocalPlayer.PlayerGui:FindFirstChild("Main")
    if gui and gui:FindFirstChild("ChooseTeam") then
        repeat
            task.wait()
            if getgenv().Setting.ModFarm.StopItemLegendary or getgenv().Setting.ModFarm.SummonKillDarkbeard then
                for _, connection in pairs(getconnections(gui.ChooseTeam.Container["Pirates"].Frame.TextButton.Activated)) do
                    connection.Function()
                end
            else
                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
            end
        until LocalPlayer.Team ~= nil
    end
end

-- Tự động farm chest
local function AutoFarmChests()
    while task.wait() do
        if AutoFarmChest then
            local closestChest = nil
            local closestDistance = math.huge
            for _, v in pairs(Workspace:GetChildren()) do
                if v.Name:find("Chest") and (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < closestDistance then
                    closestChest = v
                    closestDistance = (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                end
            end
            if closestChest then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                LocalPlayer.Character:PivotTo(closestChest:GetPivot())
                firesignal(closestChest.Touched, LocalPlayer.Character.HumanoidRootPart)
            else
                hopserver = true
                AutoFarmChest = false
            end
        end
    end
end

-- Đổi server khi cần
function HopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end
        ticklon = tick()
        
        repeat
            task.wait()
        until tick() - ticklon >= 1
        
        local function Hop()
            if not CheckInComBat() then
                for r = 1, math.huge do
                    -- Kiểm tra nếu vùng chọn chưa được xác định
                    if ChooseRegion == nil or ChooseRegion == "" then
                        ChooseRegion = "Singapore"
                    else
                        -- Cập nhật text box vùng chọn
                        game:GetService("Players").LocalPlayer.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text = ChooseRegion
                    end
                    
                    -- Gửi yêu cầu để lấy danh sách server
                    local bP = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(r)
                    
                    for k, v in pairs(bP) do
                        -- Kiểm tra nếu là server khác và có số người chơi ít hơn mức yêu cầu
                        if k ~= game.JobId and v["Count"] < bO then
                            -- Nhảy sang server
                            game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", k)
                            return true  -- Dừng việc kiểm tra sau khi nhảy server
                        end
                    end
                end
            end
            return false
        end
        
        -- Kiểm tra trạng thái lỗi và tự động nhảy server nếu gặp lỗi teleport
        if not getgenv().Loaded then
            local function bQ(v)
                if v.Name == "ErrorPrompt" then
                    if v.Visible then
                        if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                            -- Gọi lại hàm HopServer nếu gặp lỗi teleport
                            HopServer()
                            v.Visible = false
                        end
                    end
                    v:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            if v.Visible then
                                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                    -- Gọi lại hàm HopServer khi có lỗi
                                    HopServer()
                                    v.Visible = false
                                end
                            end
                        end
                    )
                end
            end
            -- Kiểm tra các thông báo lỗi hiện tại
            for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                bQ(v)
            end
            game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
            getgenv().Loaded = true
        end

        -- Vòng lặp kiểm tra và nhảy server
        while task.wait(0.1) do
            if Hop() then
                break  -- Thoát vòng lặp nếu đã nhảy server thành công
            end
        end
    end)
end
-- Kích hoạt script
CheckAntiCheatBypass()
AutoJoinTeam()

spawn(AutoFarmChests)
spawn(function()
    while task.wait() do
        if hopserver then
            HopServer()
        end
    end
end)
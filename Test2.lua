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
local hopserver = true
local resetTime = 15 -- Thời gian reset nhân vật
local ChooseRegion = "Singapore" -- Khu vực mặc định khi đổi server

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

-- Hàm reset nhân vật
local function ResetCharacter()
    while task.wait(resetTime) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character:BreakJoints()
        end
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

-- Hàm đổi server
function HopServer(maxPlayers)
    maxPlayers = maxPlayers or 10 -- Số người chơi tối đa mặc định cho server

    local tickStart = tick()
    repeat
        task.wait()
    until tick() - tickStart >= 1 -- Đảm bảo khoảng trễ 1 giây trước khi tiếp tục

    local function GetServers()
        local page = 1
        local region = ChooseRegion or "Singapore" -- Khu vực mặc định là Singapore

        while true do
            -- Gửi yêu cầu lấy danh sách server
            local servers = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(page)
            for id, info in pairs(servers) do
                if id ~= game.JobId and info.Count < maxPlayers then
                    -- Teleport tới server hợp lệ
                    game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", id)
                    return true
                end
            end
            page = page + 1 -- Tăng trang nếu không tìm thấy server phù hợp
        end
    end

    local function HandleTeleportError(guiElement)
        if guiElement.Name == "ErrorPrompt" then
            guiElement:GetPropertyChangedSignal("Visible"):Connect(function()
                if guiElement.Visible and guiElement.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                    guiElement.Visible = false
                    HopServer(maxPlayers) -- Thử lại nếu teleport thất bại
                end
            end)
        end
    end

    -- Kết nối sự kiện xử lý lỗi teleport
    for _, guiElement in pairs(game:GetService("CoreGui"):GetDescendants()) do
        HandleTeleportError(guiElement)
    end

    -- Khởi động quá trình tìm server
    GetServers()
end

-- Kích hoạt script
CheckAntiCheatBypass()
AutoJoinTeam()

spawn(AutoFarmChests)
spawn(ResetCharacter) -- Kích hoạt hàm reset nhân vật
spawn(function()
    while task.wait() do
        if hopserver then
            HopServer(10) -- Đổi server khi cần, mặc định tìm server dưới 10 người
        end
    end
end)
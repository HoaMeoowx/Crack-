repeat
    wait()
until game:IsLoaded()

-- Xác định thế giới
local world = "Unknown World"
if game.PlaceId == 2753915549 then
    world = "World 1"
elseif game.PlaceId == 4442272183 then
    world = "World 2"
elseif game.PlaceId == 7449423635 then
    world = "World 3"
end

-- Thông báo script đã kích hoạt
game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Auto Chest",
        Text = "Đã kích hoạt script tại " .. world,
        Duration = 5
    }
)

-- Khởi tạo các dịch vụ cần thiết
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    return warn("Không tìm thấy LocalPlayer!")
end

-- Khởi tạo biến toàn cục
local AutoFarmChest = true
local hopserver = false
local resetTime = 5.5 -- Thời gian reset nhân vật
local ChooseRegion = "Singapore" -- Khu vực mặc định khi đổi server
local chestsRemaining = 0 -- Biến đếm số lượng chest còn lại

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
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
        until LocalPlayer.Team ~= nil
    end
end

-- Hàm tự động farm chest
local function AutoFarmChests()
    while task.wait() do
        if AutoFarmChest then
            local closestChest = nil
            local closestDistance = math.huge
            chestsRemaining = 0 -- Đặt lại số lượng chest trước khi đếm

            for _, v in pairs(Workspace:GetChildren()) do
                if v.Name:find("Chest") then
                    chestsRemaining = chestsRemaining + 1 -- Đếm số lượng chest
                    local distance = (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestChest = v
                        closestDistance = distance
                    end
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
            elseif chestsRemaining == 0 then
                -- Không còn chest nào, thông báo và kích hoạt hop server
                game.StarterGui:SetCore(
                    "SendNotification",
                    {
                        Title = "Auto Chest",
                        Text = "Đã Lụm Hết Gương! Đang Tìm Server Khác...",
                        Duration = 5
                    }
                )
                AutoFarmChest = false
                hopserver = true
            end
        end
    end
end

-- Hàm đổi server
function HopServer(maxPlayers)
    maxPlayers = maxPlayers or 10 -- Số người chơi tối đa mặc định cho server

    -- Gửi thông báo đổi server
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "Server Hopping",
            Text = "Đang Hop Server... Chờ Một Lát!",
            Duration = 5
        }
    )

    local function GetServers()
        local page = 1
        local region = ChooseRegion or "Singapore" -- Khu vực mặc định là Singapore

        while true do
            local servers = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(page)
            for id, info in pairs(servers) do
                if id ~= game.JobId and info.Count < maxPlayers then
                    game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", id)
                    return true
                end
            end
            page = page + 1
        end
    end

    local function HandleTeleportError()
        local CoreGui = game:GetService("CoreGui")
        local errorPrompt = CoreGui:FindFirstChild("ErrorPrompt", true)

        if errorPrompt then
            errorPrompt:GetPropertyChangedSignal("Visible"):Connect(function()
                if errorPrompt.Visible and errorPrompt.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                    errorPrompt.Visible = false
                    HopServer(maxPlayers)
                end
            end)
        end
    end

    HandleTeleportError()
    GetServers()
end

-- Kích hoạt script
CheckAntiCheatBypass()
AutoJoinTeam()

spawn(AutoFarmChests)
spawn(function()
    while task.wait() do
        if hopserver then
            HopServer(10)
            hopserver = false
        end
    end
end)
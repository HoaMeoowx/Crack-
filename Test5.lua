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

-- Biến đếm số lần reset nhân vật
local resetCount = 0 -- Khởi tạo bộ đếm reset
local maxReset = 2   -- Số lần reset tối đa trong 1 server
local AutoFarmChest = true
local hopserver = false
local resetTime = 10.5 -- Thời gian giữa mỗi lần reset
local ChooseRegion = "Singapore"
local chestsRemaining = 0

-- Hàm reset nhân vật
local function ResetCharacter()
    if resetCount < maxReset then
        resetCount = resetCount + 1 -- Tăng số lần reset
        LocalPlayer.Character:BreakJoints() -- Reset nhân vật bằng cách phá vỡ joints

        -- Thông báo mỗi lần reset
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Reset Nhân Vật",
                Text = "Đang Reset Nhân Vật! Lần " .. resetCount .. " trong " .. maxReset .. " lần.",
                Duration = 5
            }
        )

        task.wait(resetTime)
    end

    -- Nếu đã reset đủ 2 lần, gửi thông báo
    if resetCount >= maxReset then
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Reset Nhân Vật",
                Text = "Đã hoàn thành 2 lần reset trong server này!",
                Duration = 5
            }
        )
    end
end

-- Gọi reset nhân vật trong một vòng lặp
local function PerformResets()
    for i = 1, maxReset do
        ResetCharacter()
    end
end

-- Hàm tự động farm chest
local function AutoFarmChests()
    while task.wait() do
        if AutoFarmChest then
            local closestChest = nil
            local closestDistance = math.huge
            chestsRemaining = 0

            for _, v in pairs(Workspace:GetChildren()) do
                if v.Name:find("Chest") then
                    chestsRemaining = chestsRemaining + 1
                    local distance = (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestChest = v
                        closestDistance = distance
                    end
                end
            end

            if closestChest then
                LocalPlayer.Character:PivotTo(closestChest:GetPivot())
                firesignal(closestChest.Touched, LocalPlayer.Character.HumanoidRootPart)
            elseif chestsRemaining == 0 then
                game.StarterGui:SetCore(
                    "SendNotification",
                    {
                        Title = "Auto Chest",
                        Text = "Đã Lụm Hết Gương! Đang Reset Nhân Vật...",
                        Duration = 5
                    }
                )
                AutoFarmChest = false
                PerformResets() -- Thực hiện 2 lần reset nhân vật
                hopserver = true
            end
        end
    end
end

-- Đổi server
function HopServer(maxPlayers)
    maxPlayers = maxPlayers or 10
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
    GetServers()
end

-- Kích hoạt script
spawn(AutoFarmChests)
spawn(function()
    if hopserver then
        HopServer(10)
    end
end)
-- Đợi game tải xong trước khi chạy script
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Khởi tạo các dịch vụ cần thiết
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    return warn("Không tìm thấy LocalPlayer!")
end

-- Các cài đặt
getgenv().AutoFarmChest = true
getgenv().AutoTeleport = true
getgenv().DontTeleportTheSameNumber = true
getgenv().MaxPlayerThreshold = 10 -- Ngưỡng tối đa người chơi trong server

-- Hàm farm chest
local function AutoFarmChests()
    while task.wait() do
        if getgenv().AutoFarmChest then
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
                -- Không tìm thấy chest, kích hoạt nhảy server
                getgenv().AutoFarmChest = false
                print("Không còn chest để farm, chuẩn bị đổi server...")
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Auto Chest",
                    Text = "Đã lụm hết gương! Đang đổi server...",
                    Duration = 3
                })
                HopServer()
            end
        end
    end
end

-- Hàm đổi server
local function HopServer()
    local gamelink = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local maxplayers = math.huge
    local goodserver = nil

    -- Hàm tìm server
    local function serversearch()
        local data = HttpService:JSONDecode(game:HttpGetAsync(gamelink)).data
        for _, server in pairs(data) do
            if type(server) == "table" and server.playing ~= nil and server.playing < getgenv().MaxPlayerThreshold and maxplayers > server.playing then
                maxplayers = server.playing
                goodserver = server.id
            end
        end
    end

    -- Hàm lấy danh sách server
    local function getservers(cursor)
        serversearch()
        local data = HttpService:JSONDecode(game:HttpGetAsync(gamelink))
        if data.nextPageCursor then
            getservers(data.nextPageCursor)
        end
    end

    -- Bắt đầu tìm server
    getservers()

    -- Teleport đến server tốt nhất
    if goodserver then
        if getgenv().DontTeleportTheSameNumber and goodserver == game.JobId then
            warn("Bạn đang ở trong server tốt nhất.")
            return
        end
        TeleportService:TeleportToPlaceInstance(game.PlaceId, goodserver)
    else
        warn("Không tìm thấy server phù hợp.")
    end
end

-- Kích hoạt AutoFarm
spawn(AutoFarmChests)
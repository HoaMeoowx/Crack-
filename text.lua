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
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    return warn("Không tìm thấy LocalPlayer!")
end

-- Các cài đặt
getgenv().AutoFarmChest = true
getgenv().MaxPlayerThreshold = 10 -- Ngưỡng tối đa người chơi trong server

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local HopButton = Instance.new("TextButton")

ScreenGui.Name = "HopServerGUI"
ScreenGui.Parent = game.CoreGui

HopButton.Name = "HopServerButton"
HopButton.Parent = ScreenGui
HopButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
HopButton.Position = UDim2.new(0.5, -50, 0.9, -25)
HopButton.Size = UDim2.new(0, 100, 0, 50)
HopButton.Font = Enum.Font.SourceSansBold
HopButton.Text = "Hop Server"
HopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HopButton.TextSize = 20

-- Hàm đổi server
local function HopServer()
    StarterGui:SetCore("SendNotification", {
        Title = "Auto Chest",
        Text = "Đang tìm server...",
        Duration = 3
    })

    local gamelink = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local maxplayers = math.huge
    local goodserver = nil

    -- Hàm tìm server
    local function serversearch()
        local success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGetAsync(gamelink))
        end)

        if success and response and response.data then
            for _, server in pairs(response.data) do
                if type(server) == "table" and server.playing ~= nil and server.playing < getgenv().MaxPlayerThreshold and maxplayers > server.playing then
                    maxplayers = server.playing
                    goodserver = server.id
                end
            end
        else
            warn("Lỗi khi lấy danh sách server:", response)
        end
    end

    -- Hàm lấy danh sách server
    local function getservers(cursor)
        serversearch()
        local success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGetAsync(gamelink))
        end)

        if success and response and response.nextPageCursor then
            gamelink = gamelink .. "&cursor=" .. response.nextPageCursor
            getservers(response.nextPageCursor)
        end
    end

    -- Bắt đầu tìm server
    getservers()

    -- Teleport đến server tốt nhất
    if goodserver then
        StarterGui:SetCore("SendNotification", {
            Title = "Auto Chest",
            Text = "Đang đổi server...",
            Duration = 3
        })
        TeleportService:TeleportToPlaceInstance(game.PlaceId, goodserver)
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Auto Chest",
            Text = "Không tìm thấy server phù hợp.",
            Duration = 3
        })
    end
end

-- Liên kết sự kiện khi nhấn nút
HopButton.MouseButton1Click:Connect(HopServer)

-- Tự động farm chest
local function AutoFarmChests()
    while task.wait() do
        if getgenv().AutoFarmChest then
            local closestChest = nil
            local closestDistance = math.huge

            for _, v in pairs(Workspace:GetChildren()) do
                if v.Name:find("Chest") and v:IsA("BasePart") and (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < closestDistance then
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
                -- Không tìm thấy chest
                getgenv().AutoFarmChest = false
                StarterGui:SetCore("SendNotification", {
                    Title = "Auto Chest",
                    Text = "Đã lụm hết gương!",
                    Duration = 3
                })
                break
            end
        end
    end
end

-- Kích hoạt AutoFarm
spawn(AutoFarmChests)
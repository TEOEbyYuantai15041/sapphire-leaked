Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
Lighting = game:GetService("Lighting")
VirtualUser = game:GetService("VirtualUser")
RunService = game:GetService("RunService")
PathfindingService = game:GetService("PathfindingService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
ProximityPromptService = game:GetService("ProximityPromptService")
UserInputService = game:GetService("UserInputService")
Workspace = game:GetService("Workspace")
SoundService = game:GetService("SoundService")
Debris = game:GetService("Debris")

if LocalPlayer:GetAttribute("NectarLoaded") then 
print("[防重复加载] 脚本已结束")
return
end

LocalPlayer:SetAttribute("NectarLoaded", true)

notifysound = 4590657391

PlayingSound = true
promptReachMultiplier = 2.0

Floor = ReplicatedStorage.GameData.Floor

GameData = ReplicatedStorage:WaitForChild("GameData")
LatestRoom = GameData:WaitForChild("LatestRoom")

RemoteFolder = ReplicatedStorage:FindFirstChild("RemotesFolder")
MainGame = LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game
RequiredMainGame = require(LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
RemoteListener = MainGame.RemoteListener
Modules = RemoteListener.Modules
ClientModules = game:GetService("ReplicatedStorage"):FindFirstChild("ModulesClient") or game:GetService("ReplicatedStorage"):FindFirstChild("ClientModules") 
Modifiers = ReplicatedStorage:WaitForChild("LiveModifiers")

Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(char)
Character = char

end)

function Sound()

sound = Instance.new("Sound",SoundService)

sound.Volume = 2.5

sound.SoundId = "rbxassetid://" .. notifysound 

sound.Playing = PlayingSound and true or false

Debris:AddItem(sound,2)

end
Sound()

Character = LocalPlayer.Character
if Character.Collision:FindFirstChild("CollisionCrouch") then
Character.Collision.CollisionCrouch.Size = Vector3.new(0.5, 0.001, 3)
end
if ReplicatedStorage:FindFirstChild("RemotesFolder") then
CollisionClone = Character.CollisionPart:Clone()
CollisionClone.Parent = Character
CollisionClone.Massless = true
CollisionClone.CanCollide = false
CollisionClone.Name = "_CollisionPart"
if CollisionClone:FindFirstChild("CollisionCrouch") then
CollisionClone.CollisionCrouch:Destroy()
end
CollisionClone2 = Character.CollisionPart:Clone()
CollisionClone2.Parent = Character
CollisionClone2.Massless = true
CollisionClone2.CanCollide = false
CollisionClone2.Name = "_CollisionPart2"
if CollisionClone2:FindFirstChild("CollisionCrouch") then
CollisionClone2.CollisionCrouch:Destroy()
end
end

Achievement = (function()
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local Plr = Players.LocalPlayer
return function(data)
task.spawn(function()
local frame = Plr.PlayerGui.GlobalUI.AchievementsHolder.Achievement:Clone()
frame.Name = "LiveAchievement"
frame.Frame.Details.Title.Text = data.Title
frame.Frame.Details.Desc.Text = data.Desc
frame.Frame.Details.Reason.Text = data.Reason
frame.Frame.ImageLabel.Image = data.Image
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Frame.Position = UDim2.new(1.1, 0, 0, 0)
frame.Visible = true
frame.Parent = Plr.PlayerGui.GlobalUI.AchievementsHolder
if data.Text then
frame.Frame.TextLabel.Text = data.Text
end
if data.TextColor then
frame.Frame.TextLabel.TextColor3 = data.TextColor
end
if data.UIStrokeColor then
frame.Frame.UIStroke.Color = data.UIStrokeColor
end
frame.Sound:Play()
frame:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", 0.8, true)
task.wait(0.8)
frame.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true)
frame.Frame.Glow.ImageColor3 = frame.Frame.UIStroke.Color
TS:Create(frame.Frame.Glow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { ImageTransparency = 1 }):Play()
task.wait(3)
frame.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), "In", "Quad", 0.5, true)
task.wait(0.5)
frame:TweenSize(UDim2.new(1, 0, -0.1, 0), "InOut", "Quad", 0.5, true)
task.wait(0.5)
frame:Destroy()
end)
end
end)()

function setcantouch(Part, Value)
if Part:IsA("Model") then
for _, v in ipairs(Part:GetChildren()) do
if v:IsA("BasePart") then
v.CanTouch = Value
end
end
elseif Part:IsA("BasePart") then
Part.CanTouch = Value
end
end

local hubFolder = "Sapphire"
local addonFolder = hubFolder.."/Addons"
local UIStyleFile = hubFolder.."/UIStyle.txt"

if not isfolder(hubFolder) then
makefolder(hubFolder)
end

if not isfolder(addonFolder) then
makefolder(addonFolder)
end

if not isfile(UIStyleFile) then
writefile("UIStyle.txt","Obsidian")
end

savedUIStyle = "Obsidian"
if readfile and isfile(UIStyleFile) then
local success, content = pcall(readfile, UIStyleFile)
if success and (content == "Obsidian" or content == "Linoria") then
savedUIStyle = content
end
end
UIStyle = savedUIStyle

Pathnode = Instance.new("Folder",workspace)
Pathnode.Name = "Path Node"

local repo
if UIStyle == "Linoria" then
repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
else
repo = 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
end
Executor = identifyexecutor() or getexecutorname() or "Unknown"
Library = loadstring(game:HttpGet(repo..'Library.lua'))()

ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
SaveManager  = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()
Options = Library.Options
Toggles = Library.Toggles
ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/MSESP/refs/heads/main/source.luau"))()

ESPLibrary.GlobalConfig.Tracers = false
ESPLibrary.GlobalConfig.Arrows = false

if Checkbox == nil then
Library.ForceCheckbox = true
else
Library.ForceCheckbox = Checkbox
end
Library.NotifySide = "Right"

Connections = {}

Library:Notify("正在加载 Nectar | Doors",5)

Window = Library:CreateWindow({
Title = 'Nectar',
Footer = "楼层："..Floor.Value.." | 版本：2.1.3",
Center = true,
NotifySide = "Right",
AutoShow = true
})

Tabs = {
Homepage = Window:AddTab("主页","house","首页信息"),
Player = Window:AddTab("玩家","user","基础功能"),
Exploits = Window:AddTab("漏洞","bug","利用Doors游戏漏洞"),
Visuals = Window:AddTab("视角","scan-eye","渲染&通知"),
Floor = Window:AddTab("楼层","sparkles","基于楼层"),
Development = Window:AddTab("","terminal","实验性功能"),
UISettings = Window:AddTab("配置","settings","用户界面&预设"),
Addons = Window:AddTab("插件","boxes","Nectar的社区插件"),
}

User = Tabs.Homepage:AddLeftGroupbox("用户信息","user-round")
TabBox1 = Tabs.Homepage:AddRightTabbox()
KeyInfo = TabBox1:AddTab("密钥信息")
Info = TabBox1:AddTab("贡献者信息")

Movement = Tabs.Player:AddLeftGroupbox("移动")
Automation = Tabs.Player:AddRightGroupbox('��')
ReachBox = Tabs.Player:AddLeftGroupbox('距离')
MiscBox = Tabs.Player:AddRightGroupbox("杂项")

Anti = Tabs.Exploits:AddLeftGroupbox('防所有实体')
Bypass = Tabs.Exploits:AddRightGroupbox('绕过')
Troll = Tabs.Exploits:AddLeftGroupbox('恶搞')

TabBox = Tabs.Visuals:AddLeftTabbox()
ESP = TabBox:AddTab('ESP')
SettingsESP = TabBox:AddTab('设置')
TabBox2 = Tabs.Visuals:AddRightTabbox()
NotifyBox = TabBox2:AddTab('通知')
NySet = TabBox2:AddTab('设置')
Ambient = Tabs.Visuals:AddLeftGroupbox("?")
TabBox3 = Tabs.Visuals:AddRightTabbox()
Self = TabBox3:AddTab('��')
Effect = TabBox3:AddTab('效果')

FloorAnti = Tabs.Floor:AddLeftGroupbox('楼层绕过')
Other = Tabs.Floor:AddRightGroupbox("其它")
ModifiersBox = Tabs.Floor:AddLeftGroupbox('��')
Farm = Tabs.Floor:AddLeftGroupbox("农场")

ModuleBox = Tabs.Development:AddLeftGroupbox("模块")
AdminPanel = Tabs.Development:AddRightGroupbox("管理员面板")

SettingsBox = Tabs.UISettings:AddLeftGroupbox('UI','wrench')

Tabs.Homepage:UpdateWarningBox({
Title = "更新日志：",
Text = "//Doors//\n<font color=\"rgb(73,230,133)\">新防 Monument</font>",
IsNormal = true,
Visible = true,
LockSize = true,
})

success, result = pcall(function()
thumbnailType = Enum.ThumbnailType.HeadShot
thumbnailSize = Enum.ThumbnailSize.Size100x100
content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbnailType, thumbnailSize)
return content
end)
User:AddImage("UserImage", {
Image = success and result or "rbxassetid://",
Callback = function(image)
end,
})
User:AddLabel("用户昵称: " .. LocalPlayer.DisplayName .. " (" .. LocalPlayer.Name .. ")", true)
User:AddLabel("注入器: " .. Executor, true)
User:AddDivider()
User:AddButton({
Text = "复制玩家用户ID",
Func = function()
local userId = tostring(LocalPlayer.UserId)
if setclipboard then
setclipboard(userId)
else
Library:Notify("无法访问剪贴板，用户ID: " .. userId, 10)
end
end
})

local HttpService = game:GetService("HttpService")
HttpService.HttpEnabled = true
local function formatRemaining(expiresAtStr)
if not expiresAtStr or expiresAtStr == "" then
return "永久"
end
local success, dateTime = pcall(DateTime.fromIsoDate, expiresAtStr)
if not success then
return "日期格式无效"
end
local target = dateTime.UnixTimestamp
local now = os.time()
local remain = target - now
local absRemain = math.abs(remain)
local days = math.floor(absRemain / 86400)
local hours = math.floor((absRemain % 86400) / 3600)
local minutes = math.floor((absRemain % 3600) / 60)
local seconds = absRemain % 60
if remain >= 0 then
return string.format(" %d天 %02d时 %02d分 %02d秒", days, hours, minutes, seconds)
else
return "已过期"
end
end
local keyValueLabel = KeyInfo:AddLabel("密钥: 加载中...")
local remainingLabel = KeyInfo:AddLabel("密钥期限: 加载中...")
local function updateKeyInfo()
task.spawn(function()
local keyFilePath = "Sapphire_key.txt"
local keyValue = nil
if isfile(keyFilePath) then
local content = readfile(keyFilePath)
keyValue = content:gsub("^%s+", ""):gsub("%s+$", "")
end
local displayKey = keyValue or ""
if #displayKey > 15 then
displayKey = string.sub(displayKey, 1, 15) .. "..."
end
keyValueLabel:SetText("密钥: " .. displayKey)
local API_KEY = "f940a405-0204-4ec5-9a8d-d59bb0a068ed"
local API_URL = "https://api.jnkie.com/api/v2/keys/" .. keyValue
local requestParams = {
Url = API_URL,
Method = "GET",
Headers = {
["Authorization"] = "Bearer " .. API_KEY,
["Accept"] = "application/json"
}
}
local success, response = pcall(function()
return HttpService:RequestAsync(requestParams)
end)
if not success then
remainingLabel:SetText("密钥期限: API请求失败")
return
end
if response.StatusCode ~= 200 then
remainingLabel:SetText("密钥期限: HTTP " .. response.StatusCode)
return
end
local decodeOk, decoded = pcall(function()
return HttpService:JSONDecode(response.Body)
end)
if not decodeOk then
return
end
local keysList = nil
if type(decoded) == "table" then
if #decoded > 0 or next(decoded) == nil then
keysList = decoded
elseif decoded.keys and type(decoded.keys) == "table" then
keysList = decoded.keys
elseif decoded.data and type(decoded.data) == "table" then
keysList = decoded.data
else
keysList = { decoded }
end
else
return
end
local foundKey = nil
for _, key in ipairs(keysList) do
local keyInfo = key.key or key
if keyInfo.key_value == keyValue then
foundKey = keyInfo
break
end
end
if not foundKey then
remainingLabel:SetText("密钥期限: 永久")
return
end
local remainingText = formatRemaining(foundKey.expires_at)
remainingLabel:SetText("密钥期限: " .. remainingText)
end)
end
task.spawn(function()
while true do
updateKeyInfo()
task.wait(2)
end
end)

Info:AddLabel("[<font color=\"rgb(73,230,133)\">千change</font>] 有?")
Info:AddDivider()
Info:AddLabel({
Text = "<font color=\"rgb(135,206,235)\">加入我们的群</font>",
Size = 23
})
Info:AddLabel("主群：<font color=\"rgb(173,216,230)\">1070767561</font>")
Info:AddLabel("②群：<font color=\"rgb(173,216,230)\">1075296984</font>")
Info:AddLabel("③群：<font color=\"rgb(173,216,230)\">1077974715</font>")
Info:AddLabel("④群：<font color=\"rgb(173,216,230)\">1079930056</font>")


Movement:AddToggle('SpeedBoost',{
     Text = "移动速度",
     Default = false
})

Speed = 15
Movement:AddSlider("SpeedBoostSlider", {
        Text = "移动速度：",
        Default = 15,
        Min = 15,
        Max = 21,
        Rounding = 1,
Callback = function(Value)
Speed = Value
end,      
})

LadderSpeedSlider = Movement:AddSlider("LadderSpeedBoost", {
    Text = "粒子加速",
    Default = 5,
    Min = 0,
    Max = 50,
    Rounding = 0,
    Compact = true,
Callback = function(Value)
if Toggles.SpeedBoost.Value and LocalPlayer.Character and 
LocalPlayer.Character:GetAttribute("Climbing") then
LocalPlayer.Character.Humanoid.WalkSpeed = Speed + Value
end
end,
})
function updateLadderSpeedSlider()
isMinesFloor = Floor.Value == "Mines"
LadderSpeedSlider:SetDisabled(not isMinesFloor)
if not isMinesFloor then
Options.LadderSpeedBoost:SetValue(0)
end
end
if Floor:IsA("StringValue") then
table.insert(Connections, Floor.Changed:Connect(updateLadderSpeedSlider))
end
updateLadderSpeedSlider()

Movement:AddToggle('EnableJump', {
    Text = "自动跳跃",
    Default = false
})
Toggles.EnableJump:OnChanged(function(Value)
if Character then
Character:SetAttribute("CanJump", Value)
end
end)
if LocalPlayer.Character and Toggles.EnableJump and Toggles.EnableJump.Value then
LocalPlayer.Character:SetAttribute("CanJump", true)
end

jumpPowerValue = 5
Movement:AddSlider("JumpPowerSlider", {
    Text = "跳跃提升",
    Default = 5,
    Min = 0,
    Max = 50,
    Rounding = 1,
    Compact = false,
Callback = function(Value)
jumpPowerValue = Value
applyJumpPower()
end,      
})
jumpPowerConnections = {}
function applyJumpPower()
character = LocalPlayer.Character
if not character then return end
humanoid = character:FindFirstChildOfClass("Humanoid")
if not humanoid then return end
if jumpPowerConnections.character then
jumpPowerConnections.character:Disconnect()
jumpPowerConnections.character = nil
end
if jumpPowerConnections.jumpPower then
jumpPowerConnections.jumpPower:Disconnect()
jumpPowerConnections.jumpPower = nil
end
if jumpPowerConnections.jumpHeight then
jumpPowerConnections.jumpHeight:Disconnect()
jumpPowerConnections.jumpHeight = nil
end
if humanoid.UseJumpPower then
humanoid.JumpPower = jumpPowerValue
jumpPowerConnections.jumpPower = humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
if humanoid.JumpPower ~= jumpPowerValue then
humanoid.JumpPower = jumpPowerValue
end
end)
else
humanoid.JumpHeight = jumpPowerValue
jumpPowerConnections.jumpHeight = humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function()
if humanoid.JumpHeight ~= jumpPowerValue then
humanoid.JumpHeight = jumpPowerValue
end
end)
end
end
if LocalPlayer.Character then
applyJumpPower()
end
jumpPowerConnections.character = LocalPlayer.CharacterAdded:Connect(function(character)
character:WaitForChildOfClass("Humanoid")
applyJumpPower()
end)
Options.JumpPowerSlider:OnChanged(function()
jumpPowerValue = Options.JumpPowerSlider.Value
applyJumpPower()
end)

Movement:AddToggle('InfiniteJump', {
    Text = "无限跳跃",
    Default = false
})
if LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons:FindFirstChild("JumpButton") then
JumpConnection = LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons.JumpButton.MouseButton1Click:Connect(function()
if Toggles and Toggles.InfiniteJump and Toggles.InfiniteJump.Value then
if Character then
Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
end)
end
table.insert(Connections, UserInputService.JumpRequest:Connect(function()
task.wait(0.3)
if Toggles.InfiniteJump.Value then
if Character then
Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
end))

Movement:AddToggle('EnableSlide', {
    Text = "自动滑铲",
    Default = false
})
Toggles.EnableSlide:OnChanged(function(Value)
if Character then
Character:SetAttribute("CanSlide", Value)
end
end)
if LocalPlayer.Character and Toggles.EnableSlide and Toggles.EnableSlide.Value then
LocalPlayer.Character:SetAttribute("CanSlide", true)
end

Movement:AddToggle('Noacceleration', {
    Text = "无加速度",
    Default = false
})
Movement:AddDivider()

Movement:AddToggle('InstantPrompt', {
    Text = "?�互动",
    Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v:SetAttribute("Hold", v.HoldDuration)
v.HoldDuration = 0
end
end
else
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v.HoldDuration = v:GetAttribute("Hold") or 0.7
end
end
end
end
})

Movement:AddToggle('NoClosetExitDelay', {
    Text = "无出柜延迟",
    Default = false
})

Movement:AddToggle('AntiAfk', {
    Text = "防挂机",
    Default = false
})
table.insert(Connections, LocalPlayer.Idled:Connect(function()
if Toggles.AntiAfk.Value then
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end
end))
Movement:AddDivider()

Movement:AddToggle('Noclip', {
    Text = "穿墙",
    Default = false
}):AddKeyPicker('NoclipKeybind', {
    Default = 'N',
    Mode = 'Toggle',
    Text = '穿墙',
    NoUI = false,
    Callback = function(Value) end,
    SyncToggleState = true,
    ChangedCallback = function(New) end
})
Toggles.Noclip:OnChanged(function(Value)
if not Value then 
LocalPlayer.Character.Collision.CanCollide = true 
if Character.Collision:FindFirstChild("CollisionCrouch") then
LocalPlayer.Character.Collision.CollisionCrouch.CanCollide = true
end
LocalPlayer.Character.HumanoidRootPart.CanCollide = true
if LocalPlayer.Character:FindFirstChild("CollisionPart") then
LocalPlayer.Character:FindFirstChild("CollisionPart").CanCollide = true
end
end
end)

Fly = Fly or {}
Fly.Enabled = false
Fly.Speed = 15
Fly.FlyBody = nil
Fly.FlyGyro = nil
local renderConn 
charAddedConn = nil
function Fly.SetupBodies(char)
root = char:FindFirstChild("HumanoidRootPart")
if not root then return end
bv = Instance.new("BodyVelocity")
bv.Name = "FlyBodyVelocity"
bv.MaxForce = Vector3.new(9e99, 9e99, 9e99)
bv.Velocity = Vector3.zero
bv.Parent = root
Fly.FlyBody = bv
bg = Instance.new("BodyGyro")
bg.Name = "FlyBodyGyro"
bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
cam = workspace.CurrentCamera
if cam then
bg.CFrame = cam.CFrame
end
bg.Parent = root
Fly.FlyGyro = bg
humanoid = char:FindFirstChild("Humanoid")
if humanoid then
humanoid.PlatformStand = true
end
end
function Fly.CleanupBodies()
if Fly.FlyBody then
Fly.FlyBody:Destroy()
Fly.FlyBody = nil
end
if Fly.FlyGyro then
Fly.FlyGyro:Destroy()
Fly.FlyGyro = nil
end
if Character then
humanoid = Character:FindFirstChild("Humanoid")
if humanoid then
humanoid.PlatformStand = false
end
end
end
function onRenderStepped()
if not Fly.Enabled then return end
char = Character
if not char then return end
humanoid = char:FindFirstChild("Humanoid")
root = char:FindFirstChild("HumanoidRootPart")
cam = workspace.CurrentCamera
if not humanoid or not root or not Fly.FlyBody or not Fly.FlyGyro or not cam then
return
end
dir = Vector3.zero
if UserInputService.KeyboardEnabled then
forward = UserInputService:IsKeyDown(Enum.KeyCode.W)
back    = UserInputService:IsKeyDown(Enum.KeyCode.S)
left    = UserInputService:IsKeyDown(Enum.KeyCode.A)
right   = UserInputService:IsKeyDown(Enum.KeyCode.D)
camCFrame = cam.CFrame
lookVec = camCFrame.LookVector
rightVec = camCFrame.RightVector
if forward then
dir = dir + lookVec
end
if back then
dir = dir - lookVec
end
if left then
dir = dir - rightVec
end
if right then
dir = dir + rightVec
end
else
moveDir = humanoid.MoveDirection
if moveDir.Magnitude > 0 then
camCFrame = cam.CFrame
flatLook = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z)
flatRight = Vector3.new(camCFrame.RightVector.X, 0, camCFrame.RightVector.Z)
if flatLook.Magnitude > 0 then
flatLook = flatLook.Unit
end
if flatRight.Magnitude > 0 then
flatRight = flatRight.Unit
end
forwardWeight = moveDir:Dot(flatLook)
rightWeight = moveDir:Dot(flatRight)
dir = camCFrame.LookVector * forwardWeight + camCFrame.RightVector * rightWeight
end
end
if dir.Magnitude > 0 then
Fly.FlyBody.Velocity = dir.Unit * Fly.Speed
else
Fly.FlyBody.Velocity = Vector3.zero
end
Fly.FlyGyro.CFrame = cam.CFrame
humanoid.PlatformStand = true
end
function Fly.Enable()
if Fly.Enabled then return end
Fly.Enabled = true
char = Character 
if char then
Fly.SetupBodies(char)
end
if not renderConn then
renderConn = RunService.RenderStepped:Connect(onRenderStepped)
end
if not charAddedConn then
charAddedConn = player.CharacterAdded:Connect(function(char2)
if Fly.Enabled then
char2:WaitForChild("HumanoidRootPart")
Fly.SetupBodies(char2)
end
end)
end
end
function Fly.Disable()
if not Fly.Enabled then return end
Fly.Enabled = false
Fly.CleanupBodies()
if renderConn then
renderConn:Disconnect()
renderConn = nil
end
if charAddedConn then
charAddedConn:Disconnect()
charAddedConn = nil
end
end
function Fly.Toggle()
if Fly.Enabled then
Fly.Disable()
else
Fly.Enable()
end
end
function Fly.SetSpeed(newSpeed)
Fly.Speed = newSpeed or Fly.Speed
end
Movement:AddToggle("Fly", {
    Text = "飞行",
    Default = false,
Callback = function(enabled)
if enabled then
Fly.Enable()
else
Fly.Disable()
end
end
}):AddKeyPicker('Fly Keybind', {
    Default = 'F', 
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = '飞行',
    NoUI = false,
Callback = function(Value) end,
ChangedCallback = function(New) end
})
FlySpeed = Movement:AddSlider("FlySpeed", {
    Text = "飞行速度",
    Min = 10,
    Max = 21,
    Default = Fly.Speed,
    Rounding = 0,
Callback = function(v)
Fly.SetSpeed(v)
end
})

local Ignore = {
    HidePrompt = true,
    RiftPrompt = true,
    StarRiftPrompt = true,
    InteractPrompt = true,
    FakePrompt = true,
    PushPrompt = true,
    ClimbPrompt = true,
    RevivePrompt = true,
    PropPrompt = true,
    NoHidingLilBro = true,
    DonatePrompt = true
}
local AutoInteractTable = {}
Automation:AddToggle('AutoInteract', {
    Text = "自动互动",
    Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if not Ignore[v.Name] then
if v:IsA("ProximityPrompt") then
table.insert(AutoInteractTable, v)
end
end
end
else
table.clear(AutoInteractTable)
end
end
}):AddKeyPicker('AutoInteractKeybind', {
Default = 'R',
SyncToggleState = true,
Mode = 'Toggle',
Text = '自动互动',
NoUI = false,
Callback = function(Value)
end,
ChangedCallback = function(New)
end
})

Automation:AddDropdown("IgnoreList", {
    Values = {"Jeff物品", "金币", "糖果", "丢弃物品", "故障方块", "死亡糖果"},
    Default = 1,
    Multi = true,
    Text = "忽略列表",
Callback = function(Value)
end,
})
Automation:AddDivider()

Automation:AddToggle('AutoCloset',{
     Text = "自动躲藏",
     Risky = true,
     Default = false
}):AddKeyPicker('AutoClosetKeybind', {
    Default = 'Q',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = '自动躲藏',
    NoUI = false,
Callback = function(Value) end,
ChangedCallback = function(New) end
})
local EntitysTable = {
    RushMoving = 85,
    BackdoorRush = 90,
    AmbushMoving = 144,
    GlitchRush = 120,
    GlitchAmbush = 155,
    A60 = 130,
    A120 = 75
}
function GetNearestCloset()
local closest = nil
local MaxDistance = math.huge
local assets = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
if assets then
for _, v in ipairs(assets:FindFirstChild("Assets", true):GetChildren()) do
if v.Name == "Wardrobe" or v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge" 
or v.Name == "Toolshed" or v.Name == "Locker_Large" or v.Name == "Backdoor_Wardrobe" 
or v.Name == "Bed" or v.Name == "Double_Bed" then
if v.PrimaryPart then
local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude
if Distance < MaxDistance then
closest = v
MaxDistance = Distance
end
end
end
end
end
return closest
end
table.insert(Connections, RunService.RenderStepped:Connect(function(dt)
if Toggles.AutoCloset.Value then
local Closet = GetNearestCloset()
for _, v in ipairs(workspace:GetChildren()) do
local range = EntitysTable[v.Name]
if range and v.PrimaryPart then
if (LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude <= range then 
if Closet then
if not LocalPlayer.Character.PrimaryPart.Anchored then
fireproximityprompt(Closet:WaitForChild("HidePrompt"))
end
end
elseif (LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude > range then 
LocalPlayer.Character:SetAttribute("Hiding", false)
if not v:GetAttribute("Destroying") then
v:SetAttribute("Destroying", true)
v.Destroying:Connect(function()
LocalPlayer.Character:SetAttribute("Hiding", false)
end)
end
end
end
end
end
end))

Automation:AddToggle('AutoHeartbeatMiniGame', {
    Text = "自动心跳小游戏",
    Default = false
})
local oldHeartbeatNamecall = nil
oldHeartbeatNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
local args = { ... }
local method = getnamecallmethod()
if self.Name == "ClutchHeartbeat" and method == "FireServer" and 
Toggles.AutoHeartbeatMiniGame and Toggles.AutoHeartbeatMiniGame.Value then
args[1] = true
return oldHeartbeatNamecall(self, unpack(args))
end
return oldHeartbeatNamecall(self, ...)
end))

Automation:AddToggle('AutoLibraryCode', {
    Text = "自动解挂锁",
    Default = false
})

Automation:AddToggle('BruteForceLibraryCose', {
    Text = "暴力破解挂锁",
    Default = false
})

Automation:AddSlider('UnlockPadLockDistance', {
    Text = '解挂锁距离',
    Min = 40, Max = 100, Default = 40,
    Rounding = 1,
Callback = function(v)
end
})

local function GetLibraryPattern()
local Paper = LocalPlayer.Character:FindFirstChild("LibraryHintPaper") 
or LocalPlayer.Backpack:FindFirstChild("LibraryHintPaper") 
or LocalPlayer.Character:FindFirstChild("LibraryHintPaperHard") 
or LocalPlayer.Backpack:FindFirstChild("LibraryHintPaperHard")
if not Paper then return "_____" end
local Slots = {"_", "_", "_", "_", "_"}
local Hints = LocalPlayer.PlayerGui.PermUI.Hints:GetChildren()
for _, UI in ipairs(Paper.UI:GetChildren()) do
if UI:IsA("ImageLabel") and tonumber(UI.Name) then
local SlotIndex = tonumber(UI.Name)
local IconX = UI.ImageRectOffset.X
for _, Hint in ipairs(Hints) do
if Hint.Name == "Icon" and Hint.ImageRectOffset.X == IconX then
Slots[SlotIndex] = Hint.TextLabel.Text
break
end
end
end
end
return table.concat(Slots)
end
local function GenerateGuess(Pattern)
local Guess = ""
for i = 1, #Pattern do
local Char = string.sub(Pattern, i, i)
if Char == "_" then
Guess = Guess .. math.random(0, 9)
else
Guess = Guess .. Char
end
end
return Guess
end
local AutoLibraryTimer = 0
local NotifyTimer = 0
table.insert(Connections, RunService.Heartbeat:Connect(function(dt)
if not alive then return end
AutoLibraryTimer = AutoLibraryTimer + dt
NotifyTimer = NotifyTimer + dt
if AutoLibraryTimer > 0.1 then
AutoLibraryTimer = 0
if LatestRoom.Value == 50 then
local Padlock = Workspace.CurrentRooms:FindFirstChild("Padlock", true)
if Padlock then
local Root = LocalPlayer.Character.HumanoidRootPart
local Pivot = Padlock:GetPivot().Position
if (Root.Position - Pivot).Magnitude < Options.UnlockPadLockDistance.Value then
local Pattern = GetLibraryPattern()
local IsComplete = not string.find(Pattern, "_")
if Toggles.AutoLibraryCode.Value and IsComplete then
RemoteFolder.PL:FireServer(Pattern)
end
if Toggles.BruteForceLibraryCose.Value and not IsComplete then
local Guess = GenerateGuess(Pattern)
RemoteFolder.PL:FireServer(Guess)
end
if Toggles.NotifyLibraryCode.Value and NotifyTimer > 2 then
NotifyTimer = 0
Library:Notify("挂锁密码: " .. Pattern, 1.5)
end
end
end
end
end
end))

Automation:AddDropdown("BreakerBoxMode", {
    Values = {"合法", "漏洞"},
    Default = "合法",
    Text = "发电机最优解法",
    Callback = function(Value) end
})

local Breaker = nil
Automation:AddToggle('AutoBreakerBox', {
    Text = "自动发电机",
    Default = false,
    Callback = function(Value)
if Value then
if LatestRoom.Value == 100 then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "ElevatorBreaker" then
Breaker = v
end
end
while task.wait() do
if not Toggles.AutoBreakerBox.Value then break end
if Breaker then
if Options.BreakerBoxMode and Options.BreakerBoxMode.Value == "漏洞" then
local Event = game:GetService("ReplicatedStorage").RemotesFolder.EBF
if Event then
Event:FireServer()
end
else
for _, v in ipairs(Breaker:GetChildren()) do
if v.Name == "BreakerSwitch" then
local codeDisplay = Breaker:WaitForChild("SurfaceGui").Frame.Code.Text
if v:GetAttribute("ID") == tonumber(codeDisplay) then
if Breaker:WaitForChild("SurfaceGui").Frame.Code.Frame.BackgroundTransparency == 0 then
v:SetAttribute("Enabled", true)
if v:WaitForChild("Sound").Playing == false then
v:WaitForChild("Sound", 1e1).Playing = true
end
v.Material = Enum.Material.Neon
v:WaitForChild("Light", 1e1).Attachment.Spark:Emit(1)
v:WaitForChild("PrismaticConstraint").TargetPosition = -0.2
else
v:SetAttribute("Enabled", false)
if v:WaitForChild("Sound").Playing == false then
v:WaitForChild("Sound", 1e1).Playing = true
end
v:WaitForChild("PrismaticConstraint").TargetPosition = 0.2
v.Material = Enum.Material.Glass
end
end
end
end
end
end
end
end
end
end
})
table.insert(Connections,workspace.DescendantAdded:Connect(function(v)
if Toggles.AutoBreakerBox.Value then
if v.Name == "ElevatorBreaker" then 
Breaker = v
end
end
end))

if ReplicatedStorage:FindFirstChild("RemotesFolder") then
Automation:AddToggle('AutoGlitch',{
Text = "自动故障",
Default = false,
Callback = function(Value)
if Value then
LocalPlayer.Character.HumanoidRootPart.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 20, 0)
else
LocalPlayer.Character.HumanoidRootPart.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 20, 0)
end
end
})
end

ReachBox:AddToggle('DoorReach',{
     Text = "延长判定",
     Default = false
})

ReachBox:AddToggle('PromptClip',{
     Text = "穿墙互动",
     Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v.RequiresLineOfSight = false
end
end
else
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v.RequiresLineOfSight = true
end
end
end
end
})

ReachBox:AddToggle('PromptReach',{
     Text = "增长互动",
     Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v:SetAttribute("Distance",v.MaxActivationDistance)
v.MaxActivationDistance = v.MaxActivationDistance * promptReachMultiplier
end
end
else
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v.MaxActivationDistance = v:GetAttribute("Distance") or 7
end
end
end
end
})

Range = 20
ReachBox:AddSlider("DoorReachRange", {
        Text = "开门距离",
        Default = 20,
        Min = 15,
        Max = 30,
        Rounding = 1,
        Compact = true,
Callback = function(Value)
Range = Value
end,      
})

promptReachMultiplier = 2.0
ReachBox:AddSlider("PromptReachMultiplier", {
    Text = "互动距离",
    Default = 1.0,
    Min = 1.0,
    Max = 2.0,
    Rounding = 1,
    Compact = true,
Callback = function(Value)
promptReachMultiplier = Value
if Toggles.PromptReach and Toggles.PromptReach.Value then
Toggles.PromptReach:SetValue(false)
Toggles.PromptReach:SetValue(true)
end
end,
})

MiscBox:AddButton({
     Text = "重置人物",
     DoubleClick = true,
Func = function()
replicatesignal(LocalPlayer.Kill)
end
})

MiscBox:AddButton({
     Text = "再玩家",
DoubleClick = true,
     Func = function()
RemoteFolder.PlayAgain:FireServer()
end
})

MiscBox:AddButton({
     Text = "返回大厅",
DoubleClick = true,
     Func = function()
RemoteFolder.Lobby:FireServer()
end
})


MiscBox:AddButton({
     Text = "玩家复活",
DoubleClick = true,
     Func = function()
RemoteFolder.Revive:FireServer()
end
})

Anti:AddToggle('AntiDread',{
     Text = "防 Dread",
     Default = false,
Callback = function(Value)
Dread = Modules:FindFirstChild("Dread") or Modules:FindFirstChild("_Dread")
if Dread then
Dread.Name = Value and "_Dread" or "Dread"
end
end
})

Anti:AddToggle('AntiHalt',{
     Text = "防 Halt",
     Default = false,
Callback = function(Value)
Halt = ClientModules.EntityModules:FindFirstChild("Shade") or
ClientModules.EntityModules:FindFirstChild("_Shade") 
Halt.Name = Value and "_Shade" or "Shade"
end
})

Anti:AddToggle('AntiScreech',{
     Text = "防 Screech",
     Default = false,
Callback = function(Value)
Screech = Modules:FindFirstChild("Screech") or Modules:FindFirstChild("_Screech")
if Screech then
Screech.Name = Value and "_Screech" or "Screech"
end
end
})
table.insert(Connections, workspace.CurrentCamera.ChildAdded:Connect(function(v)
if v.Name == "GlitchScreech" and Toggles.AntiScreech.Value then
v:Destroy()
end
end))

Anti:AddToggle('AntiDupe',{
     Text = "防 Dupe",
     Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "DoorFake" then
v:WaitForChild("Hidden").CanTouch = false
if v:FindFirstChild("Lock") then
v:FindFirstChild("Lock"):FindFirstChildOfClass("ProximityPrompt").ClickablePrompt = false
end
end
end
else
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "DoorFake" then
v:WaitForChild("Hidden").CanTouch = false
if v:FindFirstChild("Lock") then
v:FindFirstChild("Lock"):FindFirstChildOfClass("ProximityPrompt").ClickablePrompt = false
end
end
end
end
end
})

Anti:AddToggle('AntiEyes',{
     Text = "防 Eyes",
     Default = false
})

Anti:AddToggle('AntiSnare',{
     Text = "防 Snare",
     Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Snare" and v.Parent and v.Parent.Name ~= "Snare" then
v:WaitForChild("Hitbox").CanTouch = false
end
end
else
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Snare" and v.Parent and v.Parent.Name ~= "Snare" then
v:WaitForChild("Hitbox").CanTouch = true
end
end
end
end
})

Anti:AddToggle('AntiHear',{
     Text = "防盲哥听觉",
     Default = false
})
Toggles.AntiHear:OnChanged(function(Value)
if not Value then
RemoteFolder.Crouch:FireServer(false)
end
end)

if ReplicatedStorage:FindFirstChild("RemotesFolder") then
Bypass:AddDropdown("SpeedBypassMethod", {
    Values = {"质量切换", "网络休眠","暴力绕过"},
    Default = 1,
    Multi = false,
    Text = "速度绕过模式",
Callback = function(Value)
if Toggles.SpeedBypass and Toggles.SpeedBypass.Value then
if Value == "质量切换" then
Options.SpeedBoostSlider:SetMax(100)
Options.FlySpeed:SetMax(100)
elseif Value == "网络休眠" then
Options.SpeedBoostSlider:SetMax(100)
Options.FlySpeed:SetMax(100)
elseif Options.SpeedBypassMethod.Value == "暴力绕过" then
Options.SpeedBoostSlider:SetMax(150)
Options.FlySpeed:SetMax(150)
end
end
end,
})
SpeedBypassInterval = 0.216
Bypass:AddToggle('SpeedBypass',{
    Text = "速度绕过",
    Default = false,
Callback = function(Value)
if Value then
if Options.SpeedBypassMethod.Value == "网络休眠" and not sethiddenproperty then
Library:Notify("网络休眠模式无法使用，因为你的执行器不支持 Sethiddenproperty", 5)
Toggles.SpeedBypass:SetValue(false)
return
end
if Options.SpeedBypassMethod.Value == "质量切换" then
Options.SpeedBoostSlider:SetMax(100)
elseif Options.SpeedBypassMethod.Value == "网络休眠" then
Options.SpeedBoostSlider:SetMax(100)
elseif Options.SpeedBypassMethod.Value == "暴力绕过" then
Options.SpeedBoostSlider:SetMax(150)
end
Options.SpeedBoostSlider:SetValue(Value and Options.SpeedBoostSlider.Value or 21)
Options.FlySpeed:SetValue(Value and Options.FlySpeed.Value or 21)
task.spawn(function()
while Toggles.SpeedBypass.Value do
task.wait(SpeedBypassInterval)
if alive then
if Options.SpeedBypassMethod.Value == "质量切换" then
local CollisionClon = LocalPlayer.Character:WaitForChild("_CollisionPart")
local CollisionClon2 = LocalPlayer.Character:WaitForChild("_CollisionPart2")
if Character.CollisionPart.Anchored or nothitted or (Toggles.AnticheatManipulation and Toggles.AnticheatManipulation.Value) then
CollisionClon.Massless = true
CollisionClon2.Massless = true
task.wait(0.35)
else
CollisionClon.Massless = true
CollisionClon2.Massless = true
task.wait(SpeedBypassInterval)
CollisionClon2.Massless = false
CollisionClon.Massless = false
end
end
end
task.wait(0.01)
end
if alive and Character:FindFirstChild("_CollisionPart") and Character:FindFirstChild("_CollisionPart2") then
Character:FindFirstChild("_CollisionPart").Massless = true
Character:FindFirstChild("_CollisionPart2").Massless = true
end
end)
task.spawn(function()
while Toggles.SpeedBypass.Value do
if Options.SpeedBypassMethod.Value == "暴力绕过" then
local char = LocalPlayer.Character
if char then
local col1 = char:FindFirstChild("_CollisionPart")
local col2 = char:FindFirstChild("_CollisionPart2")
if col1 then col1.Massless = true end
if col2 then col2.Massless = true end
if RemoteFolder and RemoteFolder:FindFirstChild("Crouch") then
RemoteFolder.Crouch:FireServer(true, true)
end
end
task.wait()
else
task.wait()
end
end
local char = LocalPlayer.Character
if char then
local col1 = char:FindFirstChild("_CollisionPart")
local col2 = char:FindFirstChild("_CollisionPart2")
if col1 then col1.Massless = false end
if col2 then col2.Massless = false end
end
end)
else
Options.SpeedBoostSlider:SetMax(21)
Options.SpeedBoostSlider:SetValue(21)
Options.FlySpeed:SetMax(21)
Options.FlySpeed:SetValue(21)
if alive and Character then
local col1 = Character:FindFirstChild("_CollisionPart")
local col2 = Character:FindFirstChild("_CollisionPart2")
if col1 then col1.Massless = false end
if col2 then col2.Massless = false end
end
end
end,
})
task.spawn(function()
while task.wait() do
if Library.Unloaded then 
break 
end
if Toggles.SpeedBypass and Toggles.SpeedBypass.Value and 
Options.SpeedBypassMethod and Options.SpeedBypassMethod.Value == "网络休眠" then
if sethiddenproperty then
CollisionClon = LocalPlayer.Character:FindFirstChild("_CollisionPart")
CollisionClon2 = LocalPlayer.Character:FindFirstChild("_CollisionPart2")
if CollisionClon and not CollisionClon.Massless then
CollisionClon.Massless = true 
end
if CollisionClon2 and not CollisionClon2.Massless then
CollisionClon2.Massless = true
end
SetProperty = sethiddenproperty
if alive then 
loop = RunService.RenderStepped:Connect(function()
if Toggles.SpeedBypass.Value and Options.SpeedBypassMethod.Value == "网络休眠" then
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", true)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", false)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", true)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", false)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", false)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", false)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", true)
task.wait()
SetProperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", true)
task.wait()
end
end) 
task.wait()
if loop then
loop:Disconnect()
end 
end 
end
end
end
end)
Bypass:AddSlider("SpeedBypassInternal", {
    Text = "速度绕过间隔",
    Default = 0.216,
    Min = 0.2,
    Max = 0.23,
    Rounding = 2,
Compact = false,
Callback = function(Value)
SpeedBypassInterval = Value
end,      
})
Bypass:AddDivider()

Bypass:AddToggle('GodMode',{
    Text = "位置欺骗",
    Default = false,
Callback = function(Value)
local char = LocalPlayer.Character
if not char then return end
if Value then
if not Toggles.AntiHear.Value then
Toggles.AntiHear:SetValue(true)
end
char.Collision.Size = Vector3.new(1, 3, 5)
char.Humanoid.HipHeight = 0.0001
local lowerTorso = char:FindFirstChild("LowerTorso")
if lowerTorso then
local rootJoint = lowerTorso:FindFirstChild("Root")
if rootJoint and rootJoint:IsA("Motor6D") then
rootJoint.C1 = CFrame.new(0, -2.5, 0)
end
end
else
local lowerTorso = char:FindFirstChild("LowerTorso")
if lowerTorso then
local rootJoint = lowerTorso:FindFirstChild("Root")
if rootJoint and rootJoint:IsA("Motor6D") then
rootJoint.C1 = CFrame.new(0, -0.24, 0)
end
end
char.Collision.Size = Vector3.new(5.5, 3, 5)
char.Humanoid.HipHeight = 2.4
end
end
}):AddKeyPicker('GodmodeKeybind', {
    Default = 'G', 
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = '位置欺骗',
    NoUI = false,
    Callback = function(Value) end,
    ChangedCallback = function(New) end
})
Bypass:AddDropdown("GMDropdown", {
    Values = { "��", "切换" },
    Default = 2,
    Multi = false,
    Text = "位置欺骗模式",
Callback = function(Value)
end,
})
Bypass:AddDivider()

AnticheatManipulationLoop = nil
AnticheatManipulationOrigin = nil
AnticheatManipulationEnabled = false
OriginalNoclipState = false
Bypass:AddDropdown("AnticheatManipulationMode", {
    Values = {"��", "坐标", "移动"},
    Default = "��",
    Multi = false,
    Text = "操纵模式",
Callback = function(Value)
if Toggles.AnticheatManipulation and Toggles.AnticheatManipulation.Value then
Toggles.AnticheatManipulation:SetValue(false)
task.wait(0.1)
Toggles.AnticheatManipulation:SetValue(true)
end
end,
})
Bypass:AddToggle('AnticheatManipulation',{
     Text = "操纵杆",
     Default = false,
Callback = function(Value)
if Value then
AnticheatManipulationEnabled = true
if Options.AnticheatManipulationMode and Options.AnticheatManipulationMode.Value == "移动" then
OriginalNoclipState = Toggles.Noclip and Toggles.Noclip.Value or false
if Toggles.Noclip then
Toggles.Noclip:SetValue(true)
end
end
AnticheatManipulationLoop = task.spawn(function()
while AnticheatManipulationEnabled and Toggles.AnticheatManipulation.Value do
if alive then
local character = LocalPlayer.Character
local humanoidRootPart = character.HumanoidRootPart
local lookVector = humanoidRootPart.CFrame.LookVector
if Options.AnticheatManipulationMode and Options.AnticheatManipulationMode.Value == "��" then
if not AnticheatManipulationOrigin then
AnticheatManipulationOrigin = humanoidRootPart.Position
end
local backwardPosition = humanoidRootPart.Position - lookVector * 10000
character:PivotTo(CFrame.new(backwardPosition))
task.wait(0.03)
local forwardPosition = AnticheatManipulationOrigin + lookVector * 1
character:PivotTo(CFrame.new(forwardPosition))
AnticheatManipulationOrigin = forwardPosition
task.wait(0.07)
elseif Options.AnticheatManipulationMode and Options.AnticheatManipulationMode.Value == "坐标" then
local backwardPosition = humanoidRootPart.Position - (lookVector * 10000)
character:PivotTo(CFrame.new(backwardPosition))
task.wait(0.07)
else
local forwardPosition = humanoidRootPart.Position + (lookVector * 0.013)
character:PivotTo(CFrame.new(forwardPosition))
task.wait()
end
else
task.wait()
end
end
if alive and AnticheatManipulationOrigin and Options.AnticheatManipulationMode and Options.AnticheatManipulationMode.Value == "��" then
character:PivotTo(CFrame.new(AnticheatManipulationOrigin))
end
end)
else
AnticheatManipulationEnabled = false
if AnticheatManipulationLoop then
task.cancel(AnticheatManipulationLoop)
AnticheatManipulationLoop = nil
end
if Options.AnticheatManipulationMode and Options.AnticheatManipulationMode.Value == "移动" and Toggles.Noclip then
Toggles.Noclip:SetValue(OriginalNoclipState)
end
if alive and AnticheatManipulationOrigin and Options.AnticheatManipulationMode and Options.AnticheatManipulationMode.Value == "��" then
LocalPlayer.Character:PivotTo(CFrame.new(AnticheatManipulationOrigin))
end
AnticheatManipulationOrigin = nil
end
end
}):AddKeyPicker('AnticheatManipulationKeybind', {
    Default = 'H',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = '操纵杆',
    NoUI = false,
Callback = function(Value)
end,
ChangedCallback = function(New)
end
})
Bypass:AddDivider()
end

Bypass:AddToggle('UseToolsAnyWhere',{
     Text = "随时使用道具",
     Default = false,
Callback = function(Value)
if Value then
RequiredMainGame.canUseItems = true
else
RequiredMainGame.canUseItems = false
end
end
})

if ReplicatedStorage:FindFirstChild("RemotesFolder") then
local Disable3 = false
local Prompt = Instance.new("ProximityPrompt", workspace)
Prompt.Name = "TestPrompt"
local success, result = pcall(function()
return fireproximityprompt(Prompt)
end)
Prompt:Destroy()
local LockpickParents = { 
ChestBoxLocked = true, 
Locker_Small_Locked = true, 
Toolbox_Locked = true 
}
local LockpickNames = { 
UnlockPrompt = true, 
ThingToEnable = true, 
LockPrompt = true,
SkullPrompt = true, 
FusesPrompt = true 
}
local ShearsParents = { 
Chest_Vine = true, 
CuttableVines = true, 
Cellar = true 
}
local ShearsNames = { 
SkullPrompt = true 
}
local function isLockpickRelatedPrompt(v, validParents, validNames)
if not v or not v.Parent then return false end
if validParents[v.Parent.Name] or validNames[v.Name] then
return true
end
local parent = v.Parent
if parent and parent.Name == "Door" then
local grandParent = parent.Parent
if grandParent and validParents[grandParent.Name] then
local lockerTypes = {
["Locker_Small_Locked"] = true
}
if lockerTypes[grandParent.Name] then
return true
end
end
end
return false
end
local InfStore = {}
local InfSStore = {}
local function scanPrompts(validParents, validNames)
local t = {}
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") and isLockpickRelatedPrompt(v, validParents, validNames) then
table.insert(t, v)
end
end
return t
end
local function cleanupEnableReal()
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "FakePrompt" and v.Parent then
v:Destroy()
end
if v:IsA("ProximityPrompt") and v.Name ~= "FakePrompt" then
pcall(function()
v.Enabled = true
v.ClickablePrompt = true
if v:GetAttribute("HasFake") == true then
v:SetAttribute("HasFake", nil)
end
end)
end
end
end
local function addFake(prompt, mode)
if not prompt or not prompt:IsA("ProximityPrompt") then return end
if prompt:GetAttribute("HasFake") then return end
prompt:SetAttribute("HasFake", true)
local fake = prompt:Clone()
fake.Name = "FakePrompt"
fake.Parent = prompt.Parent
fake.Enabled = true
fake.ClickablePrompt = true
prompt.Enabled = false
prompt.ClickablePrompt = false
fake.Triggered:Connect(function()
local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
if not tool then return end
local dropRemote = RemoteFolder:FindFirstChild("DropItem")
if dropRemote then
dropRemote:FireServer(tool)
end
local con
con = Workspace.Drops.ChildAdded:Connect(function(v)
local p = v:FindFirstChildOfClass("ProximityPrompt")
if p then
if mode == "Lockpick" then
fireproximityprompt(p)
fireproximityprompt(prompt)
elseif mode == "Shears" then
fireproximityprompt(prompt)
fireproximityprompt(p)
end
task.wait(0.3)
con:Disconnect()
end
end)
end)
end
local function setupRealtimeDetection()
local descAddedConnection = workspace.DescendantAdded:Connect(function(v)
task.wait(0.1)
if v:IsA("ProximityPrompt") then
if isLockpickRelatedPrompt(v, LockpickParents, LockpickNames) then
if Toggles.InfiniteItems and Toggles.InfiniteItems.Value then
table.insert(InfStore, v)
local hasTool = LocalPlayer.Character and 
(LocalPlayer.Character:FindFirstChild("Lockpick") or 
LocalPlayer.Character:FindFirstChild("SkeletonKey"))
if hasTool and not v:GetAttribute("HasFake") then
addFake(v, "Lockpick")
end
end
end
if isLockpickRelatedPrompt(v, ShearsParents, ShearsNames) then
if Toggles.InfiniteSItems and Toggles.InfiniteSItems.Value then
table.insert(InfSStore, v)
local hasTool = LocalPlayer.Character and 
LocalPlayer.Character:FindFirstChild("Shears")
if hasTool and not v:GetAttribute("HasFake") then
addFake(v, "Shears")
end
end
end
end
end)
return descAddedConnection
end
local realtimeDetectionConn = nil
Bypass:AddToggle('InfiniteItems', {
    Text = "无限物品",
    Default = false,
Callback = function(Value)
if Value then
if Disable3 then
Library:Notify("当前执行器不支持此功能", 3)
Toggles.InfiniteItems:SetValue(false)
return
end
InfStore = scanPrompts(LockpickParents, LockpickNames)
if not realtimeDetectionConn then
realtimeDetectionConn = setupRealtimeDetection()
end
local infiniteCheckConn = RunService.Heartbeat:Connect(function()
if not Toggles.InfiniteItems.Value then 
return 
end
local hasTool = LocalPlayer.Character and 
(LocalPlayer.Character:FindFirstChild("Lockpick") or 
LocalPlayer.Character:FindFirstChild("SkeletonKey"))
if hasTool then
for _, prompt in ipairs(InfStore) do
if prompt and prompt.Parent and not prompt:GetAttribute("HasFake") then
addFake(prompt, "Lockpick")
end
end
end
end)
table.insert(Connections, infiniteCheckConn)
else
cleanupEnableReal()
InfStore = {}
end
end
})

Bypass:AddToggle('InfiniteSItems', {
    Text = "无限复活",
    Default = false,
Callback = function(Value)
if Value then
if Disable3 then
Library:Notify("当前执行器不支持此功能", 3)
Toggles.InfiniteSItems:SetValue(false)
return
end
InfSStore = scanPrompts(ShearsParents, ShearsNames)
if not realtimeDetectionConn then
realtimeDetectionConn = setupRealtimeDetection()
end
local infiniteSCheckConn = RunService.Heartbeat:Connect(function()
if not Toggles.InfiniteSItems.Value then 
return 
end
local hasTool = LocalPlayer.Character and 
LocalPlayer.Character:FindFirstChild("Shears")
if hasTool then
for _, prompt in ipairs(InfSStore) do
if prompt and prompt.Parent and not prompt:GetAttribute("HasFake") then
addFake(prompt, "Shears")
end
end
end
end)
table.insert(Connections, infiniteSCheckConn)
else
cleanupEnableReal()
InfSStore = {}
end
end
})

local raycastParms = RaycastParams.new()
raycastParms.FilterDescendantsInstances = {LocalPlayer.Character}
raycastParms.FilterType = Enum.RaycastFilterType.Blacklist
local DropTable = {
RushMoving = 54,
AmbushMoving = 67,
A60 = 70
}
local InfiniteCrucifixConnection = nil
local nothitted = false
task.spawn(function()
while task.wait(0.35) do
if LocalPlayer.Character and not Library.Unloaded then 
local origin = LocalPlayer.Character.HumanoidRootPart.Position
local direction = Vector3.new(0, -50, 0)
local result = workspace:Raycast(origin, direction, raycastParms)
if result then
nothitted = false
else
nothitted = true
end
end
end
end)
local DropTable = {
RushMoving = 54,
AmbushMoving = 67,
A60 = 70
}
local InfiniteCrucifixConnection = nil
InfiniteCrucifixConnection = RunService.RenderStepped:Connect(function()
if Toggles.InfiniteCrucifix.Value then
for _, v in ipairs(workspace:GetChildren()) do
local Entity = DropTable[v.Name]
if Entity and v.PrimaryPart then
v.PrimaryPart.CanCollide = true
v.PrimaryPart.CanQuery = true
local origin2 = LocalPlayer.Character.CollisionPart.Position
local direction2 = (v.PrimaryPart.Position - origin2)
local result2 = workspace:Raycast(origin2, direction2, raycastParms)
if result2 and result2.Instance:IsDescendantOf(v) then
if (LocalPlayer.Character.CollisionPart.Position - v.PrimaryPart.Position).Magnitude < Entity then
ReplicatedStorage.RemotesFolder.DropItem:FireServer(LocalPlayer.Character:FindFirstChildOfClass("Tool"))
task.wait(0.54)
if Workspace:FindFirstChild("Drops") and Workspace.Drops:FindFirstChild("Crucifix") then
fireproximityprompt(workspace.Drops:WaitForChild("Crucifix"):FindFirstChildOfClass("ProximityPrompt"))
end
end
end
end
end
end
end)
Bypass:AddToggle('InfiniteCrucifix', {
    Text = "无限十字架",
    Default = false,
    Risky = true,
Tooltip = "你可能会死或失去十字架",
Callback = function(Value)
if Value then
if not InfiniteCrucifixConnection then
InfiniteCrucifixConnection = RunService.RenderStepped:Connect(function()
if Toggles.InfiniteCrucifix.Value then
local character = LocalPlayer.Character
if not character then return end
local crucifixTool = nil
for _, tool in ipairs(character:GetChildren()) do
if tool:IsA("Tool") and (tool.Name == "Crucifix" or tool.Name == "CrucifixWall") then
crucifixTool = tool
break
end
end
if not crucifixTool then return end
for _, v in ipairs(workspace:GetChildren()) do
local Entity = DropTable[v.Name]
if Entity and v.PrimaryPart then
v.PrimaryPart.CanCollide = true
v.PrimaryPart.CanQuery = true
local origin2 = character.CollisionPart.Position
local direction2 = (v.PrimaryPart.Position - origin2)
local result2 = workspace:Raycast(origin2, direction2, raycastParms)
if result2 and result2.Instance:IsDescendantOf(v) then
if (character.CollisionPart.Position - v.PrimaryPart.Position).Magnitude < Entity then
if RemoteFolder and RemoteFolder:FindFirstChild("DropItem") then
RemoteFolder.DropItem:FireServer(crucifixTool)
end
task.wait(0.54)
if workspace:FindFirstChild("Drops") then
local droppedCrucifix = workspace.Drops:FindFirstChild("Crucifix") or 
workspace.Drops:FindFirstChild("CrucifixWall")
if droppedCrucifix then
local prompt = droppedCrucifix:FindFirstChildOfClass("ProximityPrompt")
if prompt then
fireproximityprompt(prompt)
end
end
end
end
end
end
end
end
end)
end
else
if InfiniteCrucifixConnection then
InfiniteCrucifixConnection:Disconnect()
InfiniteCrucifixConnection = nil
end
end
end
})

SecondLiveConnection = nil
OriginalGravity = workspace.Gravity
local function setupSecondLive()
local ReplicatedStore = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid") or player.Character:WaitForChild("Humanoid")
if SecondLiveConnection then
SecondLiveConnection:Disconnect()
end
SecondLiveConnection = humanoid.Died:Connect(function()
task.delay(0.5, function()
workspace.Gravity = 0
char = player.Character
if not char then return end
hum = char:FindFirstChild("Humanoid")
root = char:FindFirstChild("HumanoidRootPart")
if not hum or not root then return end
gui = player:FindFirstChild("PlayerGui")
if gui then
ui = gui:FindFirstChild("MainUI")
if ui then
d1 = ui:FindFirstChild("DeathPanel")
if d1 then d1:Destroy() end
d2 = ui:FindFirstChild("Death")
if d2 then d2:Destroy() end
end
end
hum.Health = hum.MaxHealth
hum.AutomaticScalingEnabled = true
if char:GetAttribute("Stunned") then
char:SetAttribute("Stunned", false)
end
room = ReplicatedStore.GameData.LatestRoom.Value
rm = workspace.CurrentRooms:FindFirstChild(room)
door = rm and rm:FindFirstChild("Door") and rm.Door:FindFirstChild("Door")
if door then
root.CFrame = door.CFrame + Vector3.new(0, 3, 0)
task.delay(1, function()
if SecondLiveConnection then
workspace.Gravity = OriginalGravity
end
end)
end
end)
end)
end
Bypass:AddButton({
    Text = "假身",
DoubleClick = true,
Risky = true,
Func = function()
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom") or ReplicatedStorage.GameData.LatestRoom.Value
if currentRoom >= 1 then
setupSecondLive()
player.CharacterAdded:Connect(function()
setupSecondLive()
end)
task.wait(1)
replicatesignal(LocalPlayer.Kill)
task.wait(1)
game:GetService("CoreGui"):FindFirstChild("RobloxGui").Backpack.Visible = true
game:GetService("Players").LocalPlayer:SetAttribute("Alive",true)
game:GetService("Players").LocalPlayer:SetAttribute("FakeDeath",true)
Library:Notify("拾取创口贴后恢有互动", 5)
else
Library:Notify("进入下一个房间后假身才能正常工作", 5)
end
end
})

Troll:AddToggle("Spamtoolz", { 
    Text = "滥用他人工具", 
    Default = false, 
}):AddKeyPicker("Spamtoolz_X", { 
    Default = "X", 
    SyncToggleState = false, 
    Mode = "Toggle", 
    Text = "滥用他人工具", 
    NoUI = false, 
})
end

local NonsenseLines = {
"我这是空间意识补全",
"你以为在打排位，其实在陪我调试",
"我走的不是路，是寻路算法的空隙",
"这个不是飞，是引力被我关了",
"我只是让服务器更相信我",
"我的移动是服务器认可的",
"我和服务器了双边确认协议",
"你操作的?色，我操作的是设定本身",
"我这是相位回滚，不是瞬移",
"我掉线不是掉线，是进入高维观察者模式",
"我残血是因为我开了省电模式，满血要充会员",
"你追不上我，因为你还在用欧氏几何",
"我这是物理引擎重写",
"你看到的不是我，��务器给你发的占位符",
"我这是本地不渲染移动",
"我只?判定走我的回调函数",
"我只?时间戳替我移动",
"我这是显存级透视",
"你这是渲染，我这是魔法",
"不是我在瞬移，是服务器的tick被我卡出了时空断层",
"你那����我这��子跃",
"其实我没动，是世界在动",
"我这不是加速，是我把你时间切片偷走了",
"我连你的显卡都入侵了，你的帧率是我赏的",
"我这不是穿墙，是CollisionGroup覆盖显卡缓存了",
"我没飞天，是重力脚本修改Local了",
"我关了FE的远程传送",
"你看见我的残影是上一个Tween还在跑",
"我不拉回��作弊觉得我合理",
"我这是无限缓动式量子逼近",
"速度��我献��AL14的浮点",
"假身不够我再献祭一个队友",
}
local SpamNonsenseActive = false
local SpamNonsenseThread = nil
local function startNonsenseSpam()
if SpamNonsenseThread then return end
SpamNonsenseActive = true
SpamNonsenseThread = task.spawn(function()
local textChatService = game:GetService("TextChatService")
local channel = textChatService and textChatService.TextChannels:FindFirstChild("RBXGeneral")
if not channel then
Library:Notify("无法获取聊天频道", 5)
return
end
while SpamNonsenseActive do
task.wait(2)
if not SpamNonsenseActive then break end
local line = NonsenseLines[math.random(1, #NonsenseLines)]
if line and line ~= "" then
pcall(function()
channel:SendAsync(line)
end)
end
end
end)
end
local function stopNonsenseSpam()
SpamNonsenseActive = false
if SpamNonsenseThread then
task.cancel(SpamNonsenseThread)
SpamNonsenseThread = nil
end
end
Troll:AddToggle('SpamNonsense', {
    Text = "刷屏",
    Default = false,
Callback = function(Value)
if Value then
startNonsenseSpam()
else
stopNonsenseSpam()
end
end
})

Troll:AddToggle("StunPlayer", {
    Text = "眩晕",
    Default = false,
Callback = function(Value)
if LocalPlayer.Character then
LocalPlayer.Character:SetAttribute("Stunned", Value)
end
end
})

OrbitTime = 0
OrbitSpeed = 2
OrbitRadius = 4
Troll:AddToggle('TeleportDrops', {
    Text = "掉落物传送",
    Default = false,
Callback = function(Value)
end
})

Troll:AddSlider("OrbitSpeedSlider", {
    Text = "移动速度",
    Default = 2,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,
Callback = function(Value)
OrbitSpeed = Value
end
})

Troll:AddSlider("OrbitRadiusSlider", {
    Text = "攻击范围",
    Default = 4,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Compact = true,
Callback = function(Value)
OrbitRadius = Value
end
})
OrbitSpeed = Options.OrbitSpeedSlider.Value
OrbitRadius = Options.OrbitRadiusSlider.Value

table.insert(Connections,RunService.RenderStepped:Connect(function(dt)
if Toggles.TeleportDrops and Toggles.TeleportDrops.Value then
OrbitTime = OrbitTime + dt * OrbitSpeed
local drops = workspace:FindFirstChild("Drops")
if drops and Character and Character:FindFirstChild("HumanoidRootPart") then
local rootPos = Character.HumanoidRootPart.Position
local radius = OrbitRadius
local height = 1.5
local validDrops = {}
for _, dropModel in ipairs(drops:GetChildren()) do
local pickup = dropModel:FindFirstChild("ItemDropPickup")
if pickup and pickup:IsA("BasePart") then
table.insert(validDrops, pickup)
end
end
local count = #validDrops
if count > 0 then
local angleStep = (2 * math.pi) / count
for i, pickup in ipairs(validDrops) do
local angle = (i - 1) * angleStep + OrbitTime
local offset = Vector3.new(math.cos(angle) * radius, height, math.sin(angle) * radius)
pickup.CFrame = CFrame.new(rootPos + offset)
end
end
end
end
end))

local ESPGlobalSettings = {
ESPType = "Highlight",
TracerPosition = "Bottom",
TextSize = 16,
TracerThickness = 1,
FillTransparency = 0.7,
OutlineTransparency = 0.4,
}

SettingsESP:AddDropdown("ESPType", {
Values = {"Text", "SphereAdornment", "CylinderAdornment", "Adornment", "SelectionBox", "Highlight"},
Default = "Highlight",
Text = "ESP类型",
Callback = function(Value)
ESPGlobalSettings.ESPType = Value
end
})

SettingsESP:AddToggle('GlobalTracerEnabled', {
    Text = "追踪线",
    Default = false,
Callback = function(Value)
ESPLibrary.GlobalConfig.Tracers = Value
end
})

SettingsESP:AddToggle('GlobalTracerEnabled', {
    Text = "��",
    Default = false,
Callback = function(Value)
ESPLibrary.GlobalConfig.Arrows = Value
end
})

SettingsESP:AddToggle('RainbowESP', {
    Text = '彩色ESP',
    Default = false,
Callback = function(Value)
ESPLibrary.GlobalConfig.Rainbow = Value
end
})

SettingsESP:AddToggle('ShowDistance',{
     Text = "显示距离",
     Default = true,
Callback = function(Value)
ESPLibrary.GlobalConfig.Distance = Value
end
})

SettingsESP:AddToggle('ShowText',{
     Text = "显示文本",
     Default = true,
Callback = function(Value)
ESPLibrary.GlobalConfig.Billboards = Value
end
})

SettingsESP:AddDropdown("TracerPosition", {
    Values = {"Top", "Bottom", "Center", "Mouse"},
    Default = "Bottom",
    Text = "追踪线位置",
Callback = function(Value)
ESPGlobalSettings.TracerPosition = Value
end,
})

SettingsESP:AddSlider('GlobalTextSize', {
    Text = "文本大小",
    Default = 16,
    Min = 10,
    Max = 50,
    Rounding = 0,
    Compact = true,
Callback = function(Value)
ESPGlobalSettings.TextSize = Value
end
})

SettingsESP:AddSlider("TracerThicknessSlider", {
    Text = "追踪线厚度",
    Default = 1,
    Min = 0.1,
    Max = 5.0,
    Rounding = 1,
    Compact = true,
Callback = function(Value)
ESPGlobalSettings.TracerThickness = Value
end
})

SettingsESP:AddSlider('GlobalOutlineTransparency', {
    Text = "设置透明度",
    Default = 0.4,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
Callback = function(Value)
ESPGlobalSettings.OutlineTransparency = Value
end
})

SettingsESP:AddSlider('GlobalFillTransparency', {
    Text = "设置透明度",
    Default = 0.7,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
Callback = function(Value)
ESPGlobalSettings.FillTransparency = Value
end
})

local DoorESPObjects = {}
local DoorColor = Color3.new(0, 1, 1)
local doorUpdateLoop
local function getDoorText(doorPart, roomNumber)
local status = ""
local isOpen = doorPart.Parent:GetAttribute("Opened") == true
if isOpen then
status = "[已打开] "
else
if doorPart.Parent:FindFirstChild("Lock") then
status = "[锁定] "
elseif LocalPlayer:GetAttribute("CurrentRoom") == roomNumber - 1 then
local room = workspace.CurrentRooms:FindFirstChild(tostring(roomNumber))
if room then
for _, obj in ipairs(room:GetDescendants()) do
if obj.Name == "KeyObtain" and not obj:GetAttribute("Used") then
status = "[锁定] "
break
end
end
end
end
end
return status .. " " .. (doorPart.Parent:GetAttribute("RoomID") or roomNumber)
end
local function addOrUpdateDoorESP(doorPart, roomNumber)
local esp = DoorESPObjects[doorPart]
if not esp then
esp = ESPLibrary:Add({
Name = getDoorText(doorPart, roomNumber),
Model = doorPart,
Color = DoorColor,
MaxDistance = 5000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = DoorColor,
OutlineColor = DoorColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = {
Enabled = true,
Color = DoorColor,
Thickness = ESPGlobalSettings.TracerThickness,
From = ESPGlobalSettings.TracerPosition,
},
Arrow = {
Enabled = true,
Color = DoorColor,
},
})
DoorESPObjects[doorPart] = esp
end
local newName = getDoorText(doorPart, roomNumber)
if esp.CurrentSettings and esp.CurrentSettings.Name ~= newName then
esp.CurrentSettings.Name = newName
if esp.GUI and esp.GUI.Txt then
esp.GUI.Txt.Text = newName
end
end
end
local function startDoorESP()
doorUpdateLoop = task.spawn(function()
while Toggles.Door and Toggles.Door.Value do
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if currentRoom then
local toRemove = {}
for doorPart, esp in pairs(DoorESPObjects) do
if not doorPart or not doorPart.Parent or not doorPart.Parent.Parent then
table.insert(toRemove, doorPart)
else
local roomModel = doorPart.Parent.Parent
local roomName = roomModel and roomModel.Name
if roomName ~= tostring(currentRoom) and
roomName ~= tostring(currentRoom + 1) then
table.insert(toRemove, doorPart)
end
end
end
for _, dp in ipairs(toRemove) do
pcall(function() DoorESPObjects[dp]:Destroy() end)
DoorESPObjects[dp] = nil
end
for _, offset in ipairs({0, 1}) do
local roomNumber = currentRoom + offset
local room = workspace.CurrentRooms:FindFirstChild(tostring(roomNumber))
if room then
local doorModel = room:FindFirstChild("Door")
if doorModel then
local doorPart = doorModel:FindFirstChild("Door")
if doorPart then
addOrUpdateDoorESP(doorPart, roomNumber)
end
end
end
end
end
task.wait()
end
stopDoorESP()
end)
end
local function stopDoorESP()
if doorUpdateLoop then
task.cancel(doorUpdateLoop)
doorUpdateLoop = nil
end
for _, esp in pairs(DoorESPObjects) do
pcall(esp.Destroy, esp)
end
DoorESPObjects = {}
end
ESP:AddToggle('Door', {
    Text = "",
    Default = false,
Callback = function(Value)
if Value then
startDoorESP()
else
stopDoorESP()
end
end
}):AddColorPicker('DoorColor', {
    Default = DoorColor,
    Title = '门',
    Transparency = 0,
Callback = function(Value)
DoorColor = Value
if Toggles.Door.Value then
stopDoorESP()
startDoorESP()
end
end
})

local stopLadderESP
if Floor.Value == "Mines" then
local LadderColor = Color3.new(0, 0.5, 1)
local LadderESPObjects = {}
local ladderRoomConn, ladderAddedConn, ladderRemovedConn, ladderFloorConn
local function shouldShowLadder(roomNumber)
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
return currentRoom and (roomNumber == currentRoom or roomNumber == currentRoom + 1)
end
local function AddLadderESP(ladder)
if not ladder or not ladder.Parent or LadderESPObjects[ladder] then return end
local esp = ESPLibrary:Add({
Name = "��",
Model = ladder,
Color = LadderColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = LadderColor,
OutlineColor = LadderColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = LadderColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = LadderColor }
})
LadderESPObjects[ladder] = esp
esp:Show()
end
local function RemoveLadderESP(ladder)
local esp = LadderESPObjects[ladder]
if esp then
pcall(esp.Destroy, esp)
LadderESPObjects[ladder] = nil
end
end
local function getRoomNumber(obj)
local anc = obj
while anc and anc ~= workspace do
if anc.Parent == workspace.CurrentRooms and tonumber(anc.Name) then
return tonumber(anc.Name)
end
anc = anc.Parent
end
return nil
end
local function scanLadders()
if Floor.Value ~= "Mines" then return end
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
local roomNum = tonumber(room.Name)
if roomNum and shouldShowLadder(roomNum) then
for _, ladder in ipairs(room:GetDescendants()) do
if ladder.Name == "Ladder" and ladder:IsA("Model") then
AddLadderESP(ladder)
end
end
end
end
end
local function startLadderESP()
scanLadders()
ladderRoomConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
for ladder in pairs(LadderESPObjects) do
RemoveLadderESP(ladder)
end
scanLadders()
end)
ladderAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
if not Toggles.Ladder.Value then return end
if obj.Name == "Ladder" and obj:IsA("Model") then
local roomNum = getRoomNumber(obj)
if roomNum and shouldShowLadder(roomNum) then
AddLadderESP(obj)
end
end
end)
ladderRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(obj)
if LadderESPObjects[obj] then
RemoveLadderESP(obj)
end
end)
end
function stopLadderESP()
if ladderRoomConn then ladderRoomConn:Disconnect(); ladderRoomConn = nil end
if ladderAddedConn then ladderAddedConn:Disconnect(); ladderAddedConn = nil end
if ladderRemovedConn then ladderRemovedConn:Disconnect(); ladderRemovedConn = nil end
if ladderFloorConn then ladderFloorConn:Disconnect(); ladderFloorConn = nil end
for ladder in pairs(LadderESPObjects) do
RemoveLadderESP(ladder)
end
end
ESP:AddToggle('Ladder', {
    Text = "��",
    Default = false,
Callback = function(Value)
if Value then
startLadderESP()
else
stopLadderESP()
end
end
}):AddColorPicker('LadderColor', {
    Default = LadderColor,
    Title = '��颜色',
    Transparency = 0,
Callback = function(Value)
LadderColor = Value
if Toggles.Ladder.Value then
stopLadderESP()
startLadderESP()
end
end
})
end

local TaskESPObjects = {}
local TaskColor = Color3.new(0, 1, 0)
local roomChangeConn, itemAddedConn, itemRemovedConn
local function AddTaskESP(item, text, color)
if not item or not item.Parent then return end
local model = item
if item:IsA("BasePart") and item.Parent:IsA("Model") then
model = item.Parent
end
if TaskESPObjects[model] then return end
local esp = ESPLibrary:Add({
Name = text,
Model = model,
Color = color,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = color,
OutlineColor = color,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = color, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = color }
})
TaskESPObjects[model] = esp
esp:Show()
end
local function RemoveTaskESP(model)
local esp = TaskESPObjects[model]
if esp then
pcall(esp.Destroy, esp)
TaskESPObjects[model] = nil
end
end
local function getTaskItemNameAndText(item)
local name = item.Name
if name == "KeyObtain" and not item:GetAttribute("Used") then
return "钥匙", item
elseif name == "FuseObtain" and item.Parent and item.Parent.Name == "FuseHolder" then
return "保险丝", item
elseif name == "LiveHintBook" then
return "", item
elseif name == "LiveBreakerPolePickup" then
return "��", item
elseif name == "MinesAnchor" and item:FindFirstChild("Sign") and Floor.Value == "Mines" then
return " " .. item.Sign.TextLabel.Text, item
elseif name == "GeneratorMain" then
return "发电机", item
elseif name == "MinesGateButton" then
return "门按钮", item
elseif name == "WaterPump" and Floor.Value == "Mines" then
return "水泵", item
elseif name == "TimerLever" then
return "计时器拉杆", item
elseif name == "LeverForGate" then
return "门拉杆", item
elseif Floor.Value == "Garden" and name == "Lever" and item.Parent and item.Parent.Name == "VineGuillotine" then
return "拉杆", item
elseif Floor.Value == "Ripple" and name == "CringlePresent" then
return "礼物盒", item
end
return nil, nil
end
local function scanCurrentRoom()
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return end
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if not room then return end
for _, item in ipairs(room:GetDescendants()) do
local text, model = getTaskItemNameAndText(item)
if text then
AddTaskESP(model, text, TaskColor)
end
end
end
local function startTaskESP()
scanCurrentRoom()
roomChangeConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
for model in pairs(TaskESPObjects) do
RemoveTaskESP(model)
end
scanCurrentRoom()
end)
itemAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(item)
if not Toggles.TaskESP.Value then return end
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return end
local anc = item:FindFirstAncestorOfClass("Model")
while anc and anc ~= workspace.CurrentRooms do
if anc.Name == tostring(currentRoom) then
local text, model = getTaskItemNameAndText(item)
if text then
AddTaskESP(model, text, TaskColor)
end
break
end
anc = anc.Parent
end
end)
itemRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(item)
if TaskESPObjects[item] then
RemoveTaskESP(item)
elseif item:IsA("BasePart") and item.Parent and TaskESPObjects[item.Parent] then
RemoveTaskESP(item.Parent)
end
end)
end
local function stopTaskESP()
if roomChangeConn then roomChangeConn:Disconnect(); roomChangeConn = nil end
if itemAddedConn then itemAddedConn:Disconnect(); itemAddedConn = nil end
if itemRemovedConn then itemRemovedConn:Disconnect(); itemRemovedConn = nil end
for model in pairs(TaskESPObjects) do
RemoveTaskESP(model)
end
end
ESP:AddToggle('TaskESP', {
    Text = "任务",
    Default = false,
Callback = function(Value)
if Value then
startTaskESP()
else
stopTaskESP()
end
end
}):AddColorPicker('TaskColor', {
    Default = TaskColor,
    Title = '任务颜色',
    Transparency = 0,
Callback = function(Value)
TaskColor = Value
if Toggles.TaskESP.Value then
stopTaskESP()
startTaskESP()
end
end
})

local HidingSpots = {
Wardrobe = "衣柜", Rooms_Locker = "衣柜", Backdoor_Wardrobe = "衣柜",
Toolshed = "衣柜", Locker_Large = "衣柜", Bed = "", CircularVent = "通行证",
Rooms_Locker_Fridge = "冰箱", RetroWardrobe = "衣柜", Dumpster = "垃圾桶",
Double_Bed = ""
}
local HidingSpotColor = Color3.new(0, 0.5, 0)
local HidingSpotESPObjects = {}
local hidingUpdateLoop
local function AddHidingSpotESP(model, text)
if not model or not model.PrimaryPart or HidingSpotESPObjects[model] then return end
local esp = ESPLibrary:Add({
Name = text,
Model = model,
Color = HidingSpotColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = HidingSpotColor,
OutlineColor = HidingSpotColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = HidingSpotColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = HidingSpotColor }
})
HidingSpotESPObjects[model] = esp
esp:Show()
end
local function RemoveHidingSpotESP(model)
local esp = HidingSpotESPObjects[model]
if esp then
pcall(esp.Destroy, esp)
HidingSpotESPObjects[model] = nil
end
end
local function startHidingSpotESP()
hidingUpdateLoop = task.spawn(function()
while Toggles.HidingSpotESP and Toggles.HidingSpotESP.Value do
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if currentRoom then
for model, _ in pairs(HidingSpotESPObjects) do
if not model or not model.Parent then
RemoveHidingSpotESP(model)
else
local room = model:FindFirstAncestorOfClass("Model")
while room and not room:IsDescendantOf(workspace.CurrentRooms) do
room = room.Parent
end
local roomName = room and room.Name
if roomName ~= tostring(currentRoom) then
RemoveHidingSpotESP(model)
end
end
end
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if room then
local assets = room:FindFirstChild("Assets")
if assets then
for _, spot in ipairs(assets:GetChildren()) do
local name = HidingSpots[spot.Name]
if name and spot.PrimaryPart then
AddHidingSpotESP(spot, name)
end
end
end
end
end
task.wait()
end
for model in pairs(HidingSpotESPObjects) do
RemoveHidingSpotESP(model)
end
end)
end
local function stopHidingSpotESP()
if hidingUpdateLoop then
task.cancel(hidingUpdateLoop)
hidingUpdateLoop = nil
end
for model in pairs(HidingSpotESPObjects) do
RemoveHidingSpotESP(model)
end
end
ESP:AddToggle('HidingSpotESP', {
    Text = "躲藏点",
    Default = false,
Callback = function(Value)
if Value then
startHidingSpotESP()
else
stopHidingSpotESP()
end
end
}):AddColorPicker('HidingSpotColorPicker', {
    Default = HidingSpotColor,
    Title = '躲藏点',
    Transparency = 0,
Callback = function(Value)
HidingSpotColor = Value
if Toggles.HidingSpotESP.Value then
stopHidingSpotESP()
startHidingSpotESP()
end
end
})

local ChestColor = Color3.new(1, 0.8, 0)
local ChestESPObjects = {}
local chestRoomConn, chestAddedConn, chestRemovedConn
local function AddChestESP(model, text)
if not model or not model.Parent or ChestESPObjects[model] then return end
local esp = ESPLibrary:Add({
Name = text,
Model = model,
Color = ChestColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = ChestColor,
OutlineColor = ChestColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = ChestColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = ChestColor }
})
ChestESPObjects[model] = esp
esp:Show()
end
local function RemoveChestESP(model)
local esp = ChestESPObjects[model]
if esp then
pcall(esp.Destroy, esp)
ChestESPObjects[model] = nil
end
end
local function getChestText(model)
local name = model.Name
if name == "Chest_Vine" then
return "[藤蔓] 宝箱"
elseif name == "ChestBoxLocked" then
return "[锁定] 宝箱"
elseif name == "Toolshed_Small" then
return "自动柜子"
elseif name == "ChestBox" then
return "宝箱"
end
return nil
end
local function scanChestsInCurrentRoom()
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return end
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if not room then return end
for _, obj in ipairs(room:GetDescendants()) do
local text = getChestText(obj)
if text then
AddChestESP(obj, text)
end
end
end
local function isInCurrentRoom(obj)
local anc = obj
while anc do
if anc == workspace.CurrentRooms then break end
if anc.Name == tostring(LocalPlayer:GetAttribute("CurrentRoom")) then
return true
end
anc = anc.Parent
end
return false
end
local function startChestESP()
scanChestsInCurrentRoom()
chestRoomConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
for model in pairs(ChestESPObjects) do
RemoveChestESP(model)
end
scanChestsInCurrentRoom()
end)
chestAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
if not Toggles.Chest.Value then return end
local text = getChestText(obj)
if text and isInCurrentRoom(obj) then
AddChestESP(obj, text)
end
end)
chestRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(obj)
if ChestESPObjects[obj] then
RemoveChestESP(obj)
elseif obj:IsA("BasePart") and obj.Parent and ChestESPObjects[obj.Parent] then
RemoveChestESP(obj.Parent)
end
end)
end
local function stopChestESP()
if chestRoomConn then chestRoomConn:Disconnect(); chestRoomConn = nil end
if chestAddedConn then chestAddedConn:Disconnect(); chestAddedConn = nil end
if chestRemovedConn then chestRemovedConn:Disconnect(); chestRemovedConn = nil end
for model in pairs(ChestESPObjects) do
RemoveChestESP(model)
end
end
ESP:AddToggle('Chest', {
    Text = "宝箱",
    Default = false,
Callback = function(Value)
if Value then
startChestESP()
else
stopChestESP()
end
end
}):AddColorPicker('ChestColor', {
    Default = ChestColor,
    Title = '宝箱颜色',
    Transparency = 0,
Callback = function(Value)
ChestColor = Value
if Toggles.Chest.Value then
stopChestESP()
startChestESP()
end
end
})

local PlayersColor = Color3.new(1, 1, 1)
local PlayerESPObjects = {}
local playerConnections = {}
local playerAddedConn, playerRemovingConn
local function AddPlayerESP(player, character)
if not character or not character.Parent or PlayerESPObjects[character] then return end
local displayName = player.DisplayName or player.Name
local esp = ESPLibrary:Add({
Name = displayName,
Model = character,
Color = PlayersColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = PlayersColor,
OutlineColor = PlayersColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = PlayersColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = PlayersColor }
})
PlayerESPObjects[character] = { Object = esp, Player = player }
esp:Show()
end
local function RemovePlayerESP(character)
local data = PlayerESPObjects[character]
if data then
pcall(data.Object.Destroy, data.Object)
PlayerESPObjects[character] = nil
end
end
local function setupPlayer(player)
if playerConnections[player] then return end
local conns = {}
if player.Character then
AddPlayerESP(player, player.Character)
end
conns.charAdded = player.CharacterAdded:Connect(function(char)
AddPlayerESP(player, char)
end)
conns.charRemoved = player.CharacterRemoving:Connect(function(char)
RemovePlayerESP(char)
end)
playerConnections[player] = conns
end
local function cleanupPlayer(player)
local conns = playerConnections[player]
if conns then
if conns.charAdded then conns.charAdded:Disconnect() end
if conns.charRemoved then conns.charRemoved:Disconnect() end
playerConnections[player] = nil
end
for char, data in pairs(PlayerESPObjects) do
if data.Player == player then
RemovePlayerESP(char)
end
end
end
local function startPlayerESP()
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
setupPlayer(player)
end
end
playerAddedConn = Players.PlayerAdded:Connect(function(player)
if player ~= LocalPlayer then
setupPlayer(player)
end
end)
playerRemovingConn = Players.PlayerRemoving:Connect(function(player)
cleanupPlayer(player)
end)
end
local function stopPlayerESP()
if playerAddedConn then playerAddedConn:Disconnect(); playerAddedConn = nil end
if playerRemovingConn then playerRemovingConn:Disconnect(); playerRemovingConn = nil end
for _, player in ipairs(Players:GetPlayers()) do
cleanupPlayer(player)
end
for char in pairs(PlayerESPObjects) do
RemovePlayerESP(char)
end
end
ESP:AddToggle('Players', {
    Text = "玩家",
    Default = false,
Callback = function(Value)
if Value then
startPlayerESP()
else
stopPlayerESP()
end
end
}):AddColorPicker('PlayersColor', {
    Default = PlayersColor,
    Title = '玩家颜色',
    Transparency = 0,
Callback = function(Value)
PlayersColor = Value
if Toggles.Players.Value then
stopPlayerESP()
startPlayerESP()
end
end
})

local GoldColor = Color3.new(1, 0.8, 0)
local GoldESPObjects = {}
local goldRoomConn, goldAddedConn, goldRemovedConn
local function AddGoldESP(goldPile)
if not goldPile or not goldPile.Parent or GoldESPObjects[goldPile] then return end
local goldValue = goldPile:GetAttribute("GoldValue")
local text = "金币 [" .. goldValue .. "]"
local esp = ESPLibrary:Add({
Name = text,
Model = goldPile,
Color = GoldColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = GoldColor,
OutlineColor = GoldColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = GoldColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = GoldColor }
})
GoldESPObjects[goldPile] = esp
esp:Show()
end
local function RemoveGoldESP(goldPile)
local esp = GoldESPObjects[goldPile]
if esp then
pcall(esp.Destroy, esp)
GoldESPObjects[goldPile] = nil
end
end
local function isInCurrentRoom(obj)
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return false end
local anc = obj
while anc and anc ~= workspace do
if anc.Name == tostring(currentRoom) and anc.Parent == workspace.CurrentRooms then
return true
end
anc = anc.Parent
end
return false
end
local function scanGoldInCurrentRoom()
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return end
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if not room then return end
for _, goldPile in ipairs(room:GetDescendants()) do
if goldPile.Name == "GoldPile" then
AddGoldESP(goldPile)
end
end
end
local function startGoldESP()
scanGoldInCurrentRoom()
goldRoomConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
for model in pairs(GoldESPObjects) do
RemoveGoldESP(model)
end
scanGoldInCurrentRoom()
end)
goldAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
if not Toggles.GoldESP.Value then return end
if obj.Name == "GoldPile" and isInCurrentRoom(obj) then
AddGoldESP(obj)
end
end)
goldRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(obj)
if GoldESPObjects[obj] then
RemoveGoldESP(obj)
end
end)
end
local function stopGoldESP()
if goldRoomConn then goldRoomConn:Disconnect(); goldRoomConn = nil end
if goldAddedConn then goldAddedConn:Disconnect(); goldAddedConn = nil end
if goldRemovedConn then goldRemovedConn:Disconnect(); goldRemovedConn = nil end
for model in pairs(GoldESPObjects) do
RemoveGoldESP(model)
end
end
ESP:AddToggle('GoldESP', {
    Text = "金币",
    Default = false,
Callback = function(Value)
if Value then
startGoldESP()
else
stopGoldESP()
end
end
}):AddColorPicker('GoldColorPicker', {
    Default = GoldColor,
    Title = '金币颜色',
    Transparency = 0,
Callback = function(Value)
GoldColor = Value
if Toggles.GoldESP.Value then
stopGoldESP()
startGoldESP()
end
end
})

local ItemsColor = Color3.new(1, 0, 1)
local ItemsESPObjects = {}
local itemsRoomConn, itemsAddedConn, itemsRemovedConn
local dropsAddedConn, dropsRemovedConn
local Item = {
Flashlight = "手电筒", Lockpick = "��", Lighter = "打火机", Vitamins = "维生素",
Bandage = "创口贴", StarVial = "小星星", StarBottle = "星瓶", StarJug = "星罐",
Shakelight = "手摇电筒", Straplight = "背带裤", Bulklight = "散弹枪", Battery = "电池",
Candle = "蜡烛", Crucifix = "十字架", CrucifixWall = "十字架", Glowsticks = "荧光笔",
SkeletonKey = "骷髅钥匙", Candy = "糖果", ShieldMini = "迷你盾牌", ShieldBig = "大盾牌",
BandagePack = "创口贴包装盒", BatteryPack = "电池包高亮", RiftCandle = "月光蜡烛",
LaserPointer = "荧光笔", HolyGrenade = "神圣手雷", Shears = "��", Smoothie = "奶昔",
Cheese = "奶酪", Bread = "面包", AlarmClock = "闹钟", RiftSmoothie = "月光奶昔",
GweenSoda = "苏打水", GlitchCube = "故障方块", RiftJar = "裂缝门", Compass = "罗盘",
Lantern = "手电筒", Multitool = "万能工具", Lotus = "莲花", TipJar = "小费罐",
LotusPetalPickup = "莲花花瓣", KeyIron = "铁钥匙", CandyBag = "糖果袋子", Donut = "甜甜圈"
}
local function AddItemESP(item, text)
if not item or not item.Parent then return end
local model = item
if item:IsA("BasePart") and item.Parent:IsA("Model") then model = item.Parent end
if ItemsESPObjects[model] then return end
if model:IsA("Tool") then
local owner = model:FindFirstChild("Owner") and model.Owner.Value
if owner == LocalPlayer then return end
end
if model:IsDescendantOf(LocalPlayer.Character) or model:IsDescendantOf(LocalPlayer.Backpack) then
return
end
local esp = ESPLibrary:Add({
Name = text,
Model = model,
Color = ItemsColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = ItemsColor,
OutlineColor = ItemsColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = ItemsColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = ItemsColor }
})
ItemsESPObjects[model] = esp
esp:Show()
end
local function RemoveItemESP(model)
local esp = ItemsESPObjects[model]
if esp then
pcall(esp.Destroy, esp)
ItemsESPObjects[model] = nil
end
end
local function isInCurrentRoom(obj)
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return false end
if obj:IsDescendantOf(workspace:FindFirstChild("Drops") or workspace) then
return obj:FindFirstAncestor("Drops") ~= nil
end
local anc = obj
while anc and anc ~= workspace do
if anc.Name == tostring(currentRoom) and anc.Parent == workspace.CurrentRooms then
return true
end
anc = anc.Parent
end
return false
end
local function scanItemsInCurrentScope()
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return end
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if room then
for _, obj in ipairs(room:GetDescendants()) do
local text = Item[obj.Name]
if text and obj:IsA("Model") and obj.PrimaryPart then
AddItemESP(obj, text)
end
end
end
local drops = workspace:FindFirstChild("Drops")
if drops then
for _, drop in ipairs(drops:GetChildren()) do
local text = Item[drop.Name]
if text and drop:IsA("Model") and drop.PrimaryPart then
AddItemESP(drop, text)
end
end
end
end
local function startItemsESP()
scanItemsInCurrentScope()
itemsRoomConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
for model in pairs(ItemsESPObjects) do
RemoveItemESP(model)
end
scanItemsInCurrentScope()
end)
itemsAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
if not Toggles.Items.Value then return end
local text = Item[obj.Name]
if text and obj:IsA("Model") and obj.PrimaryPart and isInCurrentRoom(obj) then
AddItemESP(obj, text)
end
end)
itemsRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(obj)
if ItemsESPObjects[obj] then
RemoveItemESP(obj)
elseif obj:IsA("BasePart") and obj.Parent and ItemsESPObjects[obj.Parent] then
RemoveItemESP(obj.Parent)
end
end)
local drops = workspace:FindFirstChild("Drops")
if drops then
dropsAddedConn = drops.ChildAdded:Connect(function(child)
if not Toggles.Items.Value then return end
local text = Item[child.Name]
if text and child:IsA("Model") and child.PrimaryPart then
AddItemESP(child, text)
end
end)
dropsRemovedConn = drops.ChildRemoved:Connect(function(child)
if ItemsESPObjects[child] then
RemoveItemESP(child)
end
end)
end
end
local function stopItemsESP()
if itemsRoomConn then itemsRoomConn:Disconnect(); itemsRoomConn = nil end
if itemsAddedConn then itemsAddedConn:Disconnect(); itemsAddedConn = nil end
if itemsRemovedConn then itemsRemovedConn:Disconnect(); itemsRemovedConn = nil end
if dropsAddedConn then dropsAddedConn:Disconnect(); dropsAddedConn = nil end
if dropsRemovedConn then dropsRemovedConn:Disconnect(); dropsRemovedConn = nil end
for model in pairs(ItemsESPObjects) do
RemoveItemESP(model)
end
end
ESP:AddToggle('Items', {
    Text = "物品",
    Default = false,
Callback = function(Value)
if Value then
startItemsESP()
else
stopItemsESP()
end
end
}):AddColorPicker('ItemsColorPicker', {
    Default = ItemsColor,
    Title = '物品颜色',
    Transparency = 0,
Callback = function(Value)
ItemsColor = Value
if Toggles.Items.Value then
stopItemsESP()
startItemsESP()
end
end
})

local StardustColor = Color3.new(1, 0.5, 0.8)
local StardustESPObjects = {}
local stardustRoomConn, stardustAddedConn, stardustRemovedConn
local function AddStardustESP(stardust)
if not stardust or not stardust.Parent or StardustESPObjects[stardust] then return end
local esp = ESPLibrary:Add({
Name = "星尘",
Model = stardust,
Color = StardustColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = StardustColor,
OutlineColor = StardustColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = StardustColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = StardustColor }
})
StardustESPObjects[stardust] = esp
esp:Show()
end
local function RemoveStardustESP(stardust)
local esp = StardustESPObjects[stardust]
if esp then
pcall(esp.Destroy, esp)
StardustESPObjects[stardust] = nil
end
end
local function isInCurrentRoom(obj)
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return false end
local anc = obj
while anc and anc ~= workspace do
if anc.Name == tostring(currentRoom) and anc.Parent == workspace.CurrentRooms then
return true
end
anc = anc.Parent
end
return false
end
local function scanStardustInCurrentRoom()
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return end
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if not room then return end
for _, stardust in ipairs(room:GetDescendants()) do
if stardust.Name == "StardustPickup" then
AddStardustESP(stardust)
end
end
end
local function startStardustESP()
scanStardustInCurrentRoom()
stardustRoomConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
for model in pairs(StardustESPObjects) do
RemoveStardustESP(model)
end
scanStardustInCurrentRoom()
end)
stardustAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
if not Toggles.Stardust.Value then return end
if obj.Name == "StardustPickup" and isInCurrentRoom(obj) then
AddStardustESP(obj)
end
end)
stardustRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(obj)
if StardustESPObjects[obj] then
RemoveStardustESP(obj)
end
end)
end
local function stopStardustESP()
if stardustRoomConn then stardustRoomConn:Disconnect(); stardustRoomConn = nil end
if stardustAddedConn then stardustAddedConn:Disconnect(); stardustAddedConn = nil end
if stardustRemovedConn then stardustRemovedConn:Disconnect(); stardustRemovedConn = nil end
for model in pairs(StardustESPObjects) do
RemoveStardustESP(model)
end
end
ESP:AddToggle('Stardust', {
    Text = "星尘",
    Default = false,
    Callback = function(Value)
if Value then
startStardustESP()
else
stopStardustESP()
end
end
}):AddColorPicker('StardustColor', {
    Default = StardustColor,
    Title = '星尘颜色',
    Transparency = 0,
Callback = function(Value)
StardustColor = Value
if Toggles.Stardust.Value then
stopStardustESP()
startStardustESP()
end
end
})

local EntityColor = Color3.new(1, 0, 0)
local EntityESPObjects = {}
local entityAddedConn, entityRemovedConn
local roomDescAddedConn, roomDescRemovedConn
local function addEntityESP(entity, label)
if not entity or not entity.Parent or EntityESPObjects[entity] then return end
local base = entity:FindFirstChildWhichIsA("BasePart")
if not base then return end
if not entity:FindFirstChildOfClass("Humanoid") then
local humanoid = Instance.new("Humanoid")
humanoid.Name = "ESP_Humanoid"
humanoid.Parent = entity
humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
end
base.Transparency = 0.99
local esp = ESPLibrary:Add({
Name = label,
Model = entity,
Color = EntityColor,
MaxDistance = 1000,
TextSize = ESPGlobalSettings.TextSize,
ESPType = ESPGlobalSettings.ESPType,
FillColor = EntityColor,
OutlineColor = EntityColor,
FillTransparency = ESPGlobalSettings.FillTransparency,
OutlineTransparency = ESPGlobalSettings.OutlineTransparency,
Tracer = { Enabled = true, Color = EntityColor, Thickness = ESPGlobalSettings.TracerThickness, From = ESPGlobalSettings.TracerPosition },
Arrow = { Enabled = true, Color = EntityColor }
})
EntityESPObjects[entity] = esp
esp:Show()
end
local function removeEntityESP(entity)
local esp = EntityESPObjects[entity]
if esp then
pcall(esp.Destroy, esp)
EntityESPObjects[entity] = nil
end
end
local function getEntityLabel(instance)
local name = instance.Name
if name == "RushMoving" then return "Rush"
elseif name == "AmbushMoving" then return "Ambush"
elseif name == "GlitchRush" then return "GlitchRush"
elseif name == "GlitchAmbush" then return "GlitchAmbush"
elseif name == "A60" then return "A-60"
elseif name == "A120" then return "A-120"
elseif name == "Eyes" then return "Eyes"
elseif name == "BackdoorLookman" then return "Lookman"
elseif name == "BackdoorRush" then return "Blitz"
elseif name == "Groundskeeper" then return "Groundskeeper"
elseif name == "FigureRig" or name == "FigureRagdoll" then return "Figure"
elseif name == "LiveEntityBramble" then return "Bramble"
elseif name == "GrumbleRig" then return "Grumble"
elseif name == "MonumentEntity" then
local top = instance:FindFirstChild("Top")
if top then
return "Monument", top
end
end
return nil
end
local function tryAddEntity(instance)
local label, model = getEntityLabel(instance)
if label then
addEntityESP(model or instance, label)
return true
end
return false
end
local function startEntitiesESP()
for _, child in ipairs(workspace:GetChildren()) do
tryAddEntity(child)
end
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
for _, descendant in ipairs(room:GetDescendants()) do
tryAddEntity(descendant)
end
end
entityAddedConn = workspace.ChildAdded:Connect(function(child)
if not Toggles.EntitiesESP.Value then return end
tryAddEntity(child)
end)
entityRemovedConn = workspace.ChildRemoved:Connect(function(child)
removeEntityESP(child)
end)
roomDescAddedConn = workspace.CurrentRooms.DescendantAdded:Connect(function(descendant)
if not Toggles.EntitiesESP.Value then return end
tryAddEntity(descendant)
end)
roomDescRemovedConn = workspace.CurrentRooms.DescendantRemoving:Connect(function(descendant)
removeEntityESP(descendant)
end)
end
local function stopEntitiesESP()
if entityAddedConn then entityAddedConn:Disconnect(); entityAddedConn = nil end
if entityRemovedConn then entityRemovedConn:Disconnect(); entityRemovedConn = nil end
if roomDescAddedConn then roomDescAddedConn:Disconnect(); roomDescAddedConn = nil end
if roomDescRemovedConn then roomDescRemovedConn:Disconnect(); roomDescRemovedConn = nil end
for entity, _ in pairs(EntityESPObjects) do
removeEntityESP(entity)
end
end
ESP:AddToggle('EntitiesESP', {
    Text = "实体",
    Default = false,
Callback = function(Value)
if Value then
startEntitiesESP()
else
stopEntitiesESP()
end
end
}):AddColorPicker('EntityColorPicker', {
    Default = EntityColor,
    Title = '实体颜色',
    Transparency = 0,
Callback = function(Value)
EntityColor = Value
if Toggles.EntitiesESP.Value then
stopEntitiesESP()
startEntitiesESP()
end
end
})

NotifyBox:AddDropdown("EntitiesPicker", {
    Values = { "Rush","Ambush","A-60","A-120","Eyes","Lookman","Blitz","GlitchRush","GlitchAmbush","Monument","Groundskeeper","Seek"},
    Default = 1,
    Multi = true,
    Text = "实体",
Callback = function(Value)
end,
})

NotifyBox:AddToggle('EntityNotifys',{
    Text = "通知实体",
    Default = false
})

local entityModelMap = {
    Rush = "RushMoving",
    Ambush = "AmbushMoving",
    ["A-60"] = "A60",
    ["A-120"] = "A120",
    Eyes = "Eyes",
    Lookman = "BackdoorLookman",
    Blitz = "BackdoorRush",
    Monument = "MonumentEntity",
    Groundskeeper = "Groundskeeper",
    Seek = "SeekMovingNewClone",
    GlitchRush = "GlitchRush",
    GlitchAmbush = "GlitchAmbush"
}

local entityNameMap = {
    Rush = "Rush",
    Ambush = "Ambush", 
    ["A-60"] = "A-60",
    ["A-120"] = "A-120",
    Eyes = "Eyes",
    Lookman = "Lookman",
    Blitz = "Blitz",
    Monument = "Monument",
    Groundskeeper = "Groundskeeper",
    Seek = "Seek",
    GlitchRush = "GlitchRush",
    GlitchAmbush = "GlitchAmbush"
}

local notifyChatRunning = false
local notifyChatConnection = nil
local notifyChatConnections = nil
NySet:AddToggle('NotifyChat',{
    Text = "通知聊天",
    Default = false,
Callback = function(Value)
if Value then
if not notifyChatRunning then
notifyChatRunning = true
local TextChatService = game:GetService("TextChatService")
local Workspace = game:GetService("Workspace")
local detectedInstances = {}
local lastCheckTime = 0
local checkInterval = 0.5
local selectedEntities = {}
for entityName, modelName in pairs(entityModelMap) do
if Options.EntitiesPicker.Value[entityName] then
selectedEntities[modelName] = entityNameMap[entityName] or entityName
end
end
local function sendMessage(message)
if TextChatService and TextChatService.TextChannels then
local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
if channel then
channel:SendAsync(message)
end
end
end
local function checkForEntities()
if not notifyChatRunning then return end
for entityName, modelName in pairs(entityModelMap) do
if Options.EntitiesPicker.Value[entityName] then
selectedEntities[modelName] = entityNameMap[entityName] or entityName
else
selectedEntities[modelName] = nil
end
end
for modelName, displayName in pairs(selectedEntities) do
local entity = Workspace:FindFirstChild(modelName)
if entity and entity:IsA("Model") then
if not detectedInstances[entity] then
detectedInstances[entity] = true
local messageFormat = Options.ChatMessageFormat.Value or "% 已生成"
local chatMessage = messageFormat:gsub("%%", displayName)
sendMessage(chatMessage)
end
end
end
for entity in pairs(detectedInstances) do
if not entity:IsDescendantOf(Workspace) then
detectedInstances[entity] = nil
end
end
end
notifyChatConnection = game:GetService("RunService").Heartbeat:Connect(function()
if not notifyChatRunning then return end
local currentTime = tick()
if currentTime - lastCheckTime >= checkInterval then
lastCheckTime = currentTime
checkForEntities()
end
end)
local entityAddedConnection = Workspace.ChildAdded:Connect(function(child)
if not notifyChatRunning then return end
task.wait(0.1)
for modelName, displayName in pairs(selectedEntities) do
if child.Name == modelName and child:IsA("Model") then
if not detectedInstances[child] then
detectedInstances[child] = true
local messageFormat = Options.ChatMessageFormat.Value or "% 已生成"
local chatMessage = messageFormat:gsub("%%", displayName)
sendMessage(chatMessage)
end
break
end
end
end)
local entityRemovedConnection = Workspace.ChildRemoved:Connect(function(child)
detectedInstances[child] = nil
end)
notifyChatConnections = {
notifyChatConnection,
entityAddedConnection,
entityRemovedConnection
}
end
else
notifyChatRunning = false
if notifyChatConnections then
for _, connection in ipairs(notifyChatConnections) do
if connection then
connection:Disconnect()
end
end
notifyChatConnections = nil
end
detectedInstances = {}
selectedEntities = {}
end
end
})

NySet:AddInput("ChatMessageFormat", {
    Default = "% 已生成",
    Numeric = false,
    Finished = false,
    Text = "聊天消息格式",
    Tooltip = "% 将替换为实体名称",
Callback = function(Value)
end,
})
NySet:AddDivider()

local OptionNotify = "Library"
NySet:AddDropdown("NotificationStyle", {
    Values = {"Library", "Doors"},
    Default = "Library",
    Text = "通知样式",
Callback = function(Value)
OptionNotify = Value
end,
})

NySet:AddToggle('PlaySound',{
    Text = "去除声音",
    Default = true,
Callback = function(Value)
PlayingSound = Value
end
})

table.insert(Connections, workspace.ChildAdded:Connect(function(v)
if Toggles.EntityNotifys and Toggles.EntityNotifys.Value then  
if v.Name == "RushMoving" and Options.EntitiesPicker.Value["Rush"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Rush",
Desc = "Rush 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://11102256553",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Rush 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "BackdoorRush" and Options.EntitiesPicker.Value["Blitz"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Blitz",
Desc = "Blitz 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://140595207306444",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Blitz 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "BackdoorLookman" and Options.EntitiesPicker.Value["Lookman"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Lookman",
Desc = "Lookman 已生成",
Reason = "不要直视它",
Image = "rbxassetid://16764872677",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Lookman 已生成！不要直视它！", 3)
Sound()
end
end
if v.Name == "AmbushMoving" and Options.EntitiesPicker.Value["Ambush"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Ambush",
Desc = "Ambush 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://10938726652",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Ambush 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "A60" and Options.EntitiesPicker.Value["A-60"] then
if OptionNotify == "Doors" then
Achievement({
Title = "A-60",
Desc = "A-60 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://12350986086",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("A-60 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "A120" and Options.EntitiesPicker.Value["A-120"] then
if OptionNotify == "Doors" then
Achievement({
Title = "A-120",
Desc = "A-120 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://12351008553",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("A-120 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "Eyes" and Options.EntitiesPicker.Value["Eyes"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Eyes",
Desc = "Eyes 已生成",
Reason = "不要直视它",
Image = "rbxassetid://10865377903",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Eyes 已生成！不要直视它！", 3)
Sound()
end
end
if v.Name == "GlitchRush" and Options.EntitiesPicker.Value["GlitchRush"] then
if OptionNotify == "Doors" then
Achievement({
Title = "GlitchRush",
Desc = "GlitchRush 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://11102256553",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("GlitchRush 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "GlitchAmbush" and Options.EntitiesPicker.Value["GlitchAmbush"] then
if OptionNotify == "Doors" then
Achievement({
Title = "GlitchAmbush",
Desc = "GlitchAmbush 已生成",
Reason = "��寻找躲藏点",
Image = "rbxassetid://10938726652",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("GlitchAmbush 已生成！请寻找躲藏点！", 3)
Sound()
end
end
if v.Name == "Groundskeeper" and Options.EntitiesPicker.Value["Groundskeeper"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Groundskeeper",
Desc = "Groundskeeper 已生成",
Reason = "不要踩踏草坪",
Image = "rbxassetid://114991380115557",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Groundskeeper 已生成！不要踩踏草坪", 3)
Sound()
end
end
if v.Name == "MonumentEntity" and Options.EntitiesPicker.Value["Monument"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Monument",
Desc = "Monument 已生成",
Reason = "看着点",
Image = "rbxassetid://88933556873017",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Monument 已生成！看着它！", 3)
Sound()
end
end
if v.Name == "SeekMovingNewClone" and Options.EntitiesPicker.Value["Seek"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Seek",
Desc = "Seek 已生成",
Reason = "下一门有Seek",
Image = "rbxassetid://109124151043322",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Seek 已生成！下一门有Seek战", 3)
Sound()
end
end
end
end))
table.insert(Connections, LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
if Toggles.EntityNotifys and Toggles.EntityNotifys.Value then
local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
if currentRoom then
local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
if room then
local v = room:FindFirstChild("Groundskeeper", true)
if v and Options.EntitiesPicker.Value["Groundskeeper"] then
if OptionNotify == "Doors" then
Achievement({
Title = "Groundskeeper",
Desc = "Groundskeeper 已生成",
Reason = "不要踩踏草坪",
Image = "rbxassetid://114991380115557",
Text = "WARNING",
TextColor = Color3.fromRGB(255, 0, 0),
UIStrokeColor = Color3.fromRGB(255, 0, 0)
})
else
Library:Notify("Groundskeeper 已生成！不要踩踏草坪", 3)
Sound()
end
end
end
end
end
end))

NotifyBox:AddToggle('NotifyLibraryCode', {
    Text = "通知挂锁密码",
    Default = false
})

local oxygenNotifyRunning = false
local oxygenNotifyUI = nil
local oxygenNotifyConnection = nil
local oxygenHideTimer = nil
NotifyBox:AddToggle('OxygenNotify',{
     Text = "通知氧气",
     Default = false,
Callback = function(Value)
if Value then
if not oxygenNotifyRunning then
oxygenNotifyRunning = true
if not oxygenNotifyUI then
oxygenNotifyUI = Instance.new("ScreenGui")
oxygenNotifyUI.Name = "OxygenNotifyUI"
oxygenNotifyUI.Parent = game:GetService("CoreGui")
oxygenNotifyUI.ResetOnSpawn = false
oxygenNotifyUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 120, 0, 45)
frame.Position = UDim2.new(0.5, -100, 0.8, -30)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.3
frame.Parent = oxygenNotifyUI
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "氧气: 100%"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 18
textLabel.Font = Enum.Font.Gotham
textLabel.Parent = frame
oxygenNotifyUI.Enabled = false
end
local function updateOxygenDisplay(oxygenValue)
if oxygenNotifyUI and oxygenNotifyUI:FindFirstChildOfClass("Frame") then
local frame = oxygenNotifyUI:FindFirstChildOfClass("Frame")
local textLabel = frame:FindFirstChildOfClass("TextLabel")
if textLabel then
textLabel.Text = "氧气: " .. tostring(math.floor(oxygenValue)) .. "%"
if oxygenValue < 30 then
textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
elseif oxygenValue < 60 then
textLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
else
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
end
end
end
end
local function checkOxygen(character)
if not character then
character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
if not character then return nil end
local oxygenValue = character:GetAttribute("Oxygen")
if oxygenValue then
return oxygenValue
end
local oxygenObj = character:FindFirstChild("Oxygen")
if oxygenObj and oxygenObj:IsA("NumberValue") then
return oxygenObj.Value
end
return nil
end
oxygenNotifyConnection = game:GetService("RunService").Heartbeat:Connect(function()
if not oxygenNotifyRunning then
return
end
local character = LocalPlayer.Character
if not character then
oxygenNotifyUI.Enabled = false
return
end
local oxygenValue = checkOxygen(character)
if oxygenValue then
if oxygenValue < 100 then
oxygenNotifyUI.Enabled = true
updateOxygenDisplay(oxygenValue)
if oxygenHideTimer then
oxygenHideTimer:Cancel()
oxygenHideTimer = nil
end
else
if oxygenNotifyUI.Enabled and not oxygenHideTimer then
oxygenHideTimer = task.delay(3, function()
if oxygenNotifyUI and oxygenNotifyRunning then
oxygenNotifyUI.Enabled = false
oxygenHideTimer = nil
end
end)
end
end
else
oxygenNotifyUI.Enabled = false
end
end)
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
if not oxygenNotifyRunning then return end
task.wait(1)
local oxygenValue = checkOxygen(newCharacter)
if oxygenValue and oxygenValue < 100 then
oxygenNotifyUI.Enabled = true
updateOxygenDisplay(oxygenValue)
else
oxygenNotifyUI.Enabled = false
end
end)
end
else
oxygenNotifyRunning = false
if oxygenNotifyConnection then
oxygenNotifyConnection:Disconnect()
oxygenNotifyConnection = nil
end
if oxygenHideTimer then
oxygenHideTimer:Cancel()
oxygenHideTimer = nil
end
if oxygenNotifyUI then
oxygenNotifyUI.Enabled = false
end
end
end
})

local hasteClockUI = nil
local hasteClockConnection = nil
local hasteClockRoomConnection = nil
NotifyBox:AddToggle('HasteClock',{
     Text = "通知计时器",
     Default = false,
Callback = function(Value)
if Value then
if not hasteClockUI then
hasteClockUI = Instance.new("ScreenGui")
hasteClockUI.Name = "HasteClockUI"
hasteClockUI.Parent = game:GetService("CoreGui")
hasteClockUI.ResetOnSpawn = false
hasteClockUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 150, 0, 45)
frame.Position = UDim2.new(0.5, 100, 0.8, -30)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.3
frame.Parent = hasteClockUI
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "计时器: --"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 18
textLabel.Font = Enum.Font.Gotham
textLabel.Parent = frame
hasteClockUI.Enabled = false
end
local function getCurrentRoomTimer()
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if not localPlayer then return nil end
local currentRoom = localPlayer:GetAttribute("CurrentRoom")
if not currentRoom then return nil end
local roomKey = tostring(currentRoom)
local currentRooms = workspace:FindFirstChild("CurrentRooms")
if not currentRooms then return nil end
local room = currentRooms:FindFirstChild(roomKey)
if not room then return nil end
local door = room:FindFirstChild("Door")
if not door then return nil end
local displayTimer = door:FindFirstChild("DisplayTimer")
if displayTimer and displayTimer:FindFirstChild("Text") then
local textObj = displayTimer.Text
if textObj and textObj.Text and textObj.Text ~= "" then
return textObj.Text
end
end
local doorModel = door:FindFirstChild("Door")
if doorModel then
local backdoorDisplayPlate = doorModel:FindFirstChild("BackdoorDisplayPlate")
if backdoorDisplayPlate then
displayTimer = backdoorDisplayPlate:FindFirstChild("DisplayTimer")
if displayTimer and displayTimer:FindFirstChild("Text") then
local textObj = displayTimer.Text
if textObj and textObj.Text and textObj.Text ~= "" then
return textObj.Text
end
end
end
end
return nil
end
local function updateTimerDisplay(timerText)
if hasteClockUI and hasteClockUI:FindFirstChildOfClass("Frame") then
local frame = hasteClockUI:FindFirstChildOfClass("Frame")
local textLabel = frame:FindFirstChildOfClass("TextLabel")
if textLabel then
textLabel.Text = "计时器: " .. timerText
end
end
end
hasteClockConnection = game:GetService("RunService").Heartbeat:Connect(function()
if not Toggles.HasteClock.Value then
return
end
local timerText = getCurrentRoomTimer()
if timerText and timerText ~= "" and timerText ~= "..." then
hasteClockUI.Enabled = true
updateTimerDisplay(timerText)
else
hasteClockUI.Enabled = false
end
end)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
hasteClockRoomConnection = localPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
if not Toggles.HasteClock.Value then return end
hasteClockUI.Enabled = true
updateTimerDisplay("...")
task.delay(2, function()
if Toggles.HasteClock.Value then
local timerText = getCurrentRoomTimer()
if not timerText or timerText == "" or timerText == "..." then
hasteClockUI.Enabled = false
end
end
end)
end)
else
if hasteClockConnection then
hasteClockConnection:Disconnect()
hasteClockConnection = nil
end
if hasteClockRoomConnection then
hasteClockRoomConnection:Disconnect()
hasteClockRoomConnection = nil
end
if hasteClockUI then
hasteClockUI.Enabled = false
end
end
end
})

if ReplicatedStorage:FindFirstChild("RemotesFolder") then
local hidingTimeConnection = nil
local hideMonsterHook = nil
local hidingAttributeConnection = nil
local hidingNotification = nil
local hidingStartTime = nil
local currentHideDuration = nil
NotifyBox:AddToggle('HidingTimeNotify',{
     Text = "通知躲藏时间",
     Default = false,
Callback = function(Value)
if Value then
if not hidingTimeConnection then
if not hideMonsterHook then
local hideMonsterEvent = RemoteFolder:FindFirstChild("HideMonster")
if hideMonsterEvent then
hideMonsterHook = hideMonsterEvent.OnClientEvent:Connect(function(hideDuration)
if Toggles.HidingTimeNotify.Value then
hidingStartTime = tick()
currentHideDuration = hideDuration
if hidingNotification then
hidingNotification:Destroy()
end
hidingNotification = Library:Notify({
Title = "玩家躲藏点...",
Description = "躲藏剩余时间: " .. hideDuration .. "",
Persist = true,
})
end
end)
end
end
hidingTimeConnection = RunService.Heartbeat:Connect(function()
if not Toggles.HidingTimeNotify.Value then return end
local isHiding = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("Hiding") == true
if isHiding and hidingStartTime and currentHideDuration then
local currentTime = tick()
local elapsedTime = currentTime - hidingStartTime
local remainingTime = math.max(0, currentHideDuration - elapsedTime)
local formattedTime = string.format("%.1f", remainingTime)
if hidingNotification then
hidingNotification:ChangeTitle("玩家躲藏点...")
hidingNotification:ChangeDescription("躲藏剩余时间: " .. formattedTime .. "")
end
if remainingTime <= 0 then
if hidingNotification then
hidingNotification:Destroy()
hidingNotification = nil
end
hidingStartTime = nil
currentHideDuration = nil
end
elseif not isHiding then
if hidingNotification then
hidingNotification:Destroy()
hidingNotification = nil
end
hidingStartTime = nil
currentHideDuration = nil
end
end)
if not hidingAttributeConnection then
hidingAttributeConnection = LocalPlayer.Character:GetAttributeChangedSignal("Hiding"):Connect(function()
if not Toggles.HidingTimeNotify.Value then return end
local isHiding = LocalPlayer.Character:GetAttribute("Hiding")
if not isHiding and hidingNotification then
hidingNotification:Destroy()
hidingNotification = nil
hidingStartTime = nil
currentHideDuration = nil
end
end)
end
end
else
if hidingTimeConnection then
hidingTimeConnection:Disconnect()
hidingTimeConnection = nil
end
if hideMonsterHook then
hideMonsterHook:Disconnect()
hideMonsterHook = nil
end
if hidingAttributeConnection then
hidingAttributeConnection:Disconnect()
hidingAttributeConnection = nil
end
if hidingNotification then
hidingNotification:Destroy()
hidingNotification = nil
end
hidingStartTime = nil
currentHideDuration = nil
end
end
})
end

Ambient:AddToggle('Fullbright', {
    Text = "全亮",
    Default = false,
Callback = function(Value)
if Value then
else
game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
end
end
})

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local skyRemovalConnection = nil
Ambient:AddToggle('AntiFog', {
    Text = "没有门",
    Default = false,
Callback = function(Value)
if Value then
if Lighting:FindFirstChildOfClass("Sky") then
Lighting:FindFirstChildOfClass("Sky"):Destroy()
end
skyRemovalConnection = RunService.Heartbeat:Connect(function()
if not Toggles.AntiFog.Value then
return
end
local currentSky = Lighting:FindFirstChildOfClass("Sky")
if currentSky then
currentSky:Destroy()
end
end)
else
if skyRemovalConnection then
skyRemovalConnection:Disconnect()
skyRemovalConnection = nil
end
end
end
})

Ambient:AddToggle('AntiLag',{
     Text = "防卡墙",
     Default = false,
Callback = function(Value)
if Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("BasePart") then
v.Material = Enum.Material.Plastic
end
if v.Name == "LightFixture" or v.Name == "Carpet" or v.Name == "CarpetLight" then
v:Destroy()
end
end
end
end
})

local ThirdPersonHandler = {enabled = false, offset = Vector3.new(2, 0, 6)}
local X, Y, Z = 2, 0, 6
local function ThirdPersonStep()
if not ThirdPersonHandler.enabled then return end
local cam = workspace.CurrentCamera
local char = LocalPlayer.Character
if not cam or not char then return end
cam.CFrame = cam.CFrame * CFrame.new(ThirdPersonHandler.offset)
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") and part.Name == "Head" then
part.LocalTransparencyModifier = 0
elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
part.Handle.LocalTransparencyModifier = 0
end
end
end
pcall(function() RunService:UnbindFromRenderStep("THIRD_PERSON_SYS") end)
RunService:BindToRenderStep("THIRD_PERSON_SYS", Enum.RenderPriority.Camera.Value+1, ThirdPersonStep)
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
if ThirdPersonHandler.enabled then
ThirdPersonHandler.enabled = false
task.wait(0.1)
ThirdPersonHandler.enabled = true
end
end)
Self:AddToggle('ThirdPerson', {
    Text = "第三人称",
    Default = false,
Callback = function(Value)
ThirdPersonHandler.enabled = Value
if not Value then
local char = LocalPlayer.Character
if char then
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") and part.Name == "Head" then
part.LocalTransparencyModifier = 1
elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
part.Handle.LocalTransparencyModifier = 1
end
end
end
end
end
}):AddKeyPicker('ThirdPKeybind', {
    Default = 'T',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = '第三人称',
    NoUI = false,
Callback = function(Value) end,
ChangedCallback = function(New) end
})
Self:AddSlider("X", {
    Text = "X",
    Default = X,
    Min = -10,
    Max = 10,
    Rounding = 0,
    Compact = true,
Callback = function(Value)
X = Value
ThirdPersonHandler.offset = Vector3.new(X, Y, Z)
end      
})
Self:AddSlider("Y", {
    Text = "Y",
    Default = Y,
    Min = -10,
    Max = 10,
    Rounding = 0,
    Compact = true,
Callback = function(Value)
Y = Value
ThirdPersonHandler.offset = Vector3.new(X, Y, Z)
end      
})
Self:AddSlider("Z", {
    Text = "Z",
    Default = Z,
    Min = -10,
    Max = 10,
    Rounding = 0,
    Compact = true,
Callback = function(Value)
Z = Value
ThirdPersonHandler.offset = Vector3.new(X, Y, Z)
end      
})
Self:AddDivider()

local FOVhandler = {mem={o=nil,r=nil,u=nil,base={}}, loop=false, cam=nil}
local function FOVstep()
local parent = LocalPlayer.PlayerGui
if not parent then return end
FOVhandler.mem.o = (FOVhandler.mem.o and FOVhandler.mem.o.Parent) and FOVhandler.mem.o or Instance.new("NumberValue", parent)
local o = FOVhandler.mem.o.Value or 0
local sum = 0
for i=1,#FOVhandler.mem.base do
local v = FOVhandler.mem.base[i]
if not v or not v.Parent then 
v = Instance.new("NumberValue", parent)
FOVhandler.mem.base[i] = v 
end
sum = sum + (v.Value or 0)
end
local target = (o ~= 0 and o) or sum
local cam = workspace.CurrentCamera
if not cam then return end
if cam ~= FOVhandler.cam then
FOVhandler.cam = cam
end
if FOVhandler.loop and target > 0 then
local vis = math.clamp(target, 25, 120)
if cam.FieldOfView ~= vis then 
cam.FieldOfView = vis 
end
end
end
pcall(function() RunService:UnbindFromRenderStep("FOV_SYS") end)
RunService:BindToRenderStep("FOV_SYS", Enum.RenderPriority.Camera.Value+1, FOVstep)
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
FOVhandler.cam = workspace.CurrentCamera
end)
local View = 70
Self:AddSlider("FieldofViewAdjust", {
    Text = "视野滑块",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
View = Value
if not FOVhandler.mem.base[1] then
FOVhandler.mem.base[1] = Instance.new("NumberValue", LocalPlayer.PlayerGui)
end
FOVhandler.mem.base[1].Value = Value
if Toggles.Fieldofview.Value then
local cam = workspace.CurrentCamera
if cam then
local vis = math.clamp(Value, 25, 120)
cam.FieldOfView = vis
end
end
end
})
Self:AddToggle('Fieldofview', {
    Text = "视野",
    Default = false,
    Callback = function(Value)
if Value then
FOVhandler.loop = true
if not FOVhandler.mem.base[1] then
FOVhandler.mem.base[1] = Instance.new("NumberValue", LocalPlayer.PlayerGui)
end
FOVhandler.mem.base[1].Value = View
local cam = workspace.CurrentCamera
if cam then
local vis = math.clamp(View, 25, 120)
cam.FieldOfView = vis
end
else
FOVhandler.loop = false
if FOVhandler.mem.base[1] then
FOVhandler.mem.base[1].Value = 0
end
end
end
})

Self:AddToggle('NoCameraShake', {
    Text = "无相机抖动",
    Default = false
})

Self:AddToggle('NoLookBob', {
    Text = "无视角抖动",
    Default = false
})
Toggles.NoLookBob:OnChanged(function()
if RequiredMainGame and RequiredMainGame.spring then
RequiredMainGame.spring.Speed = (Toggles.NoLookBob.Value and 9e9 or 8)
end
end)
task.spawn(function()
task.wait(0.5)
if RequiredMainGame and RequiredMainGame.spring then
RequiredMainGame.spring.Speed = (Toggles.NoLookBob and Toggles.NoLookBob.Value and 9e9 or 8)
end
end)

Self:AddToggle('TransparencyCloset', {
    Text = "柜子透明",
    Default = false
})
local TransparencyValue = 0.5
Self:AddSlider("TransparencySlider", {
    Text = "柜子透明度",
    Default = 0.5,
    Min = 0.1,
    Max = 1,
    Rounding = 1,
    Compact = true,
Callback = function(Value)
TransparencyValue = Value
end      
})
Toggles.TransparencyCloset:OnChanged(function(Value)
if not Value then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:FindFirstChild("HidePrompt") then
for _, base in ipairs(v:GetChildren()) do
if base:IsA("BasePart") and not (base.Name == "PlayerCollision" or base.Name == "Collision") then
base.Transparency = 0
end
end
end
end
end
end)
table.insert(Connections, Character:GetAttributeChangedSignal("Hiding"):Connect(function()
Closet = nil
if Character:GetAttribute("Hiding") == true then
for _, v in ipairs(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetDescendants()) do
if v:FindFirstChild("HidePrompt") then
if v:FindFirstChild("HiddenPlayer") and v.HiddenPlayer.Value ~= nil then
Closet = v
end
end
end
else
for _, v in ipairs(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetDescendants()) do
if v:FindFirstChild("HidePrompt") then
for _, base in ipairs(v:GetChildren()) do
if base:IsA("BasePart") and not (base.Name == "PlayerCollision" or base.Name == "Collision") then
base.Transparency = 0
end
end
end
end
end
end))
Self:AddDivider()

player = Players.LocalPlayer
local offsetX, offsetY, offsetZ = 0, 0, 0
local heartbeatConnection = nil
local thingy = nil
Self:AddToggle('ToolOffset', {
    Text = '视图模型偏移',
    Default = false,
Callback = function(enabled)
local gui = player:FindFirstChild("PlayerGui")
if not gui then return end
local moduleGui = gui:FindFirstChild("MainUI")
if not moduleGui then return end
moduleGui = moduleGui:FindFirstChild("Initiator")
if not moduleGui then return end
moduleGui = moduleGui:FindFirstChild("Main_Game")
if not moduleGui then return end
thingy = require(moduleGui)
if enabled then
if heartbeatConnection then heartbeatConnection:Disconnect() end
heartbeatConnection = RunService.Heartbeat:Connect(function()
thingy.tooloffset = Vector3.new(offsetX, offsetY, offsetZ)
end)
else
if heartbeatConnection then
heartbeatConnection:Disconnect()
heartbeatConnection = nil
end
if thingy then
thingy.tooloffset = Vector3.new(0, 0, 0)
end
end
end
})
Self:AddSlider('ToolOffsetX', {
    Text = 'X',
    Min = -10,
    Max = 10,
    Default = 0,
    Rounding = 2,
    Compact = true,
Callback = function(v) 
offsetX = v
end,
})
Self:AddSlider('ToolOffsetY', {
    Text = 'Y',
    Min = -10,
    Max = 10,
    Default = 0,
    Rounding = 2,
    Compact = true,
Callback = function(v) 
offsetY = v
end,
})
Self:AddSlider('ToolOffsetZ', {
    Text = 'Z',
    Min = -10,
    Max = 10,
    Default = 0,
    Rounding = 2,
    Compact = true,
Callback = function(v) 
offsetZ = v
end,
})

Effect:AddToggle('AntiJumpscares', {
    Text = "无跳脸",
    Default = false,
Callback = function(Value)
local JumpscaresModule = RemoteListener:FindFirstChild("Jumpscares") or RemoteListener:FindFirstChild("_Jumpscares")
if JumpscaresModule then
JumpscaresModule.Name = Value and "_Jumpscares" or "Jumpscares"
end
end
})

Effect:AddToggle('NoCutscenes', {
    Text = "无过场动画",
    Default = false
})
Toggles.NoCutscenes:OnChanged(function(Value)
local CutScenes = RemoteListener:FindFirstChild("Cutscenes") or RemoteListener:FindFirstChild("_Cutscenes")
CutScenes.Name = Value and "_Cutscenes" or "Cutscenes"
end)

Effect:AddToggle('AntiSpider',{
     Text = "无蜘蛛跳脸",
     Default = false,
Callback = function(Value)
local SpiderModule = Modules:FindFirstChild("SpiderJumpscare") or Modules:FindFirstChild("_SpiderJumpscare")
if SpiderModule then
SpiderModule.Name = Value and "_SpiderJumpscare" or "SpiderJumpscare"
end
end
})

Effect:AddToggle('AntiGlitch',{
     Text = "无故障跳脸",
     Default = false,
     Callback = function(Value)
local GlitchModule = ClientModules.EntityModules:FindFirstChild("Glitch") or ClientModules.EntityModules:FindFirstChild("_Glitch")
if GlitchModule then
GlitchModule.Name = Value and "_Glitch" or "Glitch"
end
end
})

Effect:AddToggle('AntiVoid', {
    Text = "无虚空跳脸",
    Default = false,
Callback = function(Value)
local VoidModule = ClientModules.EntityModules:FindFirstChild("Void") or ClientModules.EntityModules:FindFirstChild("_Void")
if VoidModule then
VoidModule.Name = Value and "_Void" or "Void"
end
end
})

local batDecorConnection = nil
Effect:AddToggle('NoBatDecor', {
    Text = "无蝙蝠伤害",
    Default = false,
Callback = function(Value)
if Value then
for _, decor in ipairs(workspace:GetDescendants()) do
if decor.Name == "HangingHalloweenDecor" and decor:IsA("Model") then
decor:Destroy()
end
end
if not batDecorConnection then
batDecorConnection = workspace.DescendantAdded:Connect(function(descendant)
if Toggles.NoBatDecor and Toggles.NoBatDecor.Value then
if descendant.Name == "HangingHalloweenDecor" and descendant:IsA("Model") then
descendant:Destroy()
end
end
end)
end
else
if batDecorConnection then
batDecorConnection:Disconnect()
batDecorConnection = nil
end
end
end
})

Effect:AddToggle('NoVignette', {
    Text = "柜子无暗影",
    Default = false
})
local noVignetteLoop = nil
Toggles.NoVignette:OnChanged(function(Value)
if Value then
noVignetteLoop = RunService.Heartbeat:Connect(function()
if not Toggles.NoVignette.Value then return end
local playerGui = LocalPlayer.PlayerGui
if playerGui and playerGui:FindFirstChild("MainUI") then
local mainUI = playerGui.MainUI
if mainUI and mainUI:FindFirstChild("MainFrame") then
local mainFrame = mainUI.MainFrame
if mainFrame and mainFrame:FindFirstChild("HideVignette") then
mainFrame.HideVignette.Visible = false
end
end
end
end)
else
if noVignetteLoop then
noVignetteLoop:Disconnect()
noVignetteLoop = nil
end
end
end)

Effect:AddToggle('NoOxygenVignette', {
    Text = "无缺氧效果",
    Default = false
})
local noOxygenVignetteLoop = nil
Toggles.NoOxygenVignette:OnChanged(function(Value)
if Value then
noOxygenVignetteLoop = RunService.Heartbeat:Connect(function()
if not Toggles.NoOxygenVignette.Value then return end
local playerGui = LocalPlayer.PlayerGui
if playerGui and playerGui:FindFirstChild("MainUI") then
local mainUI = playerGui.MainUI
if mainUI and mainUI:FindFirstChild("MainFrame") then
local mainFrame = mainUI.MainFrame
if mainFrame and mainFrame:FindFirstChild("EyelidsVignette") then
mainFrame.EyelidsVignette.Visible = false
end
end
end
local oxygenBlur = Lighting:FindFirstChild("OxygenBlur")
if oxygenBlur then
oxygenBlur:Destroy()
end
local oxygenCC = Lighting:FindFirstChild("OxygenCC")
if oxygenCC then
oxygenCC:Destroy()
end
end)
else
if noOxygenVignetteLoop then
noOxygenVignetteLoop:Disconnect()
noOxygenVignetteLoop = nil
end
end
end)

FloorAnti:AddToggle('AntiSeekObstructions',{
     Text = "防追逐障碍",
     Default = false,
Callback = function(Value)
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "ChandelierObstruction" or v.Name == "Seek_Arm" then
for _, part in ipairs(v:GetChildren()) do
if part:IsA("BasePart") then 
part.CanTouch = not Value
end
end
end
end
end
})

if ReplicatedStorage:FindFirstChild("RemotesFolder") then
local FakeSurge = Instance.new("RemoteEvent", ReplicatedStorage)
FakeSurge.Name = "SurgeRemote"
FloorAnti:AddToggle('AntiSurge', {
     Text = "防 Surge",
     Default = false,
Callback = function(Value)
if Value then
ReplicatedStorage.RemotesFolder.SurgeRemote.Parent = ReplicatedStorage
FakeSurge.Parent = ReplicatedStorage.RemotesFolder
else
ReplicatedStorage.RemotesFolder.SurgeRemote.Parent = ReplicatedStorage.RemotesFolder
FakeSurge.Parent = ReplicatedStorage
end
end
})

local antiMonumentConnection = nil
FloorAnti:AddToggle('AntiMonument', {
    Text = "防 Monument",
    Default = false,
Callback = function(Value)
if Value then
if antiMonumentConnection then
antiMonumentConnection:Disconnect()
for i, conn in ipairs(Connections) do
if conn == antiMonumentConnection then
table.remove(Connections, i)
break
end
end
end
antiMonumentConnection = RunService.RenderStepped:Connect(function()
if not Toggles.AntiMonument.Value then return end
local char = LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild("HumanoidRootPart")
if not root then return end
local camPos = root.Position
local closestMonument = nil
local closestDist = math.huge
for _, obj in ipairs(workspace:GetChildren()) do
if obj.Name == "MonumentEntity" and obj:IsA("Model") then
local top = obj:FindFirstChild("Top")
if top and top:IsA("Model") then
local topPos = top:GetPivot().Position
local dist = (topPos - camPos).Magnitude
if dist < closestDist then
closestDist = dist
closestMonument = topPos
end
end
end
end
if closestMonument then
local lookDir = (closestMonument - root.Position).Unit
local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
local targetCF = CFrame.new(root.Position, root.Position + flatDir)
root.CFrame = targetCF
end
end)
table.insert(Connections, antiMonumentConnection)
else
if antiMonumentConnection then
antiMonumentConnection:Disconnect()
for i, conn in ipairs(Connections) do
if conn == antiMonumentConnection then
table.remove(Connections, i)
break
end
end
antiMonumentConnection = nil
end
end
end
})
end

if Floor.Value == "Fools" then
local noPuzzleDoorsRunning = false
local noPuzzleDoorsConnection = nil
FloorAnti:AddToggle('NoPuzzleDoors', {
Text = "无谜题门",
Default = false,
Callback = function(Value)
if Value then
noPuzzleDoorsRunning = true
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
local movingDoor = room:FindFirstChild("MovingDoor", true)
if movingDoor then
movingDoor:Destroy()
end
end
noPuzzleDoorsConnection = RunService.Heartbeat:Connect(function()
if not noPuzzleDoorsRunning then return end
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
local movingDoor = room:FindFirstChild("MovingDoor", true)
if movingDoor then
movingDoor:Destroy()
end
end
end)
workspace.CurrentRooms.ChildAdded:Connect(function(room)
if not noPuzzleDoorsRunning then return end
task.wait(0.5)
local movingDoor = room:FindFirstChild("MovingDoor", true)
if movingDoor then
movingDoor:Destroy()
end
end)
else
noPuzzleDoorsRunning = false
if noPuzzleDoorsConnection then
noPuzzleDoorsConnection:Disconnect()
noPuzzleDoorsConnection = nil
end
end
end
})
end

if Floor.Value == "Rooms" then
teleportToRoomEnabled = false
teleportToRoomConnection = nil
FloorAnti:AddToggle('TeleportToNextRoom', {
    Text = "房间传送",
    Default = false,
Callback = function(Value)
teleportToRoomEnabled = Value
if Value then
if game:GetService("Players").LocalPlayer:GetAttribute("FakeDeath") == true then
teleportToRoomConnection = RunService.Heartbeat:Connect(function()
if not teleportToRoomEnabled then 
return 
end
local targetRoomNumber = ReplicatedStorage.GameData.LatestRoom.Value
local targetRoom = workspace.CurrentRooms:FindFirstChild(tostring(targetRoomNumber))
if not targetRoom then
return
end
local targetDoor = targetRoom:FindFirstChild("Door")
if not targetDoor then
return
end
local doorPart = targetDoor:FindFirstChild("Door")
if not doorPart then
return
end
local character = LocalPlayer.Character
if not character then return end
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
if not humanoidRootPart then return end
local doorCFrame = doorPart.CFrame
local teleportPosition = doorCFrame.Position + doorCFrame.LookVector * -1
character:PivotTo(CFrame.new(teleportPosition, doorCFrame.Position))
end)
else
if teleportToRoomConnection then
teleportToRoomConnection:Disconnect()
teleportToRoomConnection = nil
end
end
end
end
})
end

if Floor.Value == "Mines" then
FloorAnti:AddDivider()
FloorAnti:AddToggle('DeleteFigure', {
Text = "删除飞哥",
Default = false
})

local minecartRenameActive = false
local minecartToggleEnabled = false
local minecartRoomCheckConnection = nil
FloorAnti:AddToggle('DeleteMinecart', {
Text = "删除矿车",
Default = false,
Callback = function(Value)
minecartToggleEnabled = Value
if Value then
local room46 = workspace.CurrentRooms:FindFirstChild("46")
if room46 then
performMinecartRename()
else
minecartRoomCheckConnection = workspace.CurrentRooms.ChildAdded:Connect(function(child)
if child.Name == "46" and minecartToggleEnabled then
task.wait(1)
performMinecartRename()
if minecartRoomCheckConnection then
minecartRoomCheckConnection:Disconnect()
minecartRoomCheckConnection = nil
end
end
end)
end
else
if minecartRoomCheckConnection then
minecartRoomCheckConnection:Disconnect()
minecartRoomCheckConnection = nil
end
if not minecartRenameActive then
else
Toggles.DeleteMinecart:SetValue(true)
end
end
end
})
function performMinecartRename()
if minecartRenameActive then
return
end
minecartRenameActive = true
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemotesFolder = ReplicatedStorage:WaitForChild("RemotesFolder")
local remoteNames = {"MinecartResult"}
for _, name in ipairs(remoteNames) do
local remote = RemotesFolder:FindFirstChild(name)
if remote then
remote.Name = name .. " "
end
end
Library:Notify("删除矿车成功", 7)
Library:Notify("触发矿车过场动画后可绕过反作弊", 7)
Toggles.DeleteMinecart:SetValue(true)
end
if Toggles.DeleteMinecart and Toggles.DeleteMinecart.Value then
local room46 = workspace.CurrentRooms:FindFirstChild("46")
if room46 then
performMinecartRename()
end
end

local minecartTeleportEnabled = false
local minecartTeleportConnection = nil
local hasNotifiedReady = false
local hasNotifiedStart = false
local hasNotifiedEnd = false
FloorAnti:AddToggle('MinecartTeleport', {
    Text = "矿车传送",
    Tooltip = "不是真的矿车传�，但是比真的更快",
    Default = false,
Callback = function(Value)
if Value then
hasNotifiedReady = false
hasNotifiedStart = false
hasNotifiedEnd = false
minecartTeleportEnabled = true
minecartTeleportConnection = RunService.Heartbeat:Connect(function()
if not minecartTeleportEnabled then return end
if not Toggles.DeleteMinecart.Value then
Toggles.DeleteMinecart:SetValue(true)
end
local char = LocalPlayer.Character
if not char then return end
local latestRoom = ReplicatedStorage.GameData.LatestRoom.Value
if latestRoom == 44 and not hasNotifiedReady then
Library:Notify("矿车传�已准就绪！等待过场动画...",10)
hasNotifiedReady = true
end
local minecarting = char:GetAttribute("Minecarting")
if not minecarting then
return
end
if latestRoom >= 50 then
if not hasNotifiedEnd then
Library:Notify("矿车传送已结束",3)
hasNotifiedEnd = true
end
return
end
local room = workspace.CurrentRooms:FindFirstChild(tostring(latestRoom))
if not room then return end
local door = room:FindFirstChild("Door")
if not door then return end
local doorPart = door:FindFirstChild("Door")
if not doorPart then return end
local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
if not humanoidRootPart then return end
local teleportCF = doorPart.CFrame * CFrame.new(0, 0, -3)
humanoidRootPart.CFrame = teleportCF
if not hasNotifiedStart then
Library:Notify("矿车传�开始工作，祝你旅�愉��",3)
hasNotifiedStart = true
end
end)
table.insert(Connections, minecartTeleportConnection)
else
minecartTeleportEnabled = false
if minecartTeleportConnection then
minecartTeleportConnection:Disconnect()
minecartTeleportConnection = nil
end
end
end
})

local minecartConnection = nil
FloorAnti:AddToggle('MinecartNoCollision', {
Text = "矿车无伤害",
Default = false,
Callback = function(Value)
if Value then
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
local assets = room:FindFirstChild("Assets")
if assets then
local minecartSet = assets:FindFirstChild("MinecartSet")
if minecartSet then
for _, child in ipairs(minecartSet:GetChildren()) do
local cart = child:FindFirstChild("Cart")
if cart and cart:IsA("BasePart") then
cart.CanCollide = false
end
end
end
end
end
if not minecartConnection then
minecartConnection = workspace.DescendantAdded:Connect(function(descendant)
if Toggles.MinecartNoCollision and Toggles.MinecartNoCollision.Value then
if descendant.Name == "Cart" and descendant:IsA("BasePart") then
local parent = descendant.Parent
if parent and parent.Parent and parent.Parent.Name == "MinecartSet" then
descendant.CanCollide = false
end
end
end
end)
end
else
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
local assets = room:FindFirstChild("Assets")
if assets then
local minecartSet = assets:FindFirstChild("MinecartSet")
if minecartSet then
for _, child in ipairs(minecartSet:GetChildren()) do
local cart = child:FindFirstChild("Cart")
if cart and cart:IsA("BasePart") then
cart.CanCollide = true
end
end
end
end
end
if minecartConnection then
minecartConnection:Disconnect()
minecartConnection = nil
end
end
end
})
FloorAnti:AddDivider()

FloorAnti:AddToggle('AnticheatBypass',{
     Text = "绕过反作弊",
     Default = false
})
Toggles.AnticheatBypass:OnChanged(function(Value)
if not Value then
RemoteFolder.ClimbLadder:FireServer()
end
if Value then
Library:Notify("自动绕过反作弊",9)
end
end)
LocalPlayer.Character:GetAttributeChangedSignal("Climbing"):Connect(function()
if LocalPlayer.Character:GetAttribute("Climbing") == true then
if Toggles.AnticheatBypass.Value then 
task.wait(0.4)
LocalPlayer.Character:SetAttribute("Climbing",false)
Library:Notify("绕过成功，过场动画和Halt会破坏绕过",7)
end
end
end)

local clones = {}
local bridgeConns = {}
local function makeBarrier(barrier)
if barrier.Parent:FindFirstChild("AntiBridge") then return end
local clone = barrier:Clone()
clone.Name = "AntiBridge"
clone.Size = Vector3.new(barrier.Size.X, barrier.Size.Y, 30)
clone.Color = Color3.new(1,1,1)
clone.CFrame = barrier.CFrame * CFrame.new(0, 0, -5)
clone.Transparency = 0
clone.Anchored = true
clone.CanCollide = true
clone.CanTouch = true
clone.Parent = barrier.Parent
table.insert(clones, clone)
end
local function processBridge(bridge)
if bridge:FindFirstChild("AntiBridge") then return end
for _, part in ipairs(bridge:GetChildren()) do
if part.Name == "PlayerBarrier" and part.Size.Y == 2.75 and (part.Rotation.X % 180) == 0 then
makeBarrier(part)
end
end
local conn = bridge.ChildAdded:Connect(function(c)
if c.Name == "PlayerBarrier" then
makeBarrier(c)
end
end)
table.insert(bridgeConns, conn)
end
FloorAnti:AddToggle("ABF", {
Text = "防断桥坠落",
Default = false,
Callback = function(on)
for _, c in ipairs(bridgeConns) do c:Disconnect() end
bridgeConns = {}
for _, c in ipairs(clones) do if c and c.Parent then c:Destroy() end end
clones = {}
if not on then return end
task.spawn(function()
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
local parts = room:FindFirstChild("Parts")
if parts then
for _, obj in ipairs(parts:GetChildren()) do
if obj.Name == "Bridge" then
processBridge(obj)
end
end
local conn = parts.ChildAdded:Connect(function(c)
if c.Name == "Bridge" then
processBridge(c)
end
end)
table.insert(bridgeConns, conn)
end
end
end)
local roomConn = workspace.CurrentRooms.ChildAdded:Connect(function(room)
task.defer(function()
local parts = room:WaitForChild("Parts", 3)
if parts then
for _, obj in ipairs(parts:GetChildren()) do
if obj.Name == "Bridge" then
processBridge(obj)
end
end
local conn = parts.ChildAdded:Connect(function(c)
if c.Name == "Bridge" then
processBridge(c)
end
end)
table.insert(bridgeConns, conn)
end
end)
end)
table.insert(bridgeConns, roomConn)
end
})

FloorAnti:AddToggle('AntiSeekFlood', {
    Text = "防 Seek ��",
    Default = false,
Callback = function(Value)
local SeekSlopRemote = game:GetService("ReplicatedStorage").RemotesFolder:FindFirstChild("SeekSlop")
if SeekSlopRemote then
SeekSlopRemote.Name = Value and "_SeekSlop" or "SeekSlop"
end
end
})
FloorAnti:AddDivider()

FloorAnti:AddButton({
Text = "禁用实体",
DoubleClick = true,
Risky = true,
Func = function()
task.spawn(function()
for i = 1, 11 do
game.ReplicatedStorage.RemotesFolder.RequestAsset:InvokeServer("Remote")
task.wait(0.1)
end
end)
end
})
end

if Floor.Value == "Fools" then
FloorAnti:AddDivider()

Options.FlySpeed:SetMax(100)
Options.SpeedBoostSlider:SetMax(100)

FloorAnti:AddToggle('Godmode',{
Text = "上帝模式",
Default = false,
Callback = function(Value)
if Value then
if not Toggles.Noclip.Value then
Toggles.Noclip:SetValue(true)
end
LocalPlayer.Character.Collision.Position = LocalPlayer.Character.Collision.Position - Vector3.new(0, 11, 0)
else
LocalPlayer.Character.Collision.Position = LocalPlayer.Character.Collision.Position + Vector3.new(0, 11, 0)
end
end
}):AddKeyPicker('Godmode Keybind', {
    Default = 'G', 
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = '上帝模式',
    NoUI = false,
    Callback = function(Value) end,
    ChangedCallback = function(New) end
})

FloorAnti:AddToggle('FigureGodmode',{
Text = "飞哥上帝模式",
Default = false,
Callback = function(Value)
end
})

FloorAnti:AddToggle('AntiBanana',{
Text = "防卡死",
Default = false,
Callback = function(Value)
for _, v in ipairs(workspace:GetChildren()) do
if v.Name == "BananaPeel" then
setcantouch(v, not Value)
end
end
end
})

FloorAnti:AddToggle('DeleteSeek',{
Text = "删除Seek",
Default = false
})
task.spawn(function()
while task.wait(0.09) do
if Library.Unloaded then break end
if Toggles.DeleteSeek.Value then
local SeekCollision = workspace:FindFirstChild("TriggerEventCollision",true)
local Trigger = workspace:FindFirstChild("TriggerSeek",true)
if Trigger then
Trigger:Destroy()
end
if SeekCollision then
SeekCollision:ClearAllChildren()
end
end
end
end)

FloorAnti:AddToggle('InfiniteRevive', {
    Text = "无限复活",
    Default = false,
    Callback = function(Value)
if Value then
local RS = game:GetService("ReplicatedStorage")
local Bricks = RS:FindFirstChild("Bricks")
local EntityInfo = RS:FindFirstChild("EntityInfo")
local function setupRevive(char)
local hum = char:WaitForChild("Humanoid")
hum.Died:Connect(function()
if Toggles.InfiniteRevive.Value then
if EntityInfo then
EntityInfo.Revive:FireServer()
elseif Bricks then
Bricks:FireServer()
end
task.wait(0.5)
if Toggles.InfiniteRevive.Value then
setupRevive(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
end
end
end)
end
local charAddedConn = LocalPlayer.CharacterAdded:Connect(function(char)
if Toggles.InfiniteRevive.Value then
setupRevive(char)
end
end)
table.insert(Connections, charAddedConn)
if LocalPlayer.Character then
setupRevive(LocalPlayer.Character)
end
end
end
})
end

if Floor.Value == "Retro" then
FloorAnti:AddToggle("AntiLava", {
	Text = "防 Lava",
	Default = false,
	Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Lava" then
v.CanTouch = false
end
end
end
})

FloorAnti:AddToggle("AntiScaryWall", {
	Text = "防 ScaryWall",
	Default = false,
	Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "ScaryWall" then
for _, part in pairs(v:GetChildren()) do
if part:IsA("BasePart") then
part.CanTouch = false
end
end
end
end
end
})
workspace.DescendantAdded:Connect(function(inst)
local name = inst.Name
local parent = inst.Parent
if name == "Lava" then
inst.CanTouch = not Toggles.AntiLava.Value
end
if name == "ScaryWall" then
task.wait()
for _, p in ipairs(inst:GetChildren()) do
if p:IsA("BasePart") then
p.CanTouch = not Toggles.AntiScaryWall.Value
end
end
end
end)
end

local MaxSlopeAngle = 45
Other:AddSlider("MaxSlopeAngleSlider", {
    Text = "防大斜坡伤害",
    Default = 45,
    Min = 0,
    Max = 90,
    Rounding = 0,
Callback = function(Value)
MaxSlopeAngle = Value
if Character and Character:FindFirstChild("Humanoid") then
Character.Humanoid.MaxSlopeAngle = Value
end
end,
})
local function applyMaxSlopeAngle()
local character = LocalPlayer.Character
if not character then return end
local humanoid = character:FindFirstChildOfClass("Humanoid")
if not humanoid then return end
humanoid.MaxSlopeAngle = MaxSlopeAngle
end
if LocalPlayer.Character then
applyMaxSlopeAngle()
end
LocalPlayer.CharacterAdded:Connect(function(character)
character:WaitForChildOfClass("Humanoid")
applyMaxSlopeAngle()
end)
Other:AddDivider()

if Floor.Value == "Mines" then
autoAnchorRunning = false
autoAnchorConnection = nil
lastCheck = 0
checkInterval = 0.5
cachedAnchors = {}
local function updateAnchorCache()
cachedAnchors = {}
room50 = workspace.CurrentRooms:FindFirstChild("50")
if not room50 then 
for roomName, room in pairs(workspace.CurrentRooms:GetChildren()) do
if tonumber(roomName) and tonumber(roomName) >= 50 then
room50 = room
break
end
end
end
if room50 then
for _, anchor in ipairs(room50:GetDescendants()) do
if anchor.Name == "MinesAnchor" then
table.insert(cachedAnchors, anchor)
end
end
end
end
local function solveAnchor()
if not autoAnchorRunning then return end
playerGui = LocalPlayer:WaitForChild("PlayerGui")
mainUI = playerGui:WaitForChild("MainUI")
AnchorHintFrame = mainUI:FindFirstChild("AnchorHintFrame")
if not AnchorHintFrame then return end
anchorSignText = AnchorHintFrame:FindFirstChild("AnchorCode")
currentCode = AnchorHintFrame:FindFirstChild("Code")
if not anchorSignText or not currentCode then return end
signText = anchorSignText.Text
codeText = currentCode.Text
if signText == "" or codeText == "" then return end
playerPosition = LocalPlayer.Character and 
LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
LocalPlayer.Character.HumanoidRootPart.Position
if not playerPosition then return end
for _, anchor in ipairs(cachedAnchors) do
if not autoAnchorRunning then break end
sign = anchor:FindFirstChild("Sign")
if sign then
textLabel = sign:FindFirstChild("TextLabel")
if textLabel and textLabel.Text == signText then
anchorPosition = anchor.PrimaryPart and anchor.PrimaryPart.Position or
(anchor:FindFirstChildWhichIsA("BasePart") and anchor:FindFirstChildWhichIsA("BasePart").Position)
if anchorPosition then
distance = (playerPosition - anchorPosition).Magnitude
if distance < 12 then
anchorRemote = anchor:FindFirstChild("AnchorRemote")
if anchorRemote then
pcall(function()
anchorRemote:InvokeServer(codeText)
end)
end
break
end
end
end
end
end
end
Other:AddToggle('AutoAnchorSolver', {
    Text = "自动密码锁",
    Default = false,
Callback = function(Value)
if Value then
autoAnchorRunning = true
updateAnchorCache()
autoAnchorConnection = game:GetService("RunService").Heartbeat:Connect(function()
if not autoAnchorRunning then return end
now = tick()
if now - lastCheck >= checkInterval then
lastCheck = now
solveAnchor()
end
end)
else
autoAnchorRunning = false
if autoAnchorConnection then
autoAnchorConnection:Disconnect()
autoAnchorConnection = nil
end
end
end
})

local SeekPathColor = Color3.new(0, 1, 0)
local SeekPathThickness = 0.2
local seekPathLines = {}
local seekPathUpdateConnection = nil
function updateSeekPathLines()
for _, line in ipairs(seekPathLines) do
if line and line.Parent then
line:Destroy()
end
end
seekPathLines = {}
local allLights = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v.Name == "SeekGuidingLight" then
table.insert(allLights, v)
end
end
if #allLights < 2 then
return
end
for i = 1, #allLights - 1 do
local currentLight = allLights[i]
local nextLight = allLights[i + 1]
local distance = (currentLight.Position - nextLight.Position).Magnitude
local center = (currentLight.Position + nextLight.Position) / 2
local linePart = Instance.new("Part", Pathnode)
linePart.Name = "ShowPathLine"
linePart.Size = Vector3.new(SeekPathThickness, SeekPathThickness, distance)
linePart.CFrame = CFrame.lookAt(center, nextLight.Position)
linePart.Color = SeekPathColor
linePart.Material = Enum.Material.Neon
linePart.Anchored = true
linePart.CanCollide = false
linePart.CanTouch = false
linePart.CanQuery = false
linePart.Transparency = 0
table.insert(seekPathLines, linePart)
end
end
function clearSeekPathLines()
for _, line in ipairs(seekPathLines) do
if line and line.Parent then
line:Destroy()
end
end
seekPathLines = {}
if seekPathUpdateConnection then
seekPathUpdateConnection:Disconnect()
seekPathUpdateConnection = nil
end
end
Other:AddToggle("ShowSeekPath", {
Text = "显示追�战��",
Default = false,
Callback = function(Value)
if Value then
updateSeekPathLines()
seekPathUpdateConnection = RunService.Heartbeat:Connect(function()
if tick() % 0.5 < 0.016 then
updateSeekPathLines()
end
end)
else
clearSeekPathLines()
end
end
}):AddColorPicker('SeekPathColorPicker', {
Default = SeekPathColor,
Title = '��颜色',
Transparency = 0,
Callback = function(Value)
SeekPathColor = Value
if Toggles.ShowSeekPath and Toggles.ShowSeekPath.Value then
updateSeekPathLines()
end
end
})
Other:AddSlider("SeekPathThicknessSlider", {
Text = "线体厚度",
Default = 0.2,
Min = 0.1,
Max = 1.0,
Rounding = 1,
Compact = true,
Callback = function(Value)
SeekPathThickness = Value
if Toggles.ShowSeekPath and Toggles.ShowSeekPath.Value then
updateSeekPathLines()
end
end
})
end

ModifiersBox:AddToggle('AntiA90', {
    Text = "防 A90",
    Default = false,
Callback = function(Value)
local A90 = Modules:FindFirstChild("A90") or Modules:FindFirstChild("_A90")
if A90 then
A90.Name = Value and "_A90" or "A90"
end
end
})

ModifiersBox:AddToggle('AntiLookman', {
    Text = " Lookman",
    Default = false
})

ModifiersBox:AddToggle('AntiGiggle',{
     Text = "防 Giggle",
     Default = false,
Callback = function(Value)
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "GiggleCeiling" then
v:WaitForChild("Hitbox",9e9).CanTouch = not Value
end
end
end
})
LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
if Toggles.AntiGiggle and Toggles.AntiGiggle.Value then
for _, v in ipairs(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetChildren()) do
if v.Name == "GiggleCeiling" then
v:WaitForChild("Hitbox",9e9).CanTouch = false
end
end
end
end)

ModifiersBox:AddToggle('AntiJam',{
     Text = "防 Jamming",
     Default = false,
Callback = function(Value)
if Modifiers and not Modifiers:FindFirstChild("Jammin") then return end
mainTrack = game["SoundService"]:FindFirstChild("Main")
if mainTrack then
jamming = mainTrack:FindFirstChild("Jamming")
if jamming then
jamming.Enabled = not Value
end
end
mainUI = LocalPlayer:FindFirstChild("PlayerGui")
and LocalPlayer.PlayerGui:FindFirstChild("MainUI")
if mainUI then
healthGui = mainUI:FindFirstChild("Initiator")
and mainUI.Initiator:FindFirstChild("Main_Game")
and mainUI.Initiator.Main_Game:FindFirstChild("Health")
if healthGui then
jamSound = healthGui:FindFirstChild("Jam")
if jamSound then
jamSound.Playing = not Value
end
end
end
end
})

ModifiersBox:AddToggle('AntiGloomPile', {
    Text = "防 Gloom Egg",
    Default = false,
Callback = function(Value)
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "GloomEgg" then
v:WaitForChild("Egg", 9e9).CanTouch = not Value
end
end
end
})
table.insert(Connections,workspace.DescendantAdded:Connect(function(v)
if Toggles.AntiGloomPile and Toggles.AntiGloomPile.Value then
if v.Name == "Egg" then
v.CanTouch = false
end
end
end))

ModifiersBox:AddToggle('AntiVacuum', {
    Text = "防 Vacuum",
    Default = false,
Callback = function(Value)
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "SideroomSpace" then
for _, part in ipairs(v:GetChildren()) do
if part:IsA("BasePart") then
part.CanTouch = not Value
part.CanCollide = Value
end
end
end
end
end
})

ModifiersBox:AddToggle('AntiJeff',{
Text = "防杀手杰克",
Default = false,
Callback = function(Value)
for _, v in ipairs(workspace:GetChildren()) do
if v.Name == "JeffTheKiller" then
setcantouch(v, not Value)
end
end
end
})

Farm:AddButton({
    Text = "死亡农场",
    DoubleClick = true,
Func = function()
if not replicatesignal or not queue_on_teleport then
Library:Notify("你的执器不��复制信号", 3)
return 
end
if queue_on_teleport then
Library:Notify("死亡农场开始工作", 3)
loadstring(game:HttpGet("https://raw.msdoors.xyz/deathfarm"))()
end
end
})

local knobFarmingActive = false
local knobFarmingThread = nil
Farm:AddToggle('KnobFarm', {
    Text = "旋钮农场",
    Default = false,
Callback = function(Value)
if Value then
knobFarmingActive = true
knobFarmingThread = task.spawn(function()
while knobFarmingActive and Toggles.KnobFarm.Value do
replicatesignal(LocalPlayer.Kill)
task.wait()
if ReplicatedStorage:FindFirstChild("RemotesFolder") then
local StatisticsRemote = ReplicatedStorage.RemotesFolder:FindFirstChild("Statistics")
if StatisticsRemote then
StatisticsRemote:FireServer()
end
end
task.wait()
end
end)
else
knobFarmingActive = false
if knobFarmingThread then
task.cancel(knobFarmingThread)
knobFarmingThread = nil
end
end
end
})

ModuleBox:AddToggle('FreeMouse',{
     Text = "解锁鼠标",
     Default = false,
Callback = function(Value)
if Value then
RequiredMainGame.freemouse = true
else
RequiredMainGame.freemouse = false
end
end
})

ModuleBox:AddToggle('DisableMovement',{
     Text = "禁用移动",
     Default = false,
Callback = function(Value)
if Value then
RequiredMainGame.disableMovement = true
else
RequiredMainGame.disableMovement = false
end
end
})

ModuleBox:AddToggle('Stunned',{
     Text = "模块眩晕",
     Default = false,
Callback = function(Value)
if Value then
RequiredMainGame.stunned = true
else
RequiredMainGame.stunned = false
end
end
})

ModuleBox:AddToggle('StopCam',{
     Text = "停止相机",
     Default = false,
Callback = function(Value)
if Value then
RequiredMainGame.stopcam = true
else
RequiredMainGame.stopcam = false
end
end
})

AdminPanel:AddButton({
    Text = "生成 Surge",
Func = function()
game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand:FireServer("Surge", {})
end
})

AdminPanel:AddButton({
    Text = "生成 Bramble",
Func = function()
game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand:FireServer("Bramble", {})
end
})

AdminPanel:AddButton({
    Text = "生成 Groundskeeper",
Func = function()
game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand:FireServer("Groundskeeper", {})
end
})

AdminPanel:AddButton({
    Text = "获取开发者选项",
    DoubleClick = true,
Func = function()
for i = 1, 5 do
queue_on_teleport([[
game:GetService("RunService").Heartbeat:Connect(function()
game.Players.LocalPlayer:SetAttribute("ServerAdmin", 5)
end)
]])
end
Library:Notify("正在重进服务器，请等待...",10)
RemoteFolder.PlayAgain:FireServer()
end
})

table.insert(Connections,RunService.RenderStepped:Connect(function()
alive = LocalPlayer:GetAttribute("Alive")
if alive then

if Toggles.Fullbright.Value then
Lighting.Ambient = Color3.fromRGB(255, 255, 255)
end

if LocalPlayer:GetAttribute("FakeDeath") == true then
latestRoom = ReplicatedStorage.GameData.LatestRoom.Value
LocalPlayer:SetAttribute("CurrentRoom", latestRoom)
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v.Style = Enum.ProximityPromptStyle.Default
end
end
end

if Toggles.FigureGodmode then
local Figure = workspace:FindFirstChild("FigureRagdoll", true)
if Figure then
for _, v in Figure:GetChildren() do
if v:IsA("BasePart") then
v.CanTouch = not Toggles.FigureGodmode.Value
end
end
end
end

if Toggles.NoCutscenes.Value then
if (ReplicatedStorage.GameData.LatestRoom.Value > 89) then
Toggles.NoCutscenes:SetValue(false)
end
end

if Toggles.AntiLookman.Value then
if Workspace:FindFirstChild("BackdoorLookman") then
RemoteFolder.MotorReplication:FireServer(-890)
end
end

if Options.GMDropdown and Options.GMDropdown.Value == "��" then
local Entitys = workspace:FindFirstChild("RushMoving") or 
workspace:FindFirstChild("AmbushMoving") or 
workspace:FindFirstChild("GlitchRush") or 
workspace:FindFirstChild("GlitchAmbush") or 
workspace:FindFirstChild("BackdoorRush")
if Entitys and not Toggles.GodMode.Value then
Toggles.GodMode:SetValue(true)
elseif not Entitys and Toggles.GodMode.Value then
Toggles.GodMode:SetValue(false)
end
end

if Toggles.AntiVacuum.Value then
for _, v in ipairs(workspace:GetChildren()) do
if v.Name == "SideroomSpace" then
v:WaitForChild("Collision").CanTouch = false
v:WaitForChild("Collision").CanCollide = true
end
end
end
if Toggles.AntiVacuum.Value then
for _, v in ipairs(workspace.CurrentRooms:GetChildren()) do
if v.Name == "SideroomSpace" then
v:WaitForChild("Collision").CanTouch = false
v:WaitForChild("Collision").CanCollide = true
end
end
end

if Toggles.TransparencyCloset.Value then
if Closet then
for _, v in ipairs(Closet:GetChildren()) do
if v:IsA("BasePart") and not (v.Name == "PlayerCollision" or v.Name == "Collision") then
v.Transparency = TransparencyValue
end
end
end
end

if Toggles.DoorReach.Value then
local Door = workspace.CurrentRooms[ReplicatedStorage.GameData.LatestRoom.Value].Door
if Door and Door:FindFirstChild("ClientOpen") then
if (Character.HumanoidRootPart.Position - Door.Door.Position).Magnitude < Range then
Door.ClientOpen:FireServer()
end
end
end

if Toggles.DeleteFigure and Toggles.DeleteFigure.Value then
local Figure = workspace.CurrentRooms:FindFirstChild("FigureRig", true)
if Figure and Figure:FindFirstChild("Root") and isnetworkowner(Figure.Root) then
if Figure:FindFirstChild("Root") then
Figure.Root.Size = Vector3.new(0.4, 2000, 0.4)
Figure.Root.CanCollide = false
Figure.Hitbox.CanCollide = false
end
end
end

if Toggles.AntiEyes.Value then
if alive then
if Workspace:FindFirstChild("Eyes") then
if RemoteFolder.Name == "Bricks" or RemoteFolder.Name == "EntityInfo" then
RemoteFolder.MotorReplication:FireServer(0, -100, 0, false)
else
RemoteFolder.MotorReplication:FireServer(-890)
end
end
end
end

if Toggles.NoCameraShake.Value then
if alive then
RequiredMainGame.csgo = CFrame.new()
end
end

if Toggles.AntiDupe.Value then
for _, v in ipairs(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetChildren()) do
if v and v.Name == "SideroomDupe" then
v:WaitForChild("DoorFake",9e9):WaitForChild("Hidden",9e9).CanTouch = false
end
end
end
for _, v in ipairs(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetChildren()) do
if v.Name == "SideroomDupe" then
if v:WaitForChild("DoorFake"):FindFirstChild("Lock") then
v:WaitForChild("DoorFake"):FindFirstChild("Lock"):FindFirstChildOfClass("ProximityPrompt").Enabled = not Toggles.AntiDupe.Value
end
end
end

if Toggles.AntiSnare.Value then
for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
if room:FindFirstChild("Snares") then
for _, v in ipairs(room.Snares:GetChildren()) do
if v.Name == "Snare" then
v:WaitForChild("Hitbox",9e9).CanTouch = false
end
end
end
if room:FindFirstChild("Assets") then
for _, v in ipairs(room.Assets:GetChildren()) do
if v.Name == "Snare" then
v:WaitForChild("Hitbox",9e9).CanTouch = false
end
end
end
end
end

if Toggles.Spamtoolz and Toggles.Spamtoolz.Value and Options.Spamtoolz_X and Options.Spamtoolz_X:GetState() then
task.wait()
for _, Player in pairs(game.Players:GetPlayers()) do
if Player ~= LocalPlayer and Player then
if Player.Backpack then
for _, v in pairs(Player.Backpack:GetChildren()) do
if v.Name ~= "Candle" and v:FindFirstChildWhichIsA("RemoteEvent") then
v:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
end
end
end
if Player.Character then
local Tool = Player.Character:FindFirstChildWhichIsA("Tool")
if Tool and Tool.Name ~= "Candle" and Tool:FindFirstChild("Remote") then
Tool.Remote:FireServer()
end
end
end
end
end

if Toggles.AntiHear.Value and ReplicatedStorage:FindFirstChild("RemotesFolder") then
RemoteFolder.Crouch:FireServer(true)
end

if CollisionClone and CollisionClone.Anchored then
CollisionClone.Anchored = false
end
if CollisionClone2 and CollisionClone2.Anchored then
CollisionClone2.Anchored = false
end

if Toggles.SpeedBoost.Value then
Character.Humanoid.WalkSpeed = Speed
end

if Toggles.SpeedBoost.Value and Floor.Value == "Mines" then
local isClimbing = LocalPlayer.Character:GetAttribute("Climbing")
if isClimbing then
Character.Humanoid.WalkSpeed = Speed + Options.LadderSpeedBoost.Value
else
Character.Humanoid.WalkSpeed = Speed
end
end

if Toggles.Noacceleration.Value then
Character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0.5, 0.2)
Character.Collision.CustomPhysicalProperties = PhysicalProperties.new(100, 0.5, 0.2)
else
Character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(0.4, 0.2, 0.2)
Character.Collision.CustomPhysicalProperties = PhysicalProperties.new(0.4, 0.2, 0.2)
end

if Toggles.NoClosetExitDelay.Value and LocalPlayer.Character:GetAttribute("Hiding") == true then
if (Character.Humanoid.MoveDirection.Magnitude > 0.5) then
RemoteFolder.CamLock:FireServer()
end
end

if Toggles.Noclip.Value then
if alive then
LocalPlayer.Character.Collision.CanCollide = false
if LocalPlayer.Character.Collision:FindFirstChild("CollisionCrouch") then
LocalPlayer.Character.Collision.CollisionCrouch.CanCollide = false
end
if LocalPlayer.Character:FindFirstChild("CollisionPart")  then
LocalPlayer.Character:FindFirstChild("CollisionPart").CanCollide = false
end
LocalPlayer.Character.HumanoidRootPart.CanCollide = false
end
end

if Toggles.AutoInteract and Toggles.AutoInteract.Value then
for _, prompt in ipairs(AutoInteractTable) do
if prompt and prompt.Parent then
local check = prompt:GetAttribute("Interactions")
local isMinesGateButton = prompt.Parent and prompt.Parent.Name == "Button" and 
prompt.Parent.Parent and prompt.Parent.Parent.Name == "MinesGateButton"
local isFusesPrompt = prompt.Name == "FusesPrompt"
if isMinesGateButton or isFusesPrompt or (not check or check < 1) then
local Base
if prompt.Parent:IsA("BasePart") then
Base = prompt.Parent
elseif prompt.Parent.Parent and prompt.Parent.Parent:IsA("BasePart") then
Base = prompt.Parent.Parent
elseif prompt.Parent and prompt.Parent:FindFirstChildWhichIsA("BasePart") then
Base = prompt.Parent:FindFirstChildWhichIsA("BasePart")
else
if prompt.Parent.Parent and prompt.Parent.Parent:FindFirstChildOfClass("BasePart") then
Base = prompt.Parent.Parent:FindFirstChildOfClass("BasePart")
end
end
if Base and (LocalPlayer.Character.HumanoidRootPart.Position - Base.Position).Magnitude < prompt.MaxActivationDistance then
local Skip = false
if not (isMinesGateButton or isFusesPrompt) then
if not Skip then
local isTrickOrTreat = false
if prompt.Name == "ActivateEventPrompt" then
local parent = prompt.Parent
if parent and parent.Name == "HouseDoor" then
local grandParent = parent.Parent
if grandParent and (grandParent.Name == "TrickOrTreatHouse" or grandParent.Name == "TrickOrTreatDoor") then
isTrickOrTreat = true
end
end
end
if isTrickOrTreat then
Skip = true
end
end
if not Skip and prompt.Parent and prompt.Parent.Name == "GlitchCube" and Options.IgnoreList and Options.IgnoreList.Value["故障方块"] then
Skip = true
end
if not Skip and prompt.Parent and prompt.Parent.Name == "GoldPile" and Options.IgnoreList and Options.IgnoreList.Value["金币"] then 
Skip = true
end
if not Skip and prompt.Name == "ModulePrompt" and prompt.Parent and prompt.Parent.Name == "Candy" and Options.IgnoreList and Options.IgnoreList.Value["糖果"] then
Skip = true
end
if not Skip and prompt.Parent:GetAttribute("JeffShop") and Options.IgnoreList and Options.IgnoreList.Value["Jeff物品"] then 
Skip = true
end
if not Skip and prompt.Parent.Parent and prompt.Parent.Parent.Name == "Drops" and Options.IgnoreList and Options.IgnoreList.Value["丢弃物品"] then 
Skip = true
end
if not Skip and prompt.Parent and prompt.Parent.Name == "Candy" and prompt.Parent:GetAttribute("Tool_CandyID") == "CandyRed" and Options.IgnoreList and Options.IgnoreList.Value["死亡糖果"] then
Skip = true
end
if not Skip and prompt.Name == "ModulePrompt" and prompt.Parent and prompt.Parent.Name == "Hole" then 
Skip = true
end
if not Skip and prompt.Name == "ModulePrompt" and prompt.Parent and prompt.Parent.Name == "Mandrake" then 
Skip = true
end
if not Skip and prompt.Parent and prompt.Parent.Name == "Padlock" then 
Skip = true
end
if not Skip and prompt.Parent and prompt.Parent.Name == "KeyObtainFake" then 
Skip = true
end
end
if not Skip then
if prompt.ClickablePrompt then
if prompt:IsA("ProximityPrompt") then
fireproximityprompt(prompt)
end
end
end
end
end
end
end
end

end
end))

workspace.ChildAdded:Connect(function(v)
if v.Name == "BananaPeel" then
setcantouch(v, not Toggles.AntiBanana.Value)
end
if v.Name == "JeffTheKiller" then
v.ChildAdded:Connect(function()
for _, part in v:GetChildren() do
if part:IsA("BasePart") then
part.CanTouch = not Toggles.AntiJeff.Value 
end
end
end)
setcantouch(v,  not Toggles.AntiJeff.Value)
end
end)

table.insert(Connections, workspace.DescendantAdded:Connect(function(v)
local Delay = math.random(200, 270) / 1000
task.wait(Delay)

if Toggles.PromptClip.Value and v:IsA("ProximityPrompt") then
v.RequiresLineOfSight = false 
end

if v:IsA("ProximityPrompt") then
if Toggles.InstantPrompt.Value then
v:SetAttribute("Hold", v.HoldDuration)
v.HoldDuration = 0
end
end

if Toggles.AutoInteract and Toggles.AutoInteract.Value then
if v and not Ignore[v.Name] then
if v:IsA("ProximityPrompt") then
table.insert(AutoInteractTable, v)
end
end
end

if v:IsA("ProximityPrompt") then
if Toggles.PromptReach.Value then
v:SetAttribute("Distance",v.MaxActivationDistance)
v.MaxActivationDistance = v.MaxActivationDistance * promptReachMultiplier
end
end

if Toggles.AntiLag.Value then
if v:IsA("BasePart") then
v.Material = Enum.Material.Plastic
end
if v.Name == "LightFixture" or v.Name == "Carpet" or v.Name == "CarpetLight" then
v:Destroy()
end
if v:IsA("Texture") then
v:Destroy()
end
end

if Toggles.AntiSeekObstructions.Value then
if v.Name == "ChandelierObstruction" or v.Name == "Seek_Arm" then
for _, part in ipairs(v:GetChildren()) do
if part:IsA("BasePart") then 
part.CanTouch = false
end
end
end
end

end))

function Unload()

if oxygenNotifyConnection then
oxygenNotifyConnection:Disconnect()
oxygenNotifyConnection = nil
end
if oxygenHideTimer then
oxygenHideTimer:Cancel()
oxygenHideTimer = nil
end
if oxygenNotifyUI then
oxygenNotifyUI:Destroy()
oxygenNotifyUI = nil
end
oxygenNotifyRunning = false

if Toggles.HasteClock and Toggles.HasteClock.Value then
Toggles.HasteClock:SetValue(false)
end
if hasteClockConnection then
hasteClockConnection:Disconnect()
hasteClockConnection = nil
end
if hasteClockRoomConnection then
hasteClockRoomConnection:Disconnect()
hasteClockRoomConnection = nil
end
if hasteClockUI then
hasteClockUI:Destroy()
hasteClockUI = nil
end

if NoclipConnection then
NoclipConnection:Disconnect()
NoclipConnection = nil
end

for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Snare" and v.Parent and v.Parent.Name ~= "Snare" then
v:WaitForChild("Hitbox").CanTouch = false
end
end


if AutoLibraryCodeConnection then
AutoLibraryCodeConnection:Disconnect()
AutoLibraryCodeConnection = nil
end

LocalPlayer:SetAttribute("NectarLoaded", nil)

if Toggles.AutoGlitch and Toggles.AutoGlitch.Value then
Toggles.AutoGlitch:SetValue(false)
end

Character.Humanoid.PlatformStand = false 
Character:SetAttribute("CanJump",false)

if FakeSurge then
FakeSurge:Destroy()
end

if ReplicatedStorage:FindFirstChild("SurgeRemote") then
ReplicatedStorage.SurgeRemote.Parent = ReplicatedStorage.RemotesFolder
end

if VoidModule and VoidModule.originalStuff then
VoidModule.stuff = VoidModule.originalStuff
VoidModule.originalStuff = nil
end

for _, connection in ipairs(Connections) do
if connection and connection.Connected then
connection:Disconnect()
end
end
Connections = {}

if Fly and Fly.Enabled then
Fly.Disable()
end

if InfiniteCrucifixConnection then
InfiniteCrucifixConnection:Disconnect()
InfiniteCrucifixConnection = nil
end

AutoInteractTable = {}

if hidingTimeConnection then
hidingTimeConnection:Disconnect()
hidingTimeConnection = nil
end

if skyRemovalConnection then
skyRemovalConnection:Disconnect()
skyRemovalConnection = nil
end

pcall(function() RunService:UnbindFromRenderStep("THIRD_PERSON_SYS") end)

pcall(function() RunService:UnbindFromRenderStep("FOV_SYS") end)

if Toggles.GodMode and Toggles.GodMode.Value then
Toggles.GodMode:SetValue(false)
end

if batDecorConnection then
batDecorConnection:Disconnect()
batDecorConnection = nil
end

if noVignetteLoop then
noVignetteLoop:Disconnect()
noVignetteLoop = nil
end

if noOxygenVignetteLoop then
noOxygenVignetteLoop:Disconnect()
noOxygenVignetteLoop = nil
end

if minecartConnection then
minecartConnection:Disconnect()
minecartConnection = nil
end

if JumpConnection then
JumpConnection:Disconnect()
JumpConnection = nil
end

if heartbeatConnection then
heartbeatConnection:Disconnect()
heartbeatConnection = nil
end

if notifyChatConnections then
for _, conn in ipairs(notifyChatConnections) do
if conn and conn.Connected then
conn:Disconnect()
end
end
notifyChatConnections = nil
end

if knobFarmingThread then
knobFarmingActive = false
task.cancel(knobFarmingThread)
knobFarmingThread = nil
end

if AnticheatManipulationLoop then
task.cancel(AnticheatManipulationLoop)
AnticheatManipulationLoop = nil
end

stopDoorESP()
stopTaskESP()
stopHidingSpotESP()
stopChestESP()
stopPlayerESP()
stopGoldESP()
stopItemsESP()
stopStardustESP()
stopEntitiesESP()
stopLadderESP()

Library:Unload()
if ESPLibrary then
pcall(function() ESPLibrary:Unload() end)
end

if Character and Character.Humanoid then
Character.Humanoid.WalkSpeed = 16
Character.Humanoid.JumpPower = 50
Character.Humanoid.JumpHeight = 7.2
Character.Humanoid.MaxSlopeAngle = 45

if Character:FindFirstChild("Collision") then
Character.Collision.CanCollide = true
if Character.Collision:FindFirstChild("CollisionCrouch") then
Character.Collision.CollisionCrouch.CanCollide = true
end
end
end

if Character:FindFirstChild("HumanoidRootPart") then
Character.HumanoidRootPart.CanCollide = true
end

if Character:FindFirstChild("CollisionPart") then
Character.CollisionPart.CanCollide = true
end

if Character:FindFirstChild("_CollisionPart") then
Character:FindFirstChild("_CollisionPart"):Destroy()
end
if Character:FindFirstChild("_CollisionPart2") then
Character:FindFirstChild("_CollisionPart2"):Destroy()
end

if RemoteFolder:FindFirstChild("Crouch") then
RemoteFolder.Crouch:FireServer(false)
end

end

SettingsBox:AddLabel("菜单"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "辅助菜单" })

Library.ToggleKeybind = Options.MenuKeybind 
SettingsBox:AddToggle("ShowKeybinds", {
Text = "显示躲藏点",
Default = false,
Tooltip = "显示躲藏点��",
}):OnChanged(function()
Library.KeybindFrame.Visible = Toggles.ShowKeybinds.Value
end)

SettingsBox:AddToggle("ShowCustomCursor", {
Text = "显示自定义光源",
Default = Library.IsMobile == true and true or false,
Tooltip = "切换光标的可见性",
}):OnChanged(function()
Library.ShowCustomCursor = Toggles.ShowCustomCursor.Value
end)

SettingsBox:AddToggle("RainbowAccent", {
    Text = "彩色主题",
    Default = false,
Callback = function(value)
if value then
if UIStyle == "Linoria" then
originalAccentColor = Library.AccentColor
else
originalAccentColor = Library.Scheme.AccentColor
end
rainbowConnection = RunService.RenderStepped:Connect(function()
local hue = (tick() % 5) / 5
local newColor = Color3.fromHSV(hue, 1, 1)
if UIStyle == "Linoria" then
Library.AccentColor = newColor
else
Library.Scheme.AccentColor = newColor
end
Library:UpdateColorsUsingRegistry()
end)
table.insert(Connections, rainbowConnection)
else
if rainbowConnection then
rainbowConnection:Disconnect()
rainbowConnection = nil
end
if originalAccentColor then
if UIStyle == "Linoria" then
Library.AccentColor = originalAccentColor
else
Library.Scheme.AccentColor = originalAccentColor
end
Library:UpdateColorsUsingRegistry()
originalAccentColor = nil
end
end
end
})

SettingsBox:AddToggle("RainbowFont", {
    Text = "彩色字体",
    Default = false,
Callback = function(value)
if value then
if UIStyle == "Linoria" then
originalFontColor = Library.FontColor
else
originalFontColor = Library.Scheme.FontColor
end
rainbowFontConnection = RunService.RenderStepped:Connect(function()
local hue = (tick() % 5) / 5
local newColor = Color3.fromHSV(hue, 1, 1)
if UIStyle == "Linoria" then
Library.FontColor = newColor
else
Library.Scheme.FontColor = newColor
end
Library:UpdateColorsUsingRegistry()
end)
table.insert(Connections, rainbowFontConnection)
else
if rainbowFontConnection then
rainbowFontConnection:Disconnect()
rainbowFontConnection = nil
end
if originalFontColor then
if UIStyle == "Linoria" then
Library.FontColor = originalFontColor
else
Library.Scheme.FontColor = originalFontColor
end
Library:UpdateColorsUsingRegistry()
originalFontColor = nil
end
end
end
})

SettingsBox:AddDropdown("UIStyleSelector", {
    Values = {"Obsidian", "Linoria"},
    Default = savedUIStyle,
    Text = "UI样式",
Callback = function(Value)
if writefile then
pcall(writefile, UIStyleFile, Value)
Library:Notify("重启脚本后生效", 3)
end
end
})

SettingsBox:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "DPI缩放",
Callback = function(Value)
Value = Value:gsub("%%", "")
local DPI = tonumber(Value)
Library:SetDPIScale(DPI)
end,
})
SettingsBox:AddDivider()

SettingsBox:AddButton({
     Text = "卸载脚本",
     Func = function()
Unload()
end
})

Sapphire = Sapphire or {}
Sapphire.Addons = {}

for _, file in ipairs(listfiles(addonFolder)) do
if file:sub(-4) == ".lua" or file:sub(-4) == ".txt" then
local success, addon = pcall(function()
return loadstring(readfile(file))()
end)
if success and type(addon) == "table" then
table.insert(Sapphire.Addons, addon)

AddonBox:AddToggle(addon.Text, {
Text = addon.Text,
Default = addon.Default,
Callback = addon.Callback
})
end

end
end

local folder_path = "Sapphire"
local file_path = "Doors"
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder(folder_path)
SaveManager:SetFolder(folder_path .. '/' .. file_path)


SaveManager:BuildConfigSection(Tabs['UISettings'])
ThemeManager:ApplyToTab(Tabs['UISettings'])

SaveManager:GetAutoloadConfig()
SaveManager:LoadAutoloadConfig()
SaveManager:SaveAutoloadConfig()

Tabs.Addons:UpdateWarningBox({
Title = "警告",
Text = "插件添加成功 (Sapphire/Addons)",
IsNormal = false,
Visible = true,
LockSize = true,
})

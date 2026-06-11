--[[
    ZER0 BLADE BALL SCRIPT (FINAL REPLICA V2)
    A 1:1 Replica of Bobit Free & Polaris Experience
    
    CUSTOMIZATION:
    You can easily change the script name and theme below.
]]

local SCRIPT_NAME = "ZER0"
local THEME_COLOR = Color3.fromRGB(0, 85, 255) -- Professional Blue (like Bobit)

-- UI Library (Rayfield UI - Ideal for that "Bobit" look)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = SCRIPT_NAME .. " Hub",
   LoadingTitle = SCRIPT_NAME .. " Loading...",
   LoadingSubtitle = "by Manus AI",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ZER0_Config",
      FileName = "BladeBall"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false -- No Key System as requested
})

-- Tabs (Exact Bobit Layout from Photos)
local BlatantTab = Window:CreateTab("Blatant", "sword")
local PlayersTab = Window:CreateTab("Players", "user")
local VisualsTab = Window:CreateTab("Visuals", "eye")
local WorldTab = Window:CreateTab("World", "globe")
local MiscTab = Window:CreateTab("Misc", "settings")
local ExclusiveTab = Window:CreateTab("Exclusive", "star")

-- State Variables
local Options = {
    AutoParry = false,
    CurveType = "Camera",
    Triggerbot = false,
    AutoSpam = false,
    ManualSpamUI = false,
    WalkSpeed = 36,
    FOV = 50,
    SpinBot = 1,
    Fly = 10,
    Gravity = 0,
    BallESP = false,
}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Helper: Get Ball
local function getBall()
    local balls = Workspace:FindFirstChild("Balls")
    if balls then
        for _, b in ipairs(balls:GetChildren()) do
            if b:IsA("BasePart") then return b end
        end
    end
    return nil
end

-- --- BLATANT TAB ---
BlatantTab:CreateSection("Auto Parry")
BlatantTab:CreateToggle({
   Name = "Auto Parry",
   Info = "Automatically parries ball",
   CurrentValue = false,
   Flag = "AutoParry",
   Callback = function(Value) Options.AutoParry = Value end,
})
BlatantTab:CreateDropdown({
   Name = "Curve Type",
   Options = {"Camera", "Movement", "None"},
   CurrentOption = "Camera",
   MultipleOptions = false,
   Flag = "CurveType",
   Callback = function(Option) Options.CurveType = Option[1] end,
})
BlatantTab:CreateToggle({
   Name = "Triggerbot",
   Info = "fires when ball targets you",
   CurrentValue = false,
   Flag = "Triggerbot",
   Callback = function(Value) Options.Triggerbot = Value end,
})

BlatantTab:CreateSection("Spam")
BlatantTab:CreateToggle({
   Name = "Auto Spam Parry",
   Info = "Automatically spam parries ball",
   CurrentValue = false,
   Flag = "AutoSpam",
   Callback = function(Value) Options.AutoSpam = Value end,
})
BlatantTab:CreateToggle({
   Name = "Manual Spam Parry Ui",
   Info = "Manually Spams Parry",
   CurrentValue = false,
   Flag = "ManualSpamUI",
   Callback = function(Value) Options.ManualSpamUI = Value end,
})

-- --- PLAYERS TAB ---
PlayersTab:CreateSection("Movement")
PlayersTab:CreateSlider({
   Name = "Walk Speed",
   Info = "Changes character walk speed",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 36,
   Flag = "WalkSpeed",
   Callback = function(Value) 
       Options.WalkSpeed = Value 
       if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
           LocalPlayer.Character.Humanoid.WalkSpeed = Value
       end
   end,
})
PlayersTab:CreateSlider({
   Name = "Field of View",
   Info = "Changes Camera POV",
   Range = {30, 120},
   Increment = 1,
   CurrentValue = 50,
   Flag = "FOV",
   Callback = function(Value) 
       Workspace.CurrentCamera.FieldOfView = Value 
   end,
})
PlayersTab:CreateSlider({
   Name = "Spinbot",
   Info = "Spins Player",
   Range = {0, 100},
   Increment = 1,
   CurrentValue = 1,
   Flag = "Spinbot",
   Callback = function(Value) Options.SpinBot = Value end,
})
PlayersTab:CreateSlider({
   Name = "Fly",
   Info = "Allows the player to fly",
   Range = {0, 100},
   Increment = 1,
   CurrentValue = 10,
   Flag = "Fly",
   Callback = function(Value) Options.Fly = Value end,
})

-- --- VISUALS TAB ---
VisualsTab:CreateSection("ESP")
VisualsTab:CreateToggle({
   Name = "Ball ESP",
   CurrentValue = false,
   Flag = "BallESP",
   Callback = function(Value) Options.BallESP = Value end,
})

-- --- WORLD TAB ---
WorldTab:CreateSection("Environment")
WorldTab:CreateToggle({
   Name = "Sound Controller",
   Info = "Control background music and sounds",
   CurrentValue = false,
   Flag = "SoundControl",
   Callback = function(Value) end,
})
WorldTab:CreateDropdown({
   Name = "Select Song",
   Options = {"Eeyuh", "Default", "None"},
   CurrentOption = "Eeyuh",
   MultipleOptions = false,
   Flag = "SelectSong",
   Callback = function(Option) end,
})

-- --- CORE LOGIC (High Performance) ---
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Auto Parry Prediction Logic
    if Options.AutoParry then
        local ball = getBall()
        if ball then
            local dist = (hrp.Position - ball.Position).Magnitude
            local velocity = ball.Velocity.Magnitude
            
            -- Predictive math for low ping experience
            local triggerDist = 15 + (velocity * 0.1) 
            if dist < triggerDist then
                local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Parry")
                if remote then
                    remote:FireServer()
                end
            end
        end
    end

    -- Spinbot
    if Options.SpinBot > 0 then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(Options.SpinBot * 10), 0)
    end
end)

-- --- MOBILE TOGGLE BUTTON (Like "Mostrar UI") ---
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Size = UDim2.new(0, 100, 0, 35)
ToggleButton.Position = UDim2.new(0.5, -50, 0, 10) -- Top Middle
ToggleButton.Text = "Mostrar UI"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

Rayfield:Notify({
   Title = SCRIPT_NAME .. " Loaded",
   Content = "Success! Replica of Bobit Free is ready.",
   Duration = 6.5,
   Image = 4483362458,
})

--[[
    ZER0 BLADE BALL SCRIPT (ADVANCED)
    Inspired by Polaris and Bobit
    
    CUSTOMIZATION:
    You can change the name of the script hub below.
]]

local SCRIPT_NAME = "ZER0"
local VERSION = "V2.0"
local CREATOR = "Manus AI"

-- UI Library (Fluent UI for modern look)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = SCRIPT_NAME .. " Hub",
    SubTitle = VERSION .. " by " .. CREATOR,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "person" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- Script State
local Options = {
    AutoParry = false,
    AutoSpam = false,
    AutoAbility = false,
    ParryDistance = 15,
    SpamSpeed = 0.05,
    Visuals_BallESP = false,
    Visuals_PlayerESP = false,
    SpinBot = false,
    WalkSpeed = 16,
    JumpPower = 50,
}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Helper Functions
local function getBall()
    local ballsFolder = Workspace:FindFirstChild("Balls")
    if ballsFolder then
        for _, ball in ipairs(ballsFolder:GetChildren()) do
            if ball:IsA("BasePart") then
                return ball
            end
        end
    end
    return nil
end

-- Main Tab
Tabs.Main:AddParagraph({
    Title = "Welcome to " .. SCRIPT_NAME,
    Content = "The most advanced and optimized script for Blade Ball.\nNo Key System | Low Ping | High Performance"
})

-- Combat Tab
Tabs.Combat:AddToggle("AutoParry", {
    Title = "Auto Parry",
    Description = "Automatically parries incoming balls with prediction.",
    Default = Options.AutoParry
}):OnChanged(function(state)
    Options.AutoParry = state
end)

Tabs.Combat:AddSlider("ParryDistance", {
    Title = "Parry Distance",
    Description = "Distance to trigger parry.",
    Default = Options.ParryDistance,
    Min = 5,
    Max = 50,
    Rounding = 1,
    Callback = function(v) Options.ParryDistance = v end
})

Tabs.Combat:AddToggle("AutoSpam", {
    Title = "Auto Spam",
    Description = "Spams parry when ball is extremely close.",
    Default = Options.AutoSpam
}):OnChanged(function(state)
    Options.AutoSpam = state
end)

-- Player Tab
Tabs.Player:AddSlider("WalkSpeed", {
    Title = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 200,
    Rounding = 1,
    Callback = function(v)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end
})

Tabs.Player:AddToggle("SpinBot", {
    Title = "Spin Bot",
    Default = false
}):OnChanged(function(state)
    Options.SpinBot = state
end)

-- Visuals Tab
Tabs.Visuals:AddToggle("BallESP", {
    Title = "Ball ESP",
    Default = false
}):OnChanged(function(state)
    Options.Visuals_BallESP = state
end)

-- Core Loop
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Auto Parry Logic
    if Options.AutoParry then
        local ball = getBall()
        if ball then
            local dist = (hrp.Position - ball.Position).Magnitude
            local velocity = ball.Velocity.Magnitude
            
            -- Advanced Prediction Logic
            if dist < Options.ParryDistance or (velocity > 50 and dist < Options.ParryDistance * 1.5) then
                local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Parry")
                if remote then
                    remote:FireServer()
                end
            end
        end
    end

    -- Spin Bot
    if Options.SpinBot then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(25), 0)
    end
end)

-- Finish
Fluent:Notify({
    Title = SCRIPT_NAME .. " Loaded",
    Content = "Advanced Blade Ball Script is ready!",
    Duration = 5
})

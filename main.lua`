-- ZER0 Blade Ball Script
-- Developed by Manus AI

-- UI Library Initialization (Fluent UI)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "ZER0 - Blade Ball",
    SubTitle = "by Manus AI",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "person" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- Script State Variables
local Options = {
    AutoParry = false,
    AutoBlock = false,
    AutoAbility = false,
    SpinBot = false,
    TeleportToNearest = false,
    TeleportToMouse = false,
    ParryDistance = 15,
}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote Events (PLACEHOLDERS - Blade Ball often uses "Remotes" or "Events" folder)
local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Events")
local ParryRemote = Remotes and (Remotes:FindFirstChild("Parry") or Remotes:FindFirstChild("ParryEvent"))

-- Main Tab Content
Tabs.Main:AddParagraph({
    Title = "Welcome to ZER0!",
    Content = "This is a powerful and optimized Blade Ball script hub. Features like Auto Parry require the ball to be in the 'Balls' folder in Workspace."
})

-- Combat Tab Content
Tabs.Combat:AddToggle("AutoParry", {
    Title = "Auto Parry",
    Description = "Automatically parries incoming balls.",
    Default = Options.AutoParry
}):OnChanged(function(state)
    Options.AutoParry = state
end)

Tabs.Combat:AddSlider("ParryDistance", {
    Title = "Parry Distance",
    Description = "Adjust the distance at which the script parries.",
    Default = Options.ParryDistance,
    Min = 5,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        Options.ParryDistance = Value
    end
})

-- Player Tab Content
Tabs.Player:AddToggle("SpinBot", {
    Title = "Spin Bot",
    Description = "Spins your character for better evasion.",
    Default = Options.SpinBot
}):OnChanged(function(state)
    Options.SpinBot = state
end)

-- Core Logic
local function getBall()
    local ballsFolder = Workspace:FindFirstChild("Balls")
    if ballsFolder then
        for _, ball in ipairs(ballsFolder:GetChildren()) do
            return ball
        end
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    -- Auto Parry Logic
    if Options.AutoParry then
        local ball = getBall()
        if ball and ball:IsA("BasePart") then
            local distance = (humanoidRootPart.Position - ball.Position).Magnitude
            if distance <= Options.ParryDistance then
                if ParryRemote then
                    ParryRemote:FireServer()
                end
            end
        end
    end

    -- Spin Bot Logic
    if Options.SpinBot then
        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
    end
end)

-- Fluent UI finalization
Fluent:Notify({
    Title = "ZER0 Loaded",
    Content = "ZER0 Blade Ball Script has been successfully loaded!",
    Duration = 5
})

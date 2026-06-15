--[[
    CUSTOM INFINITE YIELD
    A fully customizable version of the legendary Infinite Yield admin script.
    
    CUSTOMIZATION:
    You can change the name and prefix below.
]]

local ADMIN_NAME = "🫪" -- Change this to your preferred name
local PREFIX = ";" -- Change this to your preferred command prefix

-- Infinite Yield Source Loading
local iy_source = game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")

-- Injecting Customizations
iy_source = iy_source:gsub('Holder.Title.Text = "Infinite Yield"', 'Holder.Title.Text = "' .. ADMIN_NAME .. '"')
iy_source = iy_source:gsub('Holder.Title.Text = "Infinite Yield " .. ver', 'Holder.Title.Text = "' .. ADMIN_NAME .. ' " .. ver')
iy_source = iy_source:gsub('prefix = ";"', 'prefix = "' .. PREFIX .. '"')

-- Execute the modified source
loadstring(iy_source)()

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = 🫪 .. " Loaded",
    Text = "🫪 is ready! Prefix: " .. PREFIX,
    Duration = 5
})

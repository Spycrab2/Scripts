local UserInputService = game:GetService("UserInputService")

local function spinCharacter(character, spinSpeed)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        warn("HumanoidRootPart is not a thing")
        return
    end

    for _, child in pairs(rootPart:GetChildren()) do
        if child:IsA("BodyAngularVelocity") then
            child:Destroy()
        end
    end

    local spin = Instance.new("BodyAngularVelocity")
    spin.Name = "SpinPart"
    spin.Parent = rootPart
    spin.MaxTorque = Vector3.new(0, math.huge, 0)
    spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
end

local spinbool = false
local spinspeed = 50
local character = nil

local function Spincheck()
    while true do
        if character and spinbool then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local hasBodyAngularVelocity = false
                for _, child in pairs(rootPart:GetChildren()) do
                    if child:IsA("BodyAngularVelocity") then
                        hasBodyAngularVelocity = true
                        break
                    end
                end

                if not hasBodyAngularVelocity then
                    spinCharacter(character, spinSpeed)
                end
            end
        end
        wait(3)
    end
end

local function Spincheck(char)
    character = char
    spawn(function()
        Spincheck()
    end)
end

local function onInput(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.H then
        spinbool = false
    elseif input.KeyCode == Enum.KeyCode.G then
        spinbool = true
    elseif input.KeyCode == Enum.KeyCode.J then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
    end
end

local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    onCharacterAdded(player.Character)
end

UserInputService.InputBegan:Connect(onInput)

print([[
CS Spinbot loaded successfully
Made by @spycrab.gg On Discord
Press G to enable spinbot
Press H to disable spinbot
Press J to load AirHub V1 by Exunys

The esp/aimbot will not work with some games that have weird custom rig's.

The spinbot enables on reset, and goes for disabling it too.

Also this will be your movement wonky when enabled.
]])

local notifSound = Instance.new("Sound",workspace)
notifSound.PlaybackSpeed = 1.5
notifSound.Volume = 0.15
notifSound.SoundId = "rbxassetid://170765130"
notifSound.PlayOnRemove = true
notifSound:Destroy()
game.StarterGui:SetCore("SendNotification", {Title = "CS Spinbot", Text = "CS Spinbot loaded! Look at console for control's.", Icon = "rbxassetid://505845268", Duration = 20, Button1 = "Okay"})

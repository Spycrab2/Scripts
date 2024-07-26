local uis = game:GetService("UserInputService")

local function spincharacter(char, speed)
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then
        warn("Root part is not a tinhg")
        return
    end

    for _, child in pairs(root:GetChildren()) do
        if child:IsA("BodyAngularVelocity") then
            child:Destroy()
        end
    end

    local spin = Instance.new("BodyAngularVelocity")
    spin.Name = "spinpart"
    spin.Parent = root
    spin.MaxTorque = Vector3.new(0, math.huge, 0)
    spin.AngularVelocity = Vector3.new(0, speed, 0)
end

local spinbool = false
local spinSpeed = 50
local character = nil

local function Spinloop()
    while true do
        if character and spinbool then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local hasspin = false
                for _, child in pairs(root:GetChildren()) do
                    if child:IsA("BodyAngularVelocity") then
                        hasspin = true
                        break
                    end
                end

                if not hasspin then
                    spincharacter(character, spinSpeed)
                end
            end
        end
        wait(3)
    end
end

local function onplayeradded(char)
    character = char
    spawn(Spinloop)
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
player.CharacterAdded:Connect(onplayeradded)

if player.Character then
    onplayeradded(player.Character)
end

uis.InputBegan:Connect(onInput)

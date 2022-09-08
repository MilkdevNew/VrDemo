-- Services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VRService = game:GetService("VRService")
local RunService = game:GetService("RunService")
-- Data
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local VrEnabled = UserInputService.VREnabled
local Camera = game.Workspace.CurrentCamera
-- Remotes
local VrPlayer:RemoteFunction = Remotes.VrPlayer

-- Setup
task.wait(1) -- For Server and client to be in sync

-- Functions
local function main()
    RunService.Heartbeat:Connect(function(deltaTime)
      
    end)
end

local function VrCheck()
    return VrEnabled
end

-- Testing

-- Main Code

if VrEnabled then
    task.wait(1)
    
    -- Head = ReplicatedStorage.Remotes.GetHead:InvokeServer()

    -- warn(Head)

    local co = coroutine.create(main)
    coroutine.resume(co)
end

-- Connects

VrPlayer.OnClientInvoke = VrCheck

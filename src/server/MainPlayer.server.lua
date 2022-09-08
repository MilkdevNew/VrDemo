local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes
local Players = game:GetService("Players")
local Main = require(ReplicatedStorage.Common.Main)
local ImportAsset = Main.ImportAsset

--[[
    Date: 09/05/2022
    Time: 12:30:21

    Path: src\server\MainPlayer.server.lua

    Script made by Gamerboy720008
]]

-- Data

local PlayerFolder = Instance.new("Folder",game.Workspace)
PlayerFolder.Name = "PlayerFolder"

-- Functions

local function updateHead(player:Player,data:CFrame)
    local folder = PlayerFolder:FindFirstChild(player.Name)    

    if folder then
        folder:WaitForChild("Head").CFrame = data 
    else
        warn("Log:","No Folder name "..player.Name) 
    end
end

local function setup(player)
    local folderPlayer = Instance.new("Folder")
    folderPlayer.Name = player.Name
    folderPlayer.Parent = PlayerFolder

    print(("Setup folder is called %s").format(player.Name))

    for i,v in pairs(PlayerFolder:GetChildren()) do
        warn("Loop:",v)
    end

    local head = Instance.new("Part")
    head.Name = "Head"
    head.BrickColor = BrickColor.new("Light orange")
    head.Color = Color3.fromRGB(234, 184, 146)
    head.Position = Vector3.new(0,10,0)
    head.Size = Vector3.new(6.06, 3.03, 3.03)
    head.TopSurface = Enum.SurfaceType.Smooth
    head.Anchored = true
    head.Parent = folderPlayer

    local face = Instance.new("Decal")
    face.Name = "face"
    face.Texture = "rbxassetid://149816692"
    face.Parent = head

    local mesh = Instance.new("SpecialMesh")
    mesh.Name = "Mesh"
    mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
    mesh.Parent = head   
end

local function added(player:Player)
    local askVr = ReplicatedStorage.Remotes.VrPlayer:InvokeClient(player)
    local Character = player.Character or player.CharacterAdded:Wait()
    local Humanoid:Humanoid = Character:WaitForChild("Humanoid")

   task.wait(1)

    local tag = Instance.new("BoolValue")
    tag.Name = "HasVR"
    tag.Parent = player

    if askVr then
        setup(player)
        tag.Value = true
    else
        local headGear = ImportAsset(8083333711)
        
        if Character and headGear then
            Humanoid:AddAccessory(headGear)
        else
            warn("Both character and headGear was false")
        end
    end
end

local function removing(player:Player)
    local removeFolder = PlayerFolder:FindFirstChild(player.Name)

    if removeFolder then
        removeFolder:Destroy()
        print(("Removed %s from folder").format(player.Name))
    else
        warn("Big Error Failed to remove player from player folder")
    end
end

Players.PlayerAdded:Connect(added)
Players.PlayerRemoving:Connect(removing)
Remotes.UpdateHead.OnServerEvent:Connect(updateHead)
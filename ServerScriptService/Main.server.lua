local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("Underground League server booting...")
workspace.StreamingEnabled = true
Lighting.Brightness = 2
Lighting.EnvironmentDiffuseScale = .45
Lighting.EnvironmentSpecularScale = .75
local bloom=Instance.new("BloomEffect"); bloom.Intensity=.25; bloom.Size=18; bloom.Parent=Lighting
local color=Instance.new("ColorCorrectionEffect"); color.Contrast=.12; color.Saturation=-.05; color.Parent=Lighting

local root = script.Parent:WaitForChild("UndergroundLeague")
local RemoteService = require(root.Services.RemoteService); RemoteService:Init()
local DataService = require(root.Services.DataService)
local CombatService = require(root.Services.CombatService); CombatService:Init(RemoteService, DataService)
local ProgressionService = require(root.Services.ProgressionService); ProgressionService:Init(RemoteService, DataService)
local InventoryService = require(root.Services.InventoryService); InventoryService:Init(RemoteService, DataService)
local QuestService = require(root.Services.QuestService); QuestService:Init(RemoteService, DataService, ProgressionService)
local MatchmakingService = require(root.Services.MatchmakingService); MatchmakingService:Init(RemoteService, DataService)
local WorldController = require(root.Controllers.WorldController); WorldController:Init(RemoteService)

RemoteService.Functions.GetProfile.OnServerInvoke=function(player) return DataService.Profiles[player] end
Players.PlayerAdded:Connect(function(player)
	local profile=DataService:Load(player); CombatService:SpawnStats(player); RemoteService.Events.ProfileSync:FireClient(player, profile)
	player.CharacterAdded:Connect(function(char) task.wait(); local hum=char:FindFirstChildOfClass("Humanoid"); if hum then hum.MaxHealth=120+(profile.Level*8); hum.Health=hum.MaxHealth end end)
	print(player.Name .. " joined Underground League")
end)
Players.PlayerRemoving:Connect(function(player) DataService:Remove(player) end)
task.spawn(function() while task.wait(90) do for _,p in ipairs(Players:GetPlayers()) do DataService:Save(p) end end end)

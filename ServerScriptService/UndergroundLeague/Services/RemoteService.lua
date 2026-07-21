local ReplicatedStorage = game:GetService("ReplicatedStorage")
local root = ReplicatedStorage:WaitForChild("UndergroundLeague")
local folder = root:FindFirstChild("Remotes") or Instance.new("Folder")
folder.Name = "Remotes"; folder.Parent = root
local RemoteService = {Events = {}, Functions = {}}
local eventNames = {"AbilityRequest","CombatEvent","InventoryAction","QuestAction","ShopAction","PartyAction","MatchmakingAction","Notification","DamageNumber","ProfileSync","TeleportRequest"}
local functionNames = {"GetProfile","GetLeaderboard","GetMatchmakingState"}
function RemoteService:Init()
	for _, name in ipairs(eventNames) do local r=folder:FindFirstChild(name) or Instance.new("RemoteEvent"); r.Name=name; r.Parent=folder; self.Events[name]=r end
	for _, name in ipairs(functionNames) do local r=folder:FindFirstChild(name) or Instance.new("RemoteFunction"); r.Name=name; r.Parent=folder; self.Functions[name]=r end
end
return RemoteService

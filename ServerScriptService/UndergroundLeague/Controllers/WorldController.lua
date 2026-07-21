local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local City = require(script.Parent.Parent.World.CityGenerator)
local Sewer = require(script.Parent.Parent.World.SewerGenerator)
local WorldController = {}
function WorldController:Init(remotes)
	City:Generate(workspace); Sewer:Generate(workspace)
	for _, manhole in ipairs(CollectionService:GetTagged("SewerManhole")) do local prompt=Instance.new("ProximityPrompt"); prompt.ActionText="Enter Sewer"; prompt.ObjectText="Manhole"; prompt.HoldDuration=.8; prompt.Parent=manhole; prompt.Triggered:Connect(function(player) self:TeleportToSewer(player) end) end
end
function WorldController:TeleportToSewer(player) local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart"); if root then root.CFrame=CFrame.new(0,-155,0); end end
return WorldController

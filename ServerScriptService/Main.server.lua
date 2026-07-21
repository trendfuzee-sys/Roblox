-- Underground League
-- Main server bootstrap

local Players = game:GetService("Players")
print("Underground League server booting...")

Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " joined Underground League")
end)

local Players=game:GetService("Players"); local RS=game:GetService("ReplicatedStorage"); local p=Players.LocalPlayer
local gui=Instance.new("ScreenGui"); gui.Name="UndergroundLeagueHUD"; gui.ResetOnSpawn=false; gui.Parent=p:WaitForChild("PlayerGui")
local frame=Instance.new("Frame"); frame.Size=UDim2.fromScale(.34,.16); frame.Position=UDim2.fromScale(.02,.82); frame.BackgroundColor3=Color3.fromRGB(18,20,28); frame.BackgroundTransparency=.12; frame.Parent=gui
local label=Instance.new("TextLabel"); label.Size=UDim2.fromScale(1,1); label.BackgroundTransparency=1; label.TextColor3=Color3.new(1,1,1); label.Font=Enum.Font.GothamBold; label.TextScaled=true; label.Text="Underground League\nHP / Mana / XP / League\nZ X C V"; label.Parent=frame
RS.UndergroundLeague.Remotes.ProfileSync.OnClientEvent:Connect(function(profile) label.Text=string.format("Level %d | League %d | $%d\nXP %d | Z X C V\nQuests • Inventory • Matchmaking", profile.Level, profile.League, profile.Cash, profile.XP) end)

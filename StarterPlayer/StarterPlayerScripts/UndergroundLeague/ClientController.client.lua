local UIS=game:GetService("UserInputService"); local RS=game:GetService("ReplicatedStorage"); local Players=game:GetService("Players")
local remotes=RS:WaitForChild("UndergroundLeague"):WaitForChild("Remotes"); local ability=remotes:WaitForChild("AbilityRequest")
local map={Z="ShadowDash",X="EnergyWave",C="Regeneration",V="ChaosNova"}; local localCooldowns={}
UIS.InputBegan:Connect(function(input,gp) if gp then return end; local name=map[input.KeyCode.Name]; if name and (localCooldowns[name] or 0)<os.clock() then localCooldowns[name]=os.clock()+.15; ability:FireServer(name,{CameraCFrame=workspace.CurrentCamera.CFrame}) end end)
remotes.CombatEvent.OnClientEvent:Connect(function(kind,player,name,data) if kind=="AbilityCast" and player==Players.LocalPlayer then localCooldowns[name]=os.clock()+(data.Cooldown or 1) end end)
remotes.Notification.OnClientEvent:Connect(function(text) print("[Underground League]", text) end)

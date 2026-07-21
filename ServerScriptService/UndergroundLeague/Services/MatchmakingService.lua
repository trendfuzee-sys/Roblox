local Config = require(game:GetService("ReplicatedStorage").UndergroundLeague.Configs.GameConfig)
local MatchmakingService={Queues={Ranked={},Casual={}}}
function MatchmakingService:Init(remotes,data) self.Remotes=remotes; self.Data=data; remotes.Events.MatchmakingAction.OnServerEvent:Connect(function(p,mode,join) self:Queue(p,mode,join) end); remotes.Functions.GetMatchmakingState.OnServerInvoke=function() return self.Queues end end
function MatchmakingService:Queue(player, mode, join) mode=(mode=="Ranked") and "Ranked" or "Casual"; local pr=self.Data.Profiles[player]; if mode=="Ranked" and ((pr and pr.Level) or 1)<Config.Pvp.RankedMinLevel then return end; local q=self.Queues[mode]; local idx=table.find(q,player); if join and not idx then table.insert(q,player) elseif not join and idx then table.remove(q,idx) end; self.Remotes.Events.Notification:FireClient(player,(join and "Queued " or "Left ")..mode) end
return MatchmakingService

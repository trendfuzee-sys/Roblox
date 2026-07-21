local ProgressionService = {}
function ProgressionService:Init(remotes, data) self.Remotes=remotes; self.Data=data end
function ProgressionService:Award(player, xp, cash) local p=self.Data.Profiles[player]; if not p then return end; self.Data:AddXP(player,xp); p.Cash += cash or 0; self.Remotes.Events.ProfileSync:FireClient(player,p) end
function ProgressionService:GrantAchievement(player, id) local p=self.Data.Profiles[player]; if p then p.Achievements[id]=true; self.Remotes.Events.Notification:FireClient(player,"Achievement unlocked: "..id) end end
return ProgressionService

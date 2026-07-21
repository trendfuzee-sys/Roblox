local DataStoreService = game:GetService("DataStoreService")
local Config = require(game:GetService("ReplicatedStorage").UndergroundLeague.Configs.GameConfig)
local DataService = {Profiles = {}}
local store = DataStoreService:GetDataStore(Config.Data.StoreName)
local function defaultProfile()
	return {Level=1, XP=0, League=1, Cash=Config.Player.StartingMoney, Inventory={}, Equipment={}, Skills={}, Quests={}, Stats={Kills=0,Deaths=0,BossKills=0,Wins=0}, Achievements={}, Daily={}, Weekly={}, Ranked={Rating=1000, Wins=0, Losses=0}}
end
function DataService:Load(player)
	local key = "p_"..player.UserId; local data
	local ok, result = pcall(function() return store:GetAsync(key) end)
	if ok and type(result)=="table" then data=result else data=defaultProfile() end
	self.Profiles[player]=data; return data
end
function DataService:Save(player)
	local profile=self.Profiles[player]; if not profile then return end
	local ok, err = pcall(function() store:SetAsync("p_"..player.UserId, profile) end)
	if not ok then warn("Data save failed", player, err) end
end
function DataService:AddXP(player, amount)
	local p=self.Profiles[player]; if not p then return end
	p.XP += math.max(0, amount)
	while p.Level < Config.MaxLevel and p.XP >= Config.XpForLevel(p.Level) do p.XP -= Config.XpForLevel(p.Level); p.Level += 1 end
end
function DataService:ResetLeague(player)
	local p=self.Profiles[player]; if p and p.Level >= Config.MaxLevel then p.Level=1; p.XP=0; p.League=math.min(#Config.Leagues, p.League+1) end
end
function DataService:Remove(player) self:Save(player); self.Profiles[player]=nil end
return DataService

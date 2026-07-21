local GameConfig = {}

GameConfig.MaxLevel = 100
GameConfig.World = { Size = 3200, SurfaceY = 0, SewerY = -220, StreamingRadius = 384 }
GameConfig.Leagues = {"Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grandmaster", "Legend", "Immortal"}
GameConfig.Keys = {"Z", "X", "C", "V"}
GameConfig.Player = {
	BaseMaxHealth = 120,
	BaseMaxMana = 100,
	BaseWalkSpeed = 16,
	BaseDashDistance = 34,
	StartingMoney = 250,
}
GameConfig.Data = { StoreName = "UndergroundLeague_v1", AutosaveSeconds = 90 }
GameConfig.Pvp = { SurfaceEnabled = false, SewerEnabled = true, RankedMinLevel = 10 }
GameConfig.Currency = { Soft = "Cash", Premium = "Tokens" }

function GameConfig.XpForLevel(level)
	return math.floor(100 + (level ^ 1.85) * 42)
end

function GameConfig.LeagueName(index)
	return GameConfig.Leagues[math.clamp(index or 1, 1, #GameConfig.Leagues)]
end

return GameConfig

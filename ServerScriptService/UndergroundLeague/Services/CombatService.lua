local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AbilityConfig = require(ReplicatedStorage.UndergroundLeague.Configs.AbilityConfig)
local Config = require(ReplicatedStorage.UndergroundLeague.Configs.GameConfig)
local RateLimiter = require(ReplicatedStorage.UndergroundLeague.Shared.RateLimiter)
local CombatService = {Cooldowns = {}, Mana = {}, IFrames = {}, limiter = RateLimiter.new(16, 1)}
function CombatService:Init(remotes, dataService)
	self.Remotes=remotes; self.Data=dataService
	remotes.Events.AbilityRequest.OnServerEvent:Connect(function(player, ability, payload) self:UseAbility(player, ability, payload or {}) end)
end
function CombatService:SpawnStats(player)
	self.Mana[player] = Config.Player.BaseMaxMana
end
function CombatService:_canCast(player, name)
	if not self.limiter:Allow(player.UserId) then return false end
	local def=AbilityConfig[name]; if not def then return false end
	local now=os.clock(); self.Cooldowns[player] = self.Cooldowns[player] or {}
	if (self.Cooldowns[player][name] or 0) > now then return false end
	if (self.Mana[player] or 0) < def.ManaCost then return false end
	return true, def
end
local function humanoidOf(model) return model and model:FindFirstChildOfClass("Humanoid") end
function CombatService:Damage(attacker, targetModel, amount, meta)
	local hum=humanoidOf(targetModel); if not hum or hum.Health<=0 then return false end
	if self.IFrames[targetModel] and self.IFrames[targetModel] > os.clock() then return false end
	local final=amount; if math.random()<((meta and meta.CritChance) or .08) then final*=1.6 end
	hum:TakeDamage(final)
	if self.Remotes then self.Remotes.Events.DamageNumber:FireAllClients(targetModel, math.floor(final), meta or {}) end
	return true
end
function CombatService:UseAbility(player, name, payload)
	local ok, def = self:_canCast(player, name); if not ok then return end
	local char=player.Character; local root=char and char:FindFirstChild("HumanoidRootPart"); local hum=char and char:FindFirstChildOfClass("Humanoid"); if not root or not hum or hum.Health<=0 then return end
	local profile=self.Data.Profiles[player] or {Level=1}; self.Mana[player]-=def.ManaCost; self.Cooldowns[player][name]=os.clock()+def.Cooldown
	local damage=(def.Damage or 0)+((profile.Level or 1)*(def.Scaling or 0)); local forward=root.CFrame.LookVector
	if name=="ShadowDash" then self.IFrames[char]=os.clock()+def.IFrames; root.AssemblyLinearVelocity=forward*def.Range*3+Vector3.yAxis*8 end
	if name=="Regeneration" then hum.Health=math.min(hum.MaxHealth, hum.Health + def.Heal + profile.Level*def.Scaling); self.IFrames[char]=os.clock()+.25 end
	local radius=def.Radius or def.Width or 12
	for _, model in ipairs(CollectionService:GetTagged("Damageable")) do
		local tr=model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
		if tr and (tr.Position-root.Position).Magnitude <= (def.Range or radius) then self:Damage(player, model, damage, {Ability=name, Knockback=def.Knockback, Stun=def.Stun}) end
	end
	self.Remotes.Events.CombatEvent:FireAllClients("AbilityCast", player, name, {Cooldown=def.Cooldown})
end
return CombatService

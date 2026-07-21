local PathfindingService = game:GetService("PathfindingService")
local CollectionService = game:GetService("CollectionService")
local Enemy = {}; Enemy.__index=Enemy
function Enemy.new(model, combat) CollectionService:AddTag(model,"Damageable"); return setmetatable({Model=model, Combat=combat, AggroRange=90, AttackRange=8, Damage=10, Home=model:GetPivot().Position}, Enemy) end
function Enemy:NearestPlayer(players)
	local root=self.Model:FindFirstChild("HumanoidRootPart"); if not root then return end; local best,dist
	for _,p in ipairs(players:GetPlayers()) do local cr=p.Character and p.Character:FindFirstChild("HumanoidRootPart"); if cr then local d=(cr.Position-root.Position).Magnitude; if d<self.AggroRange and (not dist or d<dist) then best=p; dist=d end end end
	return best,dist
end
function Enemy:Start(players)
	task.spawn(function()
		while self.Model.Parent do task.wait(.6); local target,dist=self:NearestPlayer(players); local hum=self.Model:FindFirstChildOfClass("Humanoid"); local root=self.Model:FindFirstChild("HumanoidRootPart"); if hum and root and target and target.Character then
			local tr=target.Character:FindFirstChild("HumanoidRootPart"); if tr then if dist<=self.AttackRange then self.Combat:Damage(nil,target.Character,self.Damage,{Enemy=self.Model.Name}) else local path=PathfindingService:CreatePath(); path:ComputeAsync(root.Position,tr.Position); for _,wp in ipairs(path:GetWaypoints()) do hum:MoveTo(wp.Position); if (tr.Position-root.Position).Magnitude<=self.AttackRange then break end end end end
		end end
	end)
end
return Enemy

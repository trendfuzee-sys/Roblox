local CollectionService = game:GetService("CollectionService")
local Util = require(game:GetService("ReplicatedStorage").UndergroundLeague.Shared.Util)
local SewerGenerator = {}
function SewerGenerator:Generate(parent)
	local sewer=Instance.new("Folder"); sewer.Name="Generated_UndergroundSewer"; sewer.Parent=parent
	Util.makePart(sewer,"SewerFoundation",Vector3.new(2800,8,2800),CFrame.new(0,-228,0),Color3.fromRGB(30,35,30),Enum.Material.Slate)
	for i=-1300,1300,180 do Util.makePart(sewer,"MainTunnel",Vector3.new(60,45,2700),CFrame.new(i,-195,0),Color3.fromRGB(55,65,55),Enum.Material.Concrete); Util.makePart(sewer,"CrossTunnel",Vector3.new(2700,45,60),CFrame.new(0,-195,i),Color3.fromRGB(55,65,55),Enum.Material.Concrete) end
	local rooms={"PvPLobby","RankedArena","CasualArena","TrainingArena","BossRoom","GeneratorRoom","MaintenanceRoom","SecretLootRoom"}
	for i,n in ipairs(rooms) do local r=Util.makePart(sewer,n,Vector3.new(180,55,180),CFrame.new(-1000+i*250,-190,-1150+(i%2)*2300),Color3.fromRGB(45,55,45),Enum.Material.Concrete); CollectionService:AddTag(r,n) end
	for i=1,120 do CollectionService:AddTag(Util.makePart(sewer,"FlickerLight",Vector3.new(5,5,5),CFrame.new(math.random(-1250,1250),-160,math.random(-1250,1250)),Color3.fromRGB(240,190,90),Enum.Material.Neon),"FlickerLight") end
	return sewer
end
return SewerGenerator

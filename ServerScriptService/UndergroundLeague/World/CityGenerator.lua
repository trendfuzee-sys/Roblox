local CollectionService = game:GetService("CollectionService")
local Util = require(game:GetService("ReplicatedStorage").UndergroundLeague.Shared.Util)
local CityGenerator = {}
local districts = {{"Downtown",Color3.fromRGB(80,85,95),Enum.Material.Glass},{"Residential",Color3.fromRGB(150,130,110),Enum.Material.Brick},{"Industrial",Color3.fromRGB(90,90,80),Enum.Material.Metal},{"Parks",Color3.fromRGB(60,130,70),Enum.Material.Grass},{"Docks",Color3.fromRGB(90,90,100),Enum.Material.Wood}}
function CityGenerator:Generate(parent)
	local city=Instance.new("Folder"); city.Name="GeneratedNYC_Surface"; city.Parent=parent
	Util.makePart(city,"CityBase",Vector3.new(3300,8,3300),CFrame.new(0,-4,0),Color3.fromRGB(45,45,45),Enum.Material.Asphalt)
	for x=-1500,1500,200 do Util.makePart(city,"Road_NS",Vector3.new(70,1,3300),CFrame.new(x,.1,0),Color3.fromRGB(25,25,25),Enum.Material.Asphalt) end
	for z=-1500,1500,200 do Util.makePart(city,"Road_EW",Vector3.new(3300,1,70),CFrame.new(0,.2,z),Color3.fromRGB(25,25,25),Enum.Material.Asphalt) end
	for i=1,240 do
		local d=districts[(i%#districts)+1]; local x=math.random(-1500,1500); local z=math.random(-1500,1500); local h=(d[1]=="Downtown") and math.random(120,520) or math.random(25,150)
		local b=Util.makePart(city,d[1].."_Building",Vector3.new(math.random(45,110),h,math.random(45,110)),CFrame.new(x,h/2,z),d[2],d[3]); CollectionService:AddTag(b,"Building")
		if i%9==0 then CollectionService:AddTag(b,"Enterable") end
	end
	local names={"PoliceStation","Hospital","Warehouse","Restaurant","Store","SubwayEntrance","ParkingLot"}
	for i,n in ipairs(names) do Util.makePart(city,n,Vector3.new(130,45,110),CFrame.new(-1450+i*370,22,1450),Color3.fromRGB(110+i*10,110,120),Enum.Material.Concrete) end
	for i=1,28 do local m=Util.makePart(city,"SewerManhole",Vector3.new(10,1,10),CFrame.new(math.random(-1450,1450),1,math.random(-1450,1450)),Color3.fromRGB(20,20,20),Enum.Material.Metal); CollectionService:AddTag(m,"SewerManhole") end
	for i=1,80 do CollectionService:AddTag(Util.makePart(city,"TrafficLight",Vector3.new(2,24,2),CFrame.new(math.random(-1500,1500),12,math.random(-1500,1500)),Color3.fromRGB(20,20,20),Enum.Material.Metal),"TrafficLight") end
	return city
end
return CityGenerator

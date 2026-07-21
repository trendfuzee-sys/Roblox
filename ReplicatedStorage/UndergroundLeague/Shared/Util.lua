local Util = {}
function Util.safeRequire(module) local ok, result = pcall(require, module); if not ok then warn(result) end; return ok and result or nil end
function Util.distance(a,b) return (a-b).Magnitude end
function Util.tag(instance, tag) game:GetService("CollectionService"):AddTag(instance, tag); return instance end
function Util.makePart(parent, name, size, cframe, color, material)
	local p=Instance.new("Part"); p.Name=name; p.Size=size; p.CFrame=cframe; p.Anchored=true; p.Color=color or Color3.new(1,1,1); p.Material=material or Enum.Material.Concrete; p.Parent=parent; return p
end
return Util

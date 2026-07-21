local InventoryService = {}
function InventoryService:Init(remotes,data) self.Remotes=remotes; self.Data=data; remotes.Events.InventoryAction.OnServerEvent:Connect(function(p,a,item) self:Handle(p,a,item) end) end
function InventoryService:Handle(player, action, item) local pr=self.Data.Profiles[player]; if not pr then return end; if action=="Equip" and item then pr.Equipment[item.Slot or "Utility"]=item elseif action=="Drop" then table.remove(pr.Inventory, tonumber(item) or 0) end; self.Remotes.Events.ProfileSync:FireClient(player,pr) end
function InventoryService:Add(player,item) local pr=self.Data.Profiles[player]; if pr then table.insert(pr.Inventory,item); self.Remotes.Events.Notification:FireClient(player,"Loot acquired: "..(item.Name or "Item")) end end
return InventoryService

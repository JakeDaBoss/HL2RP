--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "Normal Grade Ration Box";
ITEM.uniqueID = "normal_rationbox";
ITEM.model = "models/pg_plops/pg_food/pg_tortellinar.mdl";
ITEM.weight = 2;
ITEM.useText = "Open";
ITEM.description = "A normal grade ration box, usually issued to Citizens.";

-- Called when a player attempts to pick up the item.
function ITEM:CanPickup(player, quickUse, itemEntity)
	if (quickUse) then
		if (!player:CanHoldWeight(self.weight)) then
			Clockwork.player:Notify(player, {"YourInventoryFull"});
			
			return false;
		end;
	end;
end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (Schema:PlayerIsCombine(player)) then
		Clockwork.player:Notify(player, {"YouCannotOpenRation"});
		
		return false;
	elseif (player:GetFaction() == FACTION_ADMIN) then
		Clockwork.player:Notify(player, {"YouCannotOpenRation"});
		
		return false;
	else
		
		player:GiveItem(Clockwork.item:CreateInstance("citizen_supplements"), true);
		player:GiveItem(Clockwork.item:CreateInstance("citizenwater"), true);
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();
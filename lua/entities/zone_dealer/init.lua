--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("autorun/config.lua")

include("shared.lua")
include("autorun/config.lua")

function ENT:Initialize()
	self:SetModel(WEED_DEALERMODEL);
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetMoveType(MOVETYPE_STEP);
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetBloodColor(BLOOD_COLOR_RED);

	self:SetNWInt("price", WEED_PRICE);
end

function ENT:Think()

end

ENT.nextUse = 0
function ENT:AcceptInput(name, activator, caller)
   if (self.nextUse < CurTime()) then
	if IsValid(caller) and caller:IsPlayer() then
		if (caller:GetNWBool("GetHasPickup") == true) then
		caller:SetNWBool("GetHasPickup", false)
		if (WEED_WANTED) then
			if (!caller:getDarkRPVar("wanted")) then
				caller:wanted(caller, "Drug Trafficking", WEED_WANTEDTIME)
			end
		end
		caller:SendLua("local tab = {Color(76, 187, 23,255), [[[ZONE] ]], Color(255,255,255), [[You sold a bag of Weed for ]], Color(76, 187, 23), [["..WEED_PRICE.."$.]] } chat.AddText(unpack(tab))");
		timer.Simple(0.25, function() self:EmitSound(table.Random(WEED_YESSOUNDS), 100, 100) end);
		caller:addMoney(WEED_PRICE)
	else
		caller:SendLua("local tab = {Color(76, 187, 23,255), [[[ZONE] ]], Color(255,255,255), [[Fuck off! Bring me some of that good stuff already.]] } chat.AddText(unpack(tab))");
		timer.Simple(0.25, function() self:EmitSound(table.Random(WEED_NOSOUNDS), 100, 100) end);
		end
		end
	end
	self.nextUse = CurTime() + 1   
end

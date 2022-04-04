--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("autorun/config.lua")

include("shared.lua")
include("autorun/config.lua")

function ENT:Initialize()
	self:SetModel("models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetWeedbagPrice(WEED_PRICE)
end

function ENT:OnTakeDamage(dmginfo)
	self:VisualEffect();
	self:Remove()
end;

function ENT:VisualEffect()
	local effectData = EffectData();	
	effectData:SetStart(self:GetPos());
	effectData:SetOrigin(self:GetPos());
	effectData:SetScale(8);	
	util.Effect("GlassImpact", effectData, true, true);
end;

ENT.nextUse = 0
function ENT:Use(activator, caller)
		if (self.nextUse < CurTime()) then
			if (caller:GetNWBool("GetHasPickup") == false) then
				caller:SetNWBool("GetHasPickup", false)
				caller:SendLua("local tab = {Color(76, 187, 23,255), [[[ZONE] ]], Color(255,255,255), [[You Picked up a bag of Weed bring it to the dealer for cash!]] } chat.AddText(unpack(tab))");
				caller:SetNWBool("GetHasPickup", true)
				self:Remove()
			else
				caller:SendLua("local tab = {Color(76, 187, 23,255), [[[ZONE] ]], Color(255,255,255), [[You cant pick up more Weed you need to sell the one you have first!]] } chat.AddText(unpack(tab))");
		end
		self.nextUse = CurTime() + 1  
	end
end


hook.Add( "PlayerDeath", "dropweedondeath", function( victim, inflictor, attacker )
	if (WEED_DROPONDEATH) then
		if (victim:GetNWBool("GetHasPickup")) then
			local weedbag = ents.Create("zone_weedbag")
			weedbag:SetPos(victim:GetPos() + Vector(0, 0, 30))
			weedbag:Spawn()
			victim:SetNWBool("GetHasPickup", false)
		end
	end
end )


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
	self:SetModel("models/nater/weedplant_pot.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:GetHasWeedSeed(false)
	self:GetHasDirt(false)
	self:GetHasWater(false)
	self.EmitTime = CurTime()
	self:SetCookingProgress(0)
end

function ENT:CanCook()
	return (self:GetHasWater() and self:GetHasWeedSeed() and self:GetHasDirt())
end

function ENT:DoneCooking()
	return (self:GetCookingProgress() >= 100)
end

	function ENT:Think()
		if self:CanCook() and (not self:DoneCooking()) then
			self:SetCookingProgress(math.Clamp(self:GetCookingProgress() + 1, 0, 100))

		if (self:GetCookingProgress() == 0) then
			self:SetModel("models/nater/weedplant_pot.mdl")
		end

		if (self:GetCookingProgress() == 10) then
			self:SetModel("models/nater/weedplant_pot_growing1.mdl")
		end

    	if (self:GetCookingProgress() == 30) then
    		self:SetModel("models/nater/weedplant_pot_growing2.mdl")
    	end

    	if (self:GetCookingProgress() == 40) then
    		self:SetModel("models/nater/weedplant_pot_growing3.mdl")
    	end

    	if (self:GetCookingProgress() == 60) then
    		self:SetModel("models/nater/weedplant_pot_growing4.mdl")
    	end

    	if (self:GetCookingProgress() == 75) then
    		self:SetModel("models/nater/weedplant_pot_growing5.mdl")
    	end

    	if (self:GetCookingProgress() == 100) then
    		self:SetModel("models/nater/weedplant_pot_growing6.mdl")
    	end

		self:NextThink(CurTime() + WEED_GROWTIME / 100)
		return true
	end

end

function ENT:Touch(toucher)
	if IsValid(toucher) then
		if (toucher:GetClass() == "zone_water") and (not self:GetHasWater()) then
			self:SetHasWater(true)
			self:EmitSound("fizz.wav")
			toucher:Remove()
		elseif (toucher:GetClass() == "zone_weedseed") and (not self:GetHasWeedSeed()) then
			self:SetHasWeedSeed(true)
			self:EmitSound("fizz.wav")
			toucher:Remove()
		elseif (toucher:GetClass() == "zone_dirt") and (not self:GetHasDirt()) then
			self:SetHasDirt(true)
			self:EmitSound("fizz.wav")
			toucher:Remove()

		elseif (self:GetHasDirt() == true) then
			self:SetModel("models/nater/weedplant_pot_dirt.mdl")
		end
	end
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
	if IsValid(caller) and caller:IsPlayer() then
		if self:DoneCooking() then
			if (self:GetHasDirt()) then
				self:SetModel("models/nater/weedplant_pot_dirt.mdl")
			else
				self:SetModel("models/nater/weedplant_pot.mdl")
			end
			self:SetCookingProgress(0)
			caller:SendLua("local tab = {Color(76, 187, 23,255), [[[ZONE] ]], Color(255,255,255), [[You harvested weed from the pot. ]] } chat.AddText(unpack(tab))");
			local weedbag = ents.Create("zone_weedbag")
			weedbag:SetPos(self:GetPos() + Vector(0, 0, 30))
			weedbag:Spawn()
			self:SetHasWeedSeed(false)
			self:SetHasWater(false)
			end
		end
		self.nextUse = CurTime() + 1   
	    end

end

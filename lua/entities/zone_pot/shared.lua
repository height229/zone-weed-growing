--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Terracotta Pot"
ENT.Category = "[ZONE] Weed Growing"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CookingProgress")
	self:NetworkVar("Bool", 0, "HasWeedSeed")
	self:NetworkVar("Bool", 1, "HasWater")
	self:NetworkVar("Bool", 2, "HasDirt")

end

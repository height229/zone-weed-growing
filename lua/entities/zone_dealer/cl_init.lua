--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

AddCSLuaFile("autorun/config.lua")
include("autorun/config.lua")

include("shared.lua")

surface.CreateFont( "Mainfont", {
	font = "Trebuchet24",
	extended = false,
	size = 35,
	weight = 500,
	antialias = true,
	underline = false,
	shadow = true,
} )

surface.CreateFont( "pickupfont", {
	font = "Trebuchet24",
	extended = false,
	size = 14,
	weight = 500,
	antialias = true,
	underline = false,
	shadow = true,
} )

function ENT:Draw()
	self:DrawModel()

	local ang = self:GetAngles()
	local pos = self:GetPos()

	ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	ang:RotateAroundAxis(self:GetAngles():Forward(), 90)

	cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.125)

		draw.SimpleText(WEED_DEALERTEXT,"Mainfont",-10,-640,Color(76, 187, 23),1,1)
		draw.SimpleText("Press "..string.upper(input.LookupBinding("use")).." to sell weed.","pickupfont",0,-620,Color(255,255,255),1,1)

	cam.End3D2D()
end
--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

include("shared.lua")

surface.CreateFont( "pickupfont", {
	font = "Trebuchet24", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
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

		draw.SimpleText("Weed Bag","Mainfont",0,-100,Color(51, 214, 75),1,1)
		draw.SimpleText("Press "..string.upper(input.LookupBinding("use")).." to pickup.","pickupfont",0,-75,Color(255,255,255),1,1)

	cam.End3D2D()
end
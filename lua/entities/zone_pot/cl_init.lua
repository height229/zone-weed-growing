--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

include("shared.lua")

surface.CreateFont( "Mainfont", {
	font = "Trebuchet24", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

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

	local textAnim = (math.sin(CurTime() * 2.8) * 5)

	local donetime = self:GetCookingProgress()
	local Water = self:GetHasWater()
	local extract = self:GetHasWeedSeed() and self:GetHasWater() and self:GetHasDirt()

	ang:RotateAroundAxis(self:GetAngles():Right(), -90)
	ang:RotateAroundAxis(self:GetAngles():Forward(), 90)

	cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.125)

	if (WEED_ANIMATE) then
		draw.SimpleText("Terracotta Pot","Mainfont",0,-400 + textAnim,Color(255, 255, 255),1,1)
	else
		draw.SimpleText("Terracotta Pot","Mainfont",0,-400,Color(255, 255, 255),1,1)
	end

	cam.End3D2D()

	if (self:GetCookingProgress() == 100) then
	cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.125)

		if (WEED_ANIMATE) then
			draw.SimpleText("Press "..string.upper(input.LookupBinding("use")).." to harvest.","pickupfont",0,-380 + textAnim,Color(51, 214, 75),1,1)
		else
			draw.SimpleText("Press "..string.upper(input.LookupBinding("use")).." to harvest.","pickupfont",0,-380,Color(51, 214, 75),1,1)
		end

	cam.End3D2D()

	end

	cam.Start3D2D(pos + (ang:Up() * 10) + (ang:Right() * -5), ang, 0.1)
			draw.RoundedBox(2, -63, -65, 100, 30, Color(140, 0, 0, 100))
			if (self:GetCookingProgress() > 0) then
				draw.RoundedBox(2, -63, -65, self:GetCookingProgress(), 30, Color(0, 225, 0, 100))
			end
			draw.SimpleText("Progress", "Mainfont", -55, -64, Color(255, 255, 255, 255))
			if (self:GetCookingProgress() > 0) then
				draw.WordBox(2, -43, -30, "Weed", "Mainfont", Color(0, 225, 0, 100), Color(255, 255, 255, 255))
			else
				draw.WordBox(2, -43, -30, "Weed", "Mainfont", Color(255, 0, 0, 100), Color(255, 255, 255, 255))
			end
		cam.End3D2D()
	end
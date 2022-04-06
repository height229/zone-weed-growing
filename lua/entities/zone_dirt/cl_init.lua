--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- DON'T TOUCH THIS UNLESS YOU KNOW WHAT YOU'RE DOING! <ONLY FOR DEVELOPERS!>

include("shared.lua")

function ENT:Draw()

	self:DrawModel()

	local ang = self:GetAngles()
	local pos = self:GetPos()

	local textAnim = (math.sin(CurTime() * 2.8) * 5)

	ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	ang:RotateAroundAxis(self:GetAngles():Forward(), 90)

	cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.125)

	if (WEED_ANIMATE) then
		draw.SimpleText("Dirt","Mainfont",-20,-150 + textAnim,Color(139,69,19),1,1)
	else
		draw.SimpleText("Dirt","Mainfont",-20,-150,Color(139,69,19),1,1)
	end

	cam.End3D2D()
end
--[[------------------------------------------------------
--                   ZONE Weed Growing                  --
--              By: height229 (height229.com)           --
--]]------------------------------------------------------

-- Decides at which prices the weed will sell for.
WEED_PRICE = 20000

-- Decides how long it should take to grow weed (in seconds).
WEED_GROWTIME = 10

-- Decides if you should get wanted after selling weed.
WEED_WANTED = true

-- Decides how long the seller should be wanted for.
WEED_WANTEDTIME = 120

-- Drops the players weed on death.
WEED_DROPONDEATH = true

-- The text over the dealer npc.
WEED_DEALERTEXT = "WEED DEALER"

-- Decides which playermodel the dealer npc should use.
WEED_DEALERMODEL = "models/Humans/Group01/Male_01.mdl"

-- Sounds that should be played when selling to the dealer. (you can add more lines)
WEED_YESSOUNDS = {
	"vo/npc/male01/finally.wav",
	"vo/npc/male01/fantastic01.wav",
	"vo/npc/male01/gordead_ques10.wav"
};

-- Sounds that will be played when the player don't have anything to sell. (you can add more lines)
WEED_NOSOUNDS = {
	"vo/npc/male01/vquestion01.wav",
	"vo/npc/male01/gethellout.wav",
	"vo/npc/male01/answer17.wav"
};

-- Adds new entities to Darkrp (can be changed)
hook.Add("PostGamemodeLoaded", "DefaultDarkRPEntities", function()

	DarkRP.createCategory{
		name = "Weed Supplies",
		categorises = "entities",
		startExpanded = true,
		color = Color(0, 255, 0, 255),
		sortOrder = 1,
	}

	DarkRP.createEntity("Terracotta Pot", {
		ent = "zone_pot",
		model = "models/nater/weedplant_pot.mdl",
		price = 1000,
		max = 4,
		cmd = "buyzonepot",
		category = "Weed Supplies"
	}) 

	DarkRP.createEntity("Potting soil", {
		ent = "zone_dirt",
		model = "models/props_junk/garbage_bag001a.mdl",
		price = 1000,
		max = 1,
		cmd = "buyzoneweed",
		category = "Weed Supplies"
	}) 

	DarkRP.createEntity("Water", {
		ent = "zone_water",
		model = "models/props_junk/garbage_milkcarton001a.mdl",
		price = 1000,
		max = 2,
		cmd = "buyzonewater",
		category = "Weed Supplies"
	})

	DarkRP.createEntity("Weed seed", {
		ent = "zone_weedseed",
		model = "models/katharsmodels/contraband/zak_wiet/zak_seed.mdl",
		price = 3000,
		max = 1,
		cmd = "buyzoneweedseed",
		category = "Weed Supplies"
	})

end)
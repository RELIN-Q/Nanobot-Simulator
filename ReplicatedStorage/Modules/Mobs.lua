-- @ScriptType: ModuleScript
return {
	["Ladybug"] = {
		Name = "Ladybug",
		Health = 30,
		Level = 1,
		Loot = {
			Honey = {Chance=55,Amount=30},
			["Treat"] = {Chance=35,Amount=5},
			["Ticket"] = {Chance=25,Amount=3},
			["Royal Jelly"] = {Chance=20,Amount=1},
			["Basic Egg"] = {Chance=4.9,Amount=1},
			["Mythic Egg"] = {Chance=0.1,Amount=1},
		},
		LootType="Instant"
	},
	["Ladybug Boss"] = {
		Name = "Ladybug Boss",
		Health = 3500,
		Level = 1,
		Loot = {
			Honey = {Chance=55,Amount=100000},
			["Treat"] = {Chance=35,Amount=25},
			["Ticket"] = {Chance=25,Amount=5},
			["Royal Jelly"] = {Chance=20,Amount=3},
			["Basic Egg"] = {Chance=4.9,Amount=1},
			["Mythic Egg"] = {Chance=0.1,Amount=1},
		},
		LootType="Token"
	}
}
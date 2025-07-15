-- @ScriptType: ModuleScript
return {
	["Basic Egg"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Hatches into a Basic Bee",
		UseableOnSlot = true,
		UseableOcc = false
	},
	["Basic Nano-Mod"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Installs a Basic Nanobot",
		UseableOnSlot = true,
		UseableOcc = false
	},
	["Primary Module"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Installs the Primary Module",
		UseableOnSlot = true,
		UseableOcc = false
	},
	["Ticket"] = {
		Icon = "rbxassetid://11713568550",
		Description = "Used to buy things",
		UseableOnSlot = false,
		UseableOcc = false
	},
	["Vicious Bee Egg"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Always hatches into a Vicious Bee",
		UseableOnSlot = true,
		UseableOcc = true
	},
	["Red Extract"] = {
		Icon = "rbxassetid://2495935291",
		Description = "Grants x1.5 Red Pollen for 10 minutes.",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Red Extract Buff"] = {
		StatName = "RedPollen",
		Info = "x1.5 Red Pollen",
		Icon = "rbxassetid://2495935291",
		Clr = Color3.fromRGB(254, 198, 80)
	},
	["Blue Extract"] = {
		Icon = "rbxassetid://5916120072",
		Description = "Grants x1.5 Blue Pollen for 10 minutes.",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Blue Extract Buff"] = {
		StatName = "BluePollen",
		Info = "x1.5 Blue Pollen",
		Icon = "rbxassetid://5916120072",
		Clr = Color3.fromRGB(254, 198, 80)
	},
	["Micro Converter"] = {
		Icon = "rbxassetid://7041409606",
		Description = "Convert All of your pollens to honey.",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Mythic Egg"] = {
		Icon = "rbxassetid://11579884963",
		Description = "Hatches into a Mythic Bee",
		UseableOnSlot = true,
		UseableOcc = true
	},
	["Royal Jelly"] = {
		Icon = "rbxassetid://11473139678",
		Description = "Hatches into a Random Bee",
		UseableOnSlot = false,
		UseableOcc = true
	},
	["Star Jelly"] = {
		Icon = "rbxassetid://2485574975",
		Description = "Hatches into a Random Gifted Bee",
		UseableOnSlot = false,
		UseableOcc = true
	},
	["Treat"] = {
		Icon = "rbxassetid://11795980198",
		Description = "Grants 10 Bond to a Bee.",
		UseableOnSlot = false,
		UseableOcc = true,
		FeedBee = true,
Bond = 10
	},
	["Star Treat"] = {
		Icon = "rbxassetid://106566337731337",
		Description = "Grants 10 Bond to a Bee.",
		UseableOnSlot = false,
		UseableOcc = true,
		Bond = 1000
	},
	["Sunflower Seed"] = {
		Icon = "rbxassetid://11940501292",
		Description = "Grants 25 Bond to a Bee.",
		UseableOnSlot = false,
		UseableOcc = true,
		FeedBee = true,
		Bond = 25
	},
	["Strawberry"] = {
		Icon = "rbxassetid://11940505893",
		Description = "Grants 25 Bond to a Bee.",
		UseableOnSlot = false,
		UseableOcc = true,
		FeedBee = true,
		Bond = 25
	},
	["Sprout"] = {
		Icon = "rbxassetid://18641395540",
		Description = "Spawn A Sprout!.",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Sprinkler"] = {
		Icon = "rbxassetid://13016351302",
		Description = "Use while standing in flowers to place a Sprinkler.",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Field Dice"] = {
		Icon = "rbxassetid://17785800304",
		Description = "Roll a random field boost!",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Gumdrops"] = {
		Icon = "rbxassetid://13016678865",
		Description = "Yummy sticky gummy drops :)",
		UseableOnSlot = false,
		UseableOcc = false,
	},
	["Pineapple"] = {
		Icon = "rbxassetid://11940506169",
		Description = "Grants 25 Bond to a Bee.",
		UseableOnSlot = false,
		UseableOcc = true,
		FeedBee = true,
		Bond = 25
	},
	["Blueberry"] = {
		Icon = "rbxassetid://11940506386",
		Description = "Grants 25 Bond to a Bee.",
		UseableOnSlot = false,
		UseableOcc = true,
		FeedBee = true,
		Bond = 25
	},
	["Eviction"] = {
		Icon = "rbxassetid://11473784801",
		Description = "Evicts a Bee from its hive.",
		UseableOnSlot = false,
		UseableOcc = true
	},
	["Tide Popper"] = {
		ClickSpeed = 0.4,
		ConvertionRate = 200,
		BlueConvertRate = 200,
		RedConvertRate = 0,
		WhiteConvertRate = 400,
		WhiteRate = 150,
		RedRate = 0,
		BlueRate = 700,
		Power = 0.25,
		Passive = true,
		Stack = 500,
		EachClick = 3,
		BuffName = "Tidal Power",
		BuffColor = Color3.fromRGB(150, 200, 255),
		BuffIcon = "rbxassetid://11504519241"
	},
	["Scooper"] = {
		Description = "It collects 2 pollen from 2 patches in front of it with a speed of 0.8 seconds.",
		ClickSpeed = 0.8,
		ConvertionRate = 0,
		BlueConvertRate = 0,
		RedConvertRate = 0,
		WhiteConvertRate = 0,
		WhiteRate = 0,
		RedRate = 0,
		BlueRate = 0,
		Power = 0.1,
		Passive = false,
		Stack = 0,
		EachClick = 0,
		BuffName = "",
		BuffColor = Color3.fromRGB(0,0,0),
		BuffIcon = "",
	},
	["Porcelain Dipper"] = {
		ClickSpeed = 0.7,
		ConvertionRate = 5,
		BlueConvertRate = 15,
		RedConvertRate = 15,
		WhiteConvertRate = 25,
		WhiteRate = 50,
		RedRate = 25,
		BlueRate = 25,
		Power = 0.17,
		Passive = false,
		Stack = 0,
		EachClick = 0,
		BuffName = "",
		BuffColor = Color3.fromRGB(0,0,0),
		BuffIcon = ""
	},
	["Tidal Power"] = {
	Info = "Each time a tidal wave hits a bubble, it will add up. Stacks until 500 then you get Tidal Surge."	
	},
	["Science Enhancement"] = {
		StatName = "ConvertVisualGUIRate",
		Info = "+<ValueAmnt>% Convertion Rate",
		Icon = "rbxassetid://11608014921",
		Clr = Color3.fromRGB(244,169,13)
	},
	["Blue Boost"] = {
		StatName = "BlueBoost",
		Info = "+<ValueAmnt>% Blue Pollen",
		Icon = "rbxassetid://5029415876",
		Clr = Color3.fromRGB(146, 255, 142)
	},
	["Red Boost"] = {
		StatName = "RedBoost",
		Info = "+<ValueAmnt>% Red Pollen",
		Icon = "rbxassetid://5029422474",
		Clr = Color3.fromRGB(146, 255, 142)
	},
	["Clover Field Boost"] = {
		StatName = "Clover Field",
		Info = "x<ValueAmnt> Clover Field Boost",
		Icon = "rbxassetid://129474314",
		Clr = Color3.fromRGB(146, 255, 142)
	},
	["Bamboo Field Boost"] = {
		StatName = "Bamboo Field",
		Info = "x<ValueAmnt> Bamboo Field Boost",
		Icon = "rbxassetid://12078755974",
		Clr = Color3.fromRGB(21, 165, 255)
	},
	["Pepper Field Boost"] = {
		StatName = "Pepper Field",
		Info = "x<ValueAmnt> Pepper Field Boost",
		Icon = "rbxassetid://8981932662",
		Clr = Color3.fromRGB(255, 11, 11)
	},
	["Pouch"] = {
		Description = "A small bag.",
		Capacity = 150
	},
	["Coconut Canister"] = {
		Description = "Coconut Canister",
		Capacity = 10000000
	},
	["Honey Mask"] = {
		Description = "Grants x1.5 Pollen , +250K Capacity and Converts 35%",
		BlueConvertRate = 35,
		RedConvertRate = 35,
		WhiteConvertRate = 35,
		WhiteRate = 20,
		RedRate = 20,
		BlueRate = 20,
		Icon="rbxassetid://13678099828",
		Capacity = 250000,
		CritChance = 10,
		CritPower = 0.1,
	},
	["Belt Bag"] = {
		Description = "Grants +20% Pollen , Converts 35%",
		BlueConvertRate = 35,
		RedConvertRate = 35,
		WhiteConvertRate = 35,
		WhiteRate = 20,
		RedRate = 20,
		BlueRate = 20,
		Icon="",
		CritChance = 10,
		CritPower = 0.1,
	},
	["Red Guard"] = {
		Description = "Grants +20% Pollen , Converts 35%",
		BlueConvertRate = 35,
		RedConvertRate = 35,
		WhiteConvertRate = 35,
		WhiteRate = 20,
		RedRate = 20,
		BlueRate = 20,
		Icon="",
		CritChance = 10,
		CritPower = 0.1,
	},
	["Blue Guard"] = {
		Description = "Grants +20% Pollen , Converts 35%",
		BlueConvertRate = 35,
		RedConvertRate = 35,
		WhiteConvertRate = 35,
		WhiteRate = 20,
		RedRate = 20,
		BlueRate = 20,
		Icon="",
		CritChance = 10,
		CritPower = 0.1,
	},
	["Star Amulet"] = {
		Description = "Star Amulet 🤑",
		BlueConvertRate = 35,
		RedConvertRate = 35,
		WhiteConvertRate = 35,
		WhiteRate = 20,
		RedRate = 20,
		BlueRate = 20,
		Icon="",
		CritChance = 10,
		CritPower = 0.1,
	},
	["Basic Boots"] = {
		Description = "Collect pollen as you walk through flowers!",
		MovementCollection = 2,
		ConvertionRate = 25,
		BlueConvertRate = 0,
		RedConvertRate = 0,
		WhiteConvertRate = 0,
		WhiteRate = 0,
		RedRate = 0,
		BlueRate = 0,
		Power = 0.2,
		Passive = false,
		Stack = 0,
		EachClick = 0,
		BuffName = "",
		BuffColor = Color3.fromRGB(0,0,0),
		BuffIcon = ""
	},
	
	["Basic Sprinkler"] = {
		Description = "When planted in the ground, causes 7 nearby flowers to regrow faster!",
	},
	["Silver Soakers"] = {
		Description = "Two sprinklers which fire faster!",
	},
	["Golden Gushers"] = {
		Description = "Three gorgeous sprinklers with enormous range.",
	},
	["Diamond Drenchers"] = {
		Description = "Four enhanced sprinklers made of durable artificial diamond!",
	},
	["The Supreme Saturator"] = {
		Description = "The ultimate sprinkler. Nobody knows how it works or where it came from.",
	},
	["Glider"] = {
		Description = "Glider! You can glide this everywhere!",
	},
	["Ticket Planter"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Grows in 2 hours, gives lots of tickets.",
		UseableOnSlot = false,
		UseableOcc = false,
		["Time"] = 0.01, -- hours
		["LootReturn100%"] = {},
		["Loot"] = {
			["Chances"] = {
				["Puffs"] = 100,
				["NoPuffs"] = 0
			},
			["LootReturn100%"] = {},
			["Clover Field"] = {
				["Ticket"] = {40,1,5},
				["Treat"] = {20,1,25},
				["Sunflower Seed"] = {20,1,10},
				["Gumdrops"] = {15,1,6},
				["Royal Jelly"] = {5,1,3}
			},
			["Bamboo Field"] = {
				["Ticket"] = {40,1,5},
				["Treat"] = {20,1,15},
				["Blueberry"] = {20,1,25},
				["Gumdrops"] = {15,1,6},
				["Royal Jelly"] = {5,1,3}
			}
		}
	},
	["Paper Planter"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Grows in 1 hour, gives lots of items.",
		UseableOnSlot = false,
		UseableOcc = false,
		["Time"] = 0.01, -- hours
		["Loot"] = {
			["Chances"] = {
				["Puffs"] = 30,
				["NoPuffs"] = 70
			},
			["LootReturn100%"] = {},
			["Clover Field"] = {
				["Treat"] = {60,1,10},
				["Sunflower Seed"] = {20,1,5},
				["Gumdrops"] = {15,1,3},
				["Royal Jelly"] = {5,1,2}
			},
			["Bamboo Field"] = {
				["Treat"] = {20,1,10},
				["Blueberry"] = {60,1,5},
				["Gumdrops"] = {15,1,3},
				["Royal Jelly"] = {5,1,2}
			}
		}
	},
	["Plastic Planter"] = {
		Icon = "rbxassetid://11459121707",
		Description = "Grows in 2 hour, gives lots of items.",
		UseableOnSlot = false,
		UseableOcc = false,
		["Time"] = 0.01, -- hours
		["Loot"] = {
			["Chances"] = {
				["Puffs"] = 0,
				["NoPuffs"] = 0
			},
			["LootReturn100%"] = {},
			["Clover Field"] = {
				["Treat"] = {60,1,10},
				["Sunflower Seed"] = {20,1,5},
				["Gumdrops"] = {15,1,3},
				["Royal Jelly"] = {5,1,2}
			},
			["Bamboo Field"] = {
				["Treat"] = {20,1,10},
				["Blueberry"] = {60,1,5},
				["Gumdrops"] = {15,1,3},
				["Royal Jelly"] = {5,1,2}
			}
		}
	},

	
	["Common"] = {
		[1] = 10000,
		[2] = 30000,
		[3] = 50000,
		[4] = 80000,
		[5] = 130000,
		[6] = 200000,
		[7] = 330000,
		[8] = 560000,
		[9] = 970000,
		[10] = 1750000,
		[11] = 3230000,
		[12] = 6090000,
		[13] = 	11650000
	},
	["Rare"] = {
		[1] = 15000,
		[2] = 45000,
		[3] = 75000,
		[4] = 120000,
		[5] = 195000,
		[6] = 300000,
		[7] = 495000,
		[8] = 840000,
		[9] = 1455000,
		[10] = 2625000,
		[11] = 4845000,
		[12] = 9135000,
		[13] = 	17475000
	},
	["Epic"] = {
		[1] = 20000,
		[2] = 60000,
		[3] = 100000,
		[4] = 160000,
		[5] = 260000,
		[6] = 400000,
		[7] = 660000,
		[8] = 1120000,
		[9] = 1940000,
		[10] = 3500000,
		[11] = 6460000,
		[12] = 12180000,
		[13] = 	23300000,
	},
	["Legendary"] = {
		[1] = 25000,
		[2] = 75000,
		[3] = 125000,
		[4] = 200000,
		[5] = 325000,
		[6] = 500000,
		[7] = 825000,
		[8] = 1400000,
		[9] = 2425000,
		[10] = 4375000,
		[11] = 8075000,
		[12] = 15225000,
		[13] = 	29125000,
	},
	["Mythic"] = {
		[1] = 35000,
		[2] = 105000,
		[3] = 175000,
		[4] = 280000,
		[5] = 455000,
		[6] = 700000,
		[7] = 1155000,
		[8] = 1960000,
		[9] = 3395000,
		[10] = 6125000,
		[11] = 11305000,
		[12] = 21315000,
		[13] = 	40775000,
	},
	["PuffChance"] = {
		["Common Puffshroom"] = 80,
		["Rare Puffshroom"] = 10,
		["Epic Puffshroom"] = 7,
		["Legendary Puffshroom"] = 2.5,
		["Mythic Puffshroom"] = 0.5,

	},
	
	["Common Puffshroom"] = 0,
	["Rare Puffshroom"] = 1,
	["Epic Puffshroom"] = 2,
	["Legendary Puffshroom"] = 2.7,
	["Mythic Puffshroom"] = 3.6,
	["Puffdrops"] = {
		["Treat"] = {60,1,3},
		["Strawberry"] = {7,1,3},
		["Blueberry"] = {7,1,3},
		["Pineapple"] = {7,1,3},
		["Sunflower Seed"] = {7,1,3},
		["Royal Jelly"] = {2,1,2},
		["Gumdrops"] = {5,1,3},
		["Ticket"] = {4.5,1,3},
		["Mythic Egg"] = {0.5,1,1}
	},
	
	["BasicSprout"] = {
		Icon = "rbxassetid://15513079991",
		Description = "Summon Sprout.",
		UseableOnSlot = false,
		UseableOcc = false,
		Dragable = true,
		["LootReturn100%"] = {},
		["Loot"] = {

			["Clover Field"] = {
				["Treat"] = 50,	
				["Strawberry"] = 25,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Pepper Field"] = {
				["Treat"] = 25,	
				["Strawberry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Bamboo Field"] = {
				["Treat"] = 25,	
				["BlueBerry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
		},
		["Amount"] = {

			["Clover Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Bamboo Field"] = {
				["Blueberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Pepper Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
		}
	},
	["SupremeSprout"] = {
		Icon = "rbxassetid://15513079991",
		Description = "Summon Sprout.",
		UseableOnSlot = false,
		UseableOcc = false,
		Dragable = true,
		["LootReturn100%"] = {},
		["Loot"] = {

			["Clover Field"] = {
				["Treat"] = 50,	
				["Strawberry"] = 25,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Pepper Field"] = {
				["Treat"] = 25,	
				["Strawberry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Bamboo Field"] = {
				["Treat"] = 25,	
				["BlueBerry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
		},
		["Amount"] = {

			["Clover Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Bamboo Field"] = {
				["Blueberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Pepper Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
		}
	},
	["RareSprout"] = {
		Icon = "rbxassetid://15513079991",
		Description = "Summon Sprout.",
		UseableOnSlot = false,
		UseableOcc = false,
		Dragable = true,
		["LootReturn100%"] = {},
		["Loot"] = {

			["Clover Field"] = {
				["Treat"] = 50,	
				["Strawberry"] = 25,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Pepper Field"] = {
				["Treat"] = 25,	
				["Strawberry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Bamboo Field"] = {
				["Treat"] = 25,	
				["BlueBerry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
		},
		["Amount"] = {

			["Clover Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Bamboo Field"] = {
				["Blueberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Pepper Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
		}
	},
	["EpicSprout"] = {
		Icon = "rbxassetid://15513079991",
		Description = "Summon Sprout.",
		UseableOnSlot = false,
		UseableOcc = false,
		Dragable = true,
		["LootReturn100%"] = {},
		["Loot"] = {

			["Clover Field"] = {
				["Treat"] = 50,	
				["Strawberry"] = 25,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Pepper Field"] = {
				["Treat"] = 25,	
				["Strawberry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Bamboo Field"] = {
				["Treat"] = 25,	
				["BlueBerry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
		},
		["Amount"] = {

			["Clover Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Bamboo Field"] = {
				["Blueberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Pepper Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
		}
	},
	["LegendarySprout"] = {
		Icon = "rbxassetid://15513079991",
		Description = "Summon Sprout.",
		UseableOnSlot = false,
		UseableOcc = false,
		Dragable = true,
		["LootReturn100%"] = {},
		["Loot"] = {

			["Clover Field"] = {
				["Treat"] = 50,	
				["Strawberry"] = 25,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Pepper Field"] = {
				["Treat"] = 25,	
				["Strawberry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
			["Bamboo Field"] = {
				["Treat"] = 25,	
				["BlueBerry"] = 50,
				["Ticket"] = 5,
				["Royal Jelly"] = 5,


			},
		},
		["Amount"] = {

			["Clover Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Bamboo Field"] = {
				["Blueberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
			["Pepper Field"] = {
				["Strawberry"] = 1,
				["Treat"] = 2,
				["Ticket"] = 1,
				["Royal Jelly"] = 1,


			},
		}
	},

	
}
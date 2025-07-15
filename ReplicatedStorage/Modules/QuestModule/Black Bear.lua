-- @ScriptType: ModuleScript
--[[
QUEST TEMPLATE
	[1] = {
			Rewards = {
			[1] = {
					StatLocation = "Stats",
					StatName = "Honey",
					Amount = 250
				}	
			},
			QuestRequirement = {
				[1] = {
					QuestType="CollectPollen",
					PollenType="Clover Field",	
					Amount = 100,
					Collected = 0,
				}
			},
			QuestName = "Clover Starter",
			Dialog = {
				UnClaimed = {
					[1] = {Type="Continue",Text="Hi, I'm Black Bear!", Options = {}},
					[2] = {Type="Continue",Text="You look like a promising new honey maker!", Options = {}},
					[3] = {Type="Continue",Text="I happen to be a honey connoisseur.", Options = {}},
					[4] = {Type="Continue",Text="That means I know a lot about honey", Options = {}},
					[5] = {Type="Continue",Text="And if you're willing to go through my training, you'll be making tons of honey in no time!", Options = {}},
					[6] = {Type="Continue",Text="First off: Collect 100 pollen from the Clover Field!", Options = {}},
				},
				Claimed = {
					[1] = {Type="Continue",Text="In the real world, bees make honey out of nectar, not pollen.",Options={}},
					[2] = {Type="Continue",Text="But this is Roblox! Anything goes! Come back when you've collected 100 pollen from the Clover Field",Options={}}
				},
				Completed = {
					[1] = {Type="Continue",Text="Nice job! Here's a reward",Options={}},
					[2] = {Type="Continue",Text="Come talk to me again when you're ready for another quest.",Options={}},
				}
			}
		},

]]

return {
	Data = {
		["Quests"] = 5, --add +1 each new quest
	},
	Dialog = {
		[1] = {
			Rewards = {
			[1] = {
					StatLocation = "Stats",
					StatName = "Honey",
					Amount = 250
				}	
			},
			QuestRequirement = {
				[1] = {
					QuestType="CollectPollen",
					PollenType="Clover Field",	
					Amount = 100,
					Collected = 0,
				}
			},
			QuestName = "Clover Starter",
			Dialog = {
				UnClaimed = {
					[1] = {Type="Continue",Text="Hi, I'm Black Bear!", Options = {}},
					[2] = {Type="Continue",Text="You look like a promising new honey maker!", Options = {}},
					[3] = {Type="Continue",Text="I happen to be a honey connoisseur.", Options = {}},
					[4] = {Type="Continue",Text="That means I know a lot about honey", Options = {}},
					[5] = {Type="Continue",Text="And if you're willing to go through my training, you'll be making tons of honey in no time!", Options = {}},
					[6] = {Type="Continue",Text="First off: Collect 100 pollen from the Clover Field!", Options = {}},
				},
				Claimed = {
					[1] = {Type="Continue",Text="In the real world, bees make honey out of nectar, not pollen.",Options={}},
					[2] = {Type="Continue",Text="But this is Roblox! Anything goes! Come back when you've collected 100 pollen from the Clover Field",Options={}}
				},
				Completed = {
					[1] = {Type="Continue",Text="Nice job! Here's a reward",Options={}},
					[2] = {Type="Continue",Text="Come talk to me again when you're ready for another quest.",Options={}},
				}
			}
		},
		[2] = {
			Rewards = {
				[1] = {
					StatLocation = "Stats",
					StatName = "Honey",
					Amount = 500
				}	
			},
			QuestRequirement = {
				[1] = {
					QuestType="Defeat",
					PollenType="Ladybug",	
					Amount = 1,
					Collected = 0,
				}
			},
			QuestName = "Scary Bug",
			Dialog = {
				UnClaimed = {
					[1] = {Type="Continue",Text="I've heard there is something lurking in the Clover Field.", Options = {}},
					[2] = {Type="Continue",Text="From what i saw, it's a Scary Ladybug!", Options = {}},
					[3] = {Type="Continue",Text="Your bees are fighters too.", Options = {}},
					[4] = {Type="Continue",Text="You can use your bees' help to defeat it!", Options = {}},
					[5] = {Type="Continue",Text="Come back when you defeated it!", Options = {}},
				},
				Claimed = {
					[1] = {Type="Continue",Text="I can still see it in the Clover Field!",Options={}},
					[2] = {Type="Continue",Text="I think it's preparing for an attack! Go defeat it beekeeper, i belive in you!",Options={}}
				},
				Completed = {
					[1] = {Type="Continue",Text="Wow, your bees must bee very strong and brave.",Options={}},
					[2] = {Type="Continue",Text="Same goes for you beekeeper.",Options={}},
					[3] = {Type="Continue",Text="Here's a reward.",Options={}},
				}
			}
		},
		[3] = {
			Rewards = {
				[1] = {
					StatLocation = "Inventory",
					StatName = "Mythic Egg",
					Amount = 1
				},
				[2] = {
					StatLocation = "Inventory",
					StatName = "Treat",
					Amount = 50
				},
				[3] = {
					StatLocation = "Stats",
					StatName = "Honey",
					Amount = 500
				},
			},
			QuestRequirement = {
				[1] = {
					QuestType="CollectToken",
					PollenType="Blue Boost",	
					Amount = 3,
					Collected = 0,
				},
				[2] = {
					QuestType="CollectPollen",
					PollenType="Clover Field",	
					Amount = 1000,
					Collected = 0,
				},
				[3] = {
					QuestType="CollectColor",
					PollenType="Red",	
					Amount = 250,
					Collected = 0,
				},
			},
			QuestName = "Red Clover Salad",
			Dialog = {
				UnClaimed = {
					[1] = {Type="Continue",Text="I love salads!", Options = {}},
					[2] = {Type="Continue",Text="The Clover Salad is very delicious with some Red Pollen!", Options = {}},
					[3] = {Type="Continue",Text="This is the best chance to get lots of good stuff beekeeper!", Options = {}},
					[4] = {Type="Continue",Text="Collect 250 Red Pollen, 1000 Pollen from Clover Field and 3 Blue Boost Tokens!", Options = {}},
					[5] = {Type="Continue",Text="Come back when you have all the ingredients.", Options = {}},
				},
				Claimed = {
					[1] = {Type="Continue",Text="My stomach can't wait!",Options={}},
					[2] = {Type="Continue",Text="Those rewards are waiting for you beekeeper!",Options={}}
				},
				Completed = {
					[1] = {Type="Continue",Text="YEY, i can enjoy my salad now!",Options={}},
					[2] = {Type="Continue",Text="*Preparing*",Options={}},
					[3] = {Type="Continue",Text="Here it is, thanks beekeeper, here's your reward!",Options={}},
				}
			}
		},
		[4] = {
			Rewards = {
				[1] = {
					StatLocation = "Stats",
					StatName = "Honey",
					Amount = 3000
				},
				[2] = {
					StatLocation = "Inventory",
					StatName = "Pineapple",
					Amount = 250
				}
			},
			QuestRequirement = {
				[1] = {
					QuestType="CollectPollen",
					PollenType="Clover Field",	
					Amount = 5000,
					Collected = 0,
				},
				[2] = {
					QuestType="CollectColor",
					PollenType="Blue",	
					Amount = 1000,
					Collected = 0,
				},
			},
			QuestName = "Blue Clover Salad",
			Dialog = {
				UnClaimed = {
					[1] = {Type="Continue",Text="I've tried a Red Clover Salad.", Options = {}},
					[2] = {Type="Continue",Text="What about a Blue Clover Salad?", Options = {}},
					[3] = {Type="Continue",Text="Here's the reciepe for it!", Options = {}},
				
				},
				Claimed = {
					[1] = {Type="Continue",Text="I am hungry!",Options={}},
					[2] = {Type="Continue",Text="Hurry Up beekeeper!",Options={}}
				},
				Completed = {
					[1] = {Type="Continue",Text="Nice job! Here's a reward",Options={}},
					[2] = {Type="Continue",Text="Come talk to me again when you're ready for another quest.",Options={}},
				}
			}
		},
		[5] = {
			Rewards = {
				[1] = {
					StatLocation = "Stats",
					StatName = "Honey",
					Amount = 7000
				},
				[2] = {
					StatLocation = "Inventory",
					StatName = "Strawberry",
					Amount = 500
				},
				[3] = {
					StatLocation = "Inventory",
					StatName = "Mythic Egg",
					Amount = 1
				}
			},
			QuestRequirement = {
				[1] = {
					QuestType="CollectGum",
					PollenType="Goo",	
					Amount = 1000,
					Collected = 0,
				},
				[2] = {
					QuestType="CollectPollen",
					PollenType="Bamboo Field",	
					Amount = 10000,
					Collected = 0,
				},
			},
			QuestName = "Bamboo Goo",
			Dialog = {
				UnClaimed = {
					[1] = {Type="Continue",Text="I want some pink and blue goo!", Options = {}},
					[2] = {Type="Continue",Text="Collect 1000 Goo.", Options = {}},
					[3] = {Type="Continue",Text="Collect 10,000 Pollen from Bamboo Field.", Options = {}},

				},
				Claimed = {
					[1] = {Type="Continue",Text="I can't wait forever!",Options={}},
					[2] = {Type="Continue",Text="Hurry Up beekeeper!",Options={}}
				},
				Completed = {
					[1] = {Type="Continue",Text="Nice job! Here's a reward",Options={}},
					[2] = {Type="Continue",Text="Come talk to me again when you're ready for another quest.",Options={}},
				}
			}
		},
}
}
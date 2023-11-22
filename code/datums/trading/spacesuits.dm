/datum/trader/ship/spacesuits
	name = "Spacesuit Shop Employee"
	name_language = TRADER_DEFAULT_NAME
	origin = "Spacesuit Shop"
	possible_origins = list("Firestarters", "Everyday Life in Vacuum", "Void Tourism", "Lost In Space", "Space Safety Store", "Star Runners")

	speech = list(
		TRADER_HAIL_GENERIC       = "Hello, sir or ma'am! Welcome to ORIGIN, I hope you find what you are looking for.",
		TRADER_HAIL_DENY          = "Go bother someone else",

		TRADER_TRADE_COMPLETE     = "Thanks for buying our sturdy suits from ORIGIN!",
		TRADER_NO_BLACKLISTED     = "No-no-no. No deal",
		TRADER_NO_GOODS           = "I'm sorry, but we deal in cash only.",
		TRADER_NOT_ENOUGH         = "These are goods of highest quality and they cost more than that, trust me.",
		TRADER_HOW_MUCH           = "Our EVA suits are hard to find elsewhere, so I'd sell that to you for VALUE.",

		TRADER_COMPLEMENT_FAILURE = "I think you need to think your jokes twice.",
		TRADER_COMPLEMENT_SUCCESS = "Thank you for your appreciation.",
		TRADER_INSULT_GOOD        = "Woah, man, easy, it's not good for business.",
		TRADER_INSULT_BAD         = "Go breath some fresh vacuum, maybe that will put your mind in place, retard.",

		TRADER_BRIBE_FAILURE      = "I have other customers to trade with.",
		TRADER_BRIBE_SUCCESS      = "Yeah, maybe I'll stay for TIME more minutes."
	)

	possible_trading_items = list(
								/obj/item/tank/oxygen											= TRADER_THIS_TYPE,
								/obj/item/tank/emergency											= TRADER_SUBTYPES_ONLY,
								/obj/item/tank/jetpack/oxygen									= TRADER_THIS_TYPE,
								/obj/machinery/portable_atmospherics/canister/oxygen					= TRADER_THIS_TYPE,
								/obj/item/device/suit_cooling_unit										= TRADER_THIS_TYPE,
								/obj/item/clothing/mask/breath											= TRADER_THIS_TYPE,
								/obj/item/clothing/mask/gas												= TRADER_THIS_TYPE,
								/obj/item/clothing/mask/gas/old											= TRADER_THIS_TYPE,
								/obj/item/clothing/shoes/magboots										= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space											= TRADER_THIS_TYPE,
								/obj/item/clothing/head/helmet/space									= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/skrell									= TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/head/helmet/space/skrell								= TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/suit/space/syndicate									= TRADER_ALL,
								/obj/item/clothing/head/helmet/space/syndicate							= TRADER_ALL,
								/obj/item/clothing/suit/space/void/atmos/alt/prepared					= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/atmos/prepared						= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/engineering/alt/prepared				= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/engineering/salvage/prepared			= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/engineering/prepared					= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/excavation/prepared					= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/exploration/prepared					= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/medical/alt/prepared					= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/medical/prepared						= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/syndi/prepared						= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/mining/alt/prepared					= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/mining/prepared						= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/mining/reinforced/prepared			= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/pilot/prepared						= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/security/alt/prepared				= TRADER_THIS_TYPE,
								/obj/item/clothing/suit/space/void/security/prepared					= TRADER_THIS_TYPE,
								/obj/item/rig/ce													= TRADER_THIS_TYPE,
								/obj/item/rig/eva												= TRADER_THIS_TYPE,
								/obj/item/rig/security											= TRADER_THIS_TYPE,
								/obj/item/rig/hazmat												= TRADER_THIS_TYPE,
								/obj/item/rig/light/stealth										= TRADER_THIS_TYPE,
								/obj/item/rig/medical											= TRADER_THIS_TYPE,
								/obj/item/rig/industrial											= TRADER_THIS_TYPE,
								/obj/item/rig/mining												= TRADER_THIS_TYPE,
								/obj/item/rig/syndi/empty										= TRADER_THIS_TYPE,
								/obj/item/rig/unathi												= TRADER_ALL,
								/obj/item/rig_module													= TRADER_ALL,
								/obj/item/rig_module/chem_dispenser/ninja								= TRADER_BLACKLIST,
								/obj/item/rig_module/datajack											= TRADER_BLACKLIST,
								/obj/item/rig_module/mounted											= TRADER_BLACKLIST,
								/obj/item/rig_module/mounted/energy_blade								= TRADER_BLACKLIST,
								/obj/item/rig_module/fabricator											= TRADER_BLACKLIST,
								/obj/item/rig_module/stealth_field										= TRADER_BLACKLIST,
								/obj/item/rig_module/teleporter											= TRADER_BLACKLIST,
								/obj/item/rig_module/vision/multi										= TRADER_BLACKLIST
								)

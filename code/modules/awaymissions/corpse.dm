//These are meant for spawning on maps, namely Away Missions.

//If someone can do this in a neater way, be my guest-Kor

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).

#define CORPSE_SPAWNER_RANDOM_NAME       0x0001
#define CORPSE_SPAWNER_CUT_SURVIVAL      0x0002
#define CORPSE_SPAWNER_CUT_ID_PDA        0x0004
#define CORPSE_SPAWNER_PLAIN_HEADSET     0x0008

#define CORPSE_SPAWNER_RANDOM_SKIN_TONE    0x0010
#define CORPSE_SPAWNER_RANDOM_SKIN_COLOR   0x0020
#define CORPSE_SPAWNER_RANDOM_HAIR_COLOR   0x0040
#define CORPSE_SPAWNER_RANDOM_HAIR_STYLE   0x0080
#define CORPSE_SPAWNER_RANDOM_FACIAL_STYLE 0x0100
#define CORPSE_SPAWNER_RANDOM_EYE_COLOR    0x0200
#define CORPSE_SPAWNER_RANDOM_GENDER       0x0400

#define CORPSE_SPAWNER_NO_RANDOMIZATION ~ (CORPSE_SPAWNER_RANDOM_NAME|CORPSE_SPAWNER_RANDOM_SKIN_TONE|CORPSE_SPAWNER_RANDOM_SKIN_COLOR|CORPSE_SPAWNER_RANDOM_HAIR_COLOR|CORPSE_SPAWNER_RANDOM_HAIR_STYLE|CORPSE_SPAWNER_RANDOM_FACIAL_STYLE|CORPSE_SPAWNER_RANDOM_EYE_COLOR)


/obj/effect/landmark/corpse
	name = "Unknown"
	icon_state = "landmark_corpse"

	delete_after = TRUE

	var/species = list(SPECIES_HUMAN)                 // List of species to pick from.
	var/corpse_outfits = list(/decl/hierarchy/outfit) // List of outfits to pick from. Uses util_pick_weight()
	var/spawn_flags = (~0)

	var/skin_colors_per_species   = list() // Custom skin colors, per species -type-, if any. For example if you want dead Tajaran to always have brown fur, or similar
	var/skin_tones_per_species    = list() // Custom skin tones, per species -type-, if any. See above as to why.
	var/eye_colors_per_species    = list() // Custom eye colors, per species -type-, if any. See above as to why.
	var/hair_colors_per_species   = list() // Custom hair colors, per species -type-, if any. See above as to why.
	var/hair_styles_per_species   = list() // Custom hair styles, per species -type-, if any. For example if you want a punk gang with handlebars.
	var/facial_styles_per_species = list() // Custom facial hair styles, per species -type-, if any. See above as to why
	var/genders_per_species       = list() // For gender biases per species -type-

/obj/effect/landmark/corpse/Initialize()
	var/mob/living/carbon/human/M = new /mob/living/carbon/human(loc)

	randomize_appearance(M)
	equip_outfit(M)

	M.adjustOxyLoss(M.maxHealth) // Cease life functions.
	M.setBrainLoss(M.maxHealth)

	var/obj/item/organ/internal/heart/corpse_heart = M.internal_organs_by_name[BP_HEART]
	if(corpse_heart)
		corpse_heart.pulse = PULSE_NONE // Actually stops heart to make worried explorers not care too much.

	M.update_dna()
	M.update_icon()

	var/turf/T = get_turf(src)
	var/obj/structure/bed/C = locate() in T
	if(C)
		C.buckle_mob(M)

	. = ..()

#define HEX_COLOR_TO_RGB_ARGS(X) arglist(GetHexColors(X))
/obj/effect/landmark/corpse/proc/randomize_appearance(mob/living/carbon/human/M)
	M.set_species(util_pick_weight(species))

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_GENDER))
		if(M.species.type in genders_per_species)
			M.change_gender(util_pick_weight(genders_per_species[M.species.type]))
		else
			M.randomize_gender()

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_SKIN_TONE))
		if(M.species.type in skin_tones_per_species)
			M.change_skin_tone(util_pick_weight(skin_tones_per_species[M.species.type]))
		else
			M.randomize_skin_tone()

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_SKIN_COLOR))
		if(M.species.type in skin_colors_per_species)
			M.change_skin_color(HEX_COLOR_TO_RGB_ARGS(util_pick_weight(skin_colors_per_species[M.species.type])))
		else
			M.s_tone = random_skin_tone(M.species)

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_HAIR_COLOR))
		if(M.species.type in hair_colors_per_species)
			M.change_hair_color(HEX_COLOR_TO_RGB_ARGS(util_pick_weight(hair_colors_per_species[M.species.type])))
		else
			M.randomize_hair_color()
		M.change_facial_hair_color(M.r_hair, M.g_hair, M.b_hair)

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_HAIR_STYLE))
		if(M.species.type in hair_styles_per_species)
			M.change_hair(util_pick_weight(hair_styles_per_species[M.species.type]))
		else
			M.randomize_hair_style()

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_FACIAL_STYLE))
		if(M.species.type in facial_styles_per_species)
			M.change_facial_hair(util_pick_weight(facial_styles_per_species[M.species.type]))
		else
			M.randomize_facial_hair_style()

	if((spawn_flags & CORPSE_SPAWNER_RANDOM_EYE_COLOR))
		if(M.species.type in eye_colors_per_species)
			M.change_eye_color(HEX_COLOR_TO_RGB_ARGS(util_pick_weight(eye_colors_per_species[M.species.type])))
		else if(!(M.species.appearance_flags & HAS_EYE_COLOR))
			M.change_eye_color(HEX_COLOR_TO_RGB_ARGS(M.species.default_eye_color))
		else
			M.randomize_eye_color()

	M.SetName((CORPSE_SPAWNER_RANDOM_NAME & spawn_flags) ? M.species.get_random_name(M.gender) : name)
	M.real_name = M.name

#undef HEX_COLOR_TO_RGB_ARGS

/obj/effect/landmark/corpse/proc/equip_outfit(mob/living/carbon/human/M)
	var/adjustments = 0
	adjustments = (spawn_flags & CORPSE_SPAWNER_CUT_SURVIVAL)  ? (adjustments|OUTFIT_ADJUSTMENT_SKIP_SURVIVAL_GEAR) : adjustments
	adjustments = (spawn_flags & CORPSE_SPAWNER_CUT_ID_PDA)    ? (adjustments|OUTFIT_ADJUSTMENT_SKIP_ID_PDA)        : adjustments
	adjustments = (spawn_flags & CORPSE_SPAWNER_PLAIN_HEADSET) ? (adjustments|OUTFIT_ADJUSTMENT_PLAIN_HEADSET)      : adjustments

	var/decl/hierarchy/outfit/corpse_outfit = outfit_by_type(util_pick_weight(corpse_outfits))
	corpse_outfit.equip(M, equip_adjustments = adjustments)

/obj/effect/landmark/corpse/chef
	name = "Chef"
	corpse_outfits = list(/decl/hierarchy/outfit/job/service/chef)

/obj/effect/landmark/corpse/doctor
	name = "Doctor"
	corpse_outfits = list(/decl/hierarchy/outfit/job/medical/doctor)

/obj/effect/landmark/corpse/engineer
	name = "Engineer"
	corpse_outfits = list(/decl/hierarchy/outfit/job/engineering/engineer)

/obj/effect/landmark/corpse/scientist
	name = "Scientist"
	corpse_outfits = list(/decl/hierarchy/outfit/job/science/scientist)

/obj/effect/landmark/corpse/engineer/rig
	corpse_outfits = list(/decl/hierarchy/outfit/job/engineering/engineer/void)

/obj/effect/landmark/corpse/clown
	name = "Clown"
	corpse_outfits = list(/decl/hierarchy/outfit/clown)

/obj/effect/landmark/corpse/miner
	name = "Miner"
	corpse_outfits = list(/decl/hierarchy/outfit/job/cargo/mining)

/obj/effect/landmark/corpse/miner/rig
	corpse_outfits = list(/decl/hierarchy/outfit/job/cargo/mining/void)

/obj/effect/landmark/corpse/bridgeofficer
	name = "Bridge Officer"
	corpse_outfits = list(/decl/hierarchy/outfit/nanotrasen/officer)

/obj/effect/landmark/corpse/commander
	name = "Commander"
	corpse_outfits = list(/decl/hierarchy/outfit/nanotrasen/commander)

/obj/effect/landmark/corpse/pirate
	name = "Pirate"
	corpse_outfits = list(/decl/hierarchy/outfit/pirate/norm)
	spawn_flags = CORPSE_SPAWNER_NO_RANDOMIZATION

/obj/effect/landmark/corpse/pirate/ranged
	name = "Pirate Gunner"
	corpse_outfits = list(/decl/hierarchy/outfit/pirate/space)

/obj/effect/landmark/corpse/russian
	name = "Russian"
	corpse_outfits = list(/decl/hierarchy/outfit/soviet_soldier)
	spawn_flags = CORPSE_SPAWNER_NO_RANDOMIZATION

/obj/effect/landmark/corpse/russian/ranged
	corpse_outfits = list(/decl/hierarchy/outfit/soviet_soldier)

/obj/effect/landmark/corpse/syndicate
	name = "Syndicate Operative"
	corpse_outfits = list(/decl/hierarchy/outfit/syndicate/armored)
	spawn_flags = CORPSE_SPAWNER_NO_RANDOMIZATION
/obj/effect/landmark/corpse/syndicate/commando
	name = "Syndicate Commando"
	corpse_outfits = list(/decl/hierarchy/outfit/syndicate/armored/commando)

/obj/effect/landmark/corpse/deadcap
	name = "Dead Captain"
	corpse_outfits = list(/decl/hierarchy/outfit/deadcap)
	spawn_flags = CORPSE_SPAWNER_NO_RANDOMIZATION

/obj/effect/landmark/corpse/nurse
	name = "Dead Nurse"
	corpse_outfits = list(/decl/hierarchy/outfit/job/medical/doctor/nurse)
	spawn_flags = (~(CORPSE_SPAWNER_CUT_SURVIVAL|CORPSE_SPAWNER_PLAIN_HEADSET))

/obj/effect/landmark/corpse/nurse/equip_outfit(mob/living/carbon/human/M)
	. = ..()

	var/obj/item/organ/external/E = M.organs_by_name[BP_CHEST]
	var/obj/item/card/id/ID = new /obj/item/card/id/medical(E)
	E.implants += ID

	M.set_id_info(ID)

/datum/equipment_preset/nexus
	name = "Nexus Operative"
	languages = list(LANGUAGE_ENGLISH)
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_NEXUS
	faction_group = FACTION_LIST_NEXUS
	skills = /datum/skills/scav
	paygrades = list(PAY_SHORT_SCAV = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/nexus/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/nexus/load_race(mob/living/carbon/human/new_human)
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"

/datum/equipment_preset/nexus/grunt
	name = "Grunt"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/nexus/grunt/get_assignment(mob/living/carbon/human/new_human)
	return "Grunt"

/datum/equipment_preset/nexus/grunt/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(new_human), WEAR_BODY)
	//boots
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	//gear
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_R_STORE)

/datum/equipment_preset/nexus/grunt/load_name(mob/living/carbon/human/new_human, randomise)
	var/random_name
	new_human.gender = pick(MALE)
	if(new_human.gender == MALE)
		random_name = "GR-[rand(1,999)]"
	else
		random_name = "GR-[rand(1,999)]"
	new_human.change_real_name(new_human, random_name)

/datum/equipment_preset/nexus/agent
	name = "Agent"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/nexus/agent/get_assignment(mob/living/carbon/human/new_human)
	return "Agent"

/datum/equipment_preset/nexus/agent/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(new_human), WEAR_EYES)
	//boots
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	// gear
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended(new_human), WEAR_WAIST)

/datum/equipment_preset/nexus/agent/load_name(mob/living/carbon/human/new_human, randomise)
	var/random_name
	new_human.gender = pick(MALE)
	if(new_human.gender == MALE)
		random_name = "AG-[rand(1,999)]"
	else
		random_name = "AG-[rand(1,999)]"
	new_human.change_real_name(new_human, random_name)

/datum/equipment_preset/nexus/agentmkii
	name = "Elite Agent"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/nexus/agentmkii/get_assignment(mob/living/carbon/human/new_human)
	return "Agent+"

/datum/equipment_preset/nexus/agentmkii/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud(new_human), WEAR_EYES)
	//boots
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	//gear
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/elite(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap(new_human), WEAR_WAIST)

/datum/equipment_preset/nexus/agentmkii/load_name(mob/living/carbon/human/new_human, randomise)
	var/random_name
	new_human.gender = pick(MALE)
	if(new_human.gender == MALE)
		random_name = "EAG-[rand(1,999)]"
	else
		random_name = "EAG-[rand(1,999)]"
	new_human.change_real_name(new_human, random_name)

/datum/equipment_preset/nexus/atp/load_race(mob/living/carbon/human/new_human)
		new_human.set_species(SYNTH_GEN_THREE)
		new_human.h_style = "Bald"
		new_human.f_style = "Shaved"

/datum/equipment_preset/nexus/atp/load_skills(mob/living/carbon/human/new_human)
		new_human.set_skills(/datum/skills/everything)
		new_human.allow_gun_usage = TRUE

/datum/equipment_preset/nexus/atp/engineer
	name = "ATP Engineer"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/nexus/atp/engineer/get_assignment(mob/living/carbon/human/new_human)
	return "ATP Engineer"

/datum/equipment_preset/nexus/atp/engineer/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/marsoc(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/royal_marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc(new_human), WEAR_FACE)
	//boots
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	// gear
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/extended(new_human), WEAR_WAIST)

/datum/equipment_preset/nexus/atp/engineer/load_name(mob/living/carbon/human/new_human, randomise)
	var/random_name
	new_human.gender = pick(MALE)
	if(new_human.gender == MALE)
		random_name = "ATP/EN-[rand(1,999)]"
	else
		random_name = "ATP/EN-[rand(1,999)]"
	new_human.change_real_name(new_human, random_name)

/datum/equipment_preset/nexus/atp/soldat
	name = "ATP Soldat"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/nexus/atp/soldat/get_assignment(mob/living/carbon/human/new_human)
	return "ATP Soldat"

/datum/equipment_preset/nexus/atp/soldat/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/marsoc(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/royal_marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/canc_monoscope(new_human), WEAR_EYES)
	//boots
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	// gear
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/ap(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1/ap(new_human), WEAR_WAIST)

/datum/equipment_preset/nexus/atp/soldat/load_name(mob/living/carbon/human/new_human, randomise)
	var/random_name
	new_human.gender = pick(MALE)
	if(new_human.gender == MALE)
		random_name = "ATP/SD-[rand(1,999)]"
	else
		random_name = "ATP/SD-[rand(1,999)]"
	new_human.change_real_name(new_human, random_name)
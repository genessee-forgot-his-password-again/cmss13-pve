/datum/human_ai_squad_preset/scav
	faction = FACTION_SCAV

// scavs

/datum/human_ai_squad_preset/scav/scav_pistols
	name = "Scavs, Wanderers (Pistols)"
	desc = "Two poorly-equipped wandering scavs, each armed with a basic pistol."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/pistol = 2
	)

/datum/human_ai_squad_preset/scav/scav_rifle
	name = "Scavs, Scavenger Gang (Rifle & Pistols)"
	desc = "Three scavengers: one with a rifle, the other two armed with pistols."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/rifle = 1,
		/datum/equipment_preset/scav/pistol = 2
	)

/datum/human_ai_squad_preset/scav/scav_shotgun
	name = "Scavs, Scavenger Gang (Shotgun & Pistols)"
	desc = "Three scavengers: one with a shotgun and two with pistols."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/shotgun = 1,
		/datum/equipment_preset/scav/pistol = 2
	)

/datum/human_ai_squad_preset/scav/scav_patrol_rifles
	name = "Scavs, Patrol (Rifles & Pistol)"
	desc = "A three-scav patrol with two rifles and one pistol."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/rifle = 2,
		/datum/equipment_preset/scav/pistol = 1
	)

/datum/human_ai_squad_preset/scav/scav_patrol_shotguns
	name = "Scavs, Patrol (Shotguns & Pistol)"
	desc = "A three-scav patrol with two shotguns and one pistol."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/shotgun = 2,
		/datum/equipment_preset/scav/pistol = 1
	)

// merc & scav mix

/datum/human_ai_squad_preset/scav/mix_rifles
	name = "Merc & Scavs, Wanderers (Rifles)"
	desc = "A mixed group of one maradeur and two scavs, all equipped with rifles."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/rifle/elite = 1,
		/datum/equipment_preset/scav/rifle = 2
	)

/datum/human_ai_squad_preset/scav/mix_shotgun
	name = "Merc & Scavs, Wanderers (Shotguns)"
	desc = "A mixed group of one maradeur and two scavs, all armed with shotguns."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/shotgun/elite = 1,
		/datum/equipment_preset/scav/shotgun = 2
	)

/datum/human_ai_squad_preset/scav/mix_antitank
	name = "Merc & Scavs, Antitank Team"
	desc = "A mixed three-man team: one merc with a SADAR, one scav with a shotgun, and one scav with a rifle."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/antitank = 1,
		/datum/equipment_preset/scav/shotgun = 1,
		/datum/equipment_preset/scav/rifle = 1
	)

// mercs

/datum/human_ai_squad_preset/scav/merc_rifles
	name = "Mercs, Fireteam (Rifle+)"
	desc = "A three-man maradeur patrol, all equipped with advanced rifles."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/rifle/elite = 3
	)

/datum/human_ai_squad_preset/scav/merc_shotguns
	name = "Mercs, Fireteam (Shotguns+)"
	desc = "A three-man maradeur patrol, all equipped with advanced shotguns."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/shotgun/elite = 3
	)

/datum/human_ai_squad_preset/scav/merc_rifles_shotgun
	name = "Mercs, Fireteam (Rifle+, Shotgun+)"
	desc = "A maradeur fireteam with two advanced riflemen and one shotgunner."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/rifle/elite = 2,
		/datum/equipment_preset/scav/shotgun/elite = 1,
	)

/datum/human_ai_squad_preset/scav/merc_machinegun
	name = "Mercs, Heavy Weapon Fireteam (Heavy, Rifle+)"
	desc = "A maradeur heavy squad: one machine gunner and two riflemen."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/machinegun = 1,
		/datum/equipment_preset/scav/rifle/elite = 2,
	)

/datum/human_ai_squad_preset/scav/merc_antitank
	name = "Mercs, Antitank Fireteam (SADAR, Rifle+)"
	desc = "A maradeur team with one SADAR operator supported by two riflemen."
	ai_to_spawn = list(
		/datum/equipment_preset/scav/antitank = 1,
		/datum/equipment_preset/scav/rifle/elite = 2,
	)

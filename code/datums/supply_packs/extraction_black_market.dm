/datum/supply_packs/contraband/seized/confiscated_equipment/mendoza
	name = "Tool: Mendoza Scanner"
	contains = list(/obj/item/device/black_market_scanner)
	dollar_cost = 100
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "\improper mendoza crate"
	group = "CLF Equipment"

/datum/supply_packs/contraband/seized/confiscated_equipment/clf
	name = "CLF equipment crate (Clothing)"
	dollar_cost = 60
	group = "CLF Equipment"
	randomised_num_contained = 2
	contains = list(
		/obj/item/clothing/under/colonist/clf,
		/obj/item/clothing/head/militia,
		/obj/item/clothing/head/militia/bucket,
		/obj/item/clothing/head/beret/clf,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/prop/helmetgarb/clf_riot_shield,
		/obj/item/clothing/suit/storage/militia,
		/obj/item/clothing/suit/storage/militia/vest,
		/obj/item/clothing/suit/storage/militia/brace,
		/obj/item/clothing/suit/storage/militia/partial,
	)
	containertype = /obj/structure/largecrate/black_market
	containername = "\improper CLF surplus apparel crate"

/datum/supply_packs/contraband/seized/confiscated_equipment/clf_specfor
	name = "CLF equipment crate (Clothing - SpecForces)"
	dollar_cost = 120
	group = "CLF Equipment"
	randomised_num_contained = 2
	contains = list(
		/obj/item/clothing/under/colonist/clf/operative,
		/obj/item/clothing/under/colonist/clf/medic,
		/obj/item/clothing/under/colonist/clf/leader,
		/obj/item/clothing/suit/storage/marine/veteran/ua_riot/clf,
		/obj/item/clothing/suit/storage/marine/veteran/ua_riot/clf/jacket,
		/obj/item/clothing/suit/storage/marine/veteran/ua_riot/clf/heavy,
		/obj/item/clothing/head/militia/brown,
		/obj/item/clothing/head/militia/brown/armored,
		/obj/item/clothing/head/helmet/marine/veteran/clf,
		/obj/item/clothing/head/helmet/marine/veteran/clf/heavy,
		/obj/item/clothing/head/helmet/marine/veteran/clf/riot,
		/obj/item/clothing/suit/storage/militia/full,
		/obj/item/clothing/suit/storage/militia/smartgun,
	)
	containertype = /obj/structure/largecrate/black_market
	containername = "\improper CLF SpecForces surplus apparel crate"

/datum/supply_packs/contraband/seized/clf_weaponry
	name = "CLF weaponry crate"
	dollar_cost = 120
	group = "CLF Equipment"
	contains = list()
	containertype = /obj/structure/largecrate/black_market/clf_weaponry
	containername = "\improper CLF surplus weaponry crate"

/obj/structure/largecrate/black_market/clf_weaponry/Initialize()
	. = ..()
	spawn_guns()
	spawn_guns() //the crate gives 2 guns

/obj/structure/largecrate/black_market/clf_weaponry/proc/spawn_guns()
	switch(rand(1, 6))
		if(1)
			new /obj/item/weapon/gun/rifle/ar10(src)
			new /obj/item/ammo_magazine/rifle/ar10(src)
			new /obj/item/ammo_magazine/rifle/ar10(src)
			new /obj/item/ammo_magazine/rifle/ar10(src)
			new /obj/item/ammo_magazine/rifle/ar10(src)
		if(2)
			new /obj/item/weapon/gun/rifle/mar40(src)
			new /obj/item/ammo_magazine/rifle/mar40(src)
			new /obj/item/ammo_magazine/rifle/mar40(src)
			new /obj/item/ammo_magazine/rifle/mar40(src)
			new /obj/item/ammo_magazine/rifle/mar40(src)
		if(3)
			new /obj/item/weapon/gun/rifle/l42a(src)
			new /obj/item/ammo_magazine/rifle/l42a(src)
			new /obj/item/ammo_magazine/rifle/l42a(src)
			new /obj/item/ammo_magazine/rifle/l42a(src)
			new /obj/item/ammo_magazine/rifle/l42a(src)
		if(4)
			new /obj/item/weapon/gun/smg/ppsh(src)
			new /obj/item/ammo_magazine/smg/ppsh/extended(src)
			new /obj/item/ammo_magazine/smg/ppsh(src)
			new /obj/item/ammo_magazine/smg/ppsh(src)
			new /obj/item/ammo_magazine/smg/ppsh(src)
		if(5)
			new /obj/item/weapon/gun/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
		if(6)
			new /obj/item/weapon/gun/smg/mp27(src)
			new /obj/item/ammo_magazine/smg/mp27(src)
			new /obj/item/ammo_magazine/smg/mp27(src)
			new /obj/item/ammo_magazine/smg/mp27(src)
			new /obj/item/ammo_magazine/smg/mp27(src)

/datum/supply_packs/contraband/seized/clf_specfor_weaponry
	name = "CLF SpecForces weaponry crate"
	dollar_cost = 260
	group = "CLF Equipment"
	contains = list()
	containertype = /obj/structure/largecrate/black_market/clf_specfor_weaponry
	containername = "\improper CLF SpecForces surplus weaponry crate"

/obj/structure/largecrate/black_market/clf_specfor_weaponry/Initialize()
	. = ..()
	spawn_guns()

/obj/structure/largecrate/black_market/clf_specfor_weaponry/proc/spawn_guns()
	switch(rand(1, 6))
		if(1)
			new /obj/item/weapon/gun/rifle/m16a5(src)
			new /obj/item/ammo_magazine/rifle/m16/extended(src)
			new /obj/item/ammo_magazine/rifle/m16(src)
			new /obj/item/ammo_magazine/rifle/m16(src)
			new /obj/item/ammo_magazine/rifle/m16(src)
		if(2)
			new /obj/item/weapon/gun/smg/mp5/mp5a5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
			new /obj/item/ammo_magazine/smg/mp5(src)
		if(3)
			new /obj/item/weapon/gun/launcher/grenade/m81(src)
			new /obj/item/storage/box/packet/high_explosive(src)
			new /obj/item/storage/box/packet/high_explosive(src)
			new /obj/item/storage/box/packet/high_explosive(src)
		if(4)
			new /obj/item/weapon/gun/rifle/isr(src)
			new /obj/item/ammo_magazine/rifle/isr(src)
			new /obj/item/ammo_magazine/rifle/isr(src)
			new /obj/item/ammo_magazine/rifle/isr(src)
		if(5)
			new /obj/item/weapon/gun/rifle/m41a/stripped(src)
			new /obj/item/ammo_magazine/rifle(src)
			new /obj/item/ammo_magazine/rifle(src)
			new /obj/item/ammo_magazine/rifle(src)
			new /obj/item/ammo_magazine/rifle(src)
		if(6)
			new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb(src)
			new /obj/item/ammo_magazine/shotgun(src)
			new /obj/item/ammo_magazine/shotgun(src)
			new /obj/item/ammo_magazine/shotgun/buckshot(src)
			new /obj/item/ammo_magazine/shotgun/buckshot(src)

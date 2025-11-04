/obj/structure/machinery/fabricator
	name = "template"
	desc = "you shouldn't see this"
	icon_state = "autolathe"
	var/base_state = "autolathe"
	density = TRUE
	anchored = TRUE

	var/max_points = 0
	var/current_points = 0
	var/current_tab = null
	var/is_busy = FALSE

	var/list/categories = list()
// 	categories = list("Rifle", "SMG", "Shotgun", "Revolver", "Pistol")
	var/list/recipes = list()
	// "name" = list(obj path, price, amount, category)
	// "Rifle magazine (M41A-MK1)" = list(/obj/item/ammo_magazine/rifle/m41aMK1, 2, 1, "Rifle"),

/obj/structure/machinery/fabricator/attack_hand(mob/user)
	if(!Adjacent(user) || usr.stat)
		return
	ui_open(user)

/obj/structure/machinery/fabricator/proc/ui_open(mob/user)
	if(is_busy)
		user << browse("<html><body><h3 style='text-align:center; color:red;'>Fabricator busy...</h3></body></html>", "window=fabricator;size=300x100")
		return

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(close_ui))

	var/html = "<html><body style='background-color:#1b1b1b; color:#d0d0d0; font-family:Verdana; font-size:13px;'>"
	html += "<h2 style='text-align:center; color:#f0f0f0;'>[name]</h2>"
	html += "<p style='text-align:center;'>Fabrication points: <b>[current_points]</b> / [max_points]</p>"

	if(categories && length(categories))
		html += "<div style='text-align:center; margin-bottom:8px;'>"
		for(var/tab in categories)
			html += "<a href='?src=\ref[src];tab=[tab]' style='color:[current_tab==tab ? "#80ff80" : "#888"]; text-decoration:none; margin-right:10px;'>[tab]</a>"
		html += "</div><hr style='border:1px solid #444;'>"

	html += "<table style='width:100%; border-collapse:collapse;'>"
	html += "<tr style='color:#aaaaaa;'>"
	html += "<th align='left'>Item</th><th align='right'>Cost</th><th align='center'>Qty</th><th align='center'>Action</th></tr>"

	for(var/name in recipes)
		var/data = recipes[name]
		if(!islist(data) || length(data) < 4)
			continue
		if(current_tab && data[4] != current_tab)
			continue

		var/cost = data[2]
		html += "<tr style='border-bottom:1px solid #333;'>"
		html += "<td>[name]</td><td align='right'>[cost]</td><td align='center'>[data[3]]</td>"
		if(current_points >= cost)
			html += "<td align='center'><a href='?src=\ref[src];make=[name]' style='color:#80ff80; text-decoration:none;'>Fabricate</a></td>"
		else
			html += "<td align='center'><span style='color:#888;'>Insufficient</span></td>"
		html += "</tr>"


	html += "</table><hr style='border:1px solid #444;'>"
	html += "</body></html>"

	user << browse(html, "window=fabricator;size=640x640")

/obj/structure/machinery/fabricator/Topic(href, href_list)
	. = ..()
	if(is_busy)
		to_chat(usr, "<span class='warning'>Fabricator is busy. Please wait...</span>")
		return

	if(href_list["tab"])
		current_tab = href_list["tab"]
		ui_open(usr)
		return

	if(href_list["make"])
		fabricate(href_list["make"], usr)
		return

/obj/structure/machinery/fabricator/proc/fabricate(choice, mob/user)
	is_busy = TRUE
	var/list/data = recipes[choice]
	if(!data)
		is_busy = FALSE
		return

	var/typepath = data[1]
	var/cost = data[2]
	var/amount = data[3]

	if(current_points < cost)
		to_chat(user, "<span class='warning'>Not enough fabrication points!</span>")
		is_busy = FALSE
		return

	var/confirm = alert(user, "Fabricate [choice] for [cost] point(s)?", "Confirm Fabrication", "Yes", "No")
	if(confirm != "Yes")
		is_busy = FALSE
		return

	current_points -= cost
	to_chat(user, "<span class='notice'>Fabricator is printing [choice]...</span>")
	icon_state = "[base_state]_n"
	playsound(src, 'sound/machines/print.ogg', 25, TRUE)
	sleep(rand(30, 60))
	playsound(src, 'sound/machines/print_off.ogg', 25, TRUE)
	icon_state = "[base_state]"

	for(var/i in 1 to amount)
		var/obj/item/I = new typepath(get_turf(src))
		I.on_fabricated(src, user)


	to_chat(user, "<span class='notice'>The fabricator produces [amount]x [choice].</span>")
	to_chat(user, "<span class='notice'>Fabricator points left: [current_points]/[max_points]</span>")

	is_busy = FALSE
	ui_open(user)

/obj/item/proc/on_fabricated(/obj/structure/machinery/fabricator/, mob/user)
	return

/obj/structure/machinery/fabricator/proc/close_ui(atom/movable/user)
	if(!Adjacent(user))
		user << browse(null, "window=fabricator")
		to_chat(user, "<span class='warning'>You moved too far away from the fabricator.</span>")
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)


// Ration Packplant //

/obj/structure/machinery/fabricator/mre
	name = "Ration Packplant"
	desc = "A specialized fabricator designed to produce Military Rations (MREs) for field operatives. It utilizes limited resources that are replenished periodically."
	icon_state = "mrelathe"
	base_state = "mrelathe"

	max_points = 5
	current_points = 5

	categories = list("Low quality", "Average quality", "High quality")
	current_tab = "Low quality"

/obj/structure/machinery/fabricator/mre/Initialize()
	. = ..()

	// prob categories
	var/list/all_categories = list(
		list("Low quality", 100),
		list("Average quality", 50),
		list("High quality", 15)
	)

	if(("High quality" in categories) && !("Average quality" in categories))
		categories -= "High quality"

	categories = list()

	for(var/entry in all_categories)
		var/name = entry[1]
		var/chance = entry[2]
		if(prob(chance))
			categories += name

	if(!length(categories))
		categories += "Low quality"

	current_tab = categories[1]

	recipes = list(
		// Low quality
		"Humanitarian Daily Ration (UA)" = list(/obj/item/storage/box/mre/hdr, 1, 1, "Low quality"),
		"Box of HDR rations (UA)" = list(/obj/item/ammo_box/magazine/misc/mre/hdr, 3, 1, "Low quality"),
		"W-Y Brand Ration (WY)" = list(/obj/item/storage/box/mre/wy, 1, 1, "Low quality"),
		"Box of W-Y rations (WY)" = list(/obj/item/ammo_box/magazine/misc/mre/wy, 3, 1, "Low quality"), // 14 RP
		// Average quality
		"US Military Ration (USCM)" = list(/obj/item/storage/box/mre, 2, 1, "Average quality"),
		"Box of Military Rations (USCM)" = list(/obj/item/ammo_box/magazine/misc/mre, 4, 1, "Average quality"),
		"US First Strike Ration (USCM)" = list(/obj/item/storage/box/mre/fsr, 2, 1, "Average quality"),
		"Box of FSR Rations (USCM)" = list(/obj/item/ammo_box/magazine/misc/mre/fsr, 4, 1, "Average quality"),
		"Individual Meal Ration (UPP)" = list(/obj/item/storage/box/mre/upp, 2, 1, "Average quality"),
		"Box of UPP Rations (UPP)" = list(/obj/item/ammo_box/magazine/misc/mre/upp, 4, 1, "Average quality"), // 25 RP
		// High quality
		"Operation Ration (TWE)" = list(/obj/item/storage/box/mre/twe, 3, 1, "High quality"),
		"Box of Operation Rations (TWE)" = list(/obj/item/ammo_box/magazine/misc/mre/twe, 5, 1, "High quality"),
		"Combat Field Ration (WY)" = list(/obj/item/storage/box/mre/pmc, 3, 1, "High quality"),
		"Box of Combat Field Rations (WY)" = list(/obj/item/ammo_box/magazine/misc/mre/pmc, 5, 1, "High quality"), // 48 RP
	)

// Ammo Press //

/obj/structure/machinery/fabricator/ammunition
	name = "Ammo Press"
	desc = "A jury-rigged autolathe that's been modified to print various types of ammunition. It can pull from a limited material stock which replenishes every mission."
	icon_state = "ammolathe"
	base_state = "ammolathe"

	max_points = 4
	current_points = 4
	categories = list("Rifle", "SMG", "Shotgun", "Revolver", "Pistol")
	current_tab = "Rifle"

/obj/structure/machinery/fabricator/ammunition/Initialize()
	. = ..()
	recipes = list(
		// Rifle
		"Rifle magazine (M41A-MK1)" = list(/obj/item/ammo_magazine/rifle/m41aMK1, 2, 1, "Rifle"),
		"Rifle magazine (M41A-MK2)" = list(/obj/item/ammo_magazine/rifle, 1, 1, "Rifle"),
		"Rifle magazine (M20A)" = list(/obj/item/ammo_magazine/rifle/m20a, 1, 1, "Rifle"),
		"Rifle magazine (L42A)" = list(/obj/item/ammo_magazine/rifle/l42a, 1, 1, "Rifle"),
		"Rifle magazine (M49A)" = list(/obj/item/ammo_magazine/rifle/m49a, 1, 1, "Rifle"),
		"Rifle magazine (Type 71)" = list(/obj/item/ammo_magazine/rifle/type71, 1, 1, "Rifle"),
		"Rifle magazine (LW-317)" = list(/obj/item/ammo_magazine/rifle/lw317, 1, 1, "Rifle"),
		"Rifle magazine (M16)" = list(/obj/item/ammo_magazine/rifle/m16, 1, 1, "Rifle"),
		"Rifle magazine (AR-10)" = list(/obj/item/ammo_magazine/rifle/ar10, 1, 1, "Rifle"),
		"Rifle magazine (MAR-40)" = list(/obj/item/ammo_magazine/rifle/mar40, 1, 1, "Rifle"),
		"Rifle magazine (ABR-40)" = list(/obj/item/weapon/gun/rifle/l42a/abr40, 1, 1, "Rifle"),
		// SMG
		"SMG magazine (Viper 9)" = list(/obj/item/ammo_magazine/smg/m39, 1, 1, "SMG"),
		"SMG helical magazine (Type 64)" = list(/obj/item/ammo_magazine/smg/bizon, 1, 1, "SMG"),
		"SMG stick magazine (Type-19)" = list(/obj/item/ammo_magazine/smg/pps43, 1, 1, "SMG"),
		"SMG stick magazine (PPSh-17b)" = list(/obj/item/ammo_magazine/smg/ppsh, 1, 1, "SMG"),
		"SMG magazine (FN FP9000)" = list(/obj/item/ammo_magazine/smg/fp9000, 1, 1, "SMG"),
		"SMG magazine (MP27)" = list(/obj/item/ammo_magazine/smg/mp27, 1, 1, "SMG"),
		"SMG magazine (MP5)" = list(/obj/item/ammo_magazine/smg/mp5, 1, 1, "SMG"),
		// Shotgun
		"Shotgun magazine (XM51)" = list(/obj/item/ammo_magazine/rifle/xm51, 1, 1, "Shotgun"),
		"Ammo Packet, (Slug)" = list(/obj/item/ammo_magazine/shotgun, 1, 1, "Shotgun"),
		"Ammo Packet, (Buckshot)" = list(/obj/item/ammo_magazine/shotgun/buckshot, 1, 1, "Shotgun"),
		// Revolver
		"Revolver speedloader (Spearhead) x2" = list(/obj/item/ammo_magazine/revolver/spearhead, 1, 2, "Revolver"),
		"Revolver speedloader (M44) x2" = list(/obj/item/ammo_magazine/revolver, 1, 2, "Revolver"),
		// Pistol
		"Pistol magazines (VP70) x2" = list(/obj/item/ammo_magazine/pistol/vp70, 1, 2, "Pistol"),
		"Pistol magazines (M1911) x2" = list(/obj/item/ammo_magazine/pistol/m1911, 1, 2, "Pistol"),
		"Pistol magazines (M4A3) x2" = list(/obj/item/ammo_magazine/pistol, 1, 2, "Pistol"),
		"Pistol magazines (VP78) x2" = list(/obj/item/ammo_magazine/pistol/vp78, 1, 2, "Pistol"),
		"Pistol magazines (HG-45) x2" = list(/obj/item/ammo_magazine/pistol/highpower, 1, 2, "Pistol"),
	)

// Grenade Manufactory //

/obj/structure/machinery/fabricator/grenade
	name = "Grenade Manufactory"
	desc = "A specialized fabricator designed to produce various types of grenades for combat operatives. It can pull from a limited material stock which replenishes every mission."
	icon_state = "nadelathe"
	base_state = "nadelathe"

	max_points = 2
	current_points = 2
	categories = list("High Explosive", "Shrapnel", "Incendiary", "Airburst", "Miscellaneous")
	current_tab = "High Explosive"

/obj/structure/machinery/fabricator/grenade/Initialize()
	. = ..()
	recipes = list(
		// High Explosive
		"M40 HEDP Grenade" = list(/obj/item/explosive/grenade/high_explosive, 1, 1, "High Explosive"),
		"M15 Fragmentation Grenade" = list(/obj/item/explosive/grenade/high_explosive/m15, 1, 1, "High Explosive"),
		// Shrapnel
		"M40 HEFA Grenade" = list(/obj/item/explosive/grenade/high_explosive/frag, 1, 1, "Shrapnel"),
		"Type 6 Grenade" = list(/obj/item/explosive/grenade/high_explosive/upp, 1, 1, "Shrapnel"),
		// Incendiary
		"M77 HIAM Incendiary Grenade" = list(/obj/item/explosive/grenade/incendiary, 1, 1, "Incendiary"),
		"Improvised Phosphorus Grenade" = list(/obj/item/explosive/grenade/phosphorus/clf, 1, 1, "Incendiary"),
		// Airburst
		"M74 AGM-F Grenade" = list(/obj/item/explosive/grenade/high_explosive/airburst, 1, 1, "Airburst"),
		"M74 AGM-I Grenade" = list(/obj/item/explosive/grenade/incendiary/airburst, 1, 1, "Airburst"),
		"M74 AGM-S Grenade" = list(/obj/item/explosive/grenade/smokebomb/airburst, 1, 1, "Airburst"),
		"M74 AGM-H Hornet Shell" = list(/obj/item/explosive/grenade/high_explosive/airburst/hornet_shell, 1, 1, "Airburst"),
		"M74 AGM-S Star Shell" = list(/obj/item/explosive/grenade/high_explosive/airburst/starshell, 1, 1, "Airburst"),
		"M108 canister Grenade" = list(/obj/item/explosive/grenade/high_explosive/airburst/canister, 1, 1, "Airburst"),
		// Miscellaneous
		"M66 Teargas Grenade" = list(/obj/item/explosive/grenade/tear/marine, 1, 1, "Miscellaneous"),
		"M47 HSDP Smoke Grenade" = list(/obj/item/explosive/grenade/smokebomb, 1, 1, "Miscellaneous"),
		"M47-G HSDP Smoke Grenade" = list(/obj/item/explosive/grenade/smokebomb/green, 1, 1, "Miscellaneous"),
		"M47-R HSDP Smoke Grenade" = list(/obj/item/explosive/grenade/smokebomb/red, 1, 1, "Miscellaneous"),
		"M72A2 HIPF Starshell Grenade" = list(/obj/item/explosive/grenade/high_explosive/impact/flare, 1, 1, "Miscellaneous"),
		"M42 MFHS Grenade" = list(/obj/item/explosive/grenade/metal_foam, 1, 1, "Miscellaneous"),
	)

// Chemistry Set //

/obj/structure/machinery/fabricator/chemistry
	name = "Chemistry Set"
	desc = "A specialized fabricator designed to produce various chemical compounds and mixtures for field operatives. It can pull from a limited material stock which replenishes every mission."
	icon_state = "medilathe"
	base_state = "medilathe"

	max_points = 4
	current_points = 4
	categories = list("Kits", "Medical Packs", "Autoinjectors")
	current_tab = "Kits"

/obj/structure/machinery/fabricator/chemistry/Initialize()
	. = ..()
	recipes = list(
		// Kits
		"Regular First-Aid Kit" = list(/obj/item/storage/firstaid/regular, 4, 1, "Kits"),
		"Brute First-Aid Kit" = list(/obj/item/storage/firstaid/brute, 4, 1, "Kits"),
		"Fire First-Aid Kit" = list(/obj/item/storage/firstaid/fire, 4, 1, "Kits"),
		// Medical Packs
		"Gauzes x10" = list(/obj/item/stack/medical/bruise_pack, 1, 1, "Medical Packs"),
		"Ointments x10" = list(/obj/item/stack/medical/ointment, 1, 1, "Medical Packs"),
		"Splints x5" = list(/obj/item/stack/medical/splint, 1, 1, "Medical Packs"),
		// Autoinjectors
		"Bicaridine Autoinjector" = list(/obj/item/reagent_container/hypospray/autoinjector/bicaridine, 2, 1, "Autoinjectors"),
		"Kelotane Autoinjector" = list(/obj/item/reagent_container/hypospray/autoinjector/kelotane, 2, 1, "Autoinjectors"),
		"Tricordrazine Autoinjector" = list(/obj/item/reagent_container/hypospray/autoinjector/tricord, 2, 1, "Autoinjectors"),
		"Tramadol Autoinjector" = list(/obj/item/reagent_container/hypospray/autoinjector/tramadol, 2, 1, "Autoinjectors"),
		"Inaprovaline Autoinjector" = list(/obj/item/reagent_container/hypospray/autoinjector/inaprovaline, 2, 1, "Autoinjectors"),
	)

/obj/structure/machinery/ammunition_fabricator
	name = "ammunition fabricator"
	desc = "An old ammunition fabricator that runs on a good word, it seems to have a limited number of charges."
	icon_state = "armylathe"
	var/base_state = "armylathe"
	density = TRUE
	anchored = TRUE

	var/max_points = 4
	var/current_points = 4
	var/current_tab = "USCM" // "USCM", "UPP", "Outer Rim", "Small Arms"
	var/is_busy = FALSE

	/// Recipe list: [name] = list(type, price, quantity, category)
	var/list/recipes = list(
		// USCM
		"Rifle magazine (M41A-MK2, 10x24mm)" = list(/obj/item/ammo_magazine/rifle, 1, 1, "USCM"),
		"Rifle magazine (M20A, 10x24mm)" = list(/obj/item/ammo_magazine/rifle/m20a, 1, 1, "USCM"),
		"Rifle magazine (L42A, 10x24mm)" = list(/obj/item/ammo_magazine/rifle/l42a, 1, 1, "USCM"),
		"Rifle magazine (M49A, 10x28mm)" = list(/obj/item/ammo_magazine/rifle/m49a, 1, 1, "USCM"),
		"SMG magazine (Viper 9, 9mm)" = list(/obj/item/ammo_magazine/smg/m39, 1, 1, "USCM"),
		// UPP
		"Rifle magazine (Type 71, 10x27mm)" = list(/obj/item/ammo_magazine/rifle/type71, 1, 1, "UPP"),
		"Rifle magazine (LW-317, 6x38mm)" = list(/obj/item/ammo_magazine/rifle/lw317, 1, 1, "UPP"),
		"SMG helical magazine (Type 64, 7.62x19mm)" = list(/obj/item/ammo_magazine/smg/bizon, 1, 1, "UPP"),
		"SMG stick magazine (Type-19, 7.62x25mm)" = list(/obj/item/ammo_magazine/smg/pps43, 1, 1, "UPP"),
		"SMG drum magazine (Type-19, 7.62x25mm)" = list(/obj/item/ammo_magazine/smg/pps43/extended, 2, 1, "UPP"),
		"SMG stick magazine (PPSh-17b, 7.62x25mm)" = list(/obj/item/ammo_magazine/smg/ppsh, 1, 1, "UPP"),
		"SMG drum magazine (PPSh-17b, 7.62x25mm)" = list(/obj/item/ammo_magazine/smg/ppsh/extended, 2, 1, "UPP"),
		// Outer Rim
		"Rifle magazine (M16, 5.56x45mm)" = list(/obj/item/ammo_magazine/rifle/m16, 1, 1, "Outer Rim"),
		"Rifle magazine (AR-10, 7.62x51mm)" = list(/obj/item/ammo_magazine/rifle/ar10, 1, 1, "Outer Rim"),
		"Rifle magazine (MAR-40, 8.8x29mm)" = list(/obj/item/ammo_magazine/rifle/mar40, 1, 1, "Outer Rim"),
		"Rifle magazine, Extended (MAR-40, 8.8x29mm)" = list(/obj/item/ammo_magazine/rifle/mar40/extended, 1, 2, "Outer Rim"),
		"Rifle magazine (ABR-40, 10x24mm)" = list(/obj/item/weapon/gun/rifle/l42a/abr40, 1, 1, "Outer Rim"),
		"SMG magazine (MP27, 4.6x30mm)" = list(/obj/item/ammo_magazine/smg/mp27, 1, 1, "Outer Rim"),
		"SMG magazine (FN FP9000, 5.7x28mm)" = list(/obj/item/ammo_magazine/smg/fp9000, 1, 1, "Outer Rim"),
		"SMG magazine (MP5, 9mm)" = list(/obj/item/ammo_magazine/smg/mp5, 1, 1, "Outer Rim"),
		"Ammo Packet, Slugs (12g)" = list(/obj/item/ammo_magazine/shotgun, 1, 1, "Outer Rim"),
		"Ammo Packet, Buckshot (12g)" = list(/obj/item/ammo_magazine/shotgun/buckshot, 1, 1, "Outer Rim"),
		// Small Arms
		"Pistol magazines (M4A3, 9x19mm)" = list(/obj/item/ammo_magazine/pistol, 1, 2, "Small Arms"),
		"Pistol magazines (VP70, 9x19mm)" = list(/obj/item/ammo_magazine/pistol/vp70, 1, 2, "Small Arms"),
		"Pistol magazines (VP78, 9x19mm)" = list(/obj/item/ammo_magazine/pistol/vp78, 1, 2, "Small Arms"),
		"Pistol magazines (M1911, .45)" = list(/obj/item/ammo_magazine/pistol/m1911, 1, 2, "Small Arms"),
		"Pistol magazines (HG-45, .45)" = list(/obj/item/ammo_magazine/pistol/highpower, 1, 2, "Small Arms"),
		"Revolver speed loader (Spearhead, .357)" = list(/obj/item/ammo_magazine/revolver/spearhead, 1, 2, "Small Arms"),
		"Revolver speed loader (M44, .44)" = list(/obj/item/ammo_magazine/revolver, 1, 2, "Small Arms"),
	)

/obj/structure/machinery/ammunition_fabricator/attack_hand(mob/user)
	if(!Adjacent(user) || usr.stat)
		return
	ui_open(user)

/obj/structure/machinery/ammunition_fabricator/proc/ui_open(mob/user)
	if(is_busy)
		user << browse("<html><body><h3 style='text-align:center; color:red;'>Fabricator busy...</h3></body></html>", "window=ammunition_fabricator;size=300x100")
		return

	var/html = "<html><body style='background-color:#1b1b1b; color:#d0d0d0; font-family:Verdana; font-size:13px;'>"
	html += "<h2 style='text-align:center; color:#f0f0f0;'>Ammunition Fabricator</h2>"
	html += "<p style='text-align:center;'>Fabrication points: <b>[current_points]</b> / [max_points]</p>"

	html += "<div style='text-align:center; margin-bottom:8px;'>"
	html += "<a href='?src=\ref[src];tab=USCM' style='color:[current_tab=="USCM"?"#80ff80":"#888"]; text-decoration:none; margin-right:10px;'>USCM</a>"
	html += "<a href='?src=\ref[src];tab=UPP' style='color:[current_tab=="UPP"?"#80ff80":"#888"]; text-decoration:none; margin-right:10px;'>UPP</a>"
	html += "<a href='?src=\ref[src];tab=Outer Rim' style='color:[current_tab=="Outer Rim"?"#80ff80":"#888"]; text-decoration:none; margin-right:10px;'>Outer Rim</a>"
	html += "<a href='?src=\ref[src];tab=Small Arms' style='color:[current_tab=="Small Arms"?"#80ff80":"#888"]; text-decoration:none;'>Small Arms</a>"
	html += "</div><hr style='border:1px solid #444;'>"

	html += "<table style='width:100%; border-collapse:collapse;'>"
	html += "<tr style='color:#aaaaaa;'>"
	html += "<th align='left'>Item</th><th align='right'>Cost</th><th align='center'>Quantity</th><th align='center'>Action</th></tr>"

	for(var/name in recipes)
		var/data = recipes[name]
		if(data[4] != current_tab)
			continue

		var/cost = data[2]
		html += "<tr style='border-bottom:1px solid #333;'>"
		html += "<td>[name]</td>"
		html += "<td align='right'>[cost]</td>"
		html += "<td align='center'>[data[3]]</td>"
		if(current_points >= cost)
			html += "<td align='center'><a href='?src=\ref[src];make=[name]' style='color:#80ff80; text-decoration:none;'>Fabricate</a></td>"
		else
			html += "<td align='center'><span style='color:#888;'>Insufficient</span></td>"
		html += "</tr>"

	html += "</table><hr style='border:1px solid #444;'>"
	html += "</body></html>"

	user << browse(html, "window=ammunition_fabricator;size=640x640")

/obj/structure/machinery/ammunition_fabricator/attackby(obj/item/W, mob/user)
	return ..()

/obj/structure/machinery/ammunition_fabricator/Topic(href, href_list)
	. = ..()
	if(is_busy)
		to_chat(usr, "<span class='warning'>Fabricator is busy. Please wait...</span>")
		return

	if(href_list["tab"])
		current_tab = href_list["tab"]
		ui_open(usr)
		return

	if(href_list["make"])
		is_busy = TRUE
		var/choice = href_list["make"]
		var/list/data = recipes[choice]
		if(!data)
			is_busy = FALSE
			return

		var/typepath = data[1]
		var/cost = data[2]
		var/amount = data[3]

		if(current_points < cost)
			to_chat(usr, "<span class='warning'>Not enough fabrication points!</span>")
			is_busy = FALSE
			return

		var/confirm = alert(usr, "Fabricate [choice] for [cost] point(s)?", "Confirm Fabrication", "Yes", "No")
		if(confirm != "Yes")
			is_busy = FALSE
			return

		current_points -= cost
		to_chat(usr, "<span class='notice'>Fabricator is printing [choice]...</span>")
		icon_state = "[base_state]_n"
		playsound(src, 'sound/machines/print.ogg', 25, TRUE)
		sleep(rand(30, 60))
		playsound(src, 'sound/machines/print_off.ogg', 25, TRUE)
		icon_state = "[base_state]"

		for(var/i in 1 to amount)
			var/obj/item/I = new typepath(get_turf(src))
			if(istype(I, /obj/item/ammo_magazine))
				var/obj/item/ammo_magazine/M = I
				M.current_rounds = M.max_rounds
				M.update_icon()

		to_chat(usr, "<span class='notice'>The fabricator produces [amount]x [choice].</span>")
		to_chat(usr, "<span class='notice'>Fabricator points left: [current_points]/[max_points]</span>")

		is_busy = FALSE
		ui_open(usr)

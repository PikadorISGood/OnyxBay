//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/structure/computerframe
	density = 1
	anchored = 0
	name = "computer frame"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "0"
	turf_height_offset = 12
	var/state = 0
	var/obj/item/circuitboard/circuit = null
	atom_flags = ATOM_FLAG_CLIMBABLE
	pull_sound = SFX_PULL_MACHINE
//	weight = 1.0E8

/obj/structure/computerframe/attackby(obj/item/P as obj, mob/user as mob)
	switch(state)
		if(0)
			if(isWrench(P))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				if(do_after(user, 20, src))
					to_chat(user, "<span class='notice'>You wrench the frame into place.</span>")
					src.anchored = 1
					src.state = 1
			if(isWelder(P))
				var/obj/item/weldingtool/WT = P
				if(!WT.remove_fuel(0, user))
					to_chat(user, "The welding tool must be on to complete this task.")
					return
				playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
				if(do_after(user, 20, src))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You deconstruct the frame.</span>")
					new /obj/item/stack/material/steel( src.loc, 5 )
					qdel(src)
		if(1)
			if(isWrench(P))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				if(do_after(user, 20, src))
					to_chat(user, "<span class='notice'>You unfasten the frame.</span>")
					src.anchored = 0
					src.state = 0
			if(istype(P, /obj/item/circuitboard) && !circuit)
				var/obj/item/circuitboard/B = P
				if(B.board_type == "computer")
					if(!user.drop(P, src))
						return
					playsound(loc, 'sound/items/Deconstruct.ogg', 50, 1)
					to_chat(user, "<span class='notice'>You place the circuit board inside the frame.</span>")
					icon_state = "1"
					circuit = P
				else
					to_chat(user, "<span class='warning'>This frame does not accept circuit boards of this type!</span>")
			if(isScrewdriver(P) && circuit)
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You screw the circuit board into place.</span>")
				src.state = 2
				src.icon_state = "2"
			if(isCrowbar(P) && circuit)
				playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You remove the circuit board.</span>")
				src.state = 1
				src.icon_state = "0"
				circuit.dropInto(loc)
				src.circuit = null
		if(2)
			if(isScrewdriver(P) && circuit)
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You unfasten the circuit board.</span>")
				src.state = 1
				src.icon_state = "1"
			if(isCoil(P))
				var/obj/item/stack/cable_coil/C = P
				if (C.get_amount() < 5)
					to_chat(user, "<span class='warning'>You need five coils of wire to add them to the frame.</span>")
					return
				to_chat(user, "<span class='notice'>You start to add cables to the frame.</span>")
				playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
				if(do_after(user, 20, src) && state == 2)
					if (C.use(5))
						to_chat(user, "<span class='notice'>You add cables to the frame.</span>")
						state = 3
						icon_state = "3"
		if(3)
			if(isWirecutter(P))
				playsound(src.loc, 'sound/items/Wirecutter.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You remove the cables.</span>")
				src.state = 2
				src.icon_state = "2"
				var/obj/item/stack/cable_coil/A = new /obj/item/stack/cable_coil( src.loc )
				A.amount = 5

			if(istype(P, /obj/item/stack/material) && P.get_material_name() == MATERIAL_GLASS)
				var/obj/item/stack/G = P
				if (G.get_amount() < 2)
					to_chat(user, "<span class='warning'>You need two sheets of glass to put in the glass panel.</span>")
					return
				playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You start to put in the glass panel.</span>")
				if(do_after(user, 20, src) && state == 3)
					if (G.use(2))
						to_chat(user, "<span class='notice'>You put in the glass panel.</span>")
						src.state = 4
						src.icon_state = "4"
		if(4)
			if(isCrowbar(P))
				playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You remove the glass panel.</span>")
				src.state = 3
				src.icon_state = "3"
				new /obj/item/stack/material/glass( src.loc, 2 )
			if(isScrewdriver(P))
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You connect the monitor.</span>")
				var/B = new src.circuit.build_path ( src.loc )
				src.circuit.construct(B)
				qdel(src)

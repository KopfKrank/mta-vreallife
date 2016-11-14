Eingangblip = createBlip( -2089.669, 84.314, 34, 18, 4, 0, 100, 0, 255)
paintball = createMarker( -2089.669, 84.314, 34, "cylinder", 1.5, 255, 255, 0, 255 )
warptab = {}
warptab[1]= {2538,-1281,1046}
warptab[2]= {2533,-1306,1046}
warptab[3]= {2570,-1281,1046}
warptab[4]= {2570,-1306,1046}
warptab[5]= {2577,-1304,1046}
warptab[6]= {2577,-1281,1046}
warptab[7]= {2582,-1285,1046}
warptab[8]= {2576,-1282,1039}
warptab[9]= {2568,-1306,1039}
warptab[10]= {2570,-1283,1033}
warptab[11]= {2564,-1305,1033}
warptab[12]= {2564,-1282,1033}
warptab[13]= {2532,-1281,1033}
warptab[14]= {2528,-1289,1033}
warptab[15]= {2525,-1297,1033}
warptab[20]= {2569,-1282,1048}
warptab[21]= {2569,-1385,1048}
warptab[22]= {2569,-1288,1048}
warptab[23]= {2569,-1291,1048}
warptab[24]= {2569,-1294,1048}
warptab[25]= {2569,-1297,1048}
warptab[26]= {2569,-1300,1048}
warptab[27]= {2569,-1303,1048}

local PaintballPlayers = {}

painteventmode = false
peventmaker = "none"
teilnehmer = 0
markerzu = false

function paintball_eventmode(player)
	if isReporter(player) or vioGetElementData(player, "adminlvl") >= 1 then
		local x, y, z = getElementPosition(player)
		--if getDistanceBetweenPoints3D ( x, y, z, -2092.289, 85.961, 35.313 ) >= 15 then
			if painteventmode == false then
				outputChatBox("Du hast den Paintball Event-Modus gestartet. Sobald du den Marker hittest, startet das Event, und keiner kann die Halle mehr betreten!", player, 0, 0, 200)
				painteventmode = true
				peventmaker = getPlayerName(player)
				teilnehmer = 0
				addEventHandler("onPlayerQuit", getRootElement(), function()
					if getPlayerName(source) == peventmaker then
						painteventmode = false
						peventmaker = "none"
						teilnehmer = 0
						markerzu = false
						outputChatBox("Das Paintball-Event wurde beendet (Disconnect "..peventmaker..")", getRootElement(), 255, 155, 0)
					end
				end)
				
			else
				outputChatBox("Der Eventmodus ist bereits an!", player, 200, 155, 0)
			end
		--else
			--outputChatBox("Du bist nicht an der Paintball-Halle.", player, 200, 0, 0)
		--end
	else
		outputChatBox("Du bist nicht befugt.", player, 200, 0, 0)
	end
end
addCommandHandler("paintballevent", paintball_eventmode)


function warp(player)
	if isPedInVehicle(player) == true then return end
	if vioGetElementData ( player, "playingtime" ) >= 180 then
		if painteventmode == true then
			if (getPlayerName(player) == peventmaker) then
				markerzu = true
				outputChatBox("Das Event hat begonnen!", player, 255, 155, 0)
			else
				if markerzu == false then
					teilnehmer = teilnehmer + 1
					
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Eintritt hat\ndich 10$\ngekostet!", 5000, 200, 200, 0 )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 10 )
					
					PaintballKasse = PaintballKasse + 10 --BIZ

					local warpp = math.random(1, 15)
					takeAllWeapons ( player )
					outputChatBox("Willkommen beim Paintballevent!", player, 255, 255, 0, false)
					outputChatBox("Du bekommst Waffen, und kannst laufen, sobald alle Spieler die Halle betreten haben, und das Event gestartet wird.", player, 255, 255, 0, false)
					showPlayerHudComponent(player, "radar", false)
					setElementFrozen(player, true)
					setElementPosition(player, unpack(warptab[warpp]))
					setElementDimension(player, 1000)
					setElementInterior(player, 2)
					
					setElementData(player, "paintevent", true)
					
					local pname = getPlayerName(player)
					PaintballPlayers[pname] = true
					
					addEventHandler("onMarkerHit", paintball, function(hitElement)
						if (getElementType(hitElement) == "player") then
							if (getPlayerName(hitElement) == peventmaker) then
								outputChatBox("Das Event hat nun begonnen.", player, 255, 155, 0, false)
								outputChatBox("Viel Glück!", player, 255, 155, 0, false)
								setElementFrozen(player, false)
								
								giveWeapon ( player, 33, 200, true)
								giveWeapon ( player, 30, 500, true)
								giveWeapon ( player, 29, 500, true)
							end
						end
					end)
					
				else
					outputChatBox("Momentan findet ein Paintballevent statt, du kannst die Halle nicht betreten.", player, 255, 155, 0)
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Eintritt hat\ndich 10$\ngekostet!", 5000, 200, 200, 0 )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 10 )
			
			PaintballKasse = PaintballKasse + 10 --BIZ

			local warpp = math.random(1, 15)
			takeAllWeapons ( player )
			outputChatBox("Willkommen in der Painballhalle!", player, 255, 255, 0, false)
			outputChatBox("Mit #1AFF00/goout #FFFF00kannst du die Halle verlassen!", player, 255, 255, 0, true)
			setElementPosition(player, unpack(warptab[warpp]))
			setElementDimension(player, 1000)
			setElementInterior(player, 2)
			giveWeapon ( player, 33, 200, true)
			giveWeapon ( player, 30, 500, true)
			giveWeapon ( player, 29, 500, true)
			showPlayerHudComponent(player, "radar", false)
			
			local pname = getPlayerName(player)
			PaintballPlayers[pname] = true
		end
	else
		outputChatBox("Du brauchst min. 3 Spielstunden!", player, 255, 255, 0, false)
	end
end
addEventHandler("onMarkerHit", paintball, warp)


function verlassen(player)
	if getElementDimension(player) == 1000 then
		if painteventmode == false then
			outputChatBox("Du hast die Paintballhalle verlassen!", player, 255, 255, 100, false)
			setElementPosition(player, -2092.455, 84.836, 35.313)
			setElementDimension(player, 0)
			setElementInterior(player, 0)
			setWeaponAmmo(player, 33, 0)
			setWeaponAmmo(player, 30, 0)
			setWeaponAmmo(player, 29, 0)
			local pname = getPlayerName(player)
			PaintballPlayers[pname] = false
		end
	end
end
addCommandHandler("goout", verlassen)


function paintballTreffer( attacker, weapon, bodypart, loss )
	--if not attacker == nil then
		if attacker then
			if weapon == 33 or weapon == 30 or weapon == 29 then
				if getElementDimension(attacker) == 1000 then
					if (painteventmode == true and teilnehmer == 2) then
						
						name1 = getPlayerName(attacker)
						name2 = getPlayerName(source)
						
						setElementPosition(source, -2092.455, 84.836, 35.313)
						setElementDimension(source, 0)
						setElementInterior(source, 0)
						setWeaponAmmo(source, 33, 0)
						setWeaponAmmo(source, 30, 0)
						setWeaponAmmo(source, 29, 0)
						setElementData(source, "paintevent", false)
						
						setElementPosition(attacker, -2092.455, 84.836, 35.313)
						setElementDimension(attacker, 0)
						setElementInterior(attacker, 0)
						setWeaponAmmo(attacker, 33, 0)
						setWeaponAmmo(attacker, 30, 0)
						setWeaponAmmo(attacker, 29, 0)
						setElementData(attacker, "paintevent", false)
						
						outputChatBox("Du wurdest von "..name1.." getroffen!",source,255,0,0)
						outputChatBox("Du hast "..name2.." getroffen!", attacker, 0,0,255)
						
						setElementHealth ( source, 100 )
						setElementHealth ( attacker, 100 )
						
						outputChatBox("2St. - "..getPlayerName(source), an, 0, 0, 255)
						outputChatBox("1St. - "..getPlayerName(attacker), an, 0, 0, 255)
						
						local an = getPlayerFromName(peventmaker)
						outputChatBox("Event zuende! - Eventmodus beendet", an, 255, 155, 0)
						setElementPosition(an, -2092.455, 84.836, 35.313)
						setElementDimension(an, 0)
						setElementInterior(an, 0)
						
						painteventmode = false
						peventmaker = "none"
						teilnehmer = 0
						markerzu = false
						
						PaintballPlayers[name1] = false
						PaintballPlayers[name2] = false
					else
						name1 = getPlayerName(attacker)
						name2 = getPlayerName(source)
						setElementFrozen ( source, true )
						setTimer(setElementFrozen, 50, 1, source, false)
						local warpp = math.random(20, 27)
						setElementPosition(source, unpack(warptab[warpp]))
						setElementDimension(source, 1000)
						setElementInterior(source, 2)
						setTimer( tot, 50 , 1 , source)
						setWeaponAmmo(source, 33, 0)
						setWeaponAmmo(source, 30, 0)
						setWeaponAmmo(source, 29, 0)
						outputChatBox("Du wurdest von "..name1.." getroffen!",source,255,0,0)
						outputChatBox("Du hast "..name2.." getroffen!", attacker, 0,0,255)
						outputChatBox("Mit #1AFF00/goout #FFFF00kannst du die Paintballhalle verlassen!", source, 255, 255, 0, true)
						setElementHealth ( source, 100 )
					end
				end
			end
		end
	--end
end
--addEventHandler("onPlayerDamage",getRootElement(),paintballTreffer)
addEvent( "paintballAttacked", true )
addEventHandler( "paintballAttacked", getRootElement(), paintballTreffer )

function tot(source)
	if painteventmode == true then
		outputChatBox("Du bist "..teilnehmer.."St. geworden!", source, 255, 255, 100, false)
		setElementPosition(source, -2092.455, 84.836, 35.313)
		setElementDimension(source, 0)
		setElementInterior(source, 0)
		setWeaponAmmo(source, 33, 0)
		setWeaponAmmo(source, 30, 0)
		setWeaponAmmo(source, 29, 0)
		setElementData(source, "paintevent", false)
		
		local an = getPlayerFromName(peventmaker)
		outputChatBox(teilnehmer.."St. - "..getPlayerName(source), an, 0, 0, 255)
		
		teilnehmer = teilnehmer - 1
		
		local pname = getPlayerName(source)
		PaintballPlayers[pname] = false
	else
		local warpp = math.random(1, 15)
		setElementPosition(source, unpack(warptab[warpp]))
		setElementDimension(source, 1000)
		setElementInterior(source, 2)
		setElementHealth(source, 100)
		giveWeapon (source, 33, 200, true)
		giveWeapon (source, 30, 500, true)
		giveWeapon (source, 29, 500, true)
	end
end

function paintPlayerOuit(quitType)
	local pl = source
	if getElementData(pl, "paintevent") == true then
		if teilnehmer == 2 then
			local an = getPlayerFromName(peventmaker)
			outputChatBox("2St. - "..getPlayerName(source).." ("..quitType..")", an, 0, 0, 255)
			outputChatBox("1St. - Noch in der Paintballhalle (bitte /goout) ("..quitType..")", an, 0, 0, 255)
			teilnehmer = teilnehmer - 1
			
			local pname = getPlayerName(source)
			PaintballPlayers[pname] = false
			
			painteventmode = false
			peventmaker = "none"
			teilnehmer = 0
			markerzu = false
		else
			local an = getPlayerFromName(peventmaker)
			outputChatBox(teilnehmer.."St. - "..getPlayerName(source).." ("..quitType..")", an, 0, 0, 255)
			teilnehmer = teilnehmer - 1
			
			local pname = getPlayerName(source)
			PaintballPlayers[pname] = false
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), paintPlayerOuit )
drivingSchoolMarkers = {
 ["x"] = {
  [1]=-2256.1000976563,
  [2]=-2251.5,
  [3]=-2226.6999511719,
  [4]=-2497.6999511719,
  [5]=-2581.3000488281,
  [6]=-2706.8999023438,
  [7]=-2706.3999023438,
  [8]=-2502.3999023438,
  [9]=-2047.1999511719
 },
 ["y"] = {
  [1]=-70,
  [2]=320.29998779297,
  [3]=507.5,
  [4]=451.79998779297,
  [5]=227.5,
  [6]=157.80000305176,
  [7]=-70.099998474121,
  [8]=-70,
  [9]=-94.400001525879
 },
 ["z"] = {
  [1]=35.200000762939,
  [2]=35.200000762939,
  [3]=35,
  [4]=28,
  [5]=9.3999996185303,
  [6]=4.3000001907349,
  [7]=4.3000001907349,
  [8]=25.60000038147,
  [9]=35.200000762939
 }
}

function startDrivingSchoolTheory_func ()

	local player = client
	setElementDimension ( player, tonumber ( vioGetElementData ( player, "playerid" ) ) )
	setElementPosition ( player, 361.36, 171.82, 1025.44 )
	setPedRotation ( player, 180 )
	triggerClientEvent ( player, "startDrivingLicenseTheory", player )
	showCursor ( player, true )
	setElementClicked ( player, true )
end

function showNextDrivingSchoolMarker ( player )

	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		local old = vioGetElementData ( player, "drivingSchoolMarker" )
		if old then
			if isElement ( old ) then
				destroyElement ( old )
				destroyElement ( vioGetElementData ( player, "drivingSchoolBlip" ) )
			end
		end
		local new = vioGetElementData ( player, "drivingSchoolCur" ) + 1
		vioSetElementData ( player, "drivingSchoolCur", new )
		if new <= table.size ( drivingSchoolMarkers["x"] ) then
			local x, y, z = drivingSchoolMarkers["x"][new], drivingSchoolMarkers["y"][new], drivingSchoolMarkers["z"][new]
			local marker = createMarker ( x, y, z, "checkpoint", 10, 200,0,0, 255, player )
			local blip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0, player )
			local dim = getElementDimension ( player )
			vioSetElementData ( player, "drivingSchoolMarker", marker )
			vioSetElementData ( player, "drivingSchoolBlip", blip )
			setElementDimension ( marker, dim )
			setElementDimension ( blip, dim )
			infobox ( player, "Checkpoint erreicht -\nnun zum nächsten!", 5000, 84, 242, 31 )
			addEventHandler ( "onMarkerHit", marker, showNextDrivingSchoolMarker )
		else
			triggerClientEvent ( player, "drivingSchoolFinished", player )
			spawnAfterDrivingSchool ( player )
			infobox ( player, "Herzlichen\nGlückwunsch,du hast\ndie Fahrprüfung\nbestanden!", 5000, 84, 242, 31 )
			vioSetElementData ( player, "carlicense", 1 )
			playSoundFrontEnd ( player, 40 )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - vioGetElementData ( player, "drivingLicensePrice" ) )
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Autofuehrerschein", 1, "UID", playerUID[getPlayerName ( player )] )
		end
	end
end

function drivingSchoolTheoryComplete_func ( correct )

	local player = client
	if correct >= 6 then
		-- Practise
		showCursor ( player, false )
		setElementClicked ( player, false )
		
		setElementInterior ( player, 0 )
		local dim = getElementDimension ( player )
		local veh = createVehicle ( 405, -2047, -78.300003051758, 35.200000762939 )
		local ped = createPed ( 17, 0, 0, 0 )
		warpPedIntoVehicle ( player, veh, 0 )
		warpPedIntoVehicle ( ped, veh, 1 )
		setVehicleDamageProof ( veh, true )
		setElementDimension ( veh, dim )
		setElementDimension ( ped, dim )
		
		vioSetElementData ( player, "drivingSchoolVeh", veh )
		vioSetElementData ( player, "drivingSchoolPed", ped )
		vioSetElementData ( player, "drivingSchoolCur", 0 )
		vioSetElementData ( player, "drivingSchoolPractise", true )
		
		toggleControl ( player, "enter_exit", false )
		
		outputChatBox ( "Um die praktische Prüfung abzuschließen, musst die die vorgegebene Strecke abfahren.", player, 200, 200, 0 )
		outputChatBox ( "Beachte dabei jedoch, dass du nicht schneller als 120 km/h fahren darfst - sonst ist die Prüfung gelaufen!", player, 200, 200, 0 )
		outputChatBox ( "Drücke X und L, um Licht oder Motor ein- oder aus zu schalten!", player, 200, 200, 0 )
		
		triggerClientEvent ( player, "checkDrivingSchoolSpeed", player )
		
		showNextDrivingSchoolMarker ( player )
		
		addEventHandler ( "onVehicleExit", veh,
			function ( player )
				infobox ( player, "Du hast das Fahrzeug verlassen!", 5000, 125, 0, 0 )
				spawnAfterDrivingSchool ( player )
			end
		)
		removeEventHandler ( "onPlayerQuit", player, drivingSchoolQuit )
		addEventHandler ( "onPlayerQuit", player, drivingSchoolQuit )
	else
		infobox ( player, "Du bist durchgefallen!\nDu hast nur "..correct.." / 7\n Fragen richtig be-\nantwortet.", 5000, 125, 0, 0 )
		spawnAfterDrivingSchool ( player )
	end
end
addEvent ( "drivingSchoolTheoryComplete", true )
addEventHandler ( "drivingSchoolTheoryComplete", getRootElement(), drivingSchoolTheoryComplete_func )

function drivingSchoolQuit ()

	local player = source
	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		spawnAfterDrivingSchool ( player )
	end
end

function drivingSchoolToFast_func ()

	if vioGetElementData ( client, "drivingSchoolPractise" ) then
		spawnAfterDrivingSchool ( client )
		infobox ( client, "Du bist zu\nschnell gefahren!", 5000, 125, 0, 0 )
	end
end
addEvent ( "drivingSchoolToFast", true )
addEventHandler ( "drivingSchoolToFast", getRootElement(), drivingSchoolToFast_func )

function spawnAfterDrivingSchool ( player )

	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		vioSetElementData ( player, "drivingSchoolPractise", false )
		local veh = vioGetElementData ( player, "drivingSchoolVeh" )
		if veh then
			if isElement ( veh ) then
				removePedFromVehicle ( player )
				destroyElement ( veh )
			end
		end
		local ped = vioGetElementData ( player, "drivingSchoolPed" )
		if ped then
			if isElement ( ped ) then
				destroyElement ( ped )
			end
		end
		local old = vioGetElementData ( player, "drivingSchoolMarker" )
		if old then
			if isElement ( old ) then
				destroyElement ( old )
				destroyElement ( vioGetElementData ( player, "drivingSchoolBlip" ) )
			end
		end
		
		if isElement ( player ) then
			toggleControl ( player, "enter_exit", true )
			setElementPosition ( player, -2026.6999511719, -98.099998474121, 35.200000762939 )
			setElementDimension ( player, 0 )
			setPedRotation ( player, 90 )
			setCameraTarget ( player )
			setElementDimension ( player, 0 )
			triggerClientEvent ( player, "drivingSchoolFinished", player )
		end
	end
end
--rathauspickup_1 = createPickup ( -2764.5270996094, 375.37478637695, 6.3415489196777, 3, 1239, 0)

jobchoosepickup = createPickup ( 362.45562744141, 173.81, 1007.5, 3, 1210, 50)  --- Jobbs
setElementInterior (jobchoosepickup, 3, 362.45562744141, 173.81, 1007.5)  --- Jobbs

createMarker ( -2057.6000976563, 454.10000610352, 34.700000762939, "corona", 1, getColorFromString ( "#0CF127" ) ) -- Marker für Eingang
cityHallEnter = createMarker ( -2057.6000976563, 454.10000610352, 34.700000762939+.5, "corona", 1, 0, 0, 0, 0 )  -- Rein gehen in den Marker
cityHallExit = createMarker ( 389.89999389648, 173.82061767578, 1007.3699951172+.5, "corona", 1, 0, 0, 0, 0 ) --  Marker für Ausgang
cityHallExitOptic = createMarker ( 389.89999389648, 173.82061767578, 1007.3699951172, "corona", 1, getColorFromString ( "#0CF127" ) ) -- Marker zu raus gehen
setElementInterior ( cityHallExit, 3 )
setElementInterior ( cityHallExitOptic, 3 )

createMarker ( -2026.6999511719, -101.69999694824, 35.200000762939, "corona", 1, getColorFromString ( "#0CF127" ) ) -- Marker für Eingang
cityEnter = createMarker ( -2026.6999511719, -101.69999694824, 35.200000762939+.5, "corona", 1, 0, 0, 0, 0 )  -- Rein gehen in den Marker
cityExit = createMarker ( -2026.8829345703, -103.7589263916, 1035.171875+.5, "corona", 1, 0, 0, 0, 0 ) --  Marker für Ausgang
cityExitOptic = createMarker ( -2026.8829345703, -103.7589263916, 1035.171875, "corona", 1, getColorFromString ( "#0CF127" ) ) -- Marker zu raus gehen
setElementInterior ( cityExit, 3 )
setElementInterior ( cityExitOptic, 3 )
--[[
cityHallEnter" type="corona" color="#FF000099" size="1" interior="0, , -2766.1726074219, 375.55252075195, 5.2596783638
cityhallExit" type="corona" color="#0000ff99" size="1" interior="3, , 389.89999389648, 173.82061767578, 1007.3699951172

cityHallOut90" doublesided="false" model="1337" interior="0, , -2765.0368652344, 375.58209228516, 5.99236536026
CityHallSpawn270" doublesided="false" model="1337" interior="3, , 388.5, 173.82061767578, 1008.032043457
]]

function jobchoosepickup_func (player)

	setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "showJobGui", getRootElement() )
	showCursor ( player, true )
	setElementClicked ( player, true )
end
addEventHandler ( "onPickupHit", jobchoosepickup, jobchoosepickup_func )

function pickedUpRathaus (source, dim)

	if getPedOccupiedVehicle(source) == false and dim then
		fadeElementInterior ( source, 3, 388.5, 173.82061767578, 1008.032043457, 90 )
		toggleControl ( source, "fire", false )
		toggleControl ( source, "enter_exit", false )
		vioSetElementData(source,"nodmzone", 1)
	end
end
addEventHandler ( "onMarkerHit", cityHallEnter, pickedUpRathaus )

function pickedUpRathaus3 (source, dim)

	if getPedOccupiedVehicle(source) == false and dim then
		fadeElementInterior ( source, 3, -2029.8472900391, -106.73593139648, 1035.171875, 90 )
		toggleControl ( source, "fire", false )
		toggleControl ( source, "enter_exit", false )
		vioSetElementData(source,"nodmzone", 1)
	end
end
addEventHandler ( "onMarkerHit", cityEnter, pickedUpRathaus3 )

--rathauspickup_2 = createPickup ( 387.705, 174.3994, 1008.3828, 3, 1239, 0)
--setElementInterior (rathauspickup_2, 3)

function pickedUpRathaus2 (source)

   fadeElementInterior ( source, 0, -2051, 464.60000610352, 35.200000762939, 300.005493 )  -- Spawn draußen
   toggleControl ( source, "fire", true )
   toggleControl ( source, "enter_exit", true )
   vioSetElementData(source,"nodmzone", 0)
end
addEventHandler ( "onMarkerHit", cityHallExit, pickedUpRathaus2 )

function pickedUpRathaus4 (source)

   fadeElementInterior ( source, 0, -2026.6999511719, -98.099998474121, 35.200000762939, 0.00274658 )  -- Spawn draußen
   toggleControl ( source, "fire", true )
   toggleControl ( source, "enter_exit", true )
   vioSetElementData(source,"nodmzone", 0)
end
addEventHandler ( "onMarkerHit", cityExit, pickedUpRathaus4 )

rathausmarker = createMarker ( -2032.6774902344, -117.50312042236, 1035.171875, "corona", 2, 125, 0, 0, 0 )
setElementInterior (rathausmarker, 3)
rathausmarker2 = createMarker ( -2032.6774902344, -117.50312042236, 1035.171875, "corona", 1, 125, 0, 0 )
setElementInterior (rathausmarker2, 3)



function rathausmarker_func (player)
   
    setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "ShowRathausMenue", getRootElement() )
	showCursor ( player, true )
	setElementClicked ( player, true )
end
addEventHandler ( "onMarkerHit", rathausmarker, rathausmarker_func )

rathausped = createPed(141, 359.7138671875, 173.625765625, 1008.38934)
setElementInterior (rathausped, 3)
setPedRotation(rathausped, 280)
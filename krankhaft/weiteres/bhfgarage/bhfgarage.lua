-- MARKER DRAUSSEN --
local marker1 = createMarker( -1988.647, 209.114, 26.937, "cylinder", 2, 255, 0, 0, 255 )

--DRAUSSEN > REIN--
function fickmuschi1(player)
	local theVehicle = getPedOccupiedVehicle ( player )
    if theVehicle then
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Parken hat\ndich 5$\ngekostet!", 5000, 200, 200, 0 )
		takePlayerMoney ( player, 5 )
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 5 )
		
		ParkhausKasse = ParkhausKasse + 5 --BIZ
	else
	triggerClientEvent ( player, "infobox_start", getRootElement(), "\n Herzlich\n Willkommen!", 5000, 200, 200, 0 )
	end
	
	setElementPosition ( player, -2468.323, -2531.634, 12)
    setElementRotation ( player, 0, 0, 270)
end
addEventHandler("onMarkerHit", marker1, fickmuschi1)

-- MARKER DRINNEN --
local marker2 = createMarker( -2478.111, -2533.907, 12.2, "cylinder", 2, 255, 0, 0, 255 )

--REIN > RAUS--
function fickmuschi2(player)
		setElementPosition ( player, -1991.909, 209.496, 27.4)
		setElementInterior ( player, 0)
		setElementRotation ( player, 0, 0, 90)
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n auf\n Wiedersehen!", 5000, 200, 200, 0 )
end
addEventHandler("onMarkerHit", marker2, fickmuschi2)
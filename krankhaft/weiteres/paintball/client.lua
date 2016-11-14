function setColor (cmd, r2, g2, b2)
	if r2 then
	    if tonumber (r2) >= 0 and tonumber (r2) <= 255 then
	    	r = tonumber (r2)
	    end
	end
 	if g2 then
	    if tonumber (g2) >= 0 and tonumber (g2) <= 255 then
	    	g = tonumber (g2)
	    end
	end
 	if b2 then
	    if tonumber (b2) >= 0 and tonumber (b2) <= 255 then
	    	b = tonumber (b2)
	    end
	end
end
--addCommandHandler ( "color", setColor)

function weaponfired (weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )

local r = math.random (0,255)
local g = math.random (0,255)
local b = math.random (0,255)

	local marker = createMarker ( hitX, hitY, hitZ, "corona", 0.1, r, g, b, 255 )
	setElementDimension(marker, 1000)
setElementInterior(marker, 2)
setTimer ( destroyElement, 30000, 1, marker )
end
addEventHandler ( "onClientPlayerWeaponFire", getRootElement(), weaponfired )

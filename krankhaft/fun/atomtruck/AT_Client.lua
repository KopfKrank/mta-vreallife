--[[
													#####################################
													#		Copyright by StiviK			#
													#									#
													#	Dieses Copyright darf nicht		#
													#	entfernt oder geändert werden!	#
													#####################################
--]]



atped = createPed ( 286, 2439.784, -2123.77, 13.54 )
	setElementFrozen ( atped, true )
atped1 = createPed ( 286, 2442.9355, -2123.77, 13.54 )
	setElementFrozen ( atped1, true )
atped2 = createPed ( 286, -778.0844, 494.90765, 1368.530 )
	setElementInterior ( atped2, 1 )
	setElementFrozen ( atped2, true )
	setElementRotation ( atped2, 0, 0, 90 )

function cancelPedDamage ( attacker )
	cancelEvent()
end
addEventHandler ( "onClientPedDamage", atped, cancelPedDamage )
addEventHandler ( "onClientPedDamage", atped1, cancelPedDamage )
addEventHandler ( "onClientPedDamage", atped2, cancelPedDamage )
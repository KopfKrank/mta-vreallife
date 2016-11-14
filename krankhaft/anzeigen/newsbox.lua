addEvent ( "deActivateCustomRadar", true )

function news1 ()
	outputChatBox ( "#383838═══════ #ff0000Deluxe-Reallife #383838═══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "•► Bei Fragen und Problemen benutzt /report", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Um einer Fraktion beizutreten, melde dich im Teamspeak³.", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Teamspeak: 1.ts-3.net:10139", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Forum: Coming Soon!", getRootElement(), 0, 139, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news2, 300000, 1 )
end
function news2 ()
	outputChatBox ( "#383838═══════ #ff0000Deluxe-Reallife #383838═══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "•► Bei Fragen und Problemen benutzt /report, für alle Admins online /admins.", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Nutze /save, um deine Position und deine Waffen zu sichern.", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Service Nummern: Polizei - 110 | Sanitäter - 112 | Mechaniker - 300", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Shader kannst du per /shader aktivieren.", getRootElement(), 0, 139, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news3, 300000, 1 )
end
function news3 ()
	outputChatBox ( "#383838═══════ ##ff0000Deluxe-Reallife #383838═══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "•► Mit /admins seht ihr, welcher Admin momentan online ist.", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Beim gelben Punkt kannst du dir Scheine kaufen und dich über Jobs informieren.", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Teamspeak: 1.ts-3.net:10139", getRootElement(), 0, 139, 0 )
	outputChatBox ( "•► Forum: Coming Soon!", getRootElement(), 0, 139, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news1, 300000, 1 )
end
setTimer ( news1, 300000, 1 )

function infobox ( player, text, time, r, g, b )

	if isElement ( player ) then
		triggerClientEvent ( player, "infobox_start", getRootElement(), text, time, r, g, b )
	end
end

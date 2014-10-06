	--------------------------------
	------ Variables � �diter ------
	--------------------------------
	local consigne = uservariables["Consigne"]  --Temp�rature de consigne
	local consigne_min = uservariables["Consigne_eco"]  --Temp�rature minimum
	local hysteresis = 0.5 --Valeur seuil pour �viter que le relai ne cesse de commuter dans les 2 sens
	local sonde = 'Temp Chambre2' --Nom de la sonde de temp�rature
	local thermostat = 'Calendrier Chauffage' --Nom de l'interrupteur virtuel du thermostat
	local radiateur = 'Chauffage' --Nom du radiateur � allumer/�teindre
	--------------------------------
	-- Fin des variables � �diter --
	--------------------------------
	
	commandArray = {}
	--La sonde Oregon 'thermostat' emet toutes les 40 secondes. Ce sera approximativement la fr�quence 
	-- d'ex�cution de ce script.
	if (devicechanged[sonde]) then
		local temperature = devicechanged[string.format('%s_Temperature', sonde)] --Temperature relev�e
	    --On n'agit que si le "Thermostat" est actif
	    if (otherdevices[thermostat]=='On') then
	        --print('-- Gestion du thermostat --')
	
	    	if (temperature < (consigne - hysteresis) and otherdevices[radiateur]=='Off' ) then
	            print('Allumage du chauffage')
	            commandArray[radiateur]='On'
	
		    elseif (temperature > (consigne + hysteresis)) then
		        print('Extinction du chauffage')
	            commandArray[radiateur]='Off'
	
		    end
		elseif (otherdevices[thermostat]=='Off') then
			if (temperature < (consigne_min - hysteresis)) then
				commandArray[radiateur]='On'
			elseif (temperature > (consigne_min + hysteresis)) then
	            commandArray[radiateur]='Off'
		    end
	    end
	end
return commandArray
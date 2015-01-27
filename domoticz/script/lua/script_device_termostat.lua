	--------------------------------
	------ Variables � cr�er  ------
	--------------------------------
	if(uservariables["tht_cons_confort"] == '' )then commandArray['Variable:tht_cons_confort'] = '20'end
	if(uservariables["tht_cons_eco"] == '' )then commandArray['Variable:tht_cons_eco'] = '17.5'end
	if(uservariables["tht_cons_hors_gel"] == '' )then commandArray['Variable:tht_cons_hors_gel'] = '15'end
	if(uservariables["tht_temperature"] == '' )then commandArray['Variable:tht_temperature'] = '20'end
	-- modes : [{'id':'off'},{'id':'auto'},{'id':'force'}]
	-- tht_cons_confort : 20
	-- tht_cons_eco : 17
	-- tht_cons_hors_gel : 15
	--------------------------------
	------ Variables � �diter ------
	--------------------------------
	
	local consigne = uservariables["tht_cons_confort"]  --Temp�rature de consigne
	local consigne_min = uservariables["tht_cons_eco"]  --Temp�rature minimum
	local consigne_hors_gel = uservariables["tht_cons_hors_gel"]
	local hysteresis = 0.5 --Valeur seuil pour �viter que le relai ne cesse de commuter dans les 2 sens
	local sonde = 'TEMP_PALIER' --Nom de la sonde de temp�rature
	local thermostat = 'Calendrier Chauffage' --Nom de l'interrupteur virtuel du thermostat
	local ouverture = 'Ouverture' --Non de l'interrupteur qui indique si une ouverture est ouverte
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
	    if (otherdevices[thermostat]=='On' ) then
	        --print('-- Gestion du thermostat --')
			-- phase confort
	    	if (temperature < (consigne - hysteresis) and otherdevices[radiateur]=='Off' and otherdevices[ouverture]=='Off') then
	            print('Allumage du chauffage')
	            commandArray[radiateur]='On'
				commandArray['Variable:tht_temperature'] = tostring(consigne)
		    elseif (temperature > (consigne + hysteresis)) then
		        print('Extinction du chauffage')
	            commandArray[radiateur]='Off'
				commandArray['Variable:tht_temperature'] = tostring(consigne)
		    end
		elseif (otherdevices[thermostat]=='Off') then
			-- phase eco
			if (temperature < (consigne_min - hysteresis) and otherdevices[ouverture]=='Off') then
				commandArray[radiateur]='On'
				commandArray['Variable:tht_temperature'] = tostring(consigne_min)
			elseif (temperature > (consigne_min + hysteresis)) then
	            commandArray[radiateur]='Off'
				commandArray['Variable:tht_temperature'] = tostring(consigne_min)
		    end
	    end
	end
return commandArray
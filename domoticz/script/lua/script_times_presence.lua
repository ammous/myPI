commandArray = {}



-- 
if (otherdevices['Smartphone'] == 'On' && otherdevices['Mode Nuit'] == 'Off') then
       commandArray['Multiprise S�jour']='On'
elseif ((otherdevices['Smartphone'] == 'Off' && otherdevices['PC'] == 'Off' )|| otherdevices['Mode Nuit'] == 'On') 
	  commandArray['Multiprise S�jour']='Off'
end

-- Allumage automatique de la lampe quand la tv est allum�e et qu'il fait nuit
if (otherdevices['Nuit'] == 'On' && otherdevices['Tv'] == 'On') then
	commandArray['Lampe S�jour']='On'
elseif (otherdevices['Nuit'] = 'Off')
	commandArray['Lampe S�jour']='Off'
end

-- extinction de tout les appareils
if ( otherdevices['Mode Nuit'] == 'On') then
	print('Turning off all device')
	commandArray['G�n�rale']='Off'
end
return commandArray
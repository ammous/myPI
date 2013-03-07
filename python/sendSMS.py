#!/usr/bin/python 
# -*- encoding: utf-8 -*- 
import bluetooth 
#entrer le nom du peripherie bluetooth 
target_name =raw_input("entrer le nom de votre periph�rie:\n") 
target_address = None 
#recherche des p�riph�ries bluetooth disponibles 
nearby_devices = bluetooth.discover_devices() 
#recherche le nom de votre p�riph�rie dans la liste des adresses disponibles 
for bdaddr in nearby_devices: 
     if target_name == bluetooth.lookup_name( bdaddr ): 
	     target_address = bdaddr 
		 break 
     #si la p�riph�rie est trouv�e on se lance dans le processus de connexion au t�l�phone gr�ce au protocole RFCOMM 
     #on a besoin d'un canal de communication et de l'adresse du p�riph�rie 
     if target_address is not None: 
         bt_addr = target_address 
	     channel =  bluetooth.find_service(address=bt_addr, uuid=bluetooth.DIALUP_NET_CLASS)[0]['port'] 
         #channel = 1 
         #si la connexion est �tablie on entre le num�ro du destinataire et le message a envoye(max 140 caracteres) 
         dest =raw_input("Entrer le num�ro du destinataire:\n") 
         text =raw_input("Entrer votre message:\n") 
         #connection au p�riph�rie via RFCOMM 
         sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM) 
         sock.connect((bt_addr, channel)) 
         # passe le modem en mode texte pour l'envoi de sms 
         sock.send("AT+CMGF=1\r") 
         sock.send("AT+CMGS=\"%s\"\r" % dest) 
         # chr(032) -> ctrl + Z, s�parateur de fin de sms 
         sock.send("%s%s" % (text,chr(032))) 
         #fermer la connexion 
         sock.close() 
         print "message bien envoyer" 
     else: 
         print 'aucun p�riph�rie trouver'
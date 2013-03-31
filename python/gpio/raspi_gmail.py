# On importe ce qui est n�cessaire
import RPi.GPIO as GPIO, feedparser
import time
�
# On renseigne nos identifiants
USERNAME="votre_mail@gmail.com"
PASSWORD="votre_mot_de_passe"
�
# On d�fini quel PIN est utilis� pour brancher la LED
GPIO_PIN=11
�
# On le d�fini en sortie
GPIO.setmode(GPIO.BOARD)
GPIO.setup(GPIO_PIN, GPIO.OUT)
�
# On inspecte le flux RSS
newmails = int(feedparser.parse("https://" + USERNAME + ":" + PASSWORD + "@mail.google.com/gmail/feed/atom")["feed"]["fullcount"])
�
# Si le nombre de mail est sup�rieur � 0 alors on fait clignoter la LED
if newmails > 0: 
����for i in range(1,58) :
���GPIO.output(GPIO_PIN, True)
���time.sleep(1)
���GPIO.output(GPIO_PIN, False)
���i = i+1
�
# Si il est inf�rieur � 0 on ne fait rien
else: 
����GPIO.output(GPIO_PIN, False)
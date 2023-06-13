#!/bin/bash

clear
echo " ----------- MENU ------------- "
echo "================================"
echo "1. Reiniciar la interfaz de red."
echo "2. Apagar equipo."
echo "3. Reiniciar equipo."
echo "4. Mostrar puertos abiertos."
echo "5. Salir."
echo "================================"
echo "Elige una opción:"
read opcion
case $opcion in
1)
sudo systemctl restart networkd-dispatcher.service
;;
2)
shutdown -h now
;;
3)
reboot
;;
4)
if test -f /usr/bin/nmap 
	then 
		nmap localhost
	else
		echo "Por favor instala nmap con la orden: sudo apt install nmap"
fi
;;
5)
exit
;;
*)
echo "Opción no válida"
sleep .5
sh sistema.sh
;;
esac

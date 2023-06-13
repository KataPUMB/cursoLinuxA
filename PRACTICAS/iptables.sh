#!/bin/bash

RED='\033[0;41m'
GREEN='\033[0;42m'
WHITE='\033[0;0m' 
COLORGREEN='\033[0;32m'
COLORRED='\033[0;31m'

echo "________________________________________________________________________________________"
echo "${RED}REINICIANDO FIREWAL DEL SISTEMA${WHITE}"

#REINICIAMOS EL FIREWALL
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
#reglas
sudo iptables -F
#cadenas
sudo iptables -X
#a cero
sudo iptables -Z

echo "${GREEN}FIREWALL REINICIADO CORRECTAMENTE${WHITE}"
echo "________________________________________________________________________________________"

##########################################################
echo "________________________________________________________________________________________"
echo "${RED}ESTABLECIENDO NORMAS DEL FIREWALL${WHITE}"

#REGLAS INPUT
#Esta primera linea es para no recibir errores al cambiar la política base
sudo iptables -A INPUT -i lo -j ACCEPT
#Política base deniega acceso
sudo iptables -P INPUT DROP

#Vamos a aceptar el puerto 80 de entrada, el dchp y el https en el cliente para que se pueda navegar en la máquina
#Como server
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#Como cliente
sudo iptables -A INPUT -p udp --sport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 21:22 -j ACCEPT

#Vamos a cerrar aunque no sea necesario porque la política niega la entrada pero para que no se pueda atacar mientras se ejecuta este script el ssh y el ftp
#Como servidor
sudo iptables -A INPUT -p tcp --dport 21:22 -j DROP

###########################################################

#REGLAS OUTPUT
#Cerramos todas las salidas a un puerto superior al 1024
sudo iptables -A OUTPUT -p tcp --dport :1024 -j DROP
sudo iptables -A OUTPUT -p udp --dport :1024 -j DROP

###########################################################

echo "¿Quieres activar las reglas de forwarding en el núcleo? [S/n]"
read answ
if [ $answ = "s" ] || [ $answ = "S" ] 
then
	#REGLAS FORWARD
	#Activamos el ip_forwarding en el núcleo
	sudo echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
	if [ $(echo $?) -eq 0 ]
        	then
               		echo "${GREEN}[ OK ]${COLORGREEN} IP Forwarding activado correctamente$WHITE"
        	else
        	        echo "${RED}[ ERROR ]${COLORRED} IP Forwarding no está activado por favor revisa tu configuración en /proc/sys/net/ipv4/ip_forward$WHITE"
	fi

	#Activamos el forwarding y el postrouting para que el servidor de VM funcione correctamente
	sudo iptables -P FORWARD ACCEPT
	sudo iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
else
	echo "Ignorando reglas de FORWARDING"
fi
###########################################################

#END
echo "________________________________________________________________________________________"
echo "${GREEN}FIREWAL DEL SISTEMA ACTIVADO CORRECTAMENTE${WHITE}"
echo "________________________________________________________________________________________"

#Así muestra al final de la ejecucción el resultado del script
sudo iptables -L
echo "________________________________________________________________________________________"

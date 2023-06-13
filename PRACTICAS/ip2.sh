#!/bin/bash
#Vamos a crear un firewall como cliente, permitiremos conexiones realizadas desde la máquina pero bloquearemos todos los intentos de entrada

RED='\033[0;41m'
GREEN='\033[0;42m'
WHITE='\033[0;0m' 
COLORGREEN='\033[0;32m'
COLORRED='\033[0;31m'

#Preparamos el núcleo:
sudo modprobe nf_conntrack
if [ $(echo $?) -eq 0 ]
	then
		echo "${GREEN}[ OK ]${COLORGREEN} Modprobe cargado en el nucleo de sistema correctamente$WHITE"
		echo "________________________________________________________________________________________"
	else
		echo "${RED}[ ERROR ]${COLORRED} Modprobe no se encuentra en el núcleo ni puede estar cargado$WHITE"
		echo "_____________________________________________________________________________________________"
fi
#reiniciamos el firewall
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F
sudo iptables -X
sudo iptables -Z

#APAÑO NUESTRO PARA QUE FUNCIONE AQUI
sudo iptables -A INPUT -i lo -j ACCEPT

#CONFIG DEL FIREWALL
sudo iptables -P INPUT DROP
#dejamos entrar a nuestro apache pero solo a los de esta sala
sudo iptables -A INPUT -p tcp --dport 80 -s 172.16.0.0/16 -j ACCEPT

sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
echo 
#ESCUPE EL RESULTADO
echo "${RED}RESULTADO DEL FIREWALL:$WHITE"
echo "$RED----------------------------------------$WHITE"
sudo iptables -L
echo "$RED----------------------------------------$WHITE"

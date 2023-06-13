#!/bin/bash

echo "Escribe N1"
read ene1
echo "Escribe N2"
read ene2

echo "N1= $ene1"
echo "N2= $ene2"

if [ $ene1 -ne $ene2 ];
	then 
		echo No son iguales;
	else 
		echo Son iguales;
fi

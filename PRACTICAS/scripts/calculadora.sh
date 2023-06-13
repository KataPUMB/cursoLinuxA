#!/bin/bash

clear
echo "########################"
echo "# HOLA! SOY GNUCAL v2  #"
echo "########################"
echo ""
echo "Introduce el primer valor:"
read valor1
echo "Introduce el operador, puedes elegir entre suma +, resta -, multiplicación * y división /."
read operador
echo "Introduce segundo valor:"
read valor2
resultado=`expr $valor1 "$operador" $valor2`
echo "Resultado=${resultado}"

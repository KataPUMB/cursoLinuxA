#!/bin/bash

clear
echo "soy GNU/Cal"
echo "Tu me dices lo que quieres calcular y yo te doy el resultado"
echo "Introduce el primer valor"
read valor1
echo " Introduce el operador. Puedes escoger entre: + - * /"
read operador
echo " Introduce el segundo valor"
read valor2
echo "El resultado es:"
sleep .5
expr $valor1 $operador $valor2
sleep .5
echo "gracias por su tiempo!"

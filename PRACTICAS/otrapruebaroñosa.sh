#! /bin/sh
echo "Introduce la ruta 1:"
read caterg
echo "introduce la ruta 2;"
read caterg2
if [ "$caterg" == "$caterg2" ];
	then echo "son la misma ruta";
	else echo "nope no son la misma ruta";
fi

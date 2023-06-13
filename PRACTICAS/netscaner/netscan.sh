#!\bin\bash
DataPath=$(dirname "$0")"/ipscan.data"
echo "Por favor introduce el puerto (o los puertos separados por ,) que quieres escanear:"
read selPort
echo "Generando lista de ips con puerto ${selPort} abierto..."
#generamos un archivo ipscan.data con un listado de las ip que tienen el puerto 22 abierto
nmap -p $selPort -oG - 172.16.35.0-255 | awk '/open/{ s = $2; for (i = 5; i <= NF-4; i++) s = substr($i,1,length($i)-4) "\n"; split(s, a, "/"); print $2}' > $DataPath
echo "---LISTO---"
if [ ! -s "${DataPath}" ]; then
	echo "No se ha encontrado ningún resultado"
else
	echo "Lista de IP encontradas:"
	cat $DataPath
	echo "Puedes encontrar el fichero en la ubicación: ${DataPath}"
fi

#! /bin/sh
for ciudad in Manila Bangkog Yakarta Kuala
do
	if [[ $ciudad == 'Yakarta' ]]; then
		break
	fi
echo "Encontrada $ciudad"
done

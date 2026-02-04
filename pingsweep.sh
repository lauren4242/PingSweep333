#!/bin/bash
# Ping sweep the Lab

ping_sweep(){
	base="onyxnode"
	spin='|/-\\'
	for q in {1..200}
	do
		host="onyxnode$q"
		i=$((q % 4))
		printf "\r%c %d out of 200" "${spin:$i:1}" "$q"
		if ping -c 1 -W 1 "$host" >> ping.log 2>&1; then
			echo -e "\r$host true"
		else
			echo -e "\r$host false"
		fi
	done
}
# have a help menu
help(){
	echo "Usage: pingsweep.sh [-p] [-h]"
	echo "Options:"
	echo "  -p    Run ping sweep"
	echo "  -h    Show this help menu"
	exit 1
}

# add a flag -p to run it
while getopts "ph" opt; do
	case $opt in
		p)
			ping_sweep
			;;
		h)
			help
			;;
		*)
			help
			;;
	esac
done


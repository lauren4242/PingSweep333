#!/bin/bash
# Ping sweep the Lab

ping_sweep(){
	local base="onyxnode"
	local scanned=0
	local active=0
	local unresponsive=0
	spin='|/-\\'
	for q in {1..200}
	do
		host="onyxnode$q"
		i=$((q % 4))
		printf "\r%c %d out of 200" "${spin:$i:1}" "$q"
		scanned=$((scanned+1))
		if ping -c 1 -W 1 "$host" >> ping.log 2>&1; then
			active=$((active+1))
		else
			unresponsive=$((unresponsive+1))
		fi
	done
	echo "\nScanned $scanned nodes"
	echo "Found $active active machines"
	echo "No response $unresponsive machines"
	return
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


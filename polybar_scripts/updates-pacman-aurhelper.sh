#!/usr/bin/bash

run() {
	sleep 1
	if ! updates="$(dnf check-update 2>/dev/null | wc -l)"; then
		updates=0
	fi

	if [ "$updates" -gt 0 ]; then
		printf "%s" "$updates"
	else
		printf "%s" "0"
	fi
}

update_system() {
	sudo dnf upgrade
	# After update
	printf "\n"
	printf "==========================================\n"
	printf "|           Update Completed!            |\n"
	printf "==========================================\n"
	read -n 1 -s -r -p "Press any key to close"
	# Polybar module will update in minim 1 hour
}

click() {
	# print updates
	dnf check-update
	# Ask for confirmation
	read -rp "Update the system? (y/N)" answer
	do_update=${answer:-N}

	case $do_update in
	[Yy])
		update_system
		;;
	[Nn])
		exit 0
		;;
	*)
		echo "Incorrect option"
		exit 1
		;;
	esac
}

case "$1" in
--run)
	run
	;;
--click)
	click
	;;
*)
	exit 1
	;;
esac

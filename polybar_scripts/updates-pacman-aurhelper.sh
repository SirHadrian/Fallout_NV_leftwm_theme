#!/usr/bin/bash

run() {
	sleep 1
	if ! updates_arch="$(checkupdates 2>/dev/null | wc -l)"; then
		updates_arch=0
	fi

	#if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
	if ! updates_aur="$(paru -Qum 2>/dev/null | wc -l)"; then
		updates_aur=0
	fi

	((updates = updates_arch + updates_aur))

	if [ "$updates" -gt 0 ]; then
		printf "%s" "$updates"
	else
		printf "%s" "0"
	fi
}

update_system() {
	# Use aur helper
	paru -Syu
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
	checkupdates
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

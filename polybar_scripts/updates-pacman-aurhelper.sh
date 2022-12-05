#!/usr/bin/bash

run() {
	sleep 5
	if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
		updates_arch=0
	fi

	#if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
	if ! updates_aur=$(paru -Qum 2>/dev/null | wc -l); then
		# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
		# if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
		# if ! updates_aur=$(pikaur -Qua 2> /dev/null | wc -l); then
		# if ! updates_aur=$(rua upgrade --printonly 2> /dev/null | wc -l); then
		updates_aur=0
	fi

	updates=$((updates_arch + updates_aur))

	if [ "$updates" -gt 0 ]; then
		echo "$updates"
	else
		echo "0"
	fi
}

update_system() {
	# Use aur helper
	paru -Syu
	# After update
	echo "=========================================="
	echo "|           Update Completed!            |"
	echo "=========================================="
	read -n 1 -s -r -p "Press any key to close"
	# Polybar module will update in min 20 minutes
}

click() {
	# Ask for confirmation
	read -rp "Update the system? (Y/n)" answer
	do_update=${answer:-Y}

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

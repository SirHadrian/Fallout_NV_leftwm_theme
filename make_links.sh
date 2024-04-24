#!/usr/bin/bash

create_links() {
	# Get current directory
	SCRIPTPATH="$(cd "$(dirname "$0")" || exit && pwd -P)"

	# Alacritty link
	ln -s "$SCRIPTPATH"/configs/alacritty ~/.config/alacritty

	# Fish link
	mkdir -p ~/.config/fish
	ln -s "$SCRIPTPATH"/configs/fish/config.fish ~/.config/fish/config.fish

	# Redshift link
	ln -s "$SCRIPTPATH"/configs/redshift ~/.config/redshift

	# Make leftwm directory structure if not exist
	mkdir ~/.config/leftwm/themes

	# Link scripts folder
	ln -s "$SCRIPTPATH"/scripts ~/.config/leftwm/scripts

	# Link leftwm config
	ln -s "$SCRIPTPATH"/config.ron ~/.config/leftwm/config.ron

	# Link current theme folder
	ln -s "$SCRIPTPATH" ~/.config/leftwm/themes/current
}

printf "%s" "$HOME/.config/alacritty"
printf "%s" "$HOME/.config/fish/config.fish"
printf "%s" "$HOME/.config/redshift"
printf "%s" "$HOME/.config/leftwm/themes/current"
printf "%s" "$HOME/.config/leftwm/scripts"
printf "%s" "$HOME/.config/leftwm/config.ron"

read -rp "Create the soft links? (y/N)" answer
make_links=${answer:-N}

case $make_links in
[Yy])
	create_links
	;;
[Nn])
	exit 0
	;;
*)
	echo "Incorrect option"
	exit 1
	;;
esac

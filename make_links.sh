#!/usr/bin/bash

# Get current directory
SCRIPTPATH="$(cd "$(dirname "$0")" || exit && pwd -P)"

# Alacritty link
ln -s "$SCRIPTPATH"/configs/alacritty ~/.config/alacritty

# Fish link
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

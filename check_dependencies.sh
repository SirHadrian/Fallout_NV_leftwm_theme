#!/usr/bin/env bash

SCRIPTDIR="$(cd "$(dirname "$0")" || exit && pwd -P)"

# Get colors
source "$SCRIPTDIR"/colors.sh

# Check for hard dependencies
declare -a dependencies=(
	"polybar"
	"rofi"
	"leftwm"
	"checkupdates"
	"greenclip"
	"dunst"
	"picom"
	"unclutter"
	"optimus-manager"
	"optimus-manager-qt"
	"amixer"
	"light"
	"alacritty"
	"xlock"
	"bluetoothctl"
	"paru"
	"nmcli"
	"feh"
	"wal"
	"cmus"
	"scrot"
	"ffmpeg"
	"redshift"
	"rg"
	"exa"
	"procs"
	"dust"
	"tree"
	"bat"
	"pamixer"
	"pavucontrol"
	"qpwgraph"
	"fd"
	"sddm"
	"qt5ct"
	"lxappearance"
)

printf "\n${BWhite}%s" "================================"
printf "\n%s" "|      Check Dependencies      |"
printf "\n%s${Color_Off}" "================================"
printf "\n\n"

for item in "${dependencies[@]}"; do
	printf "${BWhite}%-20s      " "${item}"
	if [[ -x "$(command -v "$item")" ]]; then
		printf "${BGreen}%s${Color_Off}\n" "Ok.."
	else
		printf "${BRed}%s${Color_Off}\n" "Missing.."
	fi
done

printf "\n%s\n" "Tip: use pacman -F <command> to find the package the command is from"

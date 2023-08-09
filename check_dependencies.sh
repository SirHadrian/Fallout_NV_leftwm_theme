#!/usr/bin/env bash

SCRIPTDIR="$(cd "$(dirname "$0")" || exit && pwd -P)"

# Get colors
source "$SCRIPTDIR"/colors.sh

# Dependencies

# Without those packages the theme may not work at all
declare -a hard_dependencies=(
	"leftwm"
	"polybar"
	"rofi"
	"picom"
	"greenclip"
	"dunst"
	"nmcli"
	"pulsemixer"
	"alacritty"
)

# Without those packages the theme may work but with some broken functionality
declare -a solft_dependencies=(
	"feh"
	"wal"
	"bluetoothctl"
	"xlock"
	"light"
	"amixer"
	"unclutter"
	"scrot"
	"optimus-manager-qt"
)

# Can be safely ignored
declare -a optional_dependencies=(
	"cmus"
	"ffmpeg"
	"redshift"
	"rg"
	"exa"
	"procs"
	"dust"
	"tree"
	"bat"
	"pavucontrol"
	"qpwgraph"
	"fd"
	"sddm"
	"qt5ct"
	"lxappearance"
	"gthumb"
	"nvidia-prime"
	"ncdu"
	"ranger"
	"figlet"
	"zoxide"
	"mprocs"
	"simple-http-server"
	"gitui"
	"mc"
	"entr"
	"fzf"
	"gwenview"
	"ncdu"
	"btm"
)

printf "\n${BWhite}%s" "=================================="
printf "\n%s" "= Check Hard Dependencies        ="
printf "\n%s${Color_Off}" "=================================="
printf "\n\n"

for item in "${hard_dependencies[@]}"; do
	printf "${BWhite}%-20s      " "${item}"
	if [[ -x "$(command -v "$item")" ]]; then
		printf "${BGreen}%s${Color_Off}\n" "Ok.."
	else
		printf "${BRed}%s${Color_Off}\n" "Missing.."
	fi
done

printf "\n${BWhite}%s" "=================================="
printf "\n%s" "= Check Soft Dependencies        ="
printf "\n%s${Color_Off}" "=================================="
printf "\n\n"

for item in "${solft_dependencies[@]}"; do
	printf "${BWhite}%-20s      " "${item}"
	if [[ -x "$(command -v "$item")" ]]; then
		printf "${BGreen}%s${Color_Off}\n" "Ok.."
	else
		printf "${BRed}%s${Color_Off}\n" "Missing.."
	fi
done

printf "\n${BWhite}%s" "=================================="
printf "\n%s" "= Check Optional Dependencies    ="
printf "\n%s${Color_Off}" "=================================="
printf "\n\n"

for item in "${optional_dependencies[@]}"; do
	printf "${BWhite}%-20s      " "${item}"
	if [[ -x "$(command -v "$item")" ]]; then
		printf "${BGreen}%s${Color_Off}\n" "Ok.."
	else
		printf "${BRed}%s${Color_Off}\n" "Missing.."
	fi
done

printf "\n%s\n" "Tip: use dnf provides <command> to find the package the command is from"

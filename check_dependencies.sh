#!/usr/bin/env bash

SCRIPTDIR="$(cd "$(dirname "$0")" || exit && pwd -P)"

# Get colors
source "$SCRIPTDIR"/colors.sh

# Dependencies

# Without those base packages the theme may not work at all
declare -a hard_dependencies=(
"leftwm"
"polybar"
"rofi"
"picom"
"greenclip"
"dunst"
"nmcli"
"pulsemixer"
"pamixer"
"alacritty"
)

# Without those packages the theme may work but with some broken functionality
declare -a solft_dependencies=(
"feh" # wallpaper changer
"wal" # colorschemes
"bluetoothctl"
"xlock" # screen lock screen
"light" # change backlight
# "amixer"
"unclutter" # Hide mouse
"scrot"
"optimus-manager-qt" # nvidia helper
)

# Can be safely ignored
declare -a optional_dependencies=(
"cmus" # music
"ffmpeg"
"redshift" # Nightlight
"rg"
"exa"
"procs"
"dust"
"tree"
"bat"
"pavucontrol"
"qpwgraph" # Pipewire gui controll
"fd"
"sddm"
"qt5ct"
"lxappearance"
"gthumb"
"nvidia-prime"
"ncdu"
"ranger" # filemanager
"figlet"
"zoxide" # based
"mprocs"
"simple-http-server"
"gitui" # git tui helper
"lazygit" # git tui helper
"mc"    # filemanager
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

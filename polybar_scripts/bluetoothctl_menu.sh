#!/usr/bin/env bash

# Config
#==========================================================
SCRIPTPATH="$(cd "$(dirname "$0")" || exit && pwd -P)"
# Config for rofi-bluetooth-menu
# position values:
# 1 2 3
# 8 0 4
# 7 6 5
POSITION=2
#x-offset
X_OFFSET=-170
#y-offset
Y_OFFSET=53
#font
FONT="JetBrainsMono Nerd Font 12"
#==========================================================

# Constants
# ==============================
EXIT="Exit"
BACK="Back"
CONNECT="Connect"
DISCONNECT="Disconnect"
# ==============================

bluetooth_check() {

        if [[ "$(systemctl is-active "bluetooth.service")" =~ "inactive" ]]; then
                printf "%s" "  Service Down "
                exit 0
        fi

        if bluetoothctl show | rg -q "Powered: no"; then
                printf " %s " ""
                exit 0
        fi

        CONNECTED="$(bluetoothctl devices Connected | awk '{print $3}')"
        if [[ -z "$CONNECTED" ]]; then
                printf " %s " ""
        else
                printf " %s %s " "" "$CONNECTED"
        fi
}

is_powered() {
        if bluetoothctl show | rg -q "Powered: yes"; then
                return 0
        else
                return 1
        fi
}

bluetooth_power() {
        if is_powered; then
                bluetoothctl disconnect "$(bluetoothctl devices Connected | awk '{print $2}')"
                sleep 2
                bluetoothctl power off
        else
                if rfkill list bluetooth | rg -q 'blocked: yes'; then
                        rfkill unblock bluetooth
                        sleep 2
                fi
                bluetoothctl power on
        fi
}

device_submenu() {

        DEVICE="$1"

        DEVICE_NAME="$(printf "%s" "$DEVICE" | awk '{print $1}')"
        DEVICE_ID="$(printf "%s" "$DEVICE" | awk '{print $2}')"

        STATUS="$(bluetoothctl info "$DEVICE_ID")"

        if printf "%s" "$STATUS" | rg -q "Connected: yes"; then
                DEVICE_NAME="${DEVICE_NAME} (Connected)"
        fi

        ACTION="$(printf "%s\n%s\n\n%s\n%s" "$CONNECT" "$DISCONNECT" "$BACK" "$EXIT" | rofi -dmenu -i -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "$DEVICE_NAME" -matching regex -config "$SCRIPTPATH/../configs/bluetoothctl_config.rasi" -location "$POSITION" -yoffset "$Y_OFFSET" -xoffset "$X_OFFSET" -font "$FONT")"

        [[ -z "$ACTION" ]] && exit 1

        if [[ "$ACTION" == "$CONNECT" ]]; then
                bluetoothctl connect "$DEVICE_ID"
        elif [[ "$ACTION" == "$DISCONNECT" ]]; then
                bluetoothctl disconnect "$DEVICE_ID"
        elif [[ "$ACTION" == "$BACK" ]]; then
                bluetooth_click
        elif [[ "$ACTION" == "$EXIT" ]]; then
                exit 0
        fi

}

bluetooth_click() {

        DEVICES_LIST="$(bluetoothctl devices Paired | awk '{print $3,$2}')"

        if bluetoothctl show | rg -q "Powered: yes"; then
                POWER="Power OFF"
                OPTIONS="$DEVICES_LIST\n\n$POWER\n$EXIT"
        else
                POWER="Power ON"
                OPTIONS="$POWER\n$EXIT"
        fi

        SELECTED="$(printf "%b" "$OPTIONS" | rofi -dmenu -i -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "Devices" -matching regex -config "$SCRIPTPATH/../configs/bluetoothctl_config.rasi" -location "$POSITION" -yoffset "$Y_OFFSET" -xoffset "$X_OFFSET" -font "$FONT")"

        # Exit if no device is selected
        [[ -z "$SELECTED" ]] && exit 1

        if [[ "$SELECTED" == "$POWER" ]]; then
                bluetooth_power
                exit 0
        elif [[ "$SELECTED" == "$EXIT" ]]; then
                exit 0
        else
                device_submenu "$SELECTED"
        fi

}

case "$1" in
        --click)
                bluetooth_click
                ;;
        *)
                bluetooth_check
                ;;
esac

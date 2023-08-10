#!/usr/bin/env bash

# Config
#==========================================================
SCRIPTPATH="$(cd "$(dirname "$0")" || exit && pwd -P)"
# Config for rofi-wifi-menu
# position values:
# 1 2 3
# 8 0 4
# 7 6 5
POSITION=3
#x-offset
X_OFFSET=-240
#y-offset
Y_OFFSET=55
#fields to be displayed
FIELDS=SSID,SECURITY,BARS
#font
FONT="JetBrainsMono Nerd Font 10"
#==========================================================

WIFI_STATUS="$(nmcli radio wifi)"

[[ "$WIFI_STATUS" == "enabled" ]] && TOGGLE="Turn wifi off" && LIST="$(nmcli --fields "$FIELDS" device wifi)"
[[ "$WIFI_STATUS" == "disabled" ]] && TOGGLE="Turn wifi on"

RESULT="$(printf "%s\n%s" "$TOGGLE" "$LIST" | rofi -dmenu -i -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "Wi-Fi SSID" -matching regex -config "$SCRIPTPATH/../configs/wifi_config.rasi" -location "$POSITION" -yoffset "$Y_OFFSET" -xoffset "$X_OFFSET" -font "$FONT")"

if [[ "$RESULT" == "Turn wifi off" ]]; then
	nmcli radio wifi off
	exit 0
elif [[ "$RESULT" == "Turn wifi on" ]]; then
	nmcli radio wifi on
	exit 0
fi

CON_SSID="$(printf "%s" "$RESULT" | awk '{print $1}')"
[[ -z "$CON_SSID" ]] && exit 0

if ! nmcli connection up "$CON_SSID"; then
	# Delete existing connection.
	nmcli connection delete "$CON_SSID"

	PASSWD="$(rofi -dmenu -i -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "Passwd" -matching regex -config "$SCRIPTPATH/../configs/wifi_config.rasi" -location "$POSITION" -yoffset "$Y_OFFSET" -xoffset "$X_OFFSET" -font "$FONT")" &&
		nmcli device wifi connection "$CON_SSID" password "$PASSWD"
fi

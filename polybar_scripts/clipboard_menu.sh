#!/usr/bin/bash

SCRIPTPATH=$(cd "$(dirname "$0")" || exit && pwd -P)

# position values:
# 1 2 3
# 8 0 4
# 7 6 5
POSITION=3
#y-offset
YOFF=53
#x-offset
XOFF=-115
#font
FONT="JetBrainsMono Nerd Font 14"

rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -hover-select -me-select-entry '' -me-accept-entry MousePrimary -config "$SCRIPTPATH"/../configs/clipboard_config.rasi -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -font "$FONT"

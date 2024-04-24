#!/usr/bin/bash

# Kill polybar
kill -9 "$(pgrep -u $UID -x 'polybar')" &>/dev/null

# Wait for polybar to die
while pgrep -u $UID -x 'polybar' &>/dev/null; do sleep 1; done

# Start polybar
index=0
monitors="$(polybar -m | sed s/:.*//)"
leftwm-state -q -n -t "$SCRIPTPATH"/sizes.liquid | sed -r '/^\s*$/d' | while read -r width x _y
do
        ((indextemp = index + 1))
        monitor=$(sed "$indextemp!d" <<<"$monitors")
        barname="mainbar$index"
        monitor=$monitor offset=$x width=$width polybar -c "$SCRIPTPATH"/polybar.config $barname &>/dev/null &
        ((index = indextemp))
done

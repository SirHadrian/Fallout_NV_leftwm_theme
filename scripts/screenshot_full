#!/bin/bash

timestamp="$(date +%d.%m.%Y"_"%H:%M:%S )"
targetbase="$HOME/Pictures/screenshots"
mkdir -p "$targetbase"
[ -d "$targetbase" ] || exit 1
scrot --silent "$targetbase/$timestamp.png"

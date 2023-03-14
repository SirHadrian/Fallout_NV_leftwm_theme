#!/usr/bin/bash

prepend_zero() {
	seq -f "%02g" "$1" "$1"
}

artist=$(printf "%s" "$(cmus-remote -C status | grep "tag artist" | cut -c 12-)")

if [[ -z "$artist" ]]; then
	printf "%s" "$(cmus-remote -C status | grep file | cut -c 6-)"
	exit
fi

if [[ $artist = *[!\ ]* ]]; then
	song=$(printf "%s" "$(cmus-remote -C status | grep title | cut -c 11-)")
	# position=$(cmus-remote -C status | grep position | cut -c 10-)
	# minutes1=$(prepend_zero $((position / 60)))
	# seconds1=$(prepend_zero $((position % 60)))
	# duration=$(cmus-remote -C status | grep duration | cut -c 10-)
	# minutes2=$(prepend_zero $((duration / 60)))
	# seconds2=$(prepend_zero $((duration % 60)))
	# echo -n "$artist - $song [$minutes1:$seconds1/$minutes2:$seconds2]"
	printf "%s" "$artist - $song"
else
	echo
fi

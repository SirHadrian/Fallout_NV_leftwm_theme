#!/usr/bin/env bash

# Notifications
ARTIST="$(cmus-remote -C status | grep "tag artist" | cut -c 12-)"
SONG="$(cmus-remote -C status | grep title | cut -c 11-)"
CURRENTLY_PLAYING="$(cmus-remote -C status | grep "file" | cut -c 6-)"
FILENAME="$(basename "${CURRENTLY_PLAYING}")"
COVERSDIR="$HOME/Music/covers"

[[ -d ${COVERSDIR} ]] || mkdir -p "${COVERSDIR}"

if ! [[ -e "${COVERSDIR}/${FILENAME}.jpeg" ]]; then
	ffmpeg -i "${CURRENTLY_PLAYING}" -an -filter scale=128:-1 "${COVERSDIR}/${FILENAME%.mp3}.jpeg" &>/dev/null || exit
fi

sleep 1
dunstify --raw_icon="${COVERSDIR}/${FILENAME%.mp3}.jpeg" "${ARTIST}" "${SONG}"

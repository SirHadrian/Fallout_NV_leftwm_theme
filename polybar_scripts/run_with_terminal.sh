#!/usr/bin/bash

SCRIPTPATH="$(cd "$(dirname "$0")" || exit && pwd -P)"

alacritty -e "$SCRIPTPATH"/updates.sh --click

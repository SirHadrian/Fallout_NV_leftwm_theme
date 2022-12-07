#!/usr/bin/env bash

SCRIPTPATH="$(cd "$(dirname "$0")" || exit && pwd -P)"

alacritty -e "$SCRIPTPATH"/updates-pacman-aurhelper.sh --click

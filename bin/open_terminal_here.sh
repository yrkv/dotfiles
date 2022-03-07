#!/bin/sh

pid="$(xdotool getwindowfocus getwindowpid)"
ppid="$(ps -o pid= --ppid "$pid" | xargs)"
alacritty --working-directory "$(readlink "/proc/$ppid/cwd")"


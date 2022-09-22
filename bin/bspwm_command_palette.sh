#!/usr/bin/env bash

# Opens searchable bspwm command palette to perform various actions.


function commands() {
    echo "toggle gap             ## toggle-gap"
    echo "float focused          ## bspc node --state floating"
    echo "tile focused           ## bspc node --state tiled"
    echo "swap desktops          ## swap-desktops | submenu"
    echo "select window geometry ## select-size | submenu"
    echo "bluetooth              ## bluetooth-menu | submenu"
    echo "reset desktop names    ## bspc monitor eDP-1 -d I II III IV V VI VII VIII IX X"
    echo "reload sxhkdrc         ## pkill -USR1 -x sxhkd"
    echo "restart bspwm          ## bspc wm --restart"
    echo "quit bspwm             ## bspc quit"

    #echo "search files           ## search-util | file-actions | submenu"
    #echo "search files           ## search-util | file-actions | submenu"
    echo "search files           ## search-util"
    echo "toggle redshift        ## pkill -USR1 redshift"
    echo "restart polybar        ## pkill polybar; polybar -r top"
    echo "restart xbanish        ## pkill xbanish; xbanish"
    echo "map caps->escape       ## setxkbmap -option caps:escape"

    # Autoclicker
    # Remove receptacles
    #for i in $(bspc query -N -n .leaf.!window.local); do bspc node $i -k; done
}

function submenu() {
    #COMMAND="$(cat - | rofi -dmenu | awk -F ' *## *' '{print $2}')"
    COMMAND="$(rofi -dmenu | awk -F ' *## *' '{print $2}')"
    eval "$COMMAND"
}

function toggle-gap() {
    test -f /tmp/bspwm-prev-gap || bspc config window_gap > /tmp/bspwm-prev-gap
    if [[ "$(bspc config window_gap)" -eq "0" ]]; then
        bspc config window_gap "$(cat /tmp/bspwm-prev-gap)"
    else
        bspc config window_gap > /tmp/bspwm-prev-gap
        bspc config window_gap 0
    fi
}

function swap-desktops() {
    seq 10 | xargs -I "{}" echo "## bspc desktop focused --swap ^{}; reset-desktop-names"

    # node swap version:
    #seq 10 | xargs -I "{}" echo "## bspc node @/ -s @^{}:/ --follow || bspc node @/ -d ^{} --follow"
}
function reset-desktop-names() {
    bspc monitor eDP-1 -d I II III IV V VI VII VIII IX X
}

function select-size() {
    echo "fit to 16:9 ## fit_aspect.sh"
    echo "fit to 1:1  ## fit_aspect.sh 1 1"
    echo "25% ## xdotool getwindowfocus windowsize 25% 25%"
    echo "33% ## xdotool getwindowfocus windowsize 33% 33%"
    #echo "shrink to 16:9 ##"
    #echo "expand to 16:9 ##"
    #echo "shrink to 1:1 ##"
    #echo "expand to 1:1 ##"
}

function bluetooth-menu() {
    echo " ## bluetoothctl connect 0C:8D:CA:5E:70:C9"
    echo " ## bluetoothctl disconnect"
    echo " ## galaxy-bat 0C:8D:CA:5E:70:C9"
    echo " ## bluetoothctl power on"
    echo " ## bluetoothctl power off"
}

function galaxy-bat() {
    notify-send "$(galaxybuds-batterylevel $1)"
}

function search-util() {
    SELECTED_FILE="$(fd -L -H -d 4 --type d . | rofi -dmenu -i -p '~/' -matching fuzzy)"
    file-actions "$SELECTED_FILE" | submenu
}
function file-actions() {
    echo "copy to clipboard ## echo -n "$1" | xclip -sel c -in"
    echo "open terminal     ## alacritty --working-directory $1"
}

commands | submenu

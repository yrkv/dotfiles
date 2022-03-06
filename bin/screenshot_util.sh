#!/bin/sh

# Click to screenshot target window or select geometry to capture.
# Writes screenshot to a file in /tmp and copies it to clipboard.
# capture full screen instead when MOD_SHIFT is set to true.

# After the screenshot, creates a dunst notification with a set
# of useful defined actions.

FILE="/tmp/screenshot$(date +"%s").png"

echo $MOD_SHIFT
if [[ $MOD_SHIFT = true ]]; then
    SCREENSHOT_COMMAND="shotgun -"
else
    # Select window/rectangle
    eval $(hacksaw -s9999 -g3 -f"WINDOW=%i; X=%x; Y=%y; W=%w; H=%h")

    # adjust selection geometry to exclude window border
    ROOTID="$(( $(awk '/Window id:/{print $4}' <(xwininfo -root)) ))"
    if [ $WINDOW -eq $ROOTID ]; then bw=0; else bw=$(bspc config border_width); fi
    GEOMETRY="$(($W-2*$bw))"x"$(($H-2*$bw))"+"$(($X+$bw))"+"$(($Y+$bw))"

    SCREENSHOT_COMMAND="shotgun -g $GEOMETRY -"
fi

# capture screenshot, save to file, copy to clipboard
$SCREENSHOT_COMMAND | tee $FILE | xclip -t 'image/png' -selection clipboard

ACTION=$(dunstify \
    -I $FILE \
    -A "default,View screenshot" \
    -A "save,Save to ~/Pictures" \
    -A "xclip,Copy path to clipboard" \
    -A "why,Why" \
    "Captured Screenshot")

case "$ACTION" in
    "default")
        feh --class "screenshot_util feh" $FILE
        ;;
    "save")
        cp $FILE ~/Pictures
        ;;
    "xclip")
        echo -n $FILE | xclip -selection clipboard
        ;;
    "why")
        feh --class "screenshot_util feh" $FILE &
        sleep 5;
        bounce.sh
        ;;
esac


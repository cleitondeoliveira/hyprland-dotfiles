#!/bin/bash

# Power menu usando wofi

options="󰗼 Logout\n󰜉 Restart\n󰐥 Shutdown"

selected=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 300 --height 200)

case $selected in
    "󰗼 Logout")
        hyprctl dispatch exit
        ;;
    "󰜉 Restart")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
esac

#!/bin/bash

# Power menu usando wofi

options="󰌾 Lock\n󰗼 Logout\n󰜉 Restart\n󰐥 Shutdown"

selected=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 300 --height 250)

case $selected in
    "󰌾 Lock")
        hyprlock
        ;;
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

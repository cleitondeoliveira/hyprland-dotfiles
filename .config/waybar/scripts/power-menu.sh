#!/bin/bash

# Power menu usando wofi

set -e

# Check if wofi is installed
if ! command -v wofi &> /dev/null; then
    notify-send "Error" "wofi is not installed" -u critical
    exit 1
fi

options="󰌾 Lock\n󰗼 Logout\n󰜉 Restart\n󰐥 Shutdown"

selected=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 300 --height 250)

case $selected in
    "󰌾 Lock")
        if command -v hyprlock &> /dev/null; then
            hyprlock
        else
            notify-send "Error" "hyprlock is not installed" -u critical
        fi
        ;;
    "󰗼 Logout")
        if command -v hyprctl &> /dev/null; then
            hyprctl dispatch exit
        else
            notify-send "Error" "hyprctl is not installed" -u critical
        fi
        ;;
    "󰜉 Restart")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
esac

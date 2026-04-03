#!/usr/bin/env bash

options="Lock\nLogout\nSuspend\nReboot\nShutdown"

chosen=$(echo -e "$options" | rofi -dmenu -p "Power" -theme ~/.config/rofi/theme.rasi)

case "$chosen" in
    Lock)     hyprlock ;;
    Logout)   hyprctl dispatch exit ;;
    Suspend)  systemctl suspend ;;
    Reboot)   systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac

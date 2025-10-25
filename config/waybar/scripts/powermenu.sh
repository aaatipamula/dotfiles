#!/usr/bin/env bash

# Prompt menu options
options="Suspend\nShutdown\nExit Hyprland"

# Use wofi to present the menu
choice=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu")

case "$choice" in
  "Suspend")
    systemctl suspend
    ;;
  "Shutdown")
    systemctl poweroff
    ;;
  "Exit Hyprland")
    hyprctl dispatch exit
    ;;
  *)
    exit 0
    ;;
esac


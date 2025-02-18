#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.local/share/backgrounds/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

NEW_WALL=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

hyprctl hyprpaper reload eDP-1,"$NEW_WALL"

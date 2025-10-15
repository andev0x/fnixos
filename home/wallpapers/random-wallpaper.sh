#!/usr/bin/env bash
# Pick a random image from the wallpapers directory and set it with swww or swaybg fallback
WALLPAPERS_DIR="$HOME/.config/wallpapers"
if [ ! -d "$WALLPAPERS_DIR" ]; then
  # fallback to repository path
  WALLPAPERS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers"
fi

pic=$(find "$WALLPAPERS_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \) | shuf -n1)

if [ -z "$pic" ]; then
  echo "no wallpaper found in $WALLPAPERS_DIR" >&2
  exit 1
fi

# try swww, then hyprpaper, then swaybg
if command -v swww >/dev/null 2>&1; then
  swww img "$pic" --transition-fps 60 --transition-type fade
elif command -v hyprpaper >/dev/null 2>&1; then
  hyprpaper wallpaper "$pic"
elif command -v swaybg >/dev/null 2>&1; then
  pkill swaybg || true
  swaybg -i "$pic" -m fill &
else
  echo "no wallpaper setter found (swww/hyprpaper/swaybg)" >&2
  exit 1
fi

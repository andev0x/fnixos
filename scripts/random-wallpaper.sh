#!/usr/bin/env bash
# Random Wallpaper Selector for Hyprland
# Selects a random image from the wallpapers directory and sets it using swww

WALLPAPER_DIR="$HOME/.config/wallpapers"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory not found at $WALLPAPER_DIR"
    exit 1
fi

# Find all image files (jpg, jpeg, png)
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)))

# Check if any wallpapers were found
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "Error: No wallpaper images found in $WALLPAPER_DIR"
    exit 1
fi

# Select a random wallpaper
RANDOM_WALLPAPER="${WALLPAPERS[$RANDOM % ${#WALLPAPERS[@]}]}"

echo "Setting wallpaper: $RANDOM_WALLPAPER"

# Set the wallpaper using swww
swww img "$RANDOM_WALLPAPER" --transition-type wipe --transition-fps 60 --transition-duration 2

exit 0

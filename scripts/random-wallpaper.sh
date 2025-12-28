#!/usr/bin/env bash

# Random wallpaper switcher for Hyprland
# Selects a random image from the wallpapers directory and sets it using swww

WALLPAPER_DIR="$HOME/.config/wallpapers"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory $WALLPAPER_DIR does not exist"
    exit 1
fi

# Find all image files in the wallpapers directory
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))

# Check if any wallpapers were found
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "Error: No image files found in $WALLPAPER_DIR"
    exit 1
fi

# Select a random wallpaper
RANDOM_WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

# Set the wallpaper using swww with smooth transition
swww img "$RANDOM_WALLPAPER" --transition-type fade --transition-duration 2

echo "Set wallpaper to: $RANDOM_WALLPAPER"

#!/usr/bin/env bash

# Random wallpaper switcher for Hyprland
# Selects a random image from the wallpapers directory and sets it using swww

# Determine the wallpapers directory - try multiple possible locations
if [ -d "$HOME/Documents/fnixos/home/wallpapers" ]; then
    WALLPAPER_DIR="$HOME/Documents/fnixos/home/wallpapers"
elif [ -d "/etc/nixos/home/wallpapers" ]; then
    WALLPAPER_DIR="/etc/nixos/home/wallpapers"
elif [ -d "$HOME/.config/wallpapers" ]; then
    WALLPAPER_DIR="$HOME/.config/wallpapers"
else
    echo "Error: Wallpaper directory not found"
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

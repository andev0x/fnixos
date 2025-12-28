# Wallpapers Directory

This directory contains wallpapers for your NixOS system.

## Usage

Place your wallpaper images in this directory and update the Hyprland configuration to use them:

```bash
# Copy your wallpaper to this directory
cp ~/Downloads/my-wallpaper.jpg ~/.config/home/wallpapers/

# Update hyprland.conf to use your wallpaper
# Change the line:
# exec-once = swww img ~/Pictures/wallpapers/nord-landscape.jpg
# To:
# exec-once = swww img ~/Pictures/wallpapers/my-wallpaper.jpg
```

## Default Wallpaper

The system is configured to use a Nord-themed wallpaper by default. You can download Nord wallpapers from:
- [Nord Theme Wallpapers](https://github.com/arcticicestudio/nord/releases)

## Supported Formats

- JPG/JPEG
- PNG
- WebP

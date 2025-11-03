#!/usr/bin/env bash

set -euo pipefail

WAYBAR_DIR="$HOME/.config/waybar"
WOFI_DIR="$HOME/.config/wofi"

current_hash=$(sha1sum "$WAYBAR_DIR/style.css" 2>/dev/null | awk '{print $1}')
dark_hash=$(sha1sum "$WAYBAR_DIR/style-dark.css" 2>/dev/null | awk '{print $1}')

if [ "$current_hash" = "$dark_hash" ]; then
  # Switch to light
  cp "$WAYBAR_DIR/style-light.css" "$WAYBAR_DIR/style.css"
  cp "$WOFI_DIR/style-light.css" "$WOFI_DIR/style.css"
else
  # Switch to dark
  cp "$WAYBAR_DIR/style-dark.css" "$WAYBAR_DIR/style.css"
  cp "$WOFI_DIR/style-dark.css" "$WOFI_DIR/style.css"
fi

# Reload waybar styles
pkill -USR2 waybar || true

exit 0



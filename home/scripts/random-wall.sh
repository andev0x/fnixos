#!/usr/bin/env bash

set -euo pipefail

# Wallpaper directory
WALL_DIR="$HOME/.config/wallpapers"
STATE_DIR="$HOME/.cache"
LIST_FILE="$STATE_DIR/wallpaper_list.txt"
INDEX_FILE="$STATE_DIR/wallpaper_index.txt"
LOG_FILE="$STATE_DIR/random-wall.log"

# Ensure directories exist
mkdir -p "$STATE_DIR"

# Logging function
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"
}

log "=== Wallpaper Script Started ==="
log "Action: ${1:-default}"

# Check if wallpaper directory exists
if [ ! -d "$WALL_DIR" ]; then
  log "ERROR: Wallpaper directory not found: $WALL_DIR"
  notify-send "Wallpaper Error" "Directory $WALL_DIR not found" -u critical
  exit 1
fi

# Build wallpaper list
log "Building wallpaper list from $WALL_DIR"
find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null | sort > "$LIST_FILE" || true

# Read wallpapers into array
mapfile -t WALLS < "$LIST_FILE" || true

log "Found ${#WALLS[@]} wallpapers"

if [ ${#WALLS[@]} -eq 0 ]; then
  log "ERROR: No wallpapers found in $WALL_DIR"
  notify-send "Wallpaper Error" "No wallpapers found in $WALL_DIR" -u critical
  exit 1
fi

# Initialize or read current index
if [ ! -f "$INDEX_FILE" ]; then
  echo 0 > "$INDEX_FILE"
fi

read -r IDX < "$INDEX_FILE" || IDX=0

# Determine action
ACTION="${1:-default}"

case "$ACTION" in
  next)
    IDX=$(( (IDX + 1) % ${#WALLS[@]} ))
    log "Action: Next wallpaper (index: $IDX)"
    ;;
  prev)
    IDX=$(( (IDX - 1 + ${#WALLS[@]}) % ${#WALLS[@]} ))
    log "Action: Previous wallpaper (index: $IDX)"
    ;;
  random)
    IDX=$(( RANDOM % ${#WALLS[@]} ))
    log "Action: Random wallpaper (index: $IDX)"
    ;;
  default)
    # Find shisui.png or use first wallpaper
    DEFAULT_IDX=0
    for i in "${!WALLS[@]}"; do
      if [[ "${WALLS[$i]}" == *"/shisui.png"* ]]; then
        DEFAULT_IDX=$i
        break
      fi
    done
    IDX=$DEFAULT_IDX
    log "Action: Default wallpaper (index: $IDX)"
    ;;
  *)
    # Try to find wallpaper by name
    FOUND=0
    for i in "${!WALLS[@]}"; do
      if [[ "${WALLS[$i]}" == *"/$1"* ]]; then
        IDX=$i
        FOUND=1
        break
      fi
    done
    if [ $FOUND -eq 0 ]; then
      log "WARNING: Wallpaper '$1' not found, using current"
    else
      log "Action: Set wallpaper to '$1' (index: $IDX)"
    fi
    ;;
esac

# Save current index
echo "$IDX" > "$INDEX_FILE"

# Get selected wallpaper
IMG="${WALLS[$IDX]}"
log "Selected wallpaper: $IMG"

# Ensure swww is running
if ! pgrep -x swww-daemon >/dev/null 2>&1; then
  log "swww-daemon not running, initializing..."
  /run/current-system/sw/bin/swww init &
  sleep 2
fi

# Apply wallpaper
log "Applying wallpaper..."
if /run/current-system/sw/bin/swww img "$IMG" \
  --transition-type fade \
  --transition-duration 2 \
  --transition-fps 60 \
  --resize crop 2>&1 | tee -a "$LOG_FILE"; then
  log "SUCCESS: Wallpaper applied"
  notify-send "Wallpaper Changed" "$(basename "$IMG")" -t 2000 -i "$IMG"
else
  log "ERROR: Failed to apply wallpaper"
  notify-send "Wallpaper Error" "Failed to apply wallpaper" -u critical
  exit 1
fi

log "=== Wallpaper Script Finished ==="
exit 0

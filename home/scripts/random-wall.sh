#!/usr/bin/env bash

set -euo pipefail

# Add a small delay to ensure the wallpaper directory is mounted
sleep 1

WALL_DIR="$HOME/.local/share/wallpapers"
STATE_DIR="$HOME/.cache"
LIST_FILE="$STATE_DIR/wallpaper_list.txt"
INDEX_FILE="$STATE_DIR/wallpaper_index.txt"

mkdir -p "$STATE_DIR"

# Build list if missing or empty
if [ ! -s "$LIST_FILE" ]; then
  find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort > "$LIST_FILE" || true
fi

mapfile -t WALLS < "$LIST_FILE" || true

if [ ${#WALLS[@]} -eq 0 ]; then
  echo "No wallpapers found in $WALL_DIR" >&2
  exit 1
fi

# Initialize index
if [ ! -f "$INDEX_FILE" ]; then
  echo 0 > "$INDEX_FILE"
fi

read -r IDX < "$INDEX_FILE" || IDX=0

ACTION="${1:-default}"
case "$ACTION" in
  next)
    IDX=$(( (IDX + 1) % ${#WALLS[@]} ))
    ;;
  prev)
    IDX=$(( (IDX - 1 + ${#WALLS[@]}) % ${#WALLS[@]} ))
    ;;
  random)
    IDX=$(( RANDOM % ${#WALLS[@]} ))
    ;;
  default)
    # Find the index of shisui.png
    for i in "${!WALLS[@]}"; do
      if [[ "${WALLS[$i]}" == *"/shisui.png"* ]]; then
        IDX=$i
        break
      fi
    done
    ;;
  *)
    # Allow setting a specific wallpaper by name
    for i in "${!WALLS[@]}"; do
      if [[ "${WALLS[$i]}" == *"/$1"* ]]; then
        IDX=$i
        break
      fi
    done
    ;;
esac

echo "$IDX" > "$INDEX_FILE"

IMG="${WALLS[$IDX]}"

# Ensure swww is running
if ! pgrep -x swww >/dev/null 2>&1; then
  swww init || true
fi

# Apply image with smooth transition
swww img "$IMG" \
  --transition-type any \
  --transition-duration 1 \
  --transition-fps 60 \
  --resize crop

exit 0



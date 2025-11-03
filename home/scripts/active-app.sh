#!/usr/bin/env bash

set -euo pipefail

get_active() {
  hyprctl -j activewindow 2>/dev/null | jq -r '{class:.class,title:.title}'
}

map_icon() {
  local cls="$1"
  case "$cls" in
    "firefox"|"librewolf"|"floorp") echo "";;
    "Google-chrome"|"Chromium"|"chromium"|"Brave-browser"|"brave-browser") echo "";;
    "code"|"Code"|"VSCodium") echo "ﳳ";;
    "Alacritty"|"kitty"|"WezTerm") echo "";;
    "org.qutebrowser.qutebrowser"|"qutebrowser") echo "";;
    "steam") echo "";;
    "thunar"|"Thunar"|"nautilus"|"Nautilus") echo "";;
    "mpv") echo "";;
    "spotify") echo "";;
    "jetbrains-.*") echo "";;
    *) echo "";;
  esac
}

json=$(get_active || echo '{}')
cls=$(jq -r '.class // ""' <<<"$json")
title=$(jq -r '.title // ""' <<<"$json")

icon="$(map_icon "$cls")"

text="$icon ${title:-}"

jq -n --arg text "$text" --arg alt "$cls" --arg tooltip "$title" '{text:$text, alt:$alt, tooltip:$tooltip}'



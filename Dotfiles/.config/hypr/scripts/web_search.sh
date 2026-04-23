#!/usr/bin/env bash

# 1. Search engine configuration
SEARCH_ENGINE="https://www.google.com/search?q="
# Others:
# SEARCH_ENGINE="https://duckduckgo.com/?q="
# SEARCH_ENGINE="https://www.youtube.com/results?search_query="

# 2. Path to the JaKooLit Rofi theme
ROFI_THEME="$HOME/.config/rofi/config-search.rasi"

# Message shown at the bottom of Rofi
msg='Search via default web browser'

# Dependency check (JaKooLit style)
if ! command -v jq >/dev/null 2>&1; then
    notify-send -u low "Rofi Search" "jq is required for URL encoding. Please install jq."
    exit 1
fi

# Kill Rofi if already running
pkill rofi

# 3. Open Rofi and capture the query
# We rely on the .rasi file for styling (no hardcoded sizes here)
query=$(printf '' | rofi -dmenu \
    -config "$ROFI_THEME" \
    -mesg "$msg" \
    -p " Search")

# Exit if the user cancels (ESC or empty)
[[ -z "$query" ]] && exit 0

# 4. URL Encoding (The "Pro" touch)
encoded_query=$(printf '%s' "$query" | jq -sRr @uri)

# 5. Launch the browser
xdg-open "${SEARCH_ENGINE}${encoded_query}" >/dev/null 2>&1 &
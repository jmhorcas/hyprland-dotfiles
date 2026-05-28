#!/usr/bin/env bash

# =====================================================================
# ROFI WEB SEARCH LAUNCHER (Minimalist Edition)
# =====================================================================
# Opens a streamlined Rofi dmenu instance to capture user text input,
# encodes the query safely, and launches it via the default web browser.

# 1. Search engine configuration
SEARCH_ENGINE="https://www.google.com/search?q="
# Alternative profiles:
# SEARCH_ENGINE="https://duckduckgo.com/?q="
# SEARCH_ENGINE="https://www.youtube.com/results?search_query="

# 2. Path to the Rofi theme
ROFI_THEME="$HOME/.config/rofi/config_websearch.rasi"

# Dependency check (Ensures jq is available for URL encoding)
if ! command -v jq >/dev/null 2>&1; then
    notify-send -u critical -a "Rofi Search" "Dependency Missing" "jq is required for URL encoding. Please install it."
    exit 1
fi

# Multi-instance guard: Gracefully close Rofi if it is already open
if pkill -x rofi; then
    exit 0
fi

# 3. Open Rofi and capture the query
# (Removed -mesg and -p flags to perfectly match the single-line .rasi theme)
query=$(rofi -dmenu -config "$ROFI_THEME")

# Exit cleanly if the user cancels (ESC) or submits an empty input
[[ -z "${query// /}" ]] && exit 0

# 4. URL Encoding (Strips trailing newlines that might break some search engines)
encoded_query=$(printf '%s' "$query" | jq -sRr @uri | tr -d '\n')

# 5. Launch the browser as a detached background process
xdg-open "${SEARCH_ENGINE}${encoded_query}" >/dev/null 2>&1 &
disown
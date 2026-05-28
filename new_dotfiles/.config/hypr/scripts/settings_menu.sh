#!/usr/bin/env bash

# =====================================================================
# HYPRLAND CONTROL CENTER MENU
# =====================================================================
# A centralized dashboard powered by Rofi to quick-launch system utilities,
# settings managers, and environment scripts.

# 1. Path to the main Rofi theme
THEME="$HOME/.config/rofi/config.rasi"

# Toggle behavior: Close Rofi if it is already running
if pkill -x rofi; then
    exit 0
fi

# 2. Define menu options using a clean Bash array (Easy to edit/reorder)
options=(
    "󰌌 View Keybinds"
    "󰸉 Change Wallpaper"
    "󰍹 Monitor Settings"
    "󰕾 Audio Settings"
    "󰤥 Network Settings"
    " Bluetooth Settings"
    " Java Settings"
    "󰐥 Power Menu"
)

# Convert the array into a newline-separated list for Rofi
options_string=$(printf "%s\n" "${options[@]}")

# 3. Launch Rofi and capture user selection
chosen=$(echo -e "$options_string" | rofi -dmenu -i -p "󰒓 Control Center" -config "$THEME")

# Exit cleanly if the user cancels out (ESC)
[[ -z "$chosen" ]] && exit 0

# 4. Handle actions based on selection (Executed as detached background processes)
case "$chosen" in
    *Keybinds*)
        ~/.config/hypr/scripts/help.sh & disown
        ;;
    *Wallpaper*)
        ~/.config/hypr/scripts/wallpaper_select.sh & disown
        ;;
    *Monitor*)
        if command -v nwg-displays >/dev/null 2>&1; then
            nwg-displays & disown
        else
            rofi -config "$HOME/.config/rofi/config-Monitors.rasi" & disown
        fi
        ;;
    *Audio*)
        pavucontrol & disown
        ;;
    *Network*)
        nm-connection-editor & disown
        ;;
    *Bluetooth*)
        blueman-manager & disown
        ;;
    *Java*)
        ~/.config/hypr/scripts/JavaManager.sh & disown
        ;;
    *Power*)
        wlogout & disown
        ;;
esac
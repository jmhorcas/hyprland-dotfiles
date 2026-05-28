#!/bin/bash

# =====================================================================
# HYPRLAND KEBINDINGS HELP MENU (Lua Bitmask Version)
# =====================================================================
# This script fetches active keybindings natively via hyprctl, 
# decodes the numerical modmask bitwise using jq, formats the strings, 
# and sends them directly to Rofi.

# 1. Fetch keybindings from Hyprland in JSON format and parse them via jq
hyprctl binds -j | jq -r '.[] | 
    # Extract keys and replace native syntax with friendlier mouse tags
    (.key // "") as $k |
    (if $k == "mouse:272" then "L-Click" 
     elif $k == "mouse:273" then "R-Click" 
     elif $k == "mouse:274" then "Mid-Click" 
     else $k end) as $clean_key |
     
    # Decode numerical modmask bits into readable modifier strings
    (.modmask // 0) as $mask |
    ([] 
     | if ($mask / 64 % 2 >= 1) then . + ["SUPER"] else . end
     | if ($mask / 4 % 2 >= 1)  then . + ["CTRL"] else . end
     | if ($mask / 8 % 2 >= 1)  then . + ["ALT"] else . end
     | if ($mask / 1 % 2 >= 1)  then . + ["SHIFT"] else . end
    ) as $mod_list |
    
    # Construct full binding string with '+' separator
    ($mod_list | join(" + ")) as $mods |
    (if $mods != "" then $mods + " + " + $clean_key else $clean_key end) as $full_bind |
    
    # Extract description, fallback to dispatcher action if empty
    (.description // .dispatcher) as $desc |
    
    # Output formatted string with a hidden separator for alignment processing
    "\($full_bind)👉\($desc)"' | 

# 2. Use awk to cleanly align the Rofi columns
awk -F"👉" '{
    printf "%-28s │ %s\n", $1, $2
}' | 

# 3. Pipe the clean table straight to Rofi
rofi -dmenu -i -p "󰌌 Binds" -config ~/.config/rofi/config_keybinds.rasi
#!/bin/bash

# Tema para el menú principal
THEME="$HOME/.config/rofi/config.rasi"

# Definimos las opciones del panel
options="󰌌 View Keybinds\n󰸉 Change Wallpaper\n󰍹 Monitor Settings\n󰕾 Audio Settings\n󰤥 Network Settings\n Bluetooth Settings\n󰐥 Power Menu"

# Lanzamos Rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "󰒓 Control Center" -config "$THEME")

case "$chosen" in
    *Keybinds*)
        # Aquí pones el nombre de tu script de keybinds
        ~/.config/hypr/scripts/help.sh ;;
    *Wallpaper*)
        ~/.config/hypr/scripts/wallpaper_select.sh ;;
    *Monitor*)
        # Si instalaste nwg-displays o usas el de JaKooLit
        nwg-displays || rofi -config ~/.config/rofi/config-Monitors.rasi ;;
    *Audio*)
        pavucontrol ;;
    *Network*)
        nm-connection-editor ;;
    *Bluetooth*)
        blueman-manager ;;
    *Power*)
        # Un comando simple de apagado o tu script de logout
        wlogout || echo -e "Log out\nRestart\nShutdown" | rofi -dmenu -p "Power" ;;
esac
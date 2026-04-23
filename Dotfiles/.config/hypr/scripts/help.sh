#!/bin/bash

CONFIG_FILE="$HOME/.config/hypr/keybinds.conf"

# Buscamos cualquier línea que empiece por bind y termine en d seguido de ' = '
# Esto captura: bindd, bindmd, bindeld, bindld, binded, etc.
grep -E '^bind[a-z]*d =' "$CONFIG_FILE" | sed -e 's/^bind[a-z]*d = //g' | awk -F, '{
    # $1 = Modificadores (pueden ser varios: $mainMod SHIFT)
    # $2 = Tecla principal
    # $3 = Descripción
    
    # 1. Limpiamos espacios
    mods = $1; gsub(/^ */, "", mods); gsub(/ *$/, "", mods);
    key  = $2; gsub(/^ */, "", key);  gsub(/ *$/, "", key);
    desc = $3; gsub(/^ */, "", desc); gsub(/ *$/, "", desc);

    # 2. TRADUCCIÓN DE RATÓN Y TECLAS
    # Traducimos los códigos de ratón
    if (key == "mouse:272") { key = "L-Click" }
    else if (key == "mouse:273") { key = "R-Click" }
    else if (key == "mouse:274") { key = "Mid-Click" }

    # 2. Traducimos $mainMod a algo legible (SUPER)
    gsub(/\$mainMod/, "SUPER", mods);

    # 3. Formateamos la combinación de teclas
    # Si hay modificadores, ponemos un '+', si no, solo la tecla
    if (mods != "") {
        full_bind = mods " + " key
    } else {
        full_bind = key
    }

    # 4. Salida para Rofi (alineada)
    printf "%-25s │ %s\n", full_bind, desc
}' | rofi -dmenu -i -p "󰌌 Binds" -config ~/.config/rofi/config-keybinds.rasi
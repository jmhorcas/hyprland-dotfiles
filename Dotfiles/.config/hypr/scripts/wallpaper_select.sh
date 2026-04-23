#!/usr/bin/env bash

# 1. Rutas y Variables
wallDIR="$HOME/Pictures/Wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
rofi_theme="$HOME/.config/rofi/config-wallpaper.rasi"
HYPR_EFFECTS_DIR="$HOME/.config/hypr/wallpaper_effects"


# Required dependencies: bc, jq, imagemagick, ffmpeg, awww
if ! command -v bc &>/dev/null || ! command -v magick &>/dev/null; then
    notify-send "Error" "Missing packages: install bc and imagemagick"
    exit 1
fi

# 2. Cálculo dinámico del tamaño de iconos (Toque JaKooLit)
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
scale_factor=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .scale')
monitor_height=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .height')

icon_size=$(echo "scale=1; ($monitor_height * 3) / ($scale_factor * 150)" | bc)
# Ajustamos para que no sea ni muy pequeño ni muy grande
adjusted_icon_size=$(echo "$icon_size" | awk '{if ($1 < 15) $1 = 20; if ($1 > 25) $1 = 25; print $1}')
rofi_override="element-icon{size:${adjusted_icon_size}%;}"

# 3. Función para generar la lista con miniaturas
generate_menu() {
    # Buscamos imágenes y vídeos
    mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.mp4" -o -iname "*.webm" \) -print0)
    
    for pic_path in "${PICS[@]}"; do
        pic_name=$(basename "$pic_path")
        
        # Si es vídeo, generamos/usamos una miniatura en caché
        if [[ "$pic_name" =~ \.(mp4|webm)$ ]]; then
            cache_dir="$HOME/.cache/video_preview"
            [[ ! -d "$cache_dir" ]] && mkdir -p "$cache_dir"
            thumb="$cache_dir/${pic_name}.png"
            [[ ! -f "$thumb" ]] && ffmpeg -y -i "$pic_path" -ss 00:00:01 -vframes 1 "$thumb" >/dev/null 2>&1
            printf "%s\x00icon\x1f%s\n" "$pic_name" "$thumb"
        else
            # Si es imagen normal
            printf "%s\x00icon\x1f%s\n" "$pic_name" "$pic_path"
        fi
    done
}

# 4. Lanzar Rofi
choice=$(generate_menu | rofi -i -dmenu -config "$rofi_theme" -theme-str "$rofi_override" -p "󰸉 Wallpapers")

# 5. Aplicar selección
if [[ -n "$choice" ]]; then
    # Buscamos la ruta completa del archivo elegido
    selected_file=$(find "$wallDIR" -iname "$choice" -print -quit)
    
    if [[ -f "$selected_file" ]]; then
        # Si es vídeo (requiere mpvpaper)
        if [[ "$selected_file" =~ \.(mp4|webm)$ ]]; then
            pkill awww-daemon || pkill mpvpaper
            mpvpaper '*' -o "no-audio --loop" "$selected_file" &
        else
            # Si es imagen
            # Asegurar que awww-daemon corre
            pgrep -x awww-daemon >/dev/null || awww-daemon &
            awww img "$selected_file" --transition-type grow --transition-fps 60
            
	    # --- THE FIX FOR HYPRLOCK & SYMLINKS ---
            # Ensure the directory exists
            [[ ! -d "$HYPR_EFFECTS_DIR" ]] && mkdir -p "$HYPR_EFFECTS_DIR"
            
            # Delete old link and create a new one to the selected image
            # This is what hyprlock.conf looks for!
            ln -sf "$selected_file" "$HYPR_EFFECTS_DIR/.wallpaper_current"

            # EJECUTAR WALLUST (Lo más importante para tus colores)
            wallust run "$selected_file"
            
	    ~/.config/hypr/scripts/sddm_wallpaper.sh --normal &

            # Refrescar componentes (Waybar, Rofi, etc)
            # Si tienes el script de Refresh de JaKooLit:
            [[ -f "$SCRIPTSDIR/Refresh.sh" ]] && "$SCRIPTSDIR/Refresh.sh"
        fi
        
        notify-send "Wallpaper" "Applied: $choice"
    fi
fi
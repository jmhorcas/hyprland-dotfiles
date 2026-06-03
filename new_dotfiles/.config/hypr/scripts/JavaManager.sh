#!/bin/bash

# --- 1. Icons (Nerd Fonts) ---
ICON_JAVA=""
ICON_ACTIVE="󰄬"
ICON_INSTALLED=""
ICON_REMOTE=" "

# --- 2. Initial data ---
INSTALLED_PKGS=$(pacman -Qq | grep -E '^jdk.*-openjdk$')
TEMP_ALL=$(pacman -Ssq '^jdk.*-openjdk$' | sort -u)
TEMP_ALL_SYSTEM=$(archlinux-java status)

ACTIVE_VERSION_RAW=$(archlinux-java get)
ACTIVE_VERSION_NUM=$(echo "$ACTIVE_VERSION_RAW" | grep -oE '[0-9]+')

LATEST_PACKAGE=$(pacman -Si "jdk-openjdk" | grep "Description" | cut -d ':' -f2- | head -n 1)
LATEST_VERSION=$(echo "$LATEST_PACKAGE" | grep -oE '[0-9]+' | sort -nr | head -n1)

ALL_AVAILABLE=$(echo "$TEMP_ALL" | awk -v lv="$LATEST_VERSION" '{
    v=$0; gsub(/[^0-9]/,"",v); 
    if(v=="") v=lv+1; 
    print v " " $0
}' | sort -nr | cut -d' ' -f2-)


# --- 3. Functions ---
get_version_num() {
    local pkg="$1"
    local v=$(echo "$pkg" | grep -oE '[0-9]+')
    # If there is not a number, it is the "latest"
    if [ -z "$v" ]; then
        echo "$LATEST_VERSION"
    else
        echo "$v"
    fi
}

generate_list() {
    for pkg in $ALL_AVAILABLE; do
        DESC=$(pacman -Si "$pkg" | grep "Description" | cut -d ':' -f2- | head -n 1 | xargs)
        
        VERSION=$(get_version_num "$pkg")
        ICON="$ICON_REMOTE"
        # We use a temporary variable for the icon to avoid overwriting ICON_REMOTE
        DISPLAY_ICON="$ICON_REMOTE"

        # 1. Is it installed?
        if echo "$INSTALLED_PKGS" | grep -q "^$pkg$"; then
            DISPLAY_ICON="$ICON_INSTALLED"
        fi

        # 2. Is it the active one?
        # We compare if the number matches OR if the raw name matches
        if [[ "$VERSION" == "$ACTIVE_VERSION_NUM" ]] || [[ "$pkg" == "$ACTIVE_VERSION_RAW" ]]; then
            DISPLAY_ICON="$ICON_ACTIVE"
        fi

        # Ensure that if the icon is empty (remote) it maintains the space
        [ -z "$DISPLAY_ICON" ] && DISPLAY_ICON="  "

        printf "%s %s %s │ %s\n" "$ICON_JAVA" "$DISPLAY_ICON" "$DESC" "$pkg"
    done
}

# --- 4. rofi ---
THEME="$HOME/.config/rofi/config.rasi"

SELECTION=$(generate_list | rofi -dmenu -i \
    -p "󰒓 Java" \
    -config "$THEME" \
    -theme-str '
    window { width: 1000px; }
    inputbar { children: [ "prompt", "textbox-prompt-colon", "entry" ]; }
    prompt { background-color: @selected; text-color: @background; padding: 4px 8px; border-radius: 4px; }
    ' \
    -kb-custom-1 "Alt+i" \
    -kb-custom-2 "Alt+r" \
    -mesg "<b>$ICON_ACTIVE</b> Default | <b>$ICON_INSTALLED</b> Installed | <b>Enter:</b> Set default | <b>Alt+I:</b> Install | <b>Alt+R:</b> Remove")

EXIT_CODE=$?
[ -z "$SELECTION" ] && exit 0

# --- 5. Clean selection ---
# 1. Extract the package name from the right side of the │ separator
PKG_NAME=$(echo "$SELECTION" | awk -F'│' '{print $2}' | xargs | awk '{print $1}')

# 2. Get the real number contained in the name (if it exists)
SEL_RAW_NUM=$(echo "$PKG_NAME" | grep -oE '[0-9]+')

# If it doesn't have a value (it's the latest package), assign LATEST_VERSION
if [ -z "$SEL_RAW_NUM" ]; then
    SEL_RAW_NUM="$LATEST_VERSION"
fi


# --- 6. Actions ---
case $EXIT_CODE in
    0) # SET DEFAULT
        # We search for the environment that matches the number (e.g.: java-26-openjdk or java-17-openjdk)
        JAVA_ENV_NAME=$(archlinux-java status | grep "java-$SEL_RAW_NUM" | awk '{print $1}' | head -n 1)

        if [ -n "$JAVA_ENV_NAME" ]; then
            notify-send "Java" "Setting $JAVA_ENV_NAME as default..."
            pkexec archlinux-java set "$JAVA_ENV_NAME"
        else
            notify-send "Error" "Version $SEL_RAW_NUM is not installed. Install it first."
        fi
        ;;
    10) # INSTALL
        kitty -e sudo pacman -S "$PKG_NAME"
        ;;
    11) # REMOVE
        kitty -e sudo pacman -Rs "$PKG_NAME"
        ;;
esac
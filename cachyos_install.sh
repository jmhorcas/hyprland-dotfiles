#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"


# --------------------------------------------------------
# Update repositories and system
# --------------------------------------------------------
echo "⚙️ Updating system..."
pacman -Syu --noconfirm

# --------------------------------------------------------
# Install packages from the official repositories
# --------------------------------------------------------
PACKAGES=(
    "hyprland"          # Desktop
    "sddm"              # Display manager
    "xdg-user-dirs"     # User directories
    "kitty"             # Terminal
    "hyprpolkitagent"   # Authentication agent
    "swaync"            # Notification daemon
    "rofi-wayland"      # Application launcher
    "yazi"              # Wayland-compatible file manager
    "7zip"              # File archiver (for yazi)
    "zoxide"            # Command-line directory jumper (for yazi)
    "resvg"             # SVG rendering tool (for yazi)
    "imagemagick"       # Image manipulation tool (for yazi)
    "trash-cli"         # Trash management tool (for yazi)
    "libinih"           # INI file parser library (for yazi)
    "xdg-desktop-portal-hyprland"  # Portal for file dialogs and screenshots
    "waybar"            # Status bar
    "wl-clipboard"      # Clipboard manager
    "grim"              # Screenshot tool
    "slurp"             # Selection tool for screenshots
    "swappy"            # Screenshot annotation tool
    "cliphist"          # Clipboard history manager
    "awww"              # Image viewer
    "hypridle"          # Idle management
    "brightnessctl"     # Brightness control (only for laptops)
    "hyprlock"          # Screen locker
    "wlogout"           # Logout menu
    "ttf-jetbrains-mono-nerd"   # Nerd Font for better icon support in terminal and status bar
    "ttf-victor-mono-nerd"      # Nerd Font for better icon support in terminal and status bar
    "imv"               # Image viewer
    "code"              # Visual Studio Code (for development and configuration editing)

)

echo "⚙️ Installing packages..."
for package in "${PACKAGES[@]}"; do
    if ! pacman -Qs "$package" > /dev/null; then
        echo "📦 Installing $package..."
        pacman -S --noconfirm "$package"
    else
        echo "✅ $package is already installed."
    fi
done

# --------------------------------------------------------
# Install AUR packages using paru
# --------------------------------------------------------
PACKAGES=(
    "dragon-drop"          # File transfer tool (for yazi)
)

echo "⚙️ Installing packages..."
for package in "${PACKAGES[@]}"; do
    if ! paru -Qs "$package" > /dev/null; then
        echo "📦 Installing $package..."
        paru -S --noconfirm "$package"
    else
        echo "✅ $package is already installed."
    fi
done

# --------------------------------------------------------
# Configure system settings and user environment
# --------------------------------------------------------
# Set default editor to micro
set -Ux EDITOR micro

# Enable SDDM display manager (Login screen)
systemctl enable sddm.service

# Update XDG user directories (Create Desktop, Documents, Downloads, Music, Pictures, Public, Templates, Videos folders if they don't exist)
xdg-user-dirs-update


# --------------------------------------------------------
# Yazi configuration
# --------------------------------------------------------
# Install the Recycle Bin plugin for Yazi
ya pkg add uhs-robert/recycle-bin

# Install the Compress plugin for Yazi
ya pkg add KKV9/compress

# Ficheros de configuración a copiar
# ./config/fish/config.d/y.fish
# ./config/fish/config.fish
# ./config/yazi/yazi.toml
# ./config/yazi/keymap.toml
# ./config/yazi/init.lua
# ./config/xdg-desktop-portal/portals.conf
# ./local/share/applications/yazi.desktop



# --------------------------------------------------------
# Files and directories for Hyprland configuration
# Fish

# Hyprland
# ./config/hypr/hyprland.lua
# ./config/hypr/user_configs/*.lua
# ./config/hypr/scripts/
# ./config/hypr/scripts/help.sh
# ./config/hypr/scripts/web_search.sh
# ./config/hypr/scripts/settings_menu.sh


# ./config/hypr/scripts/wallpaper_select.sh  # todo
# ./config/hypr/wallpaper_effects # todo

# yazi


# rofi
# ./config/rofi/config_keybinds.rasi
# ./config/rofi/config_websearch.rasi
# ./config/rofi/config.rasi
# ./config/rofi/config_wallpaper.rasi










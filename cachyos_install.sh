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
    "wlogout"           # Logout menuº
    "ttf-jetbrains-mono-nerd"   # Nerd Font for better icon support in terminal and status bar
    "ttf-victor-mono-nerd"      # Nerd Font for better icon support in terminal and status bar
    "ttf-nerd-fonts-symbols-common"  # Common symbols for Nerd Fonts (for better icon support in terminal and status bar)
    "otf-font-awesome"   # Font Awesome for better icon support in terminal and status bar
    "imv"               # Image viewer
    "code"              # Visual Studio Code (for development and configuration editing)
    "blueman-manager"   # Bluetooth management tool
    "nm-connection-editor"  # NetworkManager connection editor (for managing Wi-Fi and other network connections)
    "network-manager-applet"  # NetworkManager applet for system tray (for managing Wi-Fi and other network connections)
    "nwg-displays"        # Display configuration tool (for managing multiple monitors and display settings) 
    "xorg-xwayland"     # XWayland for running X11 applications on Wayland (for compatibility with applications that don't have native Wayland support)

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
    "xdg-desktop-portal-termfilechooser-hunkyburrito-git"   # Portal for file dialogs in terminal applications (for yazi)
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

# Install the Clipboard plugin for Yazi
ya pkg add XYenon/clipboard

# Add the user to the input group
usermod -aG input $USER

# Ficheros de configuración a copiar
# ./config/fish/config.d/y.fish
# ./config/fish/config.fish
# ./config/yazi/yazi.toml
# ./config/yazi/keymap.toml
# ./config/yazi/init.lua
# ./config/xdg-desktop-portal/portals.conf
# ./config/xdg-desktop-portal-termfilechooser/config
# ./config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
# ./local/share/applications/yazi.desktop
# ./config/mimeapps.list


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

# waybar
# ./config/waybar/config.jsonc
# ./config/waybar/style.css








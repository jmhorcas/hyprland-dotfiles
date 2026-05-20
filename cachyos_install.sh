#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"


# --------------------------------------------------------
# Update repositories and system
# --------------------------------------------------------
echo "⚙️ Updating system..."
pacman -Syu --noconfirm

PACKAGES=(
    "hyprland"          # Desktop
    "kitty"             # Terminal
    "hyprpolkitagent"   # Authentication agent
    "swaync"            # Notification daemon
    "rofi-wayland"      # Application launcher
    "thunar"            # File manager
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
    "ttf-jetbrains-mono-nerd"   # Nerd Font for better icon support in terminal and status bar
    "ttf-victor-mono-nerd"      # Nerd Font for better icon support in terminal and status bar
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





#!/bin/bash

# Hyprland dotfiles installation script

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

echo "=================================="
echo "  Hyprland Dotfiles - Install     "
echo "=================================="
echo ""

# Function to create backup
backup_config() {
    local config_name=$1
    local config_path="$CONFIG_DIR/$config_name"

    if [ -e "$config_path" ]; then
        echo "📦 Backing up $config_name..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$config_path" "$BACKUP_DIR/"
        echo "   Backup saved at: $BACKUP_DIR/$config_name"
    fi
}

# Function to install configuration
install_config() {
    local config_name=$1
    local source_path="$DOTFILES_DIR/.config/$config_name"
    local target_path="$CONFIG_DIR/$config_name"

    if [ -d "$source_path" ]; then
        echo "📋 Installing $config_name..."
        mkdir -p "$CONFIG_DIR"
        cp -r "$source_path" "$CONFIG_DIR/"
        echo "   ✓ $config_name installed"
    fi
}

# List of configurations
configs=("hypr" "waybar" "kitty" "wofi" "dunst" "fontconfig" "xsettingsd")

# Backup existing configurations
echo "Checking existing configurations..."
for config in "${configs[@]}"; do
    backup_config "$config"
done

if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "✓ Backups created at: $BACKUP_DIR"
fi

echo ""
echo "Installing configurations..."

# Install new configurations
for config in "${configs[@]}"; do
    install_config "$config"
done

# Make scripts executable
if [ -d "$CONFIG_DIR/waybar/scripts" ]; then
    chmod +x "$CONFIG_DIR/waybar/scripts/"*.sh
    echo "🔧 Waybar scripts made executable"
fi

echo ""
echo "=================================="
echo "  ✓ Installation complete!        "
echo "=================================="
echo ""
echo "Next steps:"
echo "1. Restart Hyprland: press Super+Shift+E and login again"
echo "2. Or run: hyprctl reload"
echo ""
echo "Your backups are at: $BACKUP_DIR"
echo ""

#!/bin/bash

# SDDM Astronaut theme installation script

set -e

echo "=================================="
echo "  SDDM Astronaut Theme - Install  "
echo "=================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ This script needs to be run as root (sudo)"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if SDDM is installed
if ! command -v sddm &> /dev/null; then
    echo "❌ Error: SDDM is not installed"
    echo "Please install it first: sudo pacman -S sddm"
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    echo "Please install it first: sudo pacman -S git"
    exit 1
fi

# Install astronaut theme
if [ ! -d "/usr/share/sddm/themes/astronaut" ]; then
    echo "📦 Installing SDDM Astronaut theme..."
    mkdir -p /usr/share/sddm/themes/ || {
        echo "❌ Error: Failed to create themes directory"
        exit 1
    }
    cd /usr/share/sddm/themes/
    git clone https://github.com/Keyitdev/sddm-astronaut-theme.git astronaut || {
        echo "❌ Error: Failed to clone theme repository"
        exit 1
    }
    echo "   ✓ Theme installed"
else
    echo "✓ Astronaut theme already installed"
fi

# Copy custom configuration
echo "📋 Applying custom configuration..."
if [ -f "$SCRIPT_DIR/astronaut/Themes/astronaut.conf" ]; then
    cp "$SCRIPT_DIR/astronaut/Themes/astronaut.conf" /usr/share/sddm/themes/astronaut/Themes/ || {
        echo "❌ Error: Failed to copy theme configuration"
        exit 1
    }
    echo "   ✓ Theme configuration applied"
else
    echo "⚠️  Warning: Custom theme configuration not found, using default"
fi

# Copy custom wallpaper
echo "🖼️  Applying custom wallpaper..."
if [ -f "$SCRIPT_DIR/astronaut/Backgrounds/imagem2.png" ]; then
    cp "$SCRIPT_DIR/astronaut/Backgrounds/imagem2.png" /usr/share/sddm/themes/astronaut/Backgrounds/ || {
        echo "⚠️  Warning: Failed to copy wallpaper, using default"
    }
    echo "   ✓ Wallpaper applied"
else
    echo "⚠️  Warning: Custom wallpaper not found, using default"
fi

# Copy SDDM configuration
echo "⚙️  Configuring SDDM..."
mkdir -p /etc/sddm.conf.d || {
    echo "❌ Error: Failed to create SDDM config directory"
    exit 1
}
if [ -f "$SCRIPT_DIR/sddm.conf.d/theme.conf" ]; then
    cp "$SCRIPT_DIR/sddm.conf.d/theme.conf" /etc/sddm.conf.d/ || {
        echo "❌ Error: Failed to copy SDDM configuration"
        exit 1
    }
    echo "   ✓ SDDM configured"
else
    echo "❌ Error: SDDM configuration file not found"
    exit 1
fi

# Create theme.conf symlink
if [ ! -L "/usr/share/sddm/themes/astronaut/theme.conf" ]; then
    ln -sf /usr/share/sddm/themes/astronaut/Themes/astronaut.conf /usr/share/sddm/themes/astronaut/theme.conf || {
        echo "⚠️  Warning: Failed to create symlink"
    }
    echo "   ✓ Symlink created"
fi

# Verify and fix permissions
echo "🔒 Checking permissions..."
chmod 755 /usr/share/sddm/themes/astronaut || {
    echo "⚠️  Warning: Failed to set theme directory permissions"
}
if [ -f "/etc/sddm.conf.d/theme.conf" ]; then
    chmod 644 /etc/sddm.conf.d/theme.conf || {
        echo "⚠️  Warning: Failed to set config file permissions"
    }
fi
echo "   ✓ Permissions verified"

echo ""
echo "=================================="
echo "  ✓ Installation complete!        "
echo "=================================="
echo ""
echo "The theme will be applied on next logout/reboot."
echo ""

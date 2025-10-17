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

# Install astronaut theme
if [ ! -d "/usr/share/sddm/themes/astronaut" ]; then
    echo "📦 Installing SDDM Astronaut theme..."
    cd /usr/share/sddm/themes/
    git clone https://github.com/Keyitdev/sddm-astronaut-theme.git astronaut
    echo "   ✓ Theme installed"
else
    echo "✓ Astronaut theme already installed"
fi

# Copy custom configuration
echo "📋 Applying custom configuration..."
cp "$SCRIPT_DIR/astronaut/Themes/astronaut.conf" /usr/share/sddm/themes/astronaut/Themes/
echo "   ✓ Theme configuration applied"

# Copy custom wallpaper
echo "🖼️  Applying custom wallpaper..."
cp "$SCRIPT_DIR/astronaut/Backgrounds/imagem2.png" /usr/share/sddm/themes/astronaut/Backgrounds/
echo "   ✓ Wallpaper applied"

# Copy SDDM configuration
echo "⚙️  Configuring SDDM..."
mkdir -p /etc/sddm.conf.d
cp "$SCRIPT_DIR/sddm.conf.d/theme.conf" /etc/sddm.conf.d/
echo "   ✓ SDDM configured"

# Create theme.conf symlink
if [ ! -L "/usr/share/sddm/themes/astronaut/theme.conf" ]; then
    ln -sf /usr/share/sddm/themes/astronaut/Themes/astronaut.conf /usr/share/sddm/themes/astronaut/theme.conf
    echo "   ✓ Symlink created"
fi

echo ""
echo "=================================="
echo "  ✓ Installation complete!        "
echo "=================================="
echo ""
echo "The theme will be applied on next logout/reboot."
echo ""

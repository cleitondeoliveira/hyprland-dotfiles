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

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check dependencies
check_dependencies() {
    echo "Checking dependencies..."
    local missing_deps=()

    # Essential dependencies
    local deps=("hyprland" "waybar" "kitty" "wofi" "hyprpaper" "dunst" "hyprlock" "hypridle")

    for dep in "${deps[@]}"; do
        if ! command_exists "$dep"; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo "❌ Missing dependencies detected:"
        for dep in "${missing_deps[@]}"; do
            echo "   - $dep"
        done
        echo ""
        echo "Please install missing dependencies first:"
        echo "sudo pacman -S ${missing_deps[*]}"
        echo ""
        read -p "Do you want to continue anyway? (y/N) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            exit 1
        fi
    else
        echo "✓ All dependencies found"
    fi
    echo ""
}

# Check dependencies before proceeding
check_dependencies

# Function to create backup
backup_config() {
    local config_name=$1
    local config_path="$CONFIG_DIR/$config_name"

    if [ -e "$config_path" ]; then
        echo "📦 Backing up $config_name..."
        mkdir -p "$BACKUP_DIR" || {
            echo "❌ Error: Failed to create backup directory"
            exit 1
        }
        cp -r "$config_path" "$BACKUP_DIR/" || {
            echo "❌ Error: Failed to backup $config_name"
            exit 1
        }
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
        mkdir -p "$CONFIG_DIR" || {
            echo "❌ Error: Failed to create config directory"
            exit 1
        }
        cp -r "$source_path" "$CONFIG_DIR/" || {
            echo "❌ Error: Failed to install $config_name"
            exit 1
        }
        echo "   ✓ $config_name installed"
    else
        echo "⚠️  Warning: $source_path not found, skipping..."
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
    chmod +x "$CONFIG_DIR/waybar/scripts/"*.sh 2>/dev/null || {
        echo "⚠️  Warning: Failed to make some waybar scripts executable"
    }
    echo "🔧 Waybar scripts made executable"
fi

# Install .bashrc
if [ -f "$HOME/.bashrc" ]; then
    echo "📦 Backing up .bashrc..."
    cp "$HOME/.bashrc" "$HOME/.bashrc.bak" || {
        echo "⚠️  Warning: Failed to backup .bashrc"
    }
fi

if [ -f "$DOTFILES_DIR/.bashrc" ]; then
    echo "📋 Installing .bashrc..."
    cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc" || {
        echo "❌ Error: Failed to install .bashrc"
        exit 1
    }
    chmod 644 "$HOME/.bashrc" || {
        echo "⚠️  Warning: Failed to set .bashrc permissions"
    }
    echo "   ✓ .bashrc installed"
fi

# Verify script permissions
echo ""
echo "🔒 Verifying script permissions..."
if [ -d "$CONFIG_DIR/waybar/scripts" ]; then
    for script in "$CONFIG_DIR/waybar/scripts/"*.sh; do
        if [ -f "$script" ]; then
            if [ ! -x "$script" ]; then
                echo "⚠️  Warning: $script is not executable"
            fi
        fi
    done
    echo "   ✓ Permissions verified"
fi

echo ""
echo "=================================="
echo "  ✓ Installation complete!        "
echo "=================================="
echo ""
echo "Next steps:"
echo "1. Restart Hyprland: press Super+Shift+E and login again"
echo "2. Or run: hyprctl reload"
echo "3. Open a new terminal to load the new .bashrc"
echo ""
echo "Your backups are at: $BACKUP_DIR"
echo ".bashrc backup: ~/.bashrc.bak"
echo ""

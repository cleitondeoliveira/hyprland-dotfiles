#!/bin/bash

# Script de instalação das configurações Hyprland

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

echo "=================================="
echo "  Hyprland Dotfiles - Instalação  "
echo "=================================="
echo ""

# Função para criar backup
backup_config() {
    local config_name=$1
    local config_path="$CONFIG_DIR/$config_name"

    if [ -e "$config_path" ]; then
        echo "📦 Fazendo backup de $config_name..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$config_path" "$BACKUP_DIR/"
        echo "   Backup salvo em: $BACKUP_DIR/$config_name"
    fi
}

# Função para instalar configuração
install_config() {
    local config_name=$1
    local source_path="$DOTFILES_DIR/.config/$config_name"
    local target_path="$CONFIG_DIR/$config_name"

    if [ -d "$source_path" ]; then
        echo "📋 Instalando $config_name..."
        mkdir -p "$CONFIG_DIR"
        cp -r "$source_path" "$CONFIG_DIR/"
        echo "   ✓ $config_name instalado"
    fi
}

# Lista de configurações
configs=("hypr" "waybar" "kitty" "rofi" "wofi")

# Fazer backup das configurações existentes
echo "Verificando configurações existentes..."
for config in "${configs[@]}"; do
    backup_config "$config"
done

if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "✓ Backups criados em: $BACKUP_DIR"
fi

echo ""
echo "Instalando configurações..."

# Instalar novas configurações
for config in "${configs[@]}"; do
    install_config "$config"
done

# Tornar scripts executáveis
if [ -d "$CONFIG_DIR/waybar/scripts" ]; then
    chmod +x "$CONFIG_DIR/waybar/scripts/"*.sh
    echo "🔧 Scripts do waybar tornados executáveis"
fi

echo ""
echo "=================================="
echo "  ✓ Instalação concluída!         "
echo "=================================="
echo ""
echo "Próximos passos:"
echo "1. Reinicie o Hyprland: pressione Super+Shift+E e faça login novamente"
echo "2. Ou execute: hyprctl reload"
echo ""
echo "Seus backups estão em: $BACKUP_DIR"
echo ""

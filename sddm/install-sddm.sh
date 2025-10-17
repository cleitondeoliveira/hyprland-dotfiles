#!/bin/bash

# Script de instalação do tema SDDM Astronaut

set -e

echo "=================================="
echo "  SDDM Astronaut Theme - Install  "
echo "=================================="
echo ""

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Este script precisa ser executado como root (sudo)"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Instalar o tema astronaut
if [ ! -d "/usr/share/sddm/themes/astronaut" ]; then
    echo "📦 Instalando tema SDDM Astronaut..."
    cd /usr/share/sddm/themes/
    git clone https://github.com/Keyitdev/sddm-astronaut-theme.git astronaut
    echo "   ✓ Tema instalado"
else
    echo "✓ Tema astronaut já instalado"
fi

# Copiar configuração customizada
echo "📋 Aplicando configuração customizada..."
cp "$SCRIPT_DIR/astronaut/Themes/astronaut.conf" /usr/share/sddm/themes/astronaut/Themes/
echo "   ✓ Configuração do tema aplicada"

# Copiar wallpaper customizado
echo "🖼️  Aplicando wallpaper customizado..."
cp "$SCRIPT_DIR/astronaut/Backgrounds/imagem2.png" /usr/share/sddm/themes/astronaut/Backgrounds/
echo "   ✓ Wallpaper aplicado"

# Copiar configuração do SDDM
echo "⚙️  Configurando SDDM..."
mkdir -p /etc/sddm.conf.d
cp "$SCRIPT_DIR/sddm.conf.d/theme.conf" /etc/sddm.conf.d/
echo "   ✓ SDDM configurado"

# Criar symlink do theme.conf
if [ ! -L "/usr/share/sddm/themes/astronaut/theme.conf" ]; then
    ln -sf /usr/share/sddm/themes/astronaut/Themes/astronaut.conf /usr/share/sddm/themes/astronaut/theme.conf
    echo "   ✓ Symlink criado"
fi

echo ""
echo "=================================="
echo "  ✓ Instalação concluída!         "
echo "=================================="
echo ""
echo "O tema será aplicado no próximo logout/reboot."
echo ""

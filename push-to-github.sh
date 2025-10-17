#!/bin/bash

echo "=================================="
echo "  Push para GitHub                "
echo "=================================="
echo ""
echo "1. Crie um repositório no GitHub:"
echo "   https://github.com/new"
echo "   Nome: hyprland-dotfiles"
echo "   Deixe PRIVADO ou PÚBLICO (sua escolha)"
echo "   NÃO marque 'Add README'"
echo ""
read -p "Pressione ENTER quando criar o repositório..."
echo ""
read -p "Digite seu usuário do GitHub (cleitondeoliveira): " github_user
github_user=${github_user:-cleitondeoliveira}

echo ""
echo "Conectando ao GitHub..."
git remote add origin "https://github.com/$github_user/hyprland-dotfiles.git"

echo "Enviando para o GitHub..."
git push -u origin main

echo ""
echo "=================================="
echo "  ✓ Concluído!                    "
echo "=================================="
echo ""
echo "Repositório: https://github.com/$github_user/hyprland-dotfiles"
echo ""

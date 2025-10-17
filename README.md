# Hyprland Dotfiles

Configurações personalizadas do Hyprland compositor Wayland para Arch Linux.

## Componentes

Este repositório contém configurações para:

- **Hyprland** - Compositor Wayland dinâmico com tiling
- **Waybar** - Barra de status altamente customizável
- **Kitty** - Terminal emulador rápido e moderno
- **Wofi** - Launcher de aplicativos para Wayland
- **Dunst** - Daemon de notificações
- **Fontes** - Configuração de fontes (Ubuntu Nerd Font e JetBrainsMono Nerd Font)

## Pré-requisitos

Antes de instalar, certifique-se de ter os seguintes pacotes instalados:

```bash
sudo pacman -S hyprland waybar kitty wofi hyprpaper dunst
yay -S ttf-ubuntu-nerd ttf-jetbrains-mono-nerd
```

## Instalação

### 1. Clone o repositório

```bash
git clone https://github.com/cleitondeoliveira/hyprland-dotfiles.git
cd hyprland-dotfiles
```

### 2. Execute o script de instalação

```bash
./install.sh
```

O script irá:
- Fazer backup automático das suas configurações atuais
- Instalar as novas configurações em `~/.config/`
- Tornar os scripts executáveis

### 3. Reinicie o Hyprland

Pressione `Super+Shift+E` e faça login novamente, ou execute:

```bash
hyprctl reload
```

## Estrutura do Repositório

```
.
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf      # Configuração principal do Hyprland
│   │   ├── hyprpaper.conf     # Configuração do wallpaper
│   │   └── autostart.conf     # Apps que iniciam automaticamente
│   ├── waybar/
│   │   ├── config.jsonc       # Configuração do waybar
│   │   ├── style.css          # Estilos do waybar
│   │   └── scripts/
│   │       └── power-menu.sh  # Menu de energia
│   ├── kitty/
│   │   └── kitty.conf         # Configuração do terminal
│   ├── wofi/
│   │   ├── config             # Configuração do wofi
│   │   └── style.css          # Estilos do wofi
│   ├── dunst/
│   │   └── dunstrc            # Configuração de notificações
│   ├── fontconfig/
│   │   └── fonts.conf         # Configuração de fontes
│   └── xsettingsd/
│       └── xsettingsd.conf    # Configuração GTK
├── install.sh                  # Script de instalação
└── README.md                   # Este arquivo
```

## Atalhos Principais

Confira o arquivo `.config/hypr/hyprland.conf` para ver todos os atalhos configurados.

Alguns atalhos comuns:
- `Super + Q` - Fechar janela
- `Super + T` - Abrir terminal
- `Super + E` - Abrir gerenciador de arquivos
- `Super + R` - Abrir launcher
- `Super + F` - Modo fullscreen
- `Super + Shift + E` - Sair do Hyprland

## Personalização

Sinta-se livre para modificar as configurações de acordo com suas preferências:

- **Cores e temas**: Edite os arquivos CSS no waybar e wofi
- **Atalhos**: Modifique `hypr/hyprland.conf`
- **Wallpaper**: Altere em `hypr/hyprpaper.conf`
- **Terminal**: Configure em `kitty/kitty.conf`

## Backup

O script de instalação cria automaticamente backups em:
```
~/.config-backup-YYYYMMDD-HHMMSS/
```

Para restaurar um backup:
```bash
cp -r ~/.config-backup-YYYYMMDD-HHMMSS/* ~/.config/
```

## Contribuindo

Contribuições são bem-vindas! Sinta-se livre para:
- Reportar bugs
- Sugerir melhorias
- Enviar pull requests

## Licença

MIT License - Sinta-se livre para usar e modificar.

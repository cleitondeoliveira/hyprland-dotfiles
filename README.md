# Hyprland Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-blue)](https://hyprland.org/)
[![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/cleitondeoliveira/hyprland-dotfiles/graphs/commit-activity)

Custom Hyprland Wayland compositor configuration for Arch Linux.

## Screenshots

![Desktop with btop](screenshots/desktop-btop.png)
*Desktop with btop, fastfetch and system monitoring*

![Desktop with Wofi](screenshots/desktop-wofi.png)
*Wofi launcher and file manager*

![Desktop Extra](screenshots/desktop-extra.png)
*Additional desktop view*

## Components

This repository contains configurations for:

- **Hyprland** - Dynamic tiling Wayland compositor
- **Hyprlock** - Lockscreen with clean white theme and auto-lock after 3 minutes
- **Hypridle** - Idle management daemon
- **Waybar** - Highly customizable status bar
- **Kitty** - Fast and modern terminal emulator with custom theme
- **Bash** - Custom .bashrc with modern prompt, git integration and aliases
- **Wofi** - Application launcher for Wayland
- **Dunst** - Notification daemon
- **Fonts** - Font configuration (Ubuntu Nerd Font and JetBrainsMono Nerd Font)
- **SDDM** - Customized Astronaut theme

## Prerequisites

Before installing, make sure you have the following packages installed:

```bash
sudo pacman -S hyprland waybar kitty wofi hyprpaper dunst sddm hyprlock hypridle
yay -S ttf-ubuntu-nerd ttf-jetbrains-mono-nerd
```

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/cleitondeoliveira/hyprland-dotfiles.git
cd hyprland-dotfiles
```

### 2. Run the installation script

```bash
./install.sh
```

The script will:
- Automatically backup your current configurations
- Install the new configurations in `~/.config/`
- Make scripts executable

### 3. Restart Hyprland

Press `Super+Shift+E` and login again, or run:

```bash
hyprctl reload
```

## Repository Structure

```
.
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf      # Main Hyprland configuration
│   │   ├── hyprpaper.conf     # Wallpaper configuration
│   │   ├── hyprlock.conf      # Lockscreen configuration
│   │   ├── hypridle.conf      # Idle management (auto-lock)
│   │   └── autostart.conf     # Apps that start automatically
│   ├── waybar/
│   │   ├── config.jsonc       # Waybar configuration
│   │   ├── style.css          # Waybar styles
│   │   └── scripts/
│   │       └── power-menu.sh  # Power menu
│   ├── kitty/
│   │   └── kitty.conf         # Terminal configuration
│   ├── wofi/
│   │   ├── config             # Wofi configuration
│   │   └── style.css          # Wofi styles
├── .bashrc                     # Bash configuration with custom prompt
│   ├── dunst/
│   │   └── dunstrc            # Notification configuration
│   ├── fontconfig/
│   │   └── fonts.conf         # Font configuration
│   └── xsettingsd/
│       └── xsettingsd.conf    # GTK configuration
├── sddm/
│   ├── astronaut/             # SDDM theme customizations
│   ├── install-sddm.sh        # SDDM installation script
│   └── sddm.conf.d/           # SDDM configuration
├── install.sh                  # Installation script
└── README.md                   # This file
```

## Key Bindings

Check the `.config/hypr/hyprland.conf` file to see all configured keybindings.

Some common shortcuts:
- `Super + Q` - Close window
- `Super + T` - Open terminal
- `Super + E` - Open file manager
- `Super + R` - Open launcher
- `Super + F` - Fullscreen mode
- `Super + Escape` - Power menu (Lock/Logout/Restart/Shutdown)
- `Super + Shift + E` - Exit Hyprland

## Environment Variables

The following environment variables are configured in `hypr/hyprland.conf`:

- `GDK_SCALE=2` - Enables 2x scaling for GTK applications (useful for HiDPI displays)
- `XCURSOR_SIZE=24` - Sets the cursor size to 24 pixels
- `QT_QPA_PLATFORMTHEME=qt5ct` - Uses qt5ct for QT application theming

These can be adjusted in `.config/hypr/hyprland.conf` according to your display and preferences.

## Customization

Feel free to modify the configurations according to your preferences:

- **Colors and themes**: Edit CSS files in waybar and wofi
- **Keybindings**: Modify `hypr/hyprland.conf`
- **Wallpaper**: Change in `hypr/hyprpaper.conf`
- **Lockscreen**: Customize in `hypr/hyprlock.conf`
- **Auto-lock timing**: Adjust in `hypr/hypridle.conf` (default: 3 minutes)
- **Terminal**: Configure in `kitty/kitty.conf`
- **Shell prompt**: Customize in `.bashrc` (includes git status, aliases, and functions)
- **Environment variables**: Adjust display scaling and theming in `hypr/hyprland.conf`

## Backup

The installation script automatically creates backups in:
```
~/.config-backup-YYYYMMDD-HHMMSS/
```

To restore a backup:
```bash
cp -r ~/.config-backup-YYYYMMDD-HHMMSS/* ~/.config/
```

## SDDM Theme

This repository includes custom configurations for the **SDDM Astronaut** theme.

To install the SDDM theme (requires root):
```bash
cd sddm
sudo ./install-sddm.sh
```

### Credits
- **SDDM Astronaut Theme** by [Keyitdev](https://github.com/Keyitdev/sddm-astronaut-theme)

## Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest improvements
- Submit pull requests

## License

MIT License - Feel free to use and modify.

# SokratOS

> A biased, opinionated Arch Linux + Hyprland setup focused on productivity, customization, aesthetics and vim motions

SokratOS is a comprehensive dotfiles and configuration system for Arch Linux featuring the Hyprland compositor. It provides an elegant, functional desktop environment with dynamic theming, custom utilities, and a curated selection of tools for development and daily use.

> [!IMPORTANT]
> **sokratOS is built around Vim-style navigation.** Most menus, navigation, and custom shortcuts assume `hjkl` and `Ctrl + p/n`.
> If you’re new to Vim motions, run `vimtutor` in your terminal to get up to speed.

## ✨ Features

- 🎨 **Dynamic Theming**: Automatic color scheme generation from wallpapers using `matugen` and `pywal`
- 🖥️ **Hyprland Compositor**: Modern Wayland compositor with beautiful animations and tiling
- 🛠️ **Custom Utility Scripts**: Theme switching, focus mode, screen recording, and more
- 🔧 **Development Ready**: Docker, development tools, and Neovim configuration included
- 📱 **Modern UI Components**: Waybar, Rofi, SwayNC for notifications and menus

## 📚 Documentation

**New to sokratOS?** Start here:
- 📖 **[Complete Documentation](docs/index.md)** - Full documentation hub
- 🚀 **[Installation Guide](docs/01-getting-started/installation-arch.md)** - Get started
- 🎯 **[First Boot Tour](docs/01-getting-started/first-boot-tour.md)** - Learn the basics
- ⌨️ **[Keybinds Overview](docs/02-keybinds/overview.md)** - Essential shortcuts
- 🔧 **[Troubleshooting](docs/90-troubleshooting/common-issues.md)** - Fix common issues

## 📸 Preview

![preview1](docs/images/preview4.png)

![preview2](docs/images/preview3.png)

## 🚀 Installation

### Prerequisites

- Install Arch
- Internet connection
- Go through a base archinstall

### Video example

https://github.com/user-attachments/assets/d63283af-eb93-4078-8bd3-a0ec6c1d6c99

### Quick Start

1. Clone the repository:
```bash
sudo pacman -S git --needed

git clone https://github.com/BrouZie/sokratOS.git ~/.local/share/sokratOS
```

2. Run the installation script:
```bash
bash ~/.local/share/Sokratos/install.sh
```

The installer will:
- Set up auto-login configuration
- Install all required packages (from official repos and AUR)
- Configure Hyprland and all desktop components
- Set up terminal tools and development environment
- Install and configure themes
- Set up custom utility scripts
- Reboot the user into Hyprland-setup

## 📦 Included Components

### Desktop Environment

- **Compositor**: Hyprland with custom configuration
- **Bar**: Waybar with custom modules
- **Launcher**: Rofi application launcher
- **Notifications**: SwayNC notification daemon
- **Lock Screen**: Hyprlock
- **Idle Manager**: Hypridle
- **Wallpaper**: swww wallpaper daemon

### Terminal & CLI Tools

- **Terminal**: Kitty with custom theming
- **Shell**: Bash with custom configuration
- **Multiplexer**: Tmux with custom configuration
- **Editor**: Neovim with custom configuration
- **System Monitor**: btop
- **System Info**: fastfetch

### Development Tools

- Docker & Docker Compose
- Various language toolchains
- UV (Python package manager)
- Version control tools

### Theming System

- **matugen**: Material color generation from wallpapers
- **pywalfox**: Firefox theme integration

## 🛠️ Custom Utilities

SokratOS provides several custom scripts in the `bin` directory:

- `sokratos-next-theme`: Interactive theme selector
- `sokratos-night-mode`: Toggle night mode
- `sokratos-focus-mode`: Minimize distractions
- `sokratos-floaterminal`: Launch floating terminal
- `sokratos-cheat-sheet`: Quick cheat.sh utilizing curl
- `sokratos-wf-recorder`: Screen recording helper
- `refresh-app-daemons`: Restart UI components
- `sokratos-refresh-configs`: Restore configs to default

📖 **[Complete Scripts Reference](docs/05-reference/scripts.md)**

## ⚙️ Configuration

### User Configurations

After installation, you can customize your setup by editing these files:

- `~/.config/hypr/hyprland.conf`: Placeholder for all other configs!
- `~/.config/hypr/configs/bindings.conf`: Custom keybindings
- `~/.config/hypr/configs/envs.conf`: Environment variables
- `~/.config/hypr/configs/monitors.conf`: Monitor configuration
- `~/.config/hypr/configs/autostart.conf`: Autostart applications

### Theme Configuration

The current terminal theme is symlinked at:
- `~/.config/sokratos/current/theme/colors.conf`

📖 **[File Locations Reference](docs/05-reference/file-locations.md)** | **[Theme Switcher Guide](docs/04-tweaking-and-theming/theme-switcher.md)**

## 📁 Project Structure

```
Sokratos/
├── bin/                    # Custom utility scripts
├── docs/                   # Documentation and screenshots
├── install/                # Installation scripts
│   ├── configs/           # Configuration files
│   ├── desktop/           # Desktop environment setup
│   ├── prerequisites/     # System prerequisites
│   ├── terminal/          # Terminal and CLI tools
│   └── xtras/             # Additional features
├── themes/                # Pre-configured color schemes
├── default/               # Default configurations
├── share/                 # Shared data
└── install.sh             # Main installation script
```

## 🔧 Post-Installation

### Setting Up Monitors

Edit `~/.config/hypr/configs/monitors.conf` to configure your displays:

```conf
# Example:
monitor=DP-1,1920x1080@144,0x0,1
```

### Adding Keybindings

Add custom keybindings to `~/.config/hypr/configs/bindings.conf`:

```conf
bind = SUPER, F, exec, nautilus # File manager
```

### Autostart Applications

Add applications to launch at startup in `~/.config/hypr/configs/autostart.conf`:

```conf
exec-once = discord
```

## 🎯 Hardware Support

- **Intel Graphics**: Automatic Intel GPU configuration
- **NVIDIA Graphics**: Optional NVIDIA driver installation and configuration
- **Network**: NetworkManager with GUI support
- **Bluetooth**: Bluez with GUI controls
- **Audio**: Pipewire with full audio stack

## 🤝 Contributing

This is a personal setup, but feel free to fork and adapt it to your needs. Pull requests for bug fixes are welcome!

## 📝 License

This project is open source and available for personal use. Individual components may have their own licenses.

## 🙏 Credits

- Built for Arch Linux
- Uses the Hyprland compositor
- Inspired by the Linux ricing community and Omarchy

## 📞 Support

For issues and questions:
- 📖 **[Documentation](docs/index.md)** - Complete guides
- 🔧 **[Troubleshooting](docs/90-troubleshooting/common-issues.md)** - Common issues
- ❓ **[FAQ](docs/90-troubleshooting/faq.md)** - Frequently asked questions
- 🐛 **[GitHub Issues](https://github.com/BrouZie/sokratOS/issues)** - Report bugs

## 🗺️ Documentation Map

- **[Getting Started](docs/01-getting-started/)** - Installation and first steps
- **[Keybinds](docs/02-keybinds/)** - Complete keyboard shortcut reference
- **[Workflows](docs/03-workflows/)** - Efficient usage patterns
- **[Theming](docs/04-tweaking-and-theming/)** - Customization guides
- **[Reference](docs/05-reference/)** - Technical documentation
- **[Troubleshooting](docs/90-troubleshooting/)** - Help and support

---

> [!NOTE] 
> 1. This is an opinionated setup
> 1. It is recommended to review the installation script before running.
> 1. This is NOT an operating system - sokratOS is an implementation of Arch and Hyprland

---
id: installation-arch
title: Fresh Arch Linux Installation
tags: [installation, arch-linux, setup, getting-started]
---

# Fresh Arch Linux Installation

This guide will walk you through installing sokratOS on a fresh Arch Linux installation.

## Prerequisites

Before you begin, ensure you have:

- ✅ A fresh or minimal Arch Linux installation
- ✅ An active internet connection
- ✅ Basic familiarity with the terminal
- ✅ At least 10GB of free disk space

> **Note**: If you already have Arch Linux installed with existing configurations, see [Installing on Existing Arch](installation-existing-arch.md).

## Installation Process

### Step 1: Clone the Repository

The sokratOS repository should be cloned to `~/.local/share/sokratOS`:

```bash
git clone https://github.com/BrouZie/sokratOS.git ~/.local/share/sokratOS
```

This location is important because:
- The `bin/` scripts reference this path
- Configuration updates will sync from here
- Theme files are accessed from this location

### Step 2: Run the Installation Script

Execute the main installation script:

```bash
bash ~/.local/share/sokratOS/install.sh
```

The installer will automatically handle:

1. **Auto-login configuration** - Sets up automatic login to your user
2. **Package installation** - Installs all required packages from official repos and AUR
3. **Desktop environment setup** - Configures Hyprland and all UI components
4. **Terminal tools** - Sets up CLI utilities and development environment
5. **Theme system** - Installs color schemes and theme switcher
6. **Custom scripts** - Copies utility scripts to appropriate locations

### What Gets Installed?

The installation is organized into several modules:

#### Prerequisites
- **AUR helper** (paru) for installing AUR packages
- **Network tools** (NetworkManager)
- **Graphics drivers**:
  - Intel graphics support (automatic)
  - NVIDIA drivers (optional, prompted during install)

#### Terminal Environment
- **Kitty** terminal emulator with theming support
- **Bash** with custom configuration
- **Tmux** with TPM plugin manager
- **Neovim** with complete configuration
- **CLI utilities**: eza, btop, cava, fastfetch, and more
- **Development tools**: Docker, UV (Python manager), various toolchains
- **Firewall** configuration

#### Desktop Environment
- **Hyprland** compositor with custom configuration
- **Waybar** status bar
- **Rofi** application launcher
- **SwayNC** notification daemon
- **Hyprlock** screen locker
- **Hypridle** idle manager
- **swww** wallpaper daemon
- **Audio** (Pipewire with full stack)
- **Bluetooth** support
- **Fonts** for UI and icons

#### Theming System
- **matugen** - Material color generation from wallpapers
- **pywal** - Application theming
- **pywalfox** - Firefox theme integration
- **11 pre-configured color schemes**

### Step 3: Installation Duration

The installation typically takes **20-45 minutes** depending on:
- Your internet connection speed
- Hardware specifications
- Whether you're installing NVIDIA drivers

You'll see progress messages as each component installs.

### Step 4: Post-Installation

Once installation completes:

1. **Reboot your system**:
   ```bash
   reboot
   ```

2. **On first boot**, you'll be automatically logged into Hyprland

3. **Read the welcome message** that appears on first login

4. Continue to the [First Boot Tour](first-boot-tour.md) to learn about your new setup!

## Configuration File Locations

After installation, configuration files are placed at:

### User Configurations (Customizable)
- `~/.config/hypr/` - Hyprland configuration
  - `hyprland.conf` - Main config (sources other files)
  - `configs/bindings.conf` - Custom keybindings
  - `configs/monitors.conf` - Monitor setup
  - `configs/autostart.conf` - Startup applications
  - `configs/envs.conf` - Environment variables
- `~/.config/kitty/kitty.conf` - Terminal configuration
- `~/.config/waybar/` - Status bar configuration
- `~/.config/rofi/` - Launcher configuration
- `~/.config/swaync/` - Notification configuration
- `~/.tmux.conf` - Tmux configuration
- `~/.config/nvim/` - Neovim configuration
- `~/.bashrc` - Bash configuration

### System Files (Reference Only)
- `~/.local/share/sokratOS/` - Original repository clone
- `~/.local/share/sokratOS/bin/` - Custom utility scripts
- `~/.local/share/sokratOS/themes/` - Pre-configured color schemes
- `~/.config/sokratOS/` - Runtime configuration and theme state
  - `current/theme/colors.conf` - Symlink to active terminal theme
  - `matugen/` - Generated color schemes from wallpapers

## What Happens During Installation?

The installation script (`install.sh`) performs these tasks in order:

1. **Sets up auto-login** (`install/autologin.sh`)
2. **Installs prerequisites** (`install/prerequisites/all.sh`)
   - AUR helper, network tools, graphics drivers
3. **Configures terminal** (`install/terminal/all.sh`)
   - CLI tools, development environment, Docker
4. **Sets up desktop** (`install/desktop/all.sh`)
   - Hyprland, Waybar, audio, Bluetooth, fonts
5. **Adds extras** (`install/xtras/all.sh`)
   - Power management, printer support, mime types
6. **Copies configurations** from `install/configs/` to `~/.config/`
7. **Sets up dependencies**:
   - Tmux Plugin Manager (TPM)
   - Neovim Python environment
8. **Adds welcome message** to `~/.config/sokratOS/WELCOME.md`

## Troubleshooting

### Installation Failed

If the installation fails:

1. **Check the error message** - It will indicate which step failed
2. **Check internet connection** - Many failures are due to network issues
3. **Retry the installation**:
   ```bash
   bash ~/.local/share/sokratOS/install.sh
   ```

The installation script is idempotent - it's safe to run multiple times.

### Missing Packages

If you notice missing packages after installation:

```bash
# Check what was supposed to be installed
cat ~/.local/share/sokratOS/pacman.txt
cat ~/.local/share/sokratOS/paru.txt

# Manually install missing official packages
sudo pacman -S <package-name>

# Manually install missing AUR packages
paru -S <package-name>
```

### Display Issues

If you have display issues after installation:
- NVIDIA users: You may need to configure drivers manually
- Multi-monitor users: Edit `~/.config/hypr/configs/monitors.conf`
- See [Common Issues](../90-troubleshooting/common-issues.md) for more help

## Next Steps

🎉 **Congratulations!** You've successfully installed sokratOS!

Continue to:
- [First Boot Tour](first-boot-tour.md) - Learn the basics of your new system
- [Keybinds Overview](../02-keybinds/overview.md) - Learn essential keyboard shortcuts
- [Theme Switcher](../04-tweaking-and-theming/theme-switcher.md) - Customize your appearance

## Additional Resources

- [File Locations Reference](../05-reference/file-locations.md) - Where everything is stored
- [Custom Scripts Documentation](../05-reference/scripts.md) - Available utility scripts
- [Troubleshooting Guide](../90-troubleshooting/common-issues.md) - Solutions to common problems

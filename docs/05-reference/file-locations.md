---
id: file-locations
title: File Locations Reference
tags: [reference, configuration, files, paths]
---

# File Locations Reference

Complete reference for where sokratOS stores configurations, scripts, and data.

## Directory Structure Overview

```
~/.local/share/sokratOS/     # Repository clone (read-only reference)
~/.local/share/sokratOS/bin  # Repository scripts (defaults)
~/.config/                   # User configurations (customizable)
~/.local/bin/                # User scripts
~/Pictures/wallpaper/        # Wallpapers for theme generation
```

## Repository Clone

### Main Repository

**Location**: `~/.local/share/sokratOS/`

**Contents**:
- `bin/` - Utility scripts
- `install/` - Installation scripts and default configs
- `themes/` - Pre-configured color schemes for the terminal
- `docs/` - Documentation (this site)

**Important**: This is the source. Don't edit here unless you want to modify defaults.

### Custom Scripts

**Location**: `~/.local/bin`

**Scripts** (referenced in `$PATH`):

(New section to be continued...)

### sokratOS utility scripts

**Location**: `~/.local/share/sokratos/bin`

**Repo utilities** (referenced in `$PATH`):
- `sokratos-next-theme` - Interactive theme + wallpaper picker
- `sokratos-apply-theme` - Apply theme from wallpaper
- `sokratos-night-mode` - Toggle night light
- `sokratos-focus-mode` - Minimal distraction mode
- `sokratos-floaterminal` - Launch floating terminal
- `sokratos-wf-recorder` - Screen recording
- `sokratos-light-recorder` - Quick recording
- `sokratos-cheat-sheet` - Command reference !
- `refresh-app-daemons` - Restart UI components
- `braincreate-tmux` - Note creation system !
- `brainsearch-tmux` - Note search !

[See Scripts Reference for details](scripts.md)

### Pre-configured Terminal Themes

**Location**: `~/.local/share/sokratOS/themes/`

**Available themes**:
```
themes/
├── catppuccin/
│   └── colors.conf
├── cyberpunk/
├── everforest/
├── gruvbox/
├── kanagawa/
├── nightfox/
├── nord/
├── nvim-dark/
├── osaka-jade/
├── rosepine/
└── tokyonight/
```

**Format**: Each theme contains `colors.conf` for Kitty terminal colors.

## User Configurations

### Hyprland Configuration

**Main config**: `~/.config/hypr/hyprland.conf`

This file sources other configs:

```
~/.config/hypr/
├── hyprland.conf           # Main config (sources others)
├── hypridle.conf           # Idle management
├── hyprlock.conf           # Lock screen
└── configs/
    ├── autostart.conf      # Startup applications
    ├── bindings.conf       # Keybindings
    ├── envs.conf           # Environment variables
    ├── hyprutils.conf      # Hyprland utilities
    ├── input.conf          # Input devices (keyboard, mouse)
    ├── looknfeel.conf      # Appearance (gaps, borders, etc.)
    ├── monitors.conf       # Monitor configuration
    ├── tiling.conf         # Window tiling keybinds
    └── windowrules.conf    # Window-specific rules
```

**Customization files** (safe to edit):
- `bindings.conf` - Add/change keybinds
- `monitors.conf` - Display settings
- `autostart.conf` - Startup programs
- `envs.conf` - Environment variables
- `looknfeel.conf` - Visual appearance

**Core files** (understand before editing):
- `hyprland.conf` - Main configuration
- `tiling.conf` - Tiling behavior
- `windowrules.conf` - Application-specific behavior

### Terminal Configuration

**Kitty**: `~/.config/kitty/kitty.conf`

**Tmux**: `~/.tmux.conf`

**Bash**:
- Main: `~/.bashrc`
- Modular configs: `~/.config/bash/`
  - `aliases.sh` - Command aliases
  - Other custom scripts

### Neovim Configuration

**Location**: `~/.config/nvim/`

```
~/.config/nvim/
├── init.lua                # Entry point
├── lua/
│   ├── current-theme.lua   # Theme integration
│   └── brouzie/
│       ├── lazy.lua        # Plugin manager
│       ├── core/
│       │   ├── keymaps.lua # Keybindings
│       │   └── options.lua # Editor options
│       └── plugins/        # Plugin configurations
└── after/
    └── ftplugin/          # Filetype-specific settings
```

**Customization files**:
- `lua/brouzie/core/keymaps.lua` - Keybinds
- `lua/brouzie/core/options.lua` - Editor settings
- Individual plugin files in `lua/brouzie/plugins/`

### Desktop UI Components

**Waybar**: `~/.config/waybar/`
```
waybar/
├── config.jsonc    # Bar layout and modules
├── style.css       # Styling
└── colors.css      # Color variables
```

**Rofi**: `~/.config/rofi/`
```
rofi/
└── config.rasi     # Launcher configuration
```

**SwayNC**: `~/.config/swaync/`
```
swaync/
├── config.json     # Notification settings
└── style.css       # Notification styling
```

**Fastfetch**: `~/.config/fastfetch/`
```
fastfetch/
└── config.jsonc    # System info display
```

**Zathura** (PDF reader): `~/.config/zathura/`
```
zathura/
└── zathurarc       # PDF viewer settings
```

### Theme System

**Runtime theme state**: `~/.config/sokratOS/`
```
sokratOS/
├── current/
│   └── theme/
│       └── colors.conf -> symlink to active theme
├── matugen/                    # Generated themes from wallpapers
│   ├── hypr/colors.conf
│   ├── kitty/mat-colors.conf
│   ├── tmux/tmux-colors.conf
│   └── .primary-hex.txt        # Primary color for theme matching
└── WELCOME.md          # First-boot message
```

**Active theme symlink**: `~/.config/sokratOS/current/theme/colors.conf`
- Points to one of the themes in `~/.local/share/sokratOS/themes/`
- Updated by `sokratos-themes` and `sokratos-next-theme`

### GTK Configuration

**GTK 3**: `~/.config/gtk-3.0/settings.ini`

**GTK 4**: `~/.config/gtk-4.0/settings.ini`

Used for file pickers, some GUI applications.

### Application Launchers

**Desktop entries**: `~/.local/share/applications/`

Custom `.desktop` files for Rofi launcher.

## Data Directories

### Wallpapers

**Location**: `~/Pictures/wallpaper/`

**Usage**: Theme switcher (`sokratos-next-theme`) picks up wallpapers
interactively from this location.

**Add wallpapers**:
```bash
mv new-wallpaper.jpg ~/Pictures/wallpaper/ # move wallpaper to correct location
```

### Tmux Plugins

**Location**: `~/.tmux/plugins/`

**Manager**: TPM (Tmux Plugin Manager) at `~/.tmux/plugins/tpm`

### Neovim Data

**Plugins**: `~/.local/share/nvim/`

**State**: `~/.local/state/nvim/`

**Cache**: `~/.cache/nvim/`

**Python venv**: `~/.venvs/nvim/`
- Used for Neovim Python plugins
- Created during installation

## Cache and Runtime

### Theme Cache

**Location**: `~/.cache/sokratOS/theme/`

**Contains**: `theme-source.png` - Processed wallpaper for theme generation

### Hyprland Logs

**Location**: `~/.hyprland.log`

Check for errors if Hyprland isn't working.

## Environment Variables

Key environment variables set by sokratOS:

### In Installation Script

**`REPO_PATH`**: `$HOME/.local/share/sokratOS`
- Used during installation
- Scripts reference this location

### In User Session

**PATH additions**:
```bash
# Added to $PATH in ~/.bashrc
$HOME/.local/share/sokratOS/bin
$HOME/.local/bin
```

**Other variables** (set in `~/.config/hypr/configs/envs.conf`):
- Display/Wayland variables
- XDG directories
- Theme variables

[See Environment Variables Reference](environment-variables.md)

## Configuration File Syntax

### Hyprland Configs

**Format**: Custom Hyprland syntax

```conf
# Comments start with #
bind = SUPER, Return, exec, kitty
general {
    gaps_in = 10
}
```

**Variables**:
```conf
$variable = value
bind = $variable, ...
```

### Kitty Config

**Format**: Key-value pairs

```conf
# Comment
font_family      JetBrainsMono Nerd Font
font_size        12.0
background       #1e1e2e
```

### Tmux Config

**Format**: Tmux command syntax

```conf
# Comment
set -g option value
bind-key key command
```

### Neovim Config

**Format**: Lua

```lua
-- Comment
vim.opt.option = value
vim.keymap.set("mode", "key", "action")
```

## Backing Up Configurations

### Essential Files to Backup

```bash
# Create backup
backup_dir=~/config-backup-$(date +%Y%m%d)
mkdir -p $backup_dir

# Hyprland
cp -r ~/.config/hypr $backup_dir/

# Terminal
cp ~/.tmux.conf $backup_dir/
cp ~/.bashrc $backup_dir/
cp -r ~/.config/bash $backup_dir/
cp -r ~/.config/kitty $backup_dir/

# Neovim
cp -r ~/.config/nvim $backup_dir/

# UI
cp -r ~/.config/waybar $backup_dir/
cp -r ~/.config/rofi $backup_dir/
cp -r ~/.config/swaync $backup_dir/

# Theme state
cp -r ~/.config/sokratOS $backup_dir/
```

### Restoring from Backup

```bash
# Restore specific config
cp -r ~/config-backup-*/hypr ~/.config/

# Or restore all
cp -r ~/config-backup-*/* ~/.config/
```

## Finding Configuration Options

### Hyprland

```bash
# List all options
hyprctl getoption

# Get specific option
hyprctl getoption general:gaps_in

# Hyprland wiki
xdg-open https://wiki.hyprland.org/
```

### Other Tools

```bash
# Man pages
man kitty
man tmux

# Built-in help
nvim +help
```

## Modifying Default Configs

If you want to change the defaults for fresh installations:

1. **Edit in repository**: `~/.local/share/sokratOS/install/configs/`
2. **Test on your system** first
3. **Commit changes** if tracking with git
4. **Re-run installer** to apply (overwrites current configs!)

**Warning**: Re-running installer overwrites your current configs!

## Next Steps

- **[Scripts Reference](scripts.md)** - What each script does
- **[Environment Variables](environment-variables.md)** - Env var details
- **[Theme Switcher Guide](../04-tweaking-and-theming/theme-switcher.md)** - Theming system

## Additional Resources

- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [Arch Wiki: Dotfiles](https://wiki.archlinux.org/title/Dotfiles)
- [Hyprland Configuration](https://wiki.hyprland.org/Configuring/Configuring-Hyprland/)

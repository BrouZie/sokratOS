---
id: scripts-reference
title: Custom Scripts Reference
tags: [reference, scripts, utilities, tools]
---

# Custom Scripts Reference

Complete reference for all custom sokratOS utility scripts.

**Location**: `~/.local/share/sokratOS/bin/`

These scripts are in your `$PATH` and can be run from anywhere.

## Theme Management

### sokratos-apply-theme

**Purpose**: Generate and apply theme from a wallpaper image

**Usage**:
```bash
sokratos-apply-theme /path/to/wallpaper.jpg
```

**What it does**:
1. Processes image (crops and resizes for color analysis)
2. Sets wallpaper with `swww`
3. Generates color scheme with `matugen`
4. Analyzes dominant colors and brightness
5. Selects best matching pre-configured theme
6. Updates terminal colors
7. Refreshes UI components

**Files created/modified**:
- `~/.cache/sokratOS/theme/theme-source.png` - Processed image
- `~/.config/sokratOS/matugen/` - Generated colors
- `~/.config/sokratOS/current/theme/colors.conf` - Symlink to selected theme

**Keybind**: None (used by `sokratos-next-theme`)

---

### sokratos-next-theme

**Purpose**: Interactive wallpaper picker with automatic theme application

**Usage**:
```bash
sokratos-next-theme
```

**How it works**:
1. Shows Rofi menu with wallpapers from `~/Pictures/wallpaper/`
2. Select wallpaper
3. Automatically calls `sokratos-apply-theme`

**Keybind**: `SUPER + Shift + Space`

**Requirements**:
- Wallpapers in `~/Pictures/wallpaper/`
- Supported formats: `.jpg`, `.png`, `.jpeg`

---

### sokratos-themes

**Purpose**: Quick theme switcher (pre-configured themes only)

**Usage**:
```bash
sokratos-themes
```

**How it works**:
1. Shows Rofi menu with 11 selectable terminal colors
2. Select theme
3. Updates terminal colors immediately

**Keybind**: `SUPER + Shift + P`

**Available themes**:
- Catppuccin
- Cyberpunk
- Everforest
- Gruvbox
- Kanagawa
- Nightfox
- Nord
- Nvim Dark
- Osaka Jade
- Rosé Pine
- TokyoNight

**Location**: `~/.local/share/sokratOS/themes/`

## Display and Appearance

### sokratos-night-mode

**Purpose**: Toggle night light (reduces blue light)

**Usage**:
```bash
sokratos-night-mode
```

**What it does**:
- First run: Starts `hyprsunset` at 4000K (warm colors)
- Second run: Stops `hyprsunset` (normal colors)
- Shows notification on toggle

**Keybind**: None (run from terminal or add your own)

**Suggested keybind**:
```conf
# Add to ~/.config/hypr/configs/bindings.conf
bind = SUPER, N, exec, sokratos-night-mode
```

---

### sokratos-focus-mode

**Purpose**: Minimal distraction mode for focused work

**Usage**:
```bash
sokratos-focus-mode
```

> [!note] You can access focus mode through the utilities menu

**What it does**:
- Removes window gaps (gaps_in = 0, gaps_out = 0)
- Disables rounded corners (rounding = 0)
- Disables shadows
- Disables blur
- Kills Waybar (status bar)

## Screenshots and Recording

### sokratos-light-recorder

**Purpose**: Quick screen recording toggle

**Usage**:
```bash
sokratos-light-recorder
```

**Keybind**: `SUPER + Print`

**Features**:
- One command to start/stop
- Records full screen
- Saves to `~/Videos/`
- Includes audio

**Implementation**: Uses `wf-recorder` or similar tool

---

### sokratos-wf-recorder

**Purpose**: Advanced screen recording with options

**Usage**:
```bash
sokratos-wf-recorder
```

**Keybind**: `SUPER + Shift + Print`

**Features** (via Rofi menu):
- Select recording area
- With/without audio
- Set duration
- Choose output format
- Custom filename

**Saves to**: `~/Videos/`

## Terminal Utilities

### sokratos-floaterminal

**Purpose**: Launch floating Kitty terminal

**Usage**:
```bash
sokratos-floaterminal
# or with command
sokratos-floaterminal htop
```

**Keybind**: `SUPER + Shift + Return`

**What it does**:
- Launches Kitty with class `kitty-float`
- Window appears floating (due to window rules)
- Optional: Pass command to run in terminal

**Examples**:
```bash
# Floating htop
sokratos-floaterminal htop

# Floating Python REPL
sokratos-floaterminal python

# Just a floating shell
sokratos-floaterminal
```

---

### refresh-app-daemons

**Purpose**: Restart UI components

**Usage**:
```bash
refresh-app-daemons
```

**Keybind**: `SUPER + Shift + R`

**What it restarts**:
- SwayNC (notification daemon)
- Waybar (status bar)

**When to use**:
- After changing Waybar config
- When notifications stop working
- UI components frozen/unresponsive
- After theme changes

**Implementation**:
```bash
pkill swaync && swaync &
pkill waybar && waybar &
```

---

### github-tmux

**Purpose**: Quick GitHub repository opener

**Usage**:
```bash
# In tmux
github-tmux
```

**What it does**:
- Opens GitHub-related tmux workflow
- Customizable for your needs

### sokratos-quick-search

**Purpose**: Navigation helper inside tmux

**Usage**:
```bash
# In a tmux session: prefix + f
# Or:
sokratos-quick-search
```

**How it works**:
- Sources directory presets from `~/.config/sokratOS/env.d/fzf-dirs.sh`
- Opens an fzf list with previews and jumps into the selected directory
- Launches Neovim in that location; accepts an optional path argument to skip fzf

---

### sokratos-show-keybinds

**Purpose**: Searchable Hyprland keybind list

**Usage**:
```bash
sokratos-show-keybinds
```

**How it works**:
- Parses `~/.config/hypr/configs/bindings.conf` and `tiling.conf`
- Maps Hyprland `code:` bindings to readable key names
- Shows a Rofi menu with formatted `modifier + key → action` entries

---

### sokratos-utilities

**Purpose**: One-stop Rofi menu for common sokratOS actions

**Usage**:
```bash
sokratos-utilities
```

**Menu actions**:
- Change wallpaper/theme (calls `sokratos-next-theme`)
- Toggle focus mode or night mode
- Show keybinds (`sokratos-show-keybinds`)
- Update system (opens a floating terminal and runs `sokratos-update`)

---

### sokratos-update

**Purpose**: Update sokratOS files and system packages

**Usage**:
```bash
sokratos-update
```

**What it does**:
- Pulls the latest repo changes from `~/.local/share/sokratOS`
- Updates packages with `paru -Syu` (falls back to `sudo pacman -Syu`)
- Optionally launches `sokratos-refresh-configs` to reapply dotfiles

---

### sokratos-refresh-configs

**Purpose**: Reapply default configs with backups

**Usage**:
```bash
sokratos-refresh-configs
```

**Features**:
- Menu-driven selection for Bash, Zsh, tmux, Hyprland, Waybar, Rofi, Neovim, SwayNC, fzf dirs, and ROS2 docker files
- Backs up existing files to `.bak`, `.bak1`, etc. before copying
- Uses the curated configs from `~/.local/share/sokratOS/install/configs/`

---

### Use in Keybinds

Add to `~/.config/hypr/configs/bindings.conf`:

```conf
bind = SUPER, X, exec, my-script
```

## Script Dependencies

Most scripts require these packages (installed by sokratOS):

**Theme scripts**:
- `matugen` - Color generation
- `swww` - Wallpaper daemon
- `imagemagick` - Image processing
- `pastel` - Color manipulation

**Display**:
- `hyprsunset` - Night light
- `hyprctl` - Hyprland control

**Notifications**:
- `notify-send` - Notifications
- `swaync` - Notification daemon

**Recording**:
- `wf-recorder` - Screen recording
- `hyprshot` - Screenshots

**Terminal**:
- `kitty` - Terminal emulator
- `tmux` - Terminal multiplexer

**Selection menus**:
- `rofi` - Menu/launcher
- `fzf` - Fuzzy finder

## Troubleshooting Scripts

### Script Not Found

```bash
# Check script exists
ls ~/.local/share/sokratOS/bin/sokratos-themes

# Check PATH
echo $PATH | grep sokratOS

# Add to PATH if missing (in ~/.bashrc)
export PATH="$HOME/.local/share/sokratOS/bin:$PATH"

# Reload shell
source ~/.bashrc
```

### Permission Denied

```bash
# Make executable
chmod +x ~/.local/share/sokratOS/bin/script-name
```

### Script Fails

```bash
# Run with bash -x for debugging
bash -x ~/.local/share/sokratOS/bin/script-name

# Check dependencies
which matugen
which rofi
which fzf
```

### Theme Scripts Not Working

```bash
# Check directories exist
mkdir -p ~/Pictures/wallpaper/
mkdir -p ~/.cache/sokratOS/theme/
mkdir -p ~/.config/sokratOS/current/theme/

# Check matugen installed
which matugen

# Test theme switching manually
sokratos-themes
```

## Next Steps

- **[File Locations](file-locations.md)** - Where scripts and configs live
- **[Theme Switcher Guide](../04-tweaking-and-theming/theme-switcher.md)** - Detailed theming
- **[Keybinds Reference](../02-keybinds/overview.md)** - Script keybindings
- **[Workflows](../03-workflows/coding-workflow.md)** - Using scripts effectively

## Additional Resources

- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [Rofi Documentation](https://github.com/davatorium/rofi)
- [FZF GitHub](https://github.com/junegunn/fzf)

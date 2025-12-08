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
1. Shows Rofi menu with 11 pre-configured themes
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

**What it does**:
- Removes window gaps (gaps_in = 0, gaps_out = 0)
- Disables rounded corners (rounding = 0)
- Disables shadows
- Disables blur
- Kills Waybar (status bar)

**Reverting**:
```bash
# Reload Hyprland config (restores defaults)
hyprctl reload

# Restart UI components
refresh-app-daemons
```

**Use case**: Deep focus coding, reading, writing

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

### sokratos-cheat-sheet

**Purpose**: Quick command reference via cheat.sh

**Usage**:
```bash
# Direct run
sokratos-cheat-sheet

# In tmux
Ctrl-Space + i
```

**Keybind**: `Ctrl-Space + i` (in tmux)

**How it works**:
- Opens new tmux window
- Prompts for command/topic
- Fetches cheat sheet from cheat.sh via curl
- Shows examples and usage

**Examples**:
```
Command: curl
Command: git commit
Command: docker
Command: tar
```

**Requires**: Internet connection

## UI Management

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

## Note-Taking System

### braincreate-tmux

**Purpose**: Create notes in your 2nd Brain system

**Usage**:
```bash
# Direct run
braincreate-tmux

# In tmux
Ctrl-Space + n
```

**Keybind**: `Ctrl-Space + n` (in tmux)

**How it works**:
1. Opens fuzzy finder with note types:
   - `snippets` - Code snippets (choose language)
   - `cheatsheet` - Command references
   - `school` - Study notes (choose subject)
   - `full_notes` - Deep understanding notes
2. Prompts for title/details
3. Creates note from template
4. Opens in Neovim for editing

**Note location**: `~/Documents/2ndBrain/inbox/`

**Templates**: `~/Documents/2ndBrain/templates/`

---

### brainsearch-tmux

**Purpose**: Search and open notes

**Usage**:
```bash
brainsearch-tmux
```

**How it works**:
1. Shows fuzzy finder with note categories
2. Lists notes in selected category
3. Opens selected note in Neovim

**Search scope**: `~/Documents/2ndBrain/`

---

### brain-sort

**Purpose**: Organize notes from inbox

**Usage**:
```bash
brain-sort
```

**What it does**:
- Helps move notes from `inbox/` to proper categories
- Interactive sorting workflow

## Project Management

### rofi-sessionizer

**Purpose**: Quick project switcher (creates tmux sessions)

**Usage**:
```bash
rofi-sessionizer
```

**How it works**:
1. Scans common project directories
2. Shows Rofi menu with projects
3. Creates/attaches to tmux session for selected project
4. Changes to project directory

**Suggested keybind**:
```conf
# Add to ~/.config/hypr/configs/bindings.conf
bind = SUPER, P, exec, rofi-sessionizer
```

**Customization**:
Edit script to change project directories:
```bash
# Default locations (example)
~/projects/
~/work/
~/dev/
```

---

### session-toggle

**Purpose**: Toggle between tmux sessions

**Usage**:
```bash
session-toggle
```

**What it does**:
- Switches between last two tmux sessions
- Quick context switching

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

## Miscellaneous Utilities

### sokratos-switch-nvim

**Purpose**: Switch between Neovim configurations

**Usage**:
```bash
sokratos-switch-nvim
```

**What it does**:
- Allows testing multiple Neovim configs
- Swaps `~/.config/nvim/` between versions

**Use case**: Try different Neovim distributions while keeping sokratOS config

---

### sokratos-navigation

**Purpose**: Navigation helper utility

**Usage**:
```bash
sokratos-navigation
```

**What it does**: Provides quick navigation shortcuts or menu

---

### qresult

**Purpose**: Quick result display utility

**Usage**:
```bash
qresult
```

**What it does**: Shows command results in formatted way

## Creating Custom Scripts

### Script Template

Create your own script in `~/.local/share/sokratOS/bin/`:

```bash
#!/usr/bin/env bash

# My custom script
# Description: What it does

# Function definition
my_function() {
    echo "Hello from custom script!"
}

# Main logic
my_function
```

### Make Executable

```bash
chmod +x ~/.local/share/sokratOS/bin/my-script
```

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

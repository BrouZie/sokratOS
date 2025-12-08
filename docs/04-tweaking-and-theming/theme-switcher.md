---
id: theme-switcher
title: Theme Switcher Guide
tags: [theming, customization, colors, wallpaper]
---

# Theme Switcher Guide

Complete guide to the sokratOS theme system.

## Overview

sokratOS includes two theme systems:

1. **Pre-configured themes** - 11 hand-picked color schemes
2. **Wallpaper-based themes** - Auto-generated from images

Both systems work together seamlessly.

## Pre-configured Themes

### Available Themes

sokratOS includes 11 themes:

| Theme | Description | Colors |
|-------|-------------|--------|
| **Catppuccin** | Soothing pastel | Warm pastels |
| **Cyberpunk** | Neon vibes | Vibrant neon |
| **Everforest** | Calm forest | Green tones |
| **Gruvbox** | Retro warm | Orange/brown |
| **Kanagawa** | Japanese wave | Blue/teal |
| **Nightfox** | Deep night | Dark blue |
| **Nord** | Arctic cool | Cool blues |
| **Nvim Dark** | Professional | Dark neutral |
| **Osaka Jade** | Green teal | Jade green |
| **Rosé Pine** | Soft pastels | Pink/purple |
| **TokyoNight** | Cyberpunk night | Purple/blue |

### Quick Theme Switch

**Keybind**: `SUPER + Shift + P`

**Command**:
```bash
sokratos-themes
```

**Workflow**:
1. Press `SUPER + Shift + P`
2. Rofi menu appears with theme list
3. Select theme with arrow keys
4. Press Enter
5. Terminal colors update instantly!

## Wallpaper-Based Theming

### How It Works

1. **Select wallpaper** - Choose image
2. **Color extraction** - matugen analyzes colors
3. **Theme generation** - Creates color scheme
4. **Theme matching** - Picks best pre-configured theme
5. **Apply** - Updates terminal and wallpaper

### Using Wallpaper Themes

**Keybind**: `SUPER + Shift + Space`

**Command**:
```bash
sokratos-next-theme
```

**Workflow**:
1. Press `SUPER + Shift + Space`
2. Rofi shows wallpapers from `~/Pictures/wallpaper/`
3. Select wallpaper
4. System analyzes colors
5. Selects matching theme
6. Updates everything automatically

### Direct Application

Apply theme from any image:

```bash
sokratos-apply-theme /path/to/image.jpg
```

**What happens**:
- Image becomes wallpaper
- Colors analyzed
- Best theme selected
- UI refreshed

## Adding Wallpapers

### Default Location

`~/Pictures/wallpaper/`

### Adding New Wallpapers

```bash
# Copy wallpaper
cp ~/Downloads/cool-wallpaper.jpg ~/Pictures/wallpaper/

# Now available in theme picker
```

**Supported formats**: `.jpg`, `.png`, `.jpeg`

## Theme File Structure

### Pre-configured Theme

```
~/.local/share/sokratOS/themes/catppuccin/
├── colors.conf         # Kitty terminal colors
└── ghostty-colors      # Ghostty terminal colors (if used)
```

### Active Theme

```
~/.config/sokratOS/current/theme/
├── colors.conf -> ../../.../themes/catppuccin/colors.conf
└── ghostty-colors -> symlink
```

**Note**: These are symlinks pointing to active theme.

## What Gets Themed

### Automatically Themed

✅ **Kitty terminal** - Instant color update
✅ **Tmux status bar** - Colors via theme variables
✅ **Hyprland** - Border colors, window decorations
✅ **Waybar** - Status bar colors (via CSS variables)

### Manual Theming (Optional)

⚠️ **Neovim** - Has own colorscheme (can sync if desired)
⚠️ **Rofi** - Can be themed via config
⚠️ **SwayNC** - Notification colors customizable

## Theme Color Analysis

### How Matching Works

```bash
# Extract dominant color
PRIMARY_HEX=$(matugen analyze image.jpg)

# Analyze brightness
SHADE=$(light or dark)

# Match to theme
# Example: "dark lightpink" → nightfox
# Example: "light darkseagreen" → everforest
```

**Theme matching rules** (in `sokratos-apply-theme`):
- Light steel blue → TokyoNight or Nord
- Salmon → Gruvbox
- Aquamarine → Osaka Jade
- Pink → Rosé Pine or Nightfox
- Green → Everforest
- And more...

### Customizing Matching

Edit `~/.local/share/sokratOS/bin/sokratos-apply-theme`:

```bash
case "$SHADE $COLOR1" in
  "dark mycolor")  set_theme mytheme ;;
  # Add your rules
esac
```

## Creating Custom Themes

### 1. Create Theme Directory

```bash
mkdir -p ~/.local/share/sokratOS/themes/mytheme
```

### 2. Create colors.conf

```bash
cd ~/.local/share/sokratOS/themes/mytheme
nvim colors.conf
```

**Template** (Kitty format):
```conf
# vim:ft=kitty

## name: My Theme
## author: Your Name

# Basic colors
foreground              #FFFFFF
background              #000000
selection_foreground    #000000
selection_background    #FFFFFF

# Black
color0   #000000
color8   #555555

# Red
color1   #FF0000
color9   #FF5555

# Green
color2   #00FF00
color10  #55FF55

# Yellow
color3   #FFFF00
color11  #FFFF55

# Blue
color4   #0000FF
color12  #5555FF

# Magenta
color5   #FF00FF
color13  #FF55FF

# Cyan
color6   #00FFFF
color14  #55FFFF

# White
color7   #FFFFFF
color15  #FFFFFF
```

### 3. Use Your Theme

```bash
# Manually activate
ln -sf ~/.local/share/sokratOS/themes/mytheme/colors.conf \
       ~/.config/sokratOS/current/theme/colors.conf

# Reload terminal
pkill -SIGUSR1 kitty
```

## Syncing Neovim Colors

### Option 1: Use Matching Neovim Theme

Edit `~/.config/nvim/lua/current-theme.lua`:

```lua
-- Match your sokratOS theme
vim.cmd("colorscheme tokyonight")  -- For TokyoNight
vim.cmd("colorscheme catppuccin")  -- For Catppuccin
vim.cmd("colorscheme gruvbox")     -- For Gruvbox
-- etc.
```

### Option 2: Auto-sync Script

Create `~/. local/bin/sync-nvim-theme`:

```bash
#!/bin/bash

# Read current theme name
THEME=$(readlink ~/.config/sokratOS/current/theme/colors.conf | xargs basename | cut -d/ -f1)

# Map to nvim colorscheme
case $THEME in
  catppuccin) NVIM_THEME="catppuccin" ;;
  tokyonight) NVIM_THEME="tokyonight" ;;
  gruvbox) NVIM_THEME="gruvbox" ;;
  *) NVIM_THEME="default" ;;
esac

# Update nvim theme file
echo "vim.cmd('colorscheme $NVIM_THEME')" > ~/.config/nvim/lua/current-theme.lua
```

## Troubleshooting

### Theme Not Applying

1. **Check symlink**:
   ```bash
   ls -la ~/.config/sokratOS/current/theme/colors.conf
   ```

2. **Reload Kitty**:
   ```bash
   pkill -SIGUSR1 kitty
   ```

3. **Restart UI**:
   ```bash
   refresh-app-daemons
   ```

### Wallpaper Not Changing

```bash
# Check swww is running
pgrep swww

# Start if not running
swww init
```

### Colors Look Wrong

```bash
# Check terminal supports 256 colors
echo $TERM

# Should be: xterm-kitty or tmux-256color

# Test colors
curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
```

### matugen Not Found

```bash
# Install matugen
paru -S matugen

# Or rebuild
paru -S matugen-bin
```

## Advanced Customization

### Custom Color Extraction

Edit `sokratos-apply-theme`:

```bash
# Change image processing
magick "$WALL" \
  -resize 1920x1080^ \
  -gravity center -crop 80%x80%+0+0 +repage \
  "$PROCESSED_IMG"
```

### Temperature Adjustment

Change color temperature for wallpaper theming:

```bash
# In sokratos-apply-theme
matugen image "$PROCESSED_IMG" --temperature 0.7
```

Values: `0.0` (cooler) to `1.0` (warmer)

## Tips and Tricks

### 1. Organize Wallpapers

```bash
mkdir -p ~/Pictures/wallpaper/{dark,light,nature,abstract}
# Then select from subdirectories
```

### 2. Quick Theme Test

```bash
# Try each theme quickly
for theme in ~/.local/share/sokratOS/themes/*; do
  ln -sf "$theme/colors.conf" ~/.config/sokratOS/current/theme/colors.conf
  pkill -SIGUSR1 kitty
  sleep 3
done
```

### 3. Backup Favorite Theme

```bash
# Save current theme name
echo "catppuccin" > ~/.config/sokratOS/favorite-theme.txt
```

### 4. Automatic Theme by Time

Create script to switch themes based on time:

```bash
#!/bin/bash
hour=$(date +%H)

if [ $hour -lt 6 ] || [ $hour -gt 18 ]; then
  # Night theme
  sokratos-themes <<< "nord"
else
  # Day theme
  sokratos-themes <<< "everforest"
fi
```

## Next Steps

- **[Waybar Customization](waybar.md)** - Status bar theming
- **[Rofi Customization](rofi.md)** - Launcher theming
- **[File Locations](../05-reference/file-locations.md)** - Where themes live
- **[Scripts Reference](../05-reference/scripts.md)** - Theme script details

## Additional Resources

- [Kitty Themes](https://github.com/dexpota/kitty-themes)
- [Matugen Documentation](https://github.com/InioX/matugen)
- [Color Theory Basics](https://www.interaction-design.org/literature/article/the-basics-of-color-theory)

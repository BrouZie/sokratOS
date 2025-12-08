---
id: apps-and-launchers-keybinds
title: Apps and Launchers Keybinds
tags: [keybinds, applications, rofi, waybar, notifications]
---

# Apps and Launchers Keybinds

Keybinds for desktop applications, launchers, and UI components in sokratOS.

## Application Launcher (Rofi)

### Main Launcher

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Space` | Open launcher | Application menu with search |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 9

**How to use**:
1. Press `SUPER + Space`
2. Type application name (fuzzy search)
3. Use arrow keys to navigate
4. Press `Enter` to launch

**Examples**:
- Type "fire" → finds Firefox
- Type "code" → finds VS Code
- Type "disc" → finds Discord

### Rofi Features

**Search modes**:
- **Fuzzy matching**: Partial words work ("frfx" → Firefox)
- **Case insensitive**: "FIREFOX" = "firefox"
- **Recent apps**: Previously used apps appear first

**Tips**:
- Start typing immediately after opening
- Use Tab to autocomplete
- Escape to cancel

## File Manager

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + E` | Open Nautilus | GUI file manager |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 4

**Use cases**:
- Browse files visually
- Copy/move files with mouse
- Preview images and documents
- Mount external drives

**Alternative**: Use `<leader>e` in neovim for Oil.nvim file browser.

## Web Browser

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + B` | Open Firefox | Launch web browser |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 5

**Note**: If Firefox is already open, focuses existing window.

### Quick Website Access

Open specific websites directly:

| Keybind | Website | Customize in |
|---------|---------|--------------|
| `SUPER + A` | ChatGPT | `bindings.conf` line 25 |
| `SUPER + G` | GitHub | `bindings.conf` line 26 |
| `SUPER + C` | Canvas LMS | `bindings.conf` line 27 |
| `SUPER + Shift + B` | Bash devhints | `bindings.conf` line 28 |

**Customization**:
Edit `~/.config/hypr/configs/bindings.conf`:
```conf
bind = $mainMod, A, exec, firefox "https://your-site.com"
```

## Terminal

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Return` | Standard terminal | Open Kitty terminal |
| `SUPER + Shift + Return` | Floating terminal | Open floating Kitty window |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 3, 21

**Difference**:
- **Standard**: Tiles with other windows
- **Floating**: Appears on top, can be moved freely

## Waybar (Status Bar)

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + R` | Reload Waybar | Restart status bar |
| `SUPER + Shift + R` | Refresh UI daemons | Restart Waybar + SwayNC |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 10, 16

**When to use**:
- Waybar stops updating
- After changing Waybar config
- UI components not responding

### Waybar Modules (Mouse Interaction)

**Click actions**:
- **Workspaces**: Click to switch
- **Volume**: Click to open mixer
- **Network**: Click for network menu
- **Clock**: Shows calendar (if configured)
- **Battery**: Shows power stats (if configured)

**Right-click**: Context menus for some modules

## Notification Center (SwayNC)

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + N` | Toggle notifications | Open/close notification panel |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 11

**Features**:
- View recent notifications
- Dismiss individual notifications
- Clear all notifications
- Do Not Disturb mode toggle

**Notification levels**:
- Critical: Always shown, with sound
- Normal: Standard notification
- Low: Silent notification

## Screenshots and Recording

### Screenshots

| Keybind | Tool | Description |
|---------|------|-------------|
| `Print` | Hyprshot | Select area to screenshot |
| `SUPER + Print` | Light recorder | Quick screenshot/recording |
| `SUPER + Shift + Print` | Full recorder | Advanced recording options |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 12, 19-20

**Screenshot workflow**:
1. Press `Print`
2. Click and drag to select area
3. Screenshot saved to `~/Pictures/`

### Screen Recording

**Light recorder** (`SUPER + Print`):
- Quick on/off toggle
- Records full screen
- Saves to `~/Videos/`

**Full recorder** (`SUPER + Shift + Print`):
- Select recording area
- Choose with/without audio
- Set duration (optional)
- More options via Rofi menu

## Screen Locking

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + C` | Lock screen | Lock with Hyprlock |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 7

**Features**:
- Displays lock screen with background
- Requires password to unlock
- Dims display after timeout

**Auto-lock**: Configured in Hypridle (idle manager).

## Color Picker

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + X` | Color picker | Pick color from screen |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 8

**How it works**:
1. Press `SUPER + Shift + X`
2. Cursor becomes crosshair
3. Click on any pixel
4. Hex color code copied to clipboard

**Use cases**:
- Web development
- Graphic design
- Theming
- Matching colors

## Theme Management

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + Space` | Next theme | Theme from wallpaper picker |
| `SUPER + Shift + P` | Theme menu | Quick theme switcher |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 17-18

**Next theme workflow**:
1. Press `SUPER + Shift + Space`
2. Rofi shows wallpapers in `~/Pictures/wallpaper/`
3. Select wallpaper
4. Theme auto-generated from colors
5. System recolors automatically

**Theme menu workflow**:
1. Press `SUPER + Shift + P`
2. Rofi shows 11 pre-configured themes
3. Select theme
4. Terminal colors update instantly

[Learn more: Theme Switcher](../04-tweaking-and-theming/theme-switcher.md)

## System Actions

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + M` | Exit Hyprland | Log out to login screen |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 6

**Warning**: Immediately exits without confirmation. Save your work first!

**Alternative power options** (no default keybinds):
```bash
# Shutdown
systemctl poweroff

# Reboot
systemctl reboot

# Suspend
systemctl suspend
```

## Focus Mode

| Keybind | Script | Description |
|---------|--------|-------------|
| (none) | `sokratos-focus-mode` | Minimal distraction mode |

**No default keybind** - run from terminal:
```bash
sokratos-focus-mode
```

**What it does**:
- Removes window gaps
- Disables animations
- Removes rounded corners
- Kills Waybar
- Creates minimal, distraction-free environment

**Exiting focus mode**:
```bash
# Restart UI components
refresh-app-daemons

# Manually restart Hyprland config
hyprctl reload
```

## Night Mode

| Keybind | Script | Description |
|---------|--------|-------------|
| (none) | `sokratos-night-mode` | Toggle night light |

**No default keybind** - run from terminal:
```bash
sokratos-night-mode
```

**What it does**:
- Reduces blue light (warmer colors)
- Easier on eyes at night
- Uses `hyprsunset` at 4000K

**Toggle on/off**: Run same command to toggle.

**Add keybind** (edit `~/.config/hypr/configs/bindings.conf`):
```conf
bind = SUPER, N, exec, sokratos-night-mode
```

## Custom Application Keybinds

### Adding Your Own

Edit `~/.config/hypr/configs/bindings.conf`:

```conf
# Add at the end

# Discord
bind = SUPER, D, exec, discord

# VS Code
bind = SUPER, code:47, exec, code  # semicolon key

# Spotify
bind = SUPER, S, exec, spotify

# Calculator (floating)
bind = SUPER, EQUAL, exec, gnome-calculator

# Terminal apps
bind = SUPER, H, exec, kitty -e htop
bind = SUPER, T, exec, kitty -e btop
```

### Launch App on Specific Workspace

```conf
# Launch Firefox on workspace 1
bind = SUPER, B, exec, [workspace 1] firefox

# Launch Discord on workspace 3
bind = SUPER, D, exec, [workspace 3] discord
```

### Launch in Floating Mode

```conf
# Launch calculator floating
bind = SUPER, EQUAL, exec, [float] gnome-calculator

# Launch floating terminal with specific size
bind = SUPER SHIFT, H, exec, [float;size 800 600] kitty -e htop
```

## Desktop File Shortcuts

Create `.desktop` files for custom shortcuts in Rofi:

**Location**: `~/.local/share/applications/my-app.desktop`

```desktop
[Desktop Entry]
Name=My Custom Script
Comment=Description here
Exec=/path/to/script.sh
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Utility;Development;
```

**Then it appears in Rofi** (`SUPER + Space`)!

## Mouse Shortcuts

While sokratOS is keyboard-first, some mouse actions are available:

### Waybar Interactions

- **Left-click**: Primary action (e.g., volume mixer, network menu)
- **Right-click**: Context menu
- **Scroll**: Volume up/down (on volume module)

### Window Management

- `SUPER + Left Click Drag`: Move window
- `SUPER + Right Click Drag`: Resize window

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 57-58

### Workspace Switching

- `SUPER + Scroll Up`: Next workspace
- `SUPER + Scroll Down`: Previous workspace

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 53-54

## Rofi Customization

### Rofi Configuration

**Location**: `~/.config/rofi/config.rasi`

Customize:
- Theme colors
- Font size
- Window size
- Number of rows
- Icons

### Rofi Modi (Modes)

Switch between different Rofi modes:

```bash
# Application launcher (default)
rofi -show drun

# Window switcher
rofi -show window

# Command runner
rofi -show run

# Clipboard manager (if configured)
rofi -show clipboard
```

**Add keybinds for different modes**:
```conf
bind = SUPER, Tab, exec, rofi -show window
bind = SUPER ALT, Space, exec, rofi -show run
```

## Troubleshooting

### Rofi Not Showing Apps

1. **Check desktop files**:
   ```bash
   ls /usr/share/applications/
   ls ~/.local/share/applications/
   ```

2. **Restart Rofi**:
   ```bash
   pkill rofi
   SUPER + Space
   ```

### Waybar Not Updating

1. **Reload Waybar**:
   ```bash
   SUPER + R
   ```

2. **Check Waybar is running**:
   ```bash
   pgrep waybar
   ```

3. **Manually restart**:
   ```bash
   pkill waybar && waybar &
   ```

### Notifications Not Showing

1. **Check SwayNC is running**:
   ```bash
   pgrep swaync
   ```

2. **Restart notification daemon**:
   ```bash
   SUPER + Shift + R
   ```

3. **Test notification**:
   ```bash
   notify-send "Test" "This is a test notification"
   ```

### Screenshots Not Saving

1. **Check Pictures directory exists**:
   ```bash
   mkdir -p ~/Pictures
   ```

2. **Test hyprshot**:
   ```bash
   hyprshot -m region
   ```

3. **Check permissions**:
   ```bash
   ls -la ~/Pictures/
   ```

## Next Steps

- **[Hyprland Keybinds](hyprland.md)** - Window management
- **[Terminal Apps](terminal-apps.md)** - Command-line utilities
- **[Customization Guides](../04-tweaking-and-theming/rofi.md)** - Tweak UI components
- **[Scripts Reference](../05-reference/scripts.md)** - Custom utilities

## Additional Resources

- [Rofi Documentation](https://github.com/davatorium/rofi)
- [Waybar Configuration](https://github.com/Alexays/Waybar)
- [SwayNC Configuration](https://github.com/ErikReider/SwayNotificationCenter)
- [Hyprshot GitHub](https://github.com/Gustash/Hyprshot)

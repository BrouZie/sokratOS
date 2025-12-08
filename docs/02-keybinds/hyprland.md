---
id: hyprland-keybinds
title: Hyprland Keybinds
tags: [hyprland, keybinds, window-manager, tiling]
---

# Hyprland Keybinds

Complete reference for Hyprland window management keybinds in sokratOS.

## Modifier Key

All Hyprland keybinds use **SUPER** (Windows/Command key) as the main modifier.

```conf
$mainMod = SUPER
```

**Defined in**: `~/.config/hypr/configs/bindings.conf` and `~/.config/hypr/configs/tiling.conf`

## Basic Applications

Launch common applications quickly:

| Keybind | Action | Command |
|---------|--------|---------|
| `SUPER + Return` | Open terminal | `kitty` |
| `SUPER + E` | Open file manager | `nautilus` |
| `SUPER + B` | Open Firefox | `firefox` |
| `SUPER + Space` | Open app launcher | `rofi -show drun` |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 3-9

## Window Management

### Closing Windows

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + w` | Close window | Gracefully close focused window |
| `SUPER + Shift + w` | Force close window | Kill frozen or unresponsive windows |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 2-3

### Window States

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + F` | Toggle fullscreen | Make window fill entire screen |
| `SUPER + V` | Toggle floating | Switch between tiling and floating mode |
| `SUPER + Y` | Toggle split | Toggle split direction (horizontal/vertical) |
| `SUPER + P` | Pseudo-tile | Dwindle-specific tiling mode |

**Defined in**: `~/.config/hypr/configs/bindings.conf` line 13, `tiling.conf` lines 6-8

### Window Focus (Navigation)

Move focus between windows using vim-like keys:

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + h` | Focus left | Move focus to window on the left |
| `SUPER + j` | Focus down | Move focus to window below |
| `SUPER + k` | Focus up | Move focus to window above |
| `SUPER + l` | Focus right | Move focus to window on the right |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 11-14

**Remember**: Think "vim" - `h` (left), `j` (down), `k` (up), `l` (right)

### Window Movement (Swapping)

Swap the focused window with adjacent windows:

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + h` | Swap left | Swap with window on the left |
| `SUPER + Shift + j` | Swap down | Swap with window below |
| `SUPER + Shift + k` | Swap up | Swap with window above |
| `SUPER + Shift + l` | Swap right | Swap with window on the right |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 41-44

### Window Resizing

Resize the active window:

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + -` | Shrink width | Decrease width by 100px |
| `SUPER + =` or `SUPER + +` | Grow width | Increase width by 100px |
| `SUPER + Shift + -` | Shrink height | Decrease height by 100px |
| `SUPER + Shift + =` | Grow height | Increase height by 100px |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 47-50

**Tip**: For fine-tuned resizing, you can edit these binds to use smaller increments (e.g., 50px or 25px).

## Workspace Management

Hyprland provides 10 workspaces by default.

### Switching Workspaces

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + 1` | Workspace 1 | Switch to workspace 1 |
| `SUPER + 2` | Workspace 2 | Switch to workspace 2 |
| `SUPER + 3` | Workspace 3 | Switch to workspace 3 |
| `SUPER + 4` | Workspace 4 | Switch to workspace 4 |
| `SUPER + 5` | Workspace 5 | Switch to workspace 5 |
| `SUPER + 6` | Workspace 6 | Switch to workspace 6 |
| `SUPER + 7` | Workspace 7 | Switch to workspace 7 |
| `SUPER + 8` | Workspace 8 | Switch to workspace 8 |
| `SUPER + 9` | Workspace 9 | Switch to workspace 9 |
| `SUPER + 0` | Workspace 10 | Switch to workspace 10 |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 17-26

### Moving Windows to Workspaces

Move the focused window to a different workspace:

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + 1` | Move to workspace 1 | Move window to workspace 1 |
| `SUPER + Shift + 2` | Move to workspace 2 | Move window to workspace 2 |
| `SUPER + Shift + 3` | Move to workspace 3 | Move window to workspace 3 |
| ... | ... | ... (continues for 4-10) |
| `SUPER + Shift + 0` | Move to workspace 10 | Move window to workspace 10 |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 29-38

**Note**: Moving a window to another workspace does NOT switch to that workspace. Use `SUPER + <number>` to follow it.

### Workspace Scrolling (Mouse)

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Scroll Up` | Next workspace | Move to next workspace |
| `SUPER + Scroll Down` | Previous workspace | Move to previous workspace |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 53-54

## Mouse Bindings

Control windows with your mouse (when you need to):

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Left Click (drag)` | Move window | Drag to move a floating window |
| `SUPER + Right Click (drag)` | Resize window | Drag to resize a floating window |

**Defined in**: `~/.config/hypr/configs/tiling.conf` lines 57-58

**Tip**: These are especially useful for floating windows.

## System Controls

### Power and Session

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + M` | Exit Hyprland | Log out and exit to login screen |
| `SUPER + Shift + C` | Lock screen | Lock your session with Hyprlock |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 6-7

**Warning**: `SUPER + M` immediately exits Hyprland. Save your work first!

### UI Component Controls

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + R` | Reload Waybar | Restart the status bar |
| `SUPER + Shift + R` | Refresh UI daemons | Restart Waybar + SwayNC |
| `SUPER + Shift + N` | Toggle notifications | Open/close notification center |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 10, 16, 11

### Screenshots

| Keybind | Action | Description |
|---------|--------|-------------|
| `Print` | Area screenshot | Select region to capture |
| `SUPER + Print` | Light recorder | Quick recording tool |
| `SUPER + Shift + Print` | Full recorder | Advanced recording options |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 12, 19-20

Screenshots are saved to `~/Pictures/` by default.

## sokratOS Utilities

Custom scripts integrated into Hyprland:

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Shift + Space` | Next theme | Theme selector with wallpaper picker |
| `SUPER + Shift + P` | Theme menu | Quick theme switcher menu |
| `SUPER + Shift + Return` | Floating terminal | Open floating Kitty window |
| `SUPER + Shift + X` | Color picker | Pick color from screen (hex to clipboard) |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 17-18, 21, 8

## Quick Access Links

Open common websites directly in Firefox:

| Keybind | Website | Description |
|---------|---------|-------------|
| `SUPER + A` | ChatGPT | Open ChatGPT |
| `SUPER + G` | GitHub | Open GitHub |
| `SUPER + C` | Canvas | Open Canvas LMS |
| `SUPER + Shift + B` | Bash devhints | Open Bash cheat sheet |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 25-28

**Note**: These are user-specific. Customize them in `~/.config/hypr/configs/bindings.conf`!

## Special Workspaces (Scratchpad)

Commented out by default, but you can enable:

```conf
# Example special workspace (scratchpad)
# bind = $mainMod, W, togglespecialworkspace, magic
# bind = $mainMod SHIFT, W, movetoworkspace, special:magic
```

**Location**: `~/.config/hypr/configs/bindings.conf` lines 31-32

Uncomment and customize to create a "scratchpad" workspace for temporary windows.

## Understanding the Dwindle Layout

Hyprland uses the **dwindle layout** by default. Here's how window splits work:

### How Splits Work

1. First window: Takes full screen
2. Second window: Splits the space 50/50
3. Third window: Splits the focused half again
4. Direction alternates (vertical → horizontal → vertical...)

### Controlling Splits

- `SUPER + Y` - Toggle split direction before opening next window
- `SUPER + P` - Pseudo-tiling mode (maintains floating-like behavior while tiled)

## Customizing Hyprland Keybinds

### Where to Add Custom Keybinds

Edit: `~/.config/hypr/configs/bindings.conf`

```conf
# Add your custom keybinds here
bind = SUPER, T, exec, kitty -e htop
bind = SUPER SHIFT, T, exec, kitty -e btop
```

### Keybind Syntax

```conf
bind = MODIFIER, KEY, ACTION, PARAMS
```

**Examples**:
```conf
# Execute a command
bind = SUPER, T, exec, kitty

# Window actions
bind = SUPER, F, fullscreen, 0
bind = SUPER, V, togglefloating,

# Workspace switch
bind = SUPER, 1, workspace, 1

# Move window to workspace
bind = SUPER SHIFT, 1, movetoworkspace, 1
```

### Reload After Changes

After editing keybinds:
```bash
# Reload Hyprland config
hyprctl reload

# Or restart Waybar if keybinds don't update
SUPER + R
```

No need to restart Hyprland!

## Troubleshooting Keybinds

### Keybind Not Working

1. **Check if defined**:
   ```bash
   grep -r "SUPER, X" ~/.config/hypr/
   ```

2. **Check for conflicts**:
   ```bash
   # List all keybinds
   cat ~/.config/hypr/configs/bindings.conf
   cat ~/.config/hypr/configs/tiling.conf
   ```

3. **Test in terminal**:
   ```bash
   hyprctl keyword bind SUPER, T, exec, kitty
   ```

### Application Not Launching

If `SUPER + Return` (or another app launch) doesn't work:

1. **Test command directly**:
   ```bash
   kitty
   ```

2. **Check if installed**:
   ```bash
   which kitty
   ```

3. **Check Hyprland log**:
   ```bash
   cat ~/.hyprland.log | grep -i error
   ```

## Advanced Usage

### Window Rules

Control how specific windows behave:

**File**: `~/.config/hypr/configs/windowrules.conf`

```conf
# Float specific apps
windowrulev2 = float, class:^(kitty-float)$

# Start on specific workspace
windowrulev2 = workspace 2, class:^(firefox)$
```

### Submap (Modal Keybinds)

Create vim-like modal keybinds:

```conf
# Enter resize mode
bind = SUPER, R, submap, resize

# In resize mode
submap = resize
bind = , h, resizeactive, -100 0
bind = , l, resizeactive, 100 0
bind = , escape, submap, reset
submap = reset
```

See [Hyprland Wiki](https://wiki.hyprland.org/) for more advanced configurations.

## Next Steps

- **[Terminal Apps Keybinds](terminal-apps.md)** - System-wide application shortcuts
- **[Window Management Workflow](../03-workflows/window-management.md)** - Practical usage patterns
- **[File Locations](../05-reference/file-locations.md)** - Where configs are stored
- **[Customization Guide](../04-tweaking-and-theming/waybar.md)** - Tweaking your setup

## Additional Resources

- [Hyprland Official Wiki](https://wiki.hyprland.org/)
- [Hyprland Configuration Reference](https://wiki.hyprland.org/Configuring/Binds/)
- [sokratOS Scripts Reference](../05-reference/scripts.md)

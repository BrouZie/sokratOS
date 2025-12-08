---
id: keybinds-overview
title: Keybinds Overview
tags: [keybinds, shortcuts, keyboard, reference]
---

# Keybinds Overview

sokratOS is designed to be **keyboard-first**. This guide provides a complete overview of all keybindings organized by component.

## Philosophy

sokratOS keybinds follow these principles:

1. **SUPER (Windows key) as primary modifier** - Easy to reach, rarely conflicts
2. **Vim-like navigation** - `h/j/k/l` for directional movement
3. **Shift for variations** - `SUPER + Shift + X` for related but different actions
4. **Consistency** - Similar actions use similar keybinds across components
5. **Discoverability** - Common patterns make memorization easier

## Quick Reference Card

Print or save this for your first week:

### Essential Shortcuts

| Category | Keybind | Action |
|----------|---------|--------|
| **Apps** | `SUPER + Return` | Terminal |
| | `SUPER + Space` | Launcher |
| | `SUPER + B` | Firefox |
| | `SUPER + E` | File manager |
| **Windows** | `SUPER + w` | Close window |
| | `SUPER + Shift + w` | Force close |
| | `SUPER + F` | Fullscreen |
| | `SUPER + V` | Toggle floating |
| **Navigation** | `SUPER + h/j/k/l` | Move focus |
| | `SUPER + 1-9` | Switch workspace |
| | `SUPER + Shift + h/j/k/l` | Swap windows |
| **System** | `SUPER + Shift + C` | Lock screen |
| | `SUPER + M` | Exit Hyprland |
| | `SUPER + Shift + R` | Restart UI |

## Keybind Categories

sokratOS keybinds are organized into several categories:

### 1. Hyprland (Window Manager)

Core window management shortcuts for navigating and organizing windows.

**Covered in**: [Hyprland Keybinds](hyprland.md)

**Most used**:
- Window focus and movement
- Workspace switching
- Window tiling controls
- Fullscreen and floating modes

### 2. Terminal Applications

System-wide shortcuts that launch terminal-based applications and utilities.

**Covered in**: [Terminal Apps Keybinds](terminal-apps.md)

**Most used**:
- Opening browsers and file managers
- Launching sokratOS utilities
- Quick access to common websites

### 3. Tmux

Terminal multiplexer shortcuts for managing multiple terminal panes and sessions.

**Covered in**: [Tmux Keybinds](tmux.md)

**Prefix**: `Ctrl-Space`

**Most used**:
- Creating splits
- Navigating panes
- Managing sessions
- Custom utilities

### 4. Neovim

Text editor shortcuts for code editing and file management.

**Covered in**: [Neovim Keybinds](neovim.md)

**Leader**: `Space`

**Most used**:
- File operations
- Code navigation
- Editing commands
- Plugin shortcuts

### 5. Apps and Launchers

Shortcuts for desktop applications and UI components.

**Covered in**: [Apps and Launchers](apps-and-launchers.md)

**Most used**:
- Rofi launcher
- Waybar controls
- Notification center
- Screenshots

## Modifier Keys Reference

Understanding modifiers is key to sokratOS:

| Modifier | Symbol | Key |
|----------|--------|-----|
| SUPER | `SUPER` or `$mainMod` | Windows/Command key |
| Shift | `Shift` | Shift key |
| Control | `Ctrl` or `Control` | Control key |
| Alt | `Alt` or `Mod1` | Alt key |

### Modifier Combinations

- `SUPER + X` - Primary action
- `SUPER + Shift + X` - Related/inverse action
- `Ctrl + X` - Usually within an application (tmux, neovim)
- `Alt + X` - System-level alternative

## Learning Strategy

Don't try to memorize everything at once! Follow this progression:

### Week 1: Core Essentials (10 keybinds)
1. `SUPER + Return` - Open terminal
2. `SUPER + Space` - Launch apps
3. `SUPER + B` - Open browser
4. `SUPER + w` - Close window
5. `SUPER + 1/2/3` - Switch workspaces
6. `SUPER + h/l` - Move focus left/right
7. `SUPER + F` - Fullscreen
8. `SUPER + Shift + C` - Lock screen
9. `Print` - Screenshot
10. `SUPER + Shift + R` - Restart UI (if things break)

### Week 2: Window Management (8 keybinds)
1. `SUPER + j/k` - Move focus up/down
2. `SUPER + Shift + h/j/k/l` - Swap windows
3. `SUPER + V` - Toggle floating
4. `SUPER + Y` - Toggle split
5. `SUPER + Shift + 1/2/3` - Move window to workspace
6. `SUPER + +/-` - Resize window
7. `SUPER + E` - File manager
8. `SUPER + Shift + N` - Notifications

### Week 3: Terminal & Tmux (10 keybinds)
1. `Ctrl-Space + v` - Tmux vertical split
2. `Ctrl-Space + s` - Tmux horizontal split
3. `Ctrl-Space + h/j/k/l` - Tmux navigation
4. `Ctrl-Space + d` - Tmux detach
5. `Alt + h/l` - Switch tmux windows
6. `Ctrl-q` - Close tmux pane
7. `Ctrl-Space + i` - Cheat sheet
8. `Ctrl-Space + n` - Brain notes
9. `SUPER + Shift + Return` - Floating terminal
10. `SUPER + Shift + Space` - Theme switcher

### Week 4: Advanced & Customization
- Neovim keybinds for editing
- Custom utility scripts
- Creating your own keybinds
- Workspace-specific workflows

## Keybind Conflicts

sokratOS tries to avoid conflicts, but be aware:

### System vs Application

- **System keybinds** (SUPER-based) work everywhere
- **Application keybinds** (Ctrl-based) only work in that app
- If they conflict, system keybinds take precedence

### Common Conflicts

| Conflict | Resolution |
|----------|------------|
| `SUPER + Space` in Firefox | Use `SUPER + B` to open Firefox, then use mouse for search |
| `Ctrl-Space` in other terminals | Only affects you if you don't use tmux |
| Browser shortcuts | Most work normally; system shortcuts take precedence |

## Customizing Keybinds

All keybinds can be customized! See where they're defined:

### Hyprland Keybinds
**File**: `~/.config/hypr/configs/bindings.conf`
**File**: `~/.config/hypr/configs/tiling.conf`

```conf
# Add your own keybind
bind = SUPER, T, exec, kitty
```

[Learn more: Hyprland Keybinds](hyprland.md)

### Tmux Keybinds
**File**: `~/.tmux.conf`

```conf
# Add your own keybind
bind-key g run-shell "tmux neww lazygit"
```

[Learn more: Tmux Keybinds](tmux.md)

### Neovim Keybinds
**File**: `~/.config/nvim/lua/brouzie/core/keymaps.lua`

```lua
-- Add your own keybind
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
```

[Learn more: Neovim Keybinds](neovim.md)

## Discovering Keybinds

### In Hyprland

View all Hyprland keybinds:
```bash
cat ~/.config/hypr/configs/bindings.conf
cat ~/.config/hypr/configs/tiling.conf
```

### In Tmux

View all tmux keybinds:
```bash
# In tmux
tmux list-keys

# Or in tmux
Ctrl-Space + ?
```

### In Neovim

View keybinds in neovim:
```vim
:map      " Normal mode mappings
:imap     " Insert mode mappings
:vmap     " Visual mode mappings
```

Or use the leader key and wait - WhichKey will show options.

## Cheat Sheets

### Built-in Cheat Sheet

In tmux, press `Ctrl-Space + i` to open an interactive cheat sheet.

This uses `cheat.sh` to provide quick command references.

### PDF Cheat Sheet (Coming Soon)

A printable PDF reference will be available at `docs/cheatsheet.pdf`.

## Muscle Memory Tips

1. **Use them daily** - Force yourself to use keybinds instead of mouse
2. **One at a time** - Add one new keybind to your routine each day
3. **Post-it notes** - Put reminders on your monitor
4. **Practice sessions** - Spend 5 minutes just practicing window management
5. **Disable mouse** (extreme) - Force keyboard-only usage for an hour

## Next Steps

Dive deep into specific keybind categories:

- **[Hyprland Keybinds](hyprland.md)** - Complete window management reference
- **[Terminal Apps](terminal-apps.md)** - System-wide application shortcuts
- **[Tmux Keybinds](tmux.md)** - Terminal multiplexer shortcuts
- **[Neovim Keybinds](neovim.md)** - Text editor shortcuts
- **[Apps and Launchers](apps-and-launchers.md)** - UI component shortcuts

## Additional Resources

- [File Locations](../05-reference/file-locations.md) - Where keybind configs are stored
- [Workflows](../03-workflows/window-management.md) - How to use keybinds effectively
- [Customization Guide](../04-tweaking-and-theming/theme-switcher.md) - Making it your own

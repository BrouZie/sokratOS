---
id: first-boot-tour
title: First Boot Tour
tags: [getting-started, tutorial, first-boot, guide]
---

# First Boot Tour

Welcome to sokratOS! This guide will walk you through your first experience and help you get oriented.

## Recommended steps

1. Fix your monitor setup in `~/.config/hypr/configs/monitors.conf`
2. [Install pywalfox](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/)
3. Change wallpaper with `SUPER + SHIFT + Space`

## What to Expect on First Boot

After installation and reboot, you'll be automatically logged into Hyprland. Here's what you'll see:

1. **Wallpaper** - A default wallpaper from `~/Pictures/wallpaper/`
2. **Waybar** - Status bar at the top showing:
   - Workspaces (1-10)
   - Window title
   - Audio volume
   - Network status
   - Date and time
3. **Welcome Message** - A terminal window with a welcome message

## Your First 5 Minutes

### 1. Open a Terminal (2 seconds)

Press `SUPER + Return` (SUPER is the Windows key)

You should see the **Kitty** terminal appear with the current theme colors.

**Congratulations!** You just used your first keybind.

### 2. Launch an Application (5 seconds)

Press `SUPER + Space`

The **Rofi launcher** appears. Type "firefox" and press Enter.

Firefox will open. You now know how to launch any application!

### 3. Navigate Workspaces (10 seconds)

Workspaces are like virtual desktops. Try these:

- `SUPER + 1` - Go to workspace 1
- `SUPER + 2` - Go to workspace 2
- `SUPER + 3` - Go to workspace 3

Notice Firefox is still on workspace 2 (where you opened it).

**Tip**: You can have different applications on different workspaces for organization.

### 4. Move Between Windows (15 seconds)

Open another terminal with `SUPER + Return`.

Now try:
- `SUPER + h` - Focus window to the left
- `SUPER + l` - Focus window to the right
- `SUPER + j` - Focus window below
- `SUPER + k` - Focus window above

These vim-like keys make window navigation second nature!

> [!NOTE]
> If you are new to vim-motions start learning på typing `vimtutor` into your
> terminal!

### 5. Close a Window (20 seconds)

Press `SUPER + w` to close the currently focused window.

Want to force-close a frozen window? Use `SUPER + Shift + w`.

## Essential Keybinds to Remember

Here are the keybinds you'll use most often:

| Keybind | Action |
|---------|--------|
| `SUPER + Return` | Open terminal |
| `SUPER + Space` | Open application launcher |
| `SUPER + w` | Close window |
| `SUPER + 1-9` | Switch to workspace 1-9 |
| `SUPER + h/j/k/l` | Move focus between windows |
| `SUPER + Shift + C` | Lock screen |
| `SUPER + B` | Open Firefox |
| `SUPER + E` | Open file manager (Nautilus) |

> 💡 **Tip**: Take a picture of this table or keep it handy for your first week!

## Theme System Overview

### Generating Theme from Wallpaper

Want a theme that matches your wallpaper?

1. Press `SUPER + Shift + Space` (to select a wallpaper)
2. Choose a wallpaper image with arrow keys (`ctrl + p/n` for chads)
3. The theme is automatically generated using **matugen**
4. Add your own images to `~/Pictures/wallpaper/user_wallpaper.png`
    - All images in the mentioned directory are picked up by the theme-switcher
      script/keybind

The system analyzes the wallpaper colors and picks the best matching pre-configured theme!

## Common Tasks

### Opening Programs

**Firefox**: `SUPER + b`

**Canvas**: `SUPER + c`

**File Manager**: `SUPER + e`

**Any Application**: 
1. `SUPER + Space`
2. Type the application name
3. Press Enter

### Multiple Workspaces Workflow

Here's a typical workflow:

- **Workspace 1**: Web browser
- **Workspace 2**: Terminal/code editor
- **Workspace 3**: Documentation
- **Workspace 4**: Music/background apps

To move a window to another workspace:
1. Focus the window
2. Press `SUPER + Shift + <number>` (e.g., `SUPER + Shift + 3` for workspace 3)

### Floating Windows

Some windows (like calculators or settings dialogs) work better floating:

1. Focus the window
2. Press `SUPER + V` to toggle floating mode
3. Drag it with `SUPER + Left Mouse Button`
4. Resize it with `SUPER + Right Mouse Button`

### Fullscreen Mode

Need to focus? Press `SUPER + F` to make the current window fullscreen.

Press `SUPER + F` again to exit fullscreen.

## Exploring the Terminal

Open a terminal (`SUPER + Return`) and try these commands:

```bash
# Show system information with beautiful display
fastfetch

# List files with colors and icons
ls -la

# System monitor with beautiful UI
btop

# Audio visualizer (play some music first!)
cava
```

These are just a few of the CLI tools included in sokratOS!

## Starting Tmux

Tmux is a terminal multiplexer - it lets you have multiple terminal panes:

```bash
# Start tmux
tmux
```

In tmux:
- `Ctrl-Space + v` - Split vertically
- `Ctrl-Space + s` - Split horizontally
- `Ctrl-Space + h/j/k/l` - Navigate between panes
- `Ctrl-Space + d` - Detach from session

See the [Tmux Guide](../02-keybinds/tmux.md) for more!

## Opening Neovim

Neovim is your pre-configured code editor:

```bash
# Open neovim
nvim
```

Or open a file:
```bash
nvim myfile.txt
```

In neovim:
- `Space + e` - Open file explorer
- `Space + w` - Save file
- `Space + q` - Quit
- `:q!` - Quit without saving

See the [Neovim Guide](../02-keybinds/neovim.md) for complete keybinds!

## Checking Notifications

Press `SUPER + Shift + N` to toggle the notification center.

This shows recent notifications and lets you manage them.

## Locking Your Screen

Press `SUPER + Shift + C` to lock your screen.

Your password is required to unlock.

## Taking Screenshots

- `Print Screen` - Select area to screenshot
- `SUPER + Print` - Quick light recorder
- `SUPER + Shift + Print` - Advanced recording options

Screenshots are saved to `~/Pictures/` by default.

## Accessing the Status Bar

The Waybar at the top shows:

**Left Side**:
- Workspaces (click to switch)
- Active window title

**Right Side**:
- System tray
- Volume (click to adjust)
- Network (click for options)
- Clock (shows date/time)

**Right-click** on Waybar to reload it: `SUPER + R`

## File Manager Basics

Open the file manager with `SUPER + E` (Nautilus).

Navigate your files with a familiar GUI interface.

## Custom Utilities

sokratOS includes several custom scripts:

- `sokratos-themes` - Interactive theme selector
- `sokratos-next-theme` - Pick wallpaper and generate theme
- `sokratos-focus-mode` - Minimal distraction mode
- `sokratos-night-mode` - Toggle night light
- `sokratos-floaterminal` - Floating terminal window
- `sokratos-cheat-sheet` - Quick command reference
- `refresh-app-daemons` - Restart UI components

Try them from the terminal! See [Scripts Reference](../05-reference/scripts.md) for details.

## Getting Help

### Documentation

- Press **SUPER + i** for the in-system help center (coming soon)
- Read the full docs at [Documentation Index](../index.md)

### Cheat Sheet

Inside tmux, press `Ctrl-Space + i` to open a cheat sheet utility.

### Common Issues

Having problems? Check the [Troubleshooting Guide](../90-troubleshooting/common-issues.md).

## What's Next?

Now that you're familiar with the basics:

### Learn More Keybinds
- [Hyprland Keybinds](../02-keybinds/hyprland.md) - Window management
- [Tmux Keybinds](../02-keybinds/tmux.md) - Terminal multiplexing
- [Neovim Keybinds](../02-keybinds/neovim.md) - Code editing

### Master Your Workflow
- [Coding Workflow](../03-workflows/coding-workflow.md) - Development tips
- [Window Management](../03-workflows/window-management.md) - Organizing your workspace

### Customize Your Setup
- [Theme Switcher Deep Dive](../04-tweaking-and-theming/theme-switcher.md)
- [Waybar Configuration](../04-tweaking-and-theming/waybar.md)
- [Adding Your Own Keybinds](../05-reference/file-locations.md)

## Pro Tips

1. **Don't memorize everything** - Focus on the essential keybinds first
2. **Use workspaces** - Organize by task (coding, browsing, chat, etc.)
3. **Try the themes** - Find one that's comfortable for your eyes
4. **Explore gradually** - You don't need to learn everything at once
5. **Check the docs** - Each section has detailed guides

## Welcome to the Community!

You're now part of the sokratOS community. Enjoy your setup and happy tiling!

**Questions or feedback?** Open an issue on the [GitHub repository](https://github.com/BrouZie/sokratOS).

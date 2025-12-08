---
id: terminal-apps-keybinds
title: Terminal Apps Keybinds
tags: [keybinds, terminal, applications, utilities]
---

# Terminal Apps Keybinds

System-wide keybinds for launching terminal applications and utilities in sokratOS.

These keybinds work anywhere in Hyprland and are defined in `~/.config/hypr/configs/bindings.conf`.

## Application Launchers

### Core Applications

| Keybind | Application | Description |
|---------|-------------|-------------|
| `SUPER + Return` | Kitty terminal | Open standard terminal window |
| `SUPER + Shift + Return` | Floating terminal | Open floating Kitty window |
| `SUPER + B` | Firefox | Open web browser |
| `SUPER + E` | Nautilus | Open file manager |
| `SUPER + Space` | Rofi | Application launcher menu |

**Defined in**: `~/.config/hypr/configs/bindings.conf`

### Why These Keys?

- **Return/Enter**: Natural for terminal (entering commands)
- **B**: Browser
- **E**: Explorer (file manager)
- **Space**: Central key, easy to reach for launching anything

## sokratOS Custom Utilities

Custom scripts that enhance your workflow:

### Theme Management

| Keybind | Script | Description |
|---------|--------|-------------|
| `SUPER + Shift + Space` | `sokratos-next-theme` | Select wallpaper and apply theme |
| `SUPER + Shift + P` | `sokratos-themes` | Quick theme switcher menu |

**Script locations**: `~/.local/share/sokratOS/bin/`

**How they work**:
- `sokratos-next-theme`: Opens Rofi with wallpapers, generates theme with matugen
- `sokratos-themes`: Opens Rofi with 11 pre-configured themes

[Learn more: Theme Switcher Guide](../04-tweaking-and-theming/theme-switcher.md)

### Screen Recording

| Keybind | Script | Description |
|---------|--------|-------------|
| `Print` | Hyprshot | Screenshot selected area |
| `SUPER + Print` | `sokratos-light-recorder` | Quick screen recording |
| `SUPER + Shift + Print` | `sokratos-wf-recorder` | Advanced recording with options |

**What they do**:
- **Print**: Select area with mouse, saves PNG to `~/Pictures/`
- **Light recorder**: Quick recording toggle
- **Full recorder**: Choose region, duration, with/without audio

### Utilities

| Keybind | Script | Description |
|---------|--------|-------------|
| `SUPER + Shift + X` | Hyprpicker | Color picker (copies hex to clipboard) |
| `SUPER + R` | Waybar reload | Reload status bar |
| `SUPER + Shift + R` | `refresh-app-daemons` | Restart Waybar + SwayNC |
| `SUPER + Shift + N` | SwayNC | Toggle notification center |

**Use cases**:
- **Color picker**: Design work, theming, web development
- **Refresh daemons**: When UI components stop responding
- **Notifications**: Check recent notifications, manage them

## Quick Website Access

Open specific websites directly in Firefox:

| Keybind | Website | Customization |
|---------|---------|---------------|
| `SUPER + A` | ChatGPT | Change to your preferred AI assistant |
| `SUPER + G` | GitHub | Keep or change to GitLab, etc. |
| `SUPER + C` | Canvas LMS | Change to your university/school portal |
| `SUPER + Shift + B` | Bash devhints | Change to your favorite cheat sheet |

**Defined in**: `~/.config/hypr/configs/bindings.conf` lines 25-28

### Customizing Quick Links

Edit `~/.config/hypr/configs/bindings.conf`:

```conf
# Replace with your own links
bind = $mainMod, A, exec, firefox "https://your-favorite-site.com"
bind = $mainMod, G, exec, firefox "https://gitlab.com"
bind = $mainMod, C, exec, firefox "https://your-school-portal.edu"
```

**Ideas for quick links**:
- Email (Gmail, Outlook, ProtonMail)
- Productivity tools (Notion, Trello, Asana)
- Social media
- Documentation sites
- Your own projects

## Additional Utilities (No Keybinds)

These utilities don't have default keybinds but can be run from terminal:

### Focus and Productivity

```bash
# Minimize distractions - removes gaps, animations, kills waybar
sokratos-focus-mode

# Toggle night light (reduces blue light)
sokratos-night-mode

# Floating terminal (useful in scripts)
sokratos-floaterminal

# Quick command reference
sokratos-cheat-sheet
```

### Development Utilities

```bash
# Brain note-taking utilities (used with tmux keybinds)
braincreate-tmux
brainsearch-tmux
brain-sort

# Project sessionizer (tmux sessions for projects)
rofi-sessionizer

# Session management
session-toggle
github-tmux
```

[Learn more: Scripts Reference](../05-reference/scripts.md)

## Adding Your Own Application Keybinds

### Simple Application Launch

Edit `~/.config/hypr/configs/bindings.conf`:

```conf
# Launch your favorite terminal app
bind = SUPER, H, exec, kitty -e htop

# Launch GUI application
bind = SUPER, D, exec, discord

# Launch with specific flags
bind = SUPER, M, exec, kitty -e ncmpcpp
```

### Launch in Floating Mode

For apps that work better floating:

```conf
# Use sokratos-floaterminal helper
bind = SUPER, P, exec, sokratos-floaterminal htop

# Or specify class directly
bind = SUPER, C, exec, kitty --class kitty-float -e cava
```

Then ensure a window rule exists in `~/.config/hypr/configs/windowrules.conf`:

```conf
windowrulev2 = float, class:^(kitty-float)$
windowrulev2 = size 800 600, class:^(kitty-float)$
```

### Launch on Specific Workspace

```conf
# Launch and move to workspace 3
bind = SUPER, I, exec, [workspace 3] firefox
```

## CLI Tools Quick Reference

While these don't have keybinds, they're worth knowing:

### System Information

```bash
fastfetch           # System info with beautiful display
btop                # System monitor
htop                # Alternative system monitor
```

### File Management

```bash
eza                 # Modern ls replacement
eza -la             # List all files with icons
eza --tree          # Tree view
```

### Media

```bash
cava                # Audio visualizer (play music first!)
```

### Development

```bash
docker              # Container management
docker-compose      # Multi-container apps
```

## Rofi Application Launcher Usage

`SUPER + Space` opens Rofi, then:

1. **Type to search**: Start typing an application name
2. **Arrow keys**: Navigate results
3. **Enter**: Launch selected application
4. **Escape**: Cancel

### Rofi Tips

- Type partial names: "fire" finds Firefox
- Case insensitive: "FIREFOX" = "firefox"
- Fuzzy matching: "frfx" might find Firefox
- Recent apps appear first

### Rofi Modes

By default, Rofi shows installed applications. Access other modes:

```bash
# Show running windows
rofi -show window

# Run arbitrary command
rofi -show run

# SSH connections (if configured)
rofi -show ssh
```

Add keybinds for these in `bindings.conf`:

```conf
bind = SUPER ALT, Space, exec, rofi -show run
bind = SUPER, Tab, exec, rofi -show window
```

## System Integration

### Desktop Files

Applications in Rofi come from `.desktop` files:

- System: `/usr/share/applications/`
- User: `~/.local/share/applications/`

Create custom launchers by adding `.desktop` files to user directory.

### Example Custom Desktop File

`~/.local/share/applications/my-script.desktop`:

```desktop
[Desktop Entry]
Name=My Custom Script
Comment=Does something cool
Exec=/path/to/my-script.sh
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Utility;
```

Now it appears in Rofi!

## Troubleshooting

### Application Won't Launch

1. **Test in terminal**:
   ```bash
   firefox
   ```

2. **Check if installed**:
   ```bash
   which firefox
   ```

3. **Check keybind syntax**:
   ```bash
   grep "SUPER, B" ~/.config/hypr/configs/bindings.conf
   ```

### Rofi Not Showing Application

1. **Check desktop file exists**:
   ```bash
   ls /usr/share/applications/ | grep -i firefox
   ```

2. **Rebuild cache** (sometimes needed):
   ```bash
   # Rofi automatically updates, but force if needed
   pkill rofi
   rofi -show drun
   ```

### Script Not Found

If `sokratos-*` commands don't work:

```bash
# Check they exist
ls ~/.local/share/sokratOS/bin/

# Check PATH includes the directory
echo $PATH | grep sokratOS

# Add to PATH if missing (in ~/.bashrc)
export PATH="$HOME/.local/share/sokratOS/bin:$PATH"
```

## Next Steps

- **[Tmux Keybinds](tmux.md)** - Terminal multiplexer shortcuts
- **[Scripts Reference](../05-reference/scripts.md)** - Detailed script documentation
- **[Customization Guide](../04-tweaking-and-theming/rofi.md)** - Customize Rofi appearance
- **[Workflow Guide](../03-workflows/terminal-workflow.md)** - Efficient terminal usage

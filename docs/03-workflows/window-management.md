---
id: window-management-workflow
title: Window Management Workflow
tags: [workflow, hyprland, windows, workspaces, tiling]
---

# Window Management Workflow

Master window management in sokratOS using Hyprland's tiling capabilities.

## Core Concepts

### Workspaces as Task Containers

Think of workspaces as dedicated spaces for different activities:

```
Workspace 1: Communication (browser, email, chat)
Workspace 2: Development (editor, terminals)
Workspace 3: Documentation (PDFs, browser, notes)
Workspace 4: Media (music, videos)
```

**Switch with**: `SUPER + 1-9`

### Windows Tile Automatically

New windows automatically split available space:
- First window: Full screen
- Second window: 50/50 split
- Third+ windows: Recursive splits

**Control splitting**: `SUPER + Y` toggles split direction

## Essential Patterns

### Pattern 1: Single Focus Window

For tasks requiring full attention:

```bash
# Open application
SUPER + Return    # Terminal
# or
SUPER + B         # Browser

# Make fullscreen
SUPER + F
```

**Use case**: Reading, presentations, video calls

### Pattern 2: Side-by-Side

Two windows sharing space:

```bash
# Open first window
SUPER + Return

# Open second window
SUPER + Return

# Navigate between them
SUPER + h/l
```

**Result**:
```
┌──────────┬──────────┐
│          │          │
│   Left   │  Right   │
│          │          │
└──────────┴──────────┘
```

**Use case**: Reference + work (docs + code, tutorial + practice)

### Pattern 3: Main + Stack

One large window + several small ones:

```bash
# Open main window
SUPER + Return

# Open second window (splits right)
SUPER + Return

# Focus right pane, open third window (splits bottom)
SUPER + l
SUPER + Return
```

**Result**:
```
┌─────────────┬──────┐
│             │  2   │
│      1      ├──────┤
│    Main     │  3   │
└─────────────┴──────┘
```

**Use case**: Coding (editor + tests + server logs)

### Pattern 4: Grid Layout

Four equal windows:

```bash
# Open four windows, adjusting splits as needed
SUPER + Return  # 1st
SUPER + Return  # 2nd
SUPER + l       # Focus right
SUPER + Return  # 3rd
SUPER + Return  # 4th

# Manual resize if needed
SUPER + +/-
SUPER + Shift + +/-
```

**Result**:
```
┌──────┬──────┐
│  1   │  2   │
├──────┼──────┤
│  3   │  4   │
└──────┴──────┘
```

**Use case**: Monitoring (logs, metrics, dashboards)

## Window Operations

### Moving Windows

**Focus navigation**:
```bash
SUPER + h    # Focus left
SUPER + j    # Focus down
SUPER + k    # Focus up
SUPER + l    # Focus right
```

**Swap windows**:
```bash
SUPER + Shift + h    # Swap left
SUPER + Shift + j    # Swap down
SUPER + Shift + k    # Swap up
SUPER + Shift + l    # Swap right
```

**Workflow**:
1. Focus window you want to move
2. Press `SUPER + Shift + <direction>`
3. Window swaps with neighbor

### Resizing Windows

**Quick resize**:
```bash
SUPER + +          # Wider
SUPER + -          # Narrower
SUPER + Shift + +  # Taller
SUPER + Shift + -  # Shorter
```

**Precise resize** (with mouse):
```bash
# Move to window edge
# SUPER + Right Click Drag
```

### Window States

```bash
SUPER + F    # Fullscreen (no bar)
SUPER + V    # Floating (move freely)
SUPER + Y    # Toggle split direction
SUPER + P    # Pseudo-tiling (dwindle)
```

## Workspace Management

### Organizing by Task

**Example organization**:

```
1: Communication
   - Firefox (email, chat)
   - Discord
   - Slack

2: Development
   - Neovim
   - 2-3 terminals

3: Documentation
   - Browser (docs)
   - Zathura (PDFs)
   - Notes

4: Testing
   - Browser (app preview)
   - Terminals (servers, logs)

5: Media
   - Spotify
   - YouTube
```

### Moving Windows Between Workspaces

```bash
# Focus window to move
# Press SUPER + Shift + <workspace number>

# Example: Move Firefox to workspace 1
SUPER + Shift + 1
```

**Note**: Window moves but you stay on current workspace.

**Follow the window**:
```bash
# Move window
SUPER + Shift + 3

# Jump to that workspace
SUPER + 3
```

### Workspace Navigation

**Direct jump**:
```bash
SUPER + 1    # Workspace 1
SUPER + 2    # Workspace 2
# etc...
```

**With mouse** (on Waybar):
- Click workspace number

**Scroll through** (with mouse):
```bash
SUPER + Scroll Up     # Next workspace
SUPER + Scroll Down   # Previous workspace
```

## Floating Windows

Some windows work better floating:

### When to Float

- Calculator
- Settings dialogs
- Picture-in-picture
- Quick terminals
- Small utilities

### Making Windows Float

**Toggle current window**:
```bash
SUPER + V
```

**Launch as floating**:
```bash
# Use floating terminal helper
SUPER + Shift + Return

# Or launch any app floating
sokratos-floaterminal <command>
```

**Move floating windows**:
```bash
# SUPER + Left Mouse Drag
```

**Resize floating windows**:
```bash
# SUPER + Right Mouse Drag
```

### Floating Window Rules

Some windows float automatically (defined in `windowrules.conf`):
- File pickers
- Notification popups
- Some dialog boxes

## Multi-Monitor Setup

### Configure Monitors

Edit `~/.config/hypr/configs/monitors.conf`:

```conf
# Syntax: monitor=name,resolution@refresh,position,scale
monitor=DP-1,1920x1080@144,0x0,1
monitor=DP-2,1920x1080@60,1920x0,1
```

**Find monitor names**:
```bash
hyprctl monitors
```

### Workspace-Monitor Binding

```conf
# Bind workspaces to specific monitors
workspace=1,monitor:DP-1
workspace=2,monitor:DP-1
workspace=3,monitor:DP-2
workspace=4,monitor:DP-2
```

**Use case**: Keep communication on second monitor, work on primary.

### Moving Windows Between Monitors

```bash
# Move to workspace on other monitor
SUPER + Shift + <workspace number>
```

## Advanced Workflows

### Dynamic Workspace Switching

**Quick toggle pattern**:
```bash
# Work on workspace 2
SUPER + 2

# Quick check workspace 1
SUPER + 1

# Back to workspace 2
SUPER + 2
```

**Recent workspaces**: Hyprland remembers recent workspace, making toggling fast.

### Special Workspaces (Scratchpad)

Enable in `~/.config/hypr/configs/bindings.conf`:

```conf
# Uncomment these lines:
bind = $mainMod, W, togglespecialworkspace, magic
bind = $mainMod SHIFT, W, movetoworkspace, special:magic
```

**Usage**:
```bash
# Move window to scratchpad
SUPER + Shift + W

# Toggle scratchpad visibility
SUPER + W
```

**Use case**: Calculator, music player, notes - always accessible.

### Workspace Persistence

Windows stay on workspaces even when you switch away:
- Leave terminals running on workspace 2
- Check browser on workspace 1
- Return to workspace 2, terminals still there

### Empty Workspace Behavior

Hyprland auto-removes empty workspaces:
- Close all windows on workspace 3
- Workspace 3 disappears
- Workspaces renumber automatically (if configured)

**Keep numbering sequential**: Set in `~/.config/hypr/hyprland.conf`

## Real-World Scenarios

### Scenario 1: Web Development

```bash
Workspace 1: Code
  - Neovim (fullscreen or split)
  - Terminal (if split)

Workspace 2: Preview
  - Browser with dev tools
  - Another browser for mobile view

Workspace 3: Reference
  - Documentation browser
  - Design mockups
```

**Workflow**:
```bash
# Write code
SUPER + 1

# Check result
SUPER + 2

# Look up docs
SUPER + 3

# Back to code
SUPER + 1
```

### Scenario 2: Research & Writing

```bash
Workspace 1: Writing
  - Neovim (or LibreOffice)
  - Fullscreen, no distractions

Workspace 2: Research
  - Browser with multiple tabs
  - PDF reader (Zathura)

Workspace 3: Notes
  - Note-taking app
  - Mind mapping tool
```

### Scenario 3: System Administration

```bash
Workspace 1: Monitoring
  - btop (system monitor)
  - docker stats
  - tail -f logs

Workspace 2: Work
  - SSH sessions to servers
  - Configuration editing

Workspace 3: Documentation
  - Man pages
  - Wiki/docs
```

### Scenario 4: Video Editing

```bash
Workspace 1: Editor
  - DaVinci Resolve (fullscreen)

Workspace 2: Preview
  - Media player (test renders)

Workspace 3: Assets
  - File manager with footage
  - Browser (music licensing)
```

## Productivity Tips

### 1. Consistent Workspace Usage

Train muscle memory:
- Always code on workspace 2
- Always browse on workspace 1
- Always chat on workspace 3

Becomes automatic: `SUPER + 2` = code time

### 2. Close Unused Windows

Keep workspaces clean:
```bash
SUPER + w    # Close window
```

Fewer windows = easier navigation.

### 3. Use Fullscreen for Focus

Deep work requires focus:
```bash
SUPER + F    # Fullscreen current window
```

No distractions, just content.

### 4. Float Transient Windows

Don't let small windows take tiling space:
```bash
SUPER + V    # Toggle floating for calculator, etc.
```

### 5. Name Your Workspaces

While Hyprland uses numbers, mentally name them:
- "1 is communication"
- "2 is code"
- "3 is docs"

## Customization

### Change Window Gaps

Edit `~/.config/hypr/configs/looknfeel.conf`:

```conf
general {
    gaps_in = 10      # Gap between windows
    gaps_out = 20     # Gap from screen edge
}
```

### Change Border Colors

```conf
general {
    col.active_border = $on_primary_container    # Active window border
    col.inactive_border = $on_primary_fixed      # Inactive window border
    border_size = 2                              # Border thickness
}
```

### Disable Borders

```conf
general {
    border_size = 0
}
```

### Change Layout Algorithm

Default is dwindle, but you can try master:

```conf
general {
    layout = master
}
```

## Troubleshooting

### Windows Not Tiling

1. Check window is not floating:
   ```bash
   SUPER + V    # Toggle floating
   ```

2. Check layout is enabled:
   ```bash
   hyprctl getoption general:layout
   ```

### Can't Move Window

1. Ensure window is focused (visible border)
2. Use swap instead of move:
   ```bash
   SUPER + Shift + h/j/k/l
   ```

### Workspace Empty After Reboot

Hyprland doesn't restore windows after reboot.

**Solution**: Use autostart for important apps.

Edit `~/.config/hypr/configs/autostart.conf`:
```conf
exec-once = firefox
exec-once = kitty
```

### Window Rules Not Working

Check rule syntax:
```bash
# View window info
hyprctl clients

# Test rule
windowrulev2 = float, class:^(calculator)$
```

## Next Steps

- **[Coding Workflow](coding-workflow.md)** - Development-focused usage
- **[Terminal Workflow](terminal-workflow.md)** - Command-line mastery
- **[Hyprland Keybinds](../02-keybinds/hyprland.md)** - Complete keybind reference
- **[File Locations](../05-reference/file-locations.md)** - Where configs live

## Additional Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Tiling Window Manager Concepts](https://en.wikipedia.org/wiki/Tiling_window_manager)
- [r/unixporn](https://reddit.com/r/unixporn) - Workflow inspiration

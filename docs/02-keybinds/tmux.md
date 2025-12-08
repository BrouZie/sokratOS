---
id: tmux-keybinds
title: Tmux Keybinds
tags: [tmux, keybinds, terminal, multiplexer]
---

# Tmux Keybinds

Complete reference for Tmux keybindings in sokratOS.

## Prefix Key

sokratOS uses **`Ctrl-Space`** as the tmux prefix instead of the default `Ctrl-b`.

```conf
set -g prefix C-space
```

**Why `Ctrl-Space`?**
- More ergonomic than `Ctrl-b`
- Doesn't conflict with vim/neovim bindings
- Easy to press with one hand

**Defined in**: `~/.tmux.conf`

## How to Use Tmux Keybinds

Most tmux keybinds require the **prefix** first:

1. Press `Ctrl-Space` (prefix)
2. Release both keys
3. Press the command key

Example: `Ctrl-Space + v` means:
1. Hold `Ctrl`, press `Space`, release both
2. Press `v`

Some keybinds are **prefix-free** (marked with `Direct` below).

## Essential Tmux Commands

### Session Management

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-Space + d` | Detach | Leave tmux session running in background |
| Direct: `Ctrl-q` | Kill pane | Close current pane |

**Detaching vs Killing**:
- **Detach** (`Ctrl-Space + d`): Session keeps running, you can reattach later
- **Kill pane** (`Ctrl-q`): Closes the pane/window permanently

**Reattach to session**:
```bash
tmux attach
# or
tmux a
```

**List sessions**:
```bash
tmux ls
```

### Pane Management (Splits)

Create multiple terminal panes in one window:

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-Space + v` | Vertical split | Split pane vertically (side by side) |
| `Ctrl-Space + s` | Horizontal split | Split pane horizontally (top/bottom) |

**Defined in**: `~/.tmux.conf` lines 56-57

**Remember**: 
- `v` for **Vertical** line (creates left|right split)
- `s` for **Stacked** or **Split** horizontally (creates top/bottom split)

### Pane Navigation

Move between panes using vim keys:

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-Space + h` | Navigate left | Focus pane to the left |
| `Ctrl-Space + j` | Navigate down | Focus pane below |
| `Ctrl-Space + k` | Navigate up | Focus pane above |
| `Ctrl-Space + l` | Navigate right | Focus pane to the right |

**Defined in**: `~/.tmux.conf` lines 59-62

**Vim users**: Same as vim navigation! `h/j/k/l`

### Window Management

Windows are like tabs - each can contain multiple panes:

| Keybind | Action | Description |
|---------|--------|-------------|
| Direct: `Alt + h` | Previous window | Switch to previous window (tab) |
| Direct: `Alt + l` | Next window | Switch to next window (tab) |
| Direct: `Ctrl-q` | Kill pane | Close current pane |

**Defined in**: `~/.tmux.conf` lines 63-64, 66

**Creating new windows**:
```bash
# From command line (not a keybind)
Ctrl-Space + c
```

## Configuration and Reload

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-Space + r` | Reload config | Reload `~/.tmux.conf` |

**Defined in**: `~/.tmux.conf` line 3

**When to use**: After editing `~/.tmux.conf`, reload without restarting tmux.

## sokratOS Custom Utilities

Special keybinds for sokratOS productivity scripts:

| Keybind | Script | Description |
|---------|--------|-------------|
| `Ctrl-Space + i` | `sokratos-cheat-sheet` | Interactive command cheat sheet |
| `Ctrl-Space + n` | `braincreate-tmux` | Create/manage notes in new window |

**Defined in**: `~/.tmux.conf` lines 69-70

### Cheat Sheet (`Ctrl-Space + i`)

Opens an interactive cheat sheet using `cheat.sh`:

```bash
# Usage after pressing Ctrl-Space + i
# Type a command to see examples:
curl
git commit
```

**Use cases**:
- Quick reference while coding
- Learn new commands
- Recall syntax

### Brain Notes (`Ctrl-Space + n`)

Opens your note-taking system in a new tmux window.

**Use cases**:
- Quick capture of ideas
- Task lists
- Code snippets

## Copy Mode (Scrollback)

View and copy previous terminal output:

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-Space + [` | Enter copy mode | Scroll through history |
| (in copy mode) `Space` | Start selection | Begin text selection |
| (in copy mode) `Enter` | Copy selection | Copy to clipboard and exit |
| (in copy mode) `q` | Quit copy mode | Exit without copying |

**Defined by**: `set -g mode-keys vi` in `~/.tmux.conf` line 49

**Vim-like navigation in copy mode**:
- `h/j/k/l` - Move cursor
- `w/b` - Word forward/backward
- `gg/G` - Top/bottom
- `/` - Search
- `v` - Start visual selection (alternative to Space)

## Mouse Support

sokratOS tmux has mouse support enabled:

```conf
set -g mouse on
```

**What you can do with mouse**:
- Click panes to focus them
- Drag pane borders to resize
- Scroll to view history (enters copy mode automatically)
- Click status bar tabs to switch windows

**Tip**: Mouse is convenient, but learning keybinds is faster!

## Status Bar Information

The tmux status bar shows:

**Left side**:
- `PREFIX` indicator (when prefix key is pressed)
- Session name (e.g., `#S`)

**Center**:
- Window list (current window highlighted)
- `Z` indicator if pane is zoomed

**Right side**:
- Current directory path (abbreviated)

## Advanced Features

### Zoom Pane

Temporarily make one pane fullscreen:

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-Space + z` | Toggle zoom | Maximize/restore current pane |

**Use case**: Focus on one pane, then zoom out to see all panes again.

### Resize Panes

No default keybinds, but you can:

**With mouse**: Drag pane borders

**With commands**:
```bash
# Enter command mode
Ctrl-Space + :

# Then type:
resize-pane -L 10    # Resize left 10 cells
resize-pane -R 10    # Resize right 10 cells
resize-pane -U 5     # Resize up 5 cells
resize-pane -D 5     # Resize down 5 cells
```

**Add custom resize keybinds** (edit `~/.tmux.conf`):
```conf
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
```

The `-r` means "repeatable" - you can press `H` multiple times after prefix once.

### Break Pane to Window

Move current pane to its own window:

```bash
Ctrl-Space + !
```

### Join Pane from Window

Move a window into current window as a pane:

```bash
Ctrl-Space + :
join-pane -s 2    # Join window 2 as a pane
```

## Tmux Plugin Manager (TPM)

sokratOS includes TPM for extending tmux:

**Install plugins** (after adding to `~/.tmux.conf`):
```bash
Ctrl-Space + I (capital i)
```

**Update plugins**:
```bash
Ctrl-Space + U
```

**Remove plugins**:
```bash
Ctrl-Space + Alt + u
```

**Plugin location**: `~/.tmux/plugins/`

### Default Plugins

Check `~/.tmux.conf` for pre-installed plugins (if any).

## Integration with Neovim

Navigate seamlessly between tmux panes and neovim splits:

When in neovim:
- `Ctrl-h/j/k/l` works in both tmux and neovim
- Plugin handles detection automatically

This makes tmux + neovim feel like one cohesive environment!

## Customizing Tmux Keybinds

### Add Your Own Keybinds

Edit `~/.tmux.conf`:

```conf
# Add after existing binds

# Open htop in new window
bind-key H new-window htop

# Open project sessionizer
bind-key P run-shell "tmux neww rofi-sessionizer"

# Quick window switching
bind-key -n M-1 select-window -t 1
bind-key -n M-2 select-window -t 2
```

**Reload config**:
```bash
Ctrl-Space + r
```

### Unbind Unwanted Keybinds

```conf
# Remove default keybind
unbind '"'    # Remove default horizontal split
unbind %      # Remove default vertical split
```

### Keybind Syntax

```conf
bind-key [flags] KEY COMMAND [args]

# Flags:
# -r : Repeatable (can press multiple times after one prefix)
# -n : No prefix required (direct keybind)
# -T : Specify key table (e.g., copy-mode-vi)
```

## Tmux Commands Reference

Common commands (press `Ctrl-Space + :` first):

```bash
# Session management
new-session -s name       # Create session
kill-session -t name      # Kill session
rename-session name       # Rename session

# Window management  
new-window                # Create window
kill-window               # Kill window
rename-window name        # Rename window
select-window -t 2        # Switch to window 2

# Pane management
split-window -h           # Vertical split
split-window -v           # Horizontal split
kill-pane                 # Kill pane
swap-pane -U              # Swap with pane above
```

## Troubleshooting

### Prefix Not Working

1. **Check if tmux is running**:
   ```bash
   echo $TMUX
   ```
   Should output a path. If empty, you're not in tmux.

2. **Check prefix key**:
   ```bash
   # Inside tmux
   tmux show-options -g prefix
   ```
   Should show `C-space`.

### Keybind Not Working

1. **List all keybinds**:
   ```bash
   tmux list-keys
   ```

2. **Test keybind**:
   ```bash
   # Bind temporarily
   Ctrl-Space + :
   bind-key t display-message "Test works!"
   ```

3. **Check config syntax**:
   ```bash
   # Reload and watch for errors
   Ctrl-Space + r
   ```

### Colors Look Wrong

Check terminal support:

```bash
echo $TERM
```

Should be `tmux-256color`. If not, add to `~/.bashrc`:

```bash
export TERM=tmux-256color
```

### Clipboard Not Working

Install `xclip` or `wl-clipboard` (for Wayland):

```bash
sudo pacman -S wl-clipboard
```

Then in `~/.tmux.conf`:
```conf
# Use system clipboard
set -s copy-command 'wl-copy'
```

## Workflows and Tips

### Typical Development Session

```bash
# Start tmux
tmux

# Create layout
Ctrl-Space + v    # Vertical split
Ctrl-Space + s    # Horizontal split (on right pane)

# Result:
# ┌─────────┬─────────┐
# │         │         │
# │ Editor  │ Tests   │
# │         ├─────────┤
# │         │ Server  │
# └─────────┴─────────┘
```

### Project Organization

Use one tmux session per project:

```bash
# Create session for project
tmux new -s myproject

# Detach
Ctrl-Space + d

# Create session for another project
tmux new -s otherproject

# List sessions
tmux ls

# Switch between them
tmux attach -t myproject
tmux attach -t otherproject
```

### Quick Notes While Working

```bash
# Open notes system
Ctrl-Space + n

# Take notes, save, close window
Ctrl-Space + d
```

## Next Steps

- **[Neovim Keybinds](neovim.md)** - Text editor shortcuts
- **[Terminal Workflow](../03-workflows/terminal-workflow.md)** - Efficient terminal usage
- **[Coding Workflow](../03-workflows/coding-workflow.md)** - Development with tmux
- **[Scripts Reference](../05-reference/scripts.md)** - Custom utility scripts

## Additional Resources

- [Tmux Official Manual](https://man7.org/linux/man-pages/man1/tmux.1.html)
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [TPM GitHub](https://github.com/tmux-plugins/tpm)

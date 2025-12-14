---
id: coding-workflow
title: Coding Workflow
tags: [workflow, development, coding, tmux, neovim]
---

# Coding Workflow

Efficient development workflows using sokratOS's terminal-centric setup.

## The Terminal-First Approach

sokratOS is built around terminal tools:
- **Hyprland**: Window and workspace management
- **Tmux**: Terminal multiplexing
- **Neovim**: Code editing
- **Kitty**: Fast terminal emulator

This guide shows how to combine them effectively.

## Setting Up a Project

### 1. Create Project Workspace

Use a dedicated workspace for your project:

```bash
# Switch to workspace 2 for coding
SUPER + 2

# Open terminal
SUPER + Return
```

### 2. Start Tmux Session

```bash
# Create named session for project
tmux new -s myproject

# Or rename current session
Ctrl-Space + :
rename-session myproject
```

**Why named sessions?**
- Easy to find and reattach
- Persist between logins
- Organize multiple projects

### 3. Create Development Layout

Set up your ideal layout with tmux splits:

```bash
# Vertical split for editor | terminal
Ctrl-Space + v

# Focus right pane, horizontal split for tests | server
Ctrl-Space + l
Ctrl-Space + s
```

**Result**:
```
┌──────────────┬──────────────┐
│              │              │
│              │  Run/Test    │
│   Neovim     │              │
│              ├──────────────┤
│              │              │
│              │  Server/Logs │
└──────────────┴──────────────┘
```

### 4. Navigate to Project

```bash
# In left pane (editor)
cd ~/projects/myproject
nvim .
```

## Common Development Patterns

### Pattern 1: Full-Screen Editor

For deep focus on code:

```bash
# One terminal, just neovim
tmux
nvim .
```

**Toggle floating terminal in neovim**:
- Open: `space + tt`
- Switch back: `space + tt`

### Pattern 2: Editor + REPL

For interpreted languages (Python, Node.js):

```bash
# Top pane: Editor
nvim main.py

# Bottom pane: REPL/tests
Ctrl-Space + s
python3
# or
node
```

**Workflow**:
1. Write code in top pane
2. Test snippets in bottom REPL
3. Iterate quickly

### Pattern 3: Editor + Watcher + Server

For web development:

```bash
# Pane 1: Editor (left, full height)
nvim .

# Pane 2: Build watcher (top right)
Ctrl-Space + v
Ctrl-Space + l
npm run dev
# or
cargo watch -x run

# Pane 3: Server logs (bottom right)
Ctrl-Space + s
tail -f server.log
```

### Pattern 4: Multi-Service Project

For projects with database, API, frontend:

```bash
# Window 1: Editor
nvim .

# Window 2: Database
Ctrl-Space + c  # new window
docker-compose up postgres

# Window 3: API
Ctrl-Space + c
npm run api

# Window 4: Frontend
Ctrl-Space + c
npm run dev

# Switch windows
Alt + h  # previous
Alt + l  # next
```

## Neovim Workflow

### Opening Files

**Oil.nvim file browser**:
```bash
<leader>e       # Open file browser
Enter           # Open file/directory
-               # Go up one level
```

**Telescope fuzzy finder**:
```bash
<leader>f      # Find files
<leader>g      # Grep text in files
<leader>#      # Find open buffers
```

### Editing Multiple Files

**Splits**:
```bash
<leader>v       # Vertical split
<leader>s       # Horizontal split
<leader>S       # Split with alternate file

# Navigate splits
Ctrl-h/j/k/l    # Move between splits
```

**Buffers**:
```bash
<leader>b       # Switch to alternate buffer
:bnext          # Next buffer
:bprev          # Previous buffer
```

### Code Navigation

**LSP-powered**:
```bash
gd              # Go to definition
gr              # Find references
K               # Hover documentation
<leader>ca      # Code actions
grn             # Group rename variable across workspace
```

**Search**:
```bash
/pattern        # Search forward
n               # Next match
N               # Previous match
<Esc>           # Clear highlights
```

### Git Integration

```bash
<leader>Gs      # Git status (fugitive)
<leader>GG      # Git command

# In git status window:
-               # Stage/unstage file
cc              # Commit
ca              # Commit amend
P               # Push
```

## Debugging Workflow

### Terminal Debugger (GDB)

For C/C++/Rust:

```bash
# Compile with debug symbols
gcc -g myprogram.c -o myprogram

# Start in tmux pane
Ctrl-Space + s
gdb myprogram

# GDB commands
break main
run
next
print variable
```

### Watch Resource Usage

```bash
# Separate workspace for monitoring
SUPER + 3

# System monitor
btop
# or
htop

# Docker stats
docker stats

# Network
nethogs
```

## Version Control Workflow

### Git in Neovim

```bash
# Quick commits
<leader>GS      # Git status
-               # Stage file
cc              # Commit
# Write message, save, close

# View changes
<leader>GG      # Type: diff
```

### Git in Terminal

```bash
# Separate pane for git
Ctrl-Space + s

# Common operations
git status
git add .
git commit -m "message"
git push
git pull --rebase
```

## Workflow Tips

### 1. Persistent Tmux Sessions

```bash
# Start session
tmux new -s project

# Detach (keeps running)
Ctrl-Space + d

# Reattach later
tmux attach -s project

# Make sure tmux-plugins are installed and running
# - sessions are automatically restored being reboot
```

### 2. Focus Mode

```bash
# Minimize distractions
# Work in zen mode
sokratos-focus-mode
```

## Language-Specific Setups

### Python

```bash
# Create virtual environment
uv venv
source venv/bin/activate # Or "svba" (alias)

# Install dependencies
uv pip install -r requirements.txt
uv sync # pyproject.toml provided in repo
```

## Troubleshooting

### Terminal Feels Slow

```bash
# Check if language server is running in background
ps aux | grep -i lsp

# Restart neovim if too many LSP processes
```

### Tmux Panes Not Syncing

```bash
# Reload tmux config
Ctrl-Space + r

# Or restart tmux
tmux kill-server
tmux
```

### Neovim Plugins Not Working

```bash
# In neovim
:Lazy update
:checkhealth
```

## Next Steps

- **[Window Management Workflow](window-management.md)** - Organize your workspace
- **[Terminal Workflow](terminal-workflow.md)** - Master the terminal
- **[Keybinds Reference](../02-keybinds/overview.md)** - All shortcuts
- **[Scripts Reference](../05-reference/scripts.md)** - Custom utilities

## Additional Resources

- [Tmux for Productive Development](https://pragprog.com/titles/bhtmux2/tmux-2/)
- [Neovim from Scratch](https://www.youtube.com/watch?v=ctH-a-1eUME)
- [The Primeagen on YouTube](https://www.youtube.com/@ThePrimeagen) - Vim and tmux tips

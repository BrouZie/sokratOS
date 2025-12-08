---
id: terminal-workflow
title: Terminal Workflow
tags: [workflow, terminal, cli, bash, tools]
---

# Terminal Workflow

Master terminal-based workflows in sokratOS for maximum efficiency.

## Philosophy

sokratOS is terminal-centric because:
- **Speed**: Keyboard is faster than mouse
- **Scriptability**: Automate repetitive tasks
- **Remote work**: SSH-friendly workflows
- **Low resource**: Terminal apps are lightweight
- **Composability**: Combine tools with pipes

## Essential Terminal Tools

### Installed in sokratOS

| Tool | Purpose | Launch |
|------|---------|--------|
| `kitty` | Terminal emulator | `SUPER + Return` |
| `bash` | Shell | Default shell |
| `tmux` | Terminal multiplexer | `tmux` |
| `nvim` | Text editor | `nvim` |
| `eza` | File listing | `eza -la` |
| `btop` | System monitor | `btop` |
| `fastfetch` | System info | `fastfetch` |
| `cava` | Audio visualizer | `cava` |
| `fzf` | Fuzzy finder | Built into scripts |
| `git` | Version control | `git` |
| `docker` | Containers | `docker` |

## Terminal Navigation

### Directory Navigation

```bash
# Change directory
cd ~/projects/myproject

# Go back
cd -

# Go home
cd ~
# or just
cd

# Go up one level
cd ..

# Go up two levels
cd ../..
```

### Listing Files

```bash
# Modern ls replacement
eza

# List with details
eza -la

# Tree view
eza --tree

# With git status
eza -la --git

# Icons
eza -la --icons
```

### Finding Files

```bash
# Find by name
find . -name "*.py"

# Find and execute
find . -name "*.log" -exec rm {} \;

# Using fd (faster)
fd "pattern"
fd -e py  # Python files only
```

## File Operations

### Creating Files

```bash
# Empty file
touch file.txt

# With content
echo "content" > file.txt

# Multi-line
cat > file.txt << EOF
line 1
line 2
EOF
```

### Copying and Moving

```bash
# Copy file
cp source.txt dest.txt

# Copy directory
cp -r source/ dest/

# Move/rename
mv old.txt new.txt

# Move to directory
mv file.txt ~/Documents/
```

### Deleting

```bash
# Remove file
rm file.txt

# Remove directory
rm -r directory/

# Safe remove (confirm)
rm -i file.txt

# Force remove
rm -f file.txt
```

## Text Processing

### Viewing Files

```bash
# Print entire file
cat file.txt

# Page through file
less file.txt

# First 10 lines
head file.txt

# Last 10 lines
tail file.txt

# Follow file (logs)
tail -f app.log
```

### Searching Text

```bash
# Search in file
grep "pattern" file.txt

# Case insensitive
grep -i "pattern" file.txt

# Recursive in directory
grep -r "pattern" .

# With line numbers
grep -n "pattern" file.txt

# Using ripgrep (faster)
rg "pattern"
```

### Editing Text

```bash
# Neovim
nvim file.txt

# Sed (stream editor)
sed 's/old/new/g' file.txt

# In-place edit
sed -i 's/old/new/g' file.txt

# AWK (pattern processing)
awk '{print $1}' file.txt
```

## Process Management

### Viewing Processes

```bash
# Modern process viewer
btop

# Traditional
htop
# or
top

# List all processes
ps aux

# Find specific process
ps aux | grep firefox
# or
pgrep firefox
```

### Controlling Processes

```bash
# Run in background
command &

# Bring to foreground
fg

# Send to background
Ctrl-Z
bg

# Kill process by PID
kill 1234

# Force kill
kill -9 1234

# Kill by name
pkill firefox
```

## Pipes and Redirection

### Output Redirection

```bash
# Overwrite file
command > output.txt

# Append to file
command >> output.txt

# Redirect errors
command 2> errors.txt

# Redirect both
command > output.txt 2>&1
```

### Pipes

```bash
# Chain commands
cat file.txt | grep "pattern" | sort | uniq

# Count lines
ls | wc -l

# Complex pipeline
find . -name "*.log" | xargs grep "ERROR" | sort | uniq -c
```

## Tmux Workflows

### Session Management

```bash
# Start named session
tmux new -s work

# List sessions
tmux ls

# Attach to session
tmux attach -s work
# or
tmux a -s work

# Kill session
tmux kill-session -t work

# Detach
Ctrl-Space + d
```

### Window Management

```bash
# New window
Ctrl-Space + c

# Next window
Alt + l

# Previous window
Alt + h

# Go to window N
Ctrl-Space + N  # where N is number

# Rename window
Ctrl-Space + :
rename-window name
```

### Pane Management

```bash
# Vertical split
Ctrl-Space + v

# Horizontal split
Ctrl-Space + s

# Navigate panes
Ctrl-Space + h/j/k/l

# Close pane
Ctrl-q
```

## Git Workflow

### Basic Operations

```bash
# Initialize repo
git init

# Clone repo
git clone https://github.com/user/repo.git

# Status
git status

# Add files
git add .
git add file.txt

# Commit
git commit -m "message"

# Push
git push

# Pull
git pull
```

### Branching

```bash
# Create branch
git branch feature

# Switch branch
git checkout feature
# or
git switch feature

# Create and switch
git checkout -b feature

# Merge branch
git checkout main
git merge feature

# Delete branch
git branch -d feature
```

### History

```bash
# View log
git log

# One line per commit
git log --oneline

# Graph view
git log --graph --oneline

# Show changes
git diff

# Show specific commit
git show <commit-hash>
```

## Docker Workflows

### Container Management

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# Start container
docker start <container>

# Stop container
docker stop <container>

# Remove container
docker rm <container>

# View logs
docker logs <container>

# Follow logs
docker logs -f <container>

# Execute command
docker exec -it <container> bash
```

### Image Management

```bash
# List images
docker images

# Pull image
docker pull image:tag

# Build image
docker build -t myimage .

# Remove image
docker rmi image:tag

# Prune unused
docker image prune
```

### Docker Compose

```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs

# Follow logs
docker-compose logs -f

# Rebuild
docker-compose up --build
```

## Useful One-Liners

### System Information

```bash
# Disk usage
df -h

# Directory size
du -sh .

# Memory usage
free -h

# CPU info
lscpu

# Network interfaces
ip addr
```

### File Operations

```bash
# Find large files
find . -type f -size +100M

# Count files in directory
ls | wc -l

# Disk usage by directory
du -h --max-depth=1 | sort -hr

# Find and delete
find . -name "*.tmp" -delete
```

### Text Processing

```bash
# Remove duplicates
sort file.txt | uniq

# Count word frequency
cat file.txt | tr ' ' '\n' | sort | uniq -c | sort -nr

# Replace text in all files
find . -name "*.txt" -exec sed -i 's/old/new/g' {} \;
```

## Shell Scripting Basics

### Simple Script

```bash
#!/usr/bin/env bash

# Your script here
echo "Hello, world!"

# Variables
NAME="sokratOS"
echo "Welcome to $NAME"

# Conditionals
if [ -f "file.txt" ]; then
    echo "File exists"
fi

# Loops
for file in *.txt; do
    echo "Processing $file"
done
```

### Make Script Executable

```bash
chmod +x script.sh
./script.sh
```

## Aliases and Functions

### Common Aliases

Edit `~/.config/bash/aliases.sh`:

```bash
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# List
alias ll='eza -la'
alias la='eza -la'
alias lt='eza --tree'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Docker
alias dps='docker ps'
alias dcu='docker-compose up'
alias dcd='docker-compose down'

# Quick edit
alias vimrc='nvim ~/.config/nvim/init.lua'
alias bashrc='nvim ~/.bashrc'
```

### Shell Functions

```bash
# Create and enter directory
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.gz) tar xzf "$1" ;;
            *.zip)    unzip "$1" ;;
            *.tar)    tar xf "$1" ;;
            *)        echo "Unknown format" ;;
        esac
    fi
}

# Quick search
qf() {
    find . -name "*$1*"
}
```

## Productivity Hacks

### 1. Command History

```bash
# Search history
Ctrl-R

# Previous command
!!

# Last argument of previous
!$

# Nth argument of previous
!:N
```

### 2. Job Control

```bash
# Run in background
long-command &

# Bring back
fg

# List jobs
jobs
```

### 3. Directory Stack

```bash
# Push directory
pushd /some/path

# Pop directory
popd

# List stack
dirs
```

### 4. Brace Expansion

```bash
# Create multiple files
touch file{1..10}.txt

# Create directory structure
mkdir -p project/{src,test,docs}

# Backup
cp file.txt{,.bak}
```

## Cheat Sheet Commands

### Built-in Cheat Sheet

```bash
# In tmux
Ctrl-Space + i

# Then type command
curl
git
docker
```

### Man Pages

```bash
# Manual for command
man ls
man grep
man bash

# Search in man page
/search-term
n  # next match
N  # previous match
```

### TLDR Pages

```bash
# Install if needed
paru -S tldr

# Quick examples
tldr tar
tldr find
tldr git
```

## Troubleshooting

### Command Not Found

```bash
# Find which package provides command
paru -F <command>

# Check if installed
which <command>

# Check PATH
echo $PATH
```

### Permission Denied

```bash
# Check file permissions
ls -la file

# Make executable
chmod +x file

# Change owner
sudo chown user:user file
```

### Process Won't Die

```bash
# Force kill
kill -9 <PID>

# Kill by name
pkill -9 process-name
```

## Next Steps

- **[Coding Workflow](coding-workflow.md)** - Development patterns
- **[Window Management](window-management.md)** - Organize workspace
- **[Tmux Keybinds](../02-keybinds/tmux.md)** - Terminal multiplexing
- **[Scripts Reference](../05-reference/scripts.md)** - Custom utilities

## Additional Resources

- [Bash Guide](https://mywiki.wooledge.org/BashGuide)
- [Command Line Challenge](https://cmdchallenge.com/)
- [The Art of Command Line](https://github.com/jlevy/the-art-of-command-line)

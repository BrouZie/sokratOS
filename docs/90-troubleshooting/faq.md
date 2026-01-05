---
id: faq
title: Frequently Asked Questions
tags: [faq, questions, answers, help]
---

# Frequently Asked Questions

Common questions about sokratOS.

## General Questions

### What is sokratOS?

sokratOS is a complete Arch Linux + Hyprland setup featuring:
- Tiling window manager (Hyprland)
- Terminal-centric workflow (tmux + neovim)
- Dynamic theming system
- Custom productivity utilities

It's designed for students and users wanting to learn Linux and keyboard +
terminal oriented workflows.

### Is this a Linux distribution?

No. sokratOS is a set of configuration files and scripts that run on top of Arch Linux. You install Arch Linux first, then run the sokratOS installer.

### Why Arch Linux?

- Rolling release (always up-to-date)
- Lightweight and customizable
- Excellent documentation (Arch Wiki)
- Large package repository (AUR)

### Can I use sokratOS on other distros?

Not easily. The installer is designed for Arch and uses `pacman` and `paru`. You could manually adapt configs to other distros, but it's not officially supported.

## Installation

### How long does installation take?

Typically 20-45 minutes depending on:
- Internet speed
- Hardware
- Whether you install NVIDIA drivers

### Will it overwrite my existing configs?

Yes! The installer copies configs to `~/.config/` and will overwrite:
- Hyprland, Waybar, Rofi, SwayNC configs
- Kitty, tmux, bash configs
- Neovim configuration

### Can I try it without installing?

Sort of. You could:
1. Install Arch + archinstall in a VM
2. Run sokratOS installer
3. Test it there

There's no "live ISO" for sokratOS specifically.

### Do I need a powerful computer?

No. Hyprland and terminal apps are lightweight. Minimum recommended:
- 4GB RAM
- Dual-core CPU
- 10GB free disk space

Works great on older laptops!

## Usage

### How do I open the terminal?

`SUPER + Return` (SUPER = Windows key)

### How do I launch applications?

`SUPER + Space` opens Rofi launcher. Type app name and press Enter.

### What if I forget a keybind?

Check the documentation:
- [Keybinds Overview](../02-keybinds/overview.md)
- [Hyprland Keybinds](../02-keybinds/hyprland.md)

Or view config files:
```bash
cat ~/.config/hypr/configs/bindings.conf
cat ~/.config/hypr/configs/tiling.conf
```

### How do I exit/logout?

`SUPER + M` exits Hyprland immediately.

**Warning**: Save your work first!

Alternative (safer):
```bash
# From terminal
hyprctl dispatch exit
```

## Customization

### Can I change keybinds?

Yes! Edit `~/.config/hypr/configs/bindings.conf`

Add your keybinds, then reload:
```bash
hyprctl reload
```

See: [Hyprland Keybinds Guide](../02-keybinds/hyprland.md)

### How do I change themes?

Two ways:

**Pre-configured themes**:
```bash
SUPER + Shift + P
```

**From wallpaper**:
```bash
SUPER + Shift + Space
```

See: [Theme Switcher Guide](../04-tweaking-and-theming/theme-switcher.md)

### Can I use my own wallpapers?

Yes! Copy to `~/Pictures/wallpaper/`:
```bash
cp my-wallpaper.jpg ~/Pictures/wallpaper/
```

Then use `SUPER + Shift + Space` to select it.

### Can I use a different terminal?

Yes, but you'll need to:
1. Install your preferred terminal
2. Change keybinds in `bindings.conf`
3. Update theme system (if you want themed terminal)

### Can I use zsh instead of bash?

Yes:
```bash
# Install zsh
sudo pacman -S zsh

# Set as default shell
chsh -s $(which zsh)

cp ~/.local/share/sokratOS/install/configs/zshrc ~/.zshrc
cp -r ~/.local/share/sokratOS/install/configs/zshrc ~/.config/zsh

# Make sure auto-login still works!
echo '[[ $(tty) == /dev/tty1 ]] && exec start-hyprland' >> ~/.zprofile

# Logout and login
```

## Troubleshooting

### Nothing happens when I press keybinds

Check if Hyprland is running:
```bash
echo $HYPRLAND_INSTANCE_SIGNATURE
```

If empty, you're not in Hyprland. Try starting it:
```bash
Hyprland
```

### Black screen after login

Check logs:
```bash
cat ~/.hyprland.log | grep -i error
```

Common cause: Graphics driver issues (especially NVIDIA)

See: [Common Issues](common-issues.md#black-screen-after-login)

### Terminal colors look wrong

Check your TERM variable:
```bash
echo $TERM
```

Should be `xterm-kitty`. If not, add to `~/.bashrc`:
```bash
export TERM=xterm-kitty
```

### How do I get logs for debugging?

```bash
# Hyprland log
cat ~/.hyprland.log

# Waybar errors
waybar 2>&1 | grep -i error

# System journal
journalctl -xe
```

## Workflow Questions

### What is tmux and why should I use it?

Tmux is a terminal multiplexer. Benefits:
- Multiple terminal panes in one window
- Sessions persist (survive disconnects)
- Organize workflows (one session per project)

See: [Tmux Keybinds](../02-keybinds/tmux.md)

### Do I have to learn vim/neovim?

Not required, but recommended for terminal-centric workflow. You can:
- Use nano (simpler editor)
- Use GUI editors (VS Code, etc.)
- Gradually learn neovim

Start with basics: `i` (insert), `Esc` (normal mode), `:w` (save), `:q` (quit)

### How do workspaces work?

Workspaces are like virtual desktops:
- `SUPER + 1-9` to switch
- Each workspace is independent
- Organize by task (workspace 1 = browser, 2 = code, etc.)

See: [Window Management Workflow](../03-workflows/window-management.md)

### What's the difference between tiling and floating?

**Tiling**: Windows automatically arrange themselves, no overlapping
**Floating**: Windows can be freely moved and overlapped (traditional)

Toggle with `SUPER + V`

## Advanced

### Can I use Docker with sokratOS?

Yes! Docker is installed by default. Use normally:
```bash
docker run hello-world
docker-compose up
```

### Can I customize the status bar?

Yes! Edit `~/.config/waybar/config.jsonc` and `style.css`

Reload with `SUPER + R`

### How do I add custom scripts?

1. Create script in `~/.local/share/sokratOS/bin/`
2. Make executable: `chmod +x script`
3. Add keybind in `bindings.conf`

See: [Scripts Reference](../05-reference/scripts.md)

### Can I contribute to sokratOS?

Yes! Check the GitHub repository:
https://github.com/BrouZie/sokratOS

- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

### Where are my dotfiles?

Configurations are in `~/.config/`:
- `hypr/` - Hyprland
- `kitty/` - Terminal
- `nvim/` - Neovim
- `waybar/` - Status bar
- etc.

See: [File Locations](../05-reference/file-locations.md)

### How do I backup my config?

```bash
# Quick backup
backup_dir=~/sokratos-backup-$(date +%Y%m%d)
mkdir -p $backup_dir
cp -r ~/.config/{hypr,kitty,nvim,waybar,rofi,swaync} $backup_dir/
cp ~/.tmux.conf ~/.bashrc $backup_dir/
```

### Can I sync configs across machines?

Yes! Use git:
```bash
cd ~/.config/hypr
git init
git add .
git commit -m "My Hyprland config"
git remote add origin <your-repo>
git push
```

Repeat for other configs or use a dotfile manager like `stow`.

## Performance

### Is Hyprland fast?

Yes! Hyprland is very performant. Much faster than heavy DEs like GNOME or KDE.

### Why does startup feel slow?

Check autostart applications:
```bash
cat ~/.config/hypr/configs/autostart.conf
```

Remove unnecessary apps to speed up startup.

### Can I disable animations?

Temporarily:
```bash
sokratos-focus-mode
```

Permanently: Edit `~/.config/hypr/configs/looknfeel.conf` and set animation durations to 0.

## Compatibility

### Does this work on laptops?

Yes! Works great on laptops. Includes:
- Power management
- Laptop keyboard support
- Touchpad gestures (if configured)
- Battery indicator in Waybar

### What about touchscreen?

Hyprland supports touchscreens, but sokratOS keybind-focused workflow is optimized for keyboard.

### Can I use external monitors?

Yes! Configure in `~/.config/hypr/configs/monitors.conf`:
```conf
monitor=eDP-1,1920x1080@60,0x0,1          # Laptop
monitor=HDMI-A-1,2560x1440@144,1920x0,1   # External
```

## Community and Support

### Where can I get help?

1. Check docs: https://github.com/BrouZie/sokratOS/tree/main/docs
2. Open GitHub issue
3. Hyprland Discord
4. Arch Linux forums

### Is there a Discord/Matrix community?

Check the GitHub repository for community links.

### How do I report bugs?

Open an issue on GitHub:
https://github.com/BrouZie/sokratOS/issues

Include:
- What you expected
- What happened
- Steps to reproduce
- Error messages
- System info

## Philosophy and Design

### Why terminal-centric?

- **Speed**: Keyboard is faster than mouse
- **Flexibility**: Compose tools together
- **Remote-friendly**: Works over SSH
- **Learning**: Understand your system deeply
- **Efficiency**: Less context switching

### Why these specific tools?

- **Hyprland**: Modern, fast, beautiful
- **Kitty**: GPU-accelerated, themeable
- **Tmux**: Industry standard, powerful
- **Neovim**: Extensible, efficient
- **Bash**: Universal, simple

Each tool is chosen for a balance of power and accessibility.

### Who is sokratOS for?

- Students learning Linux
- Developers wanting efficient workflows
- Curious users exploring tiling WMs
- Anyone wanting a keyboard-driven setup

You don't need to be an expert! The docs guide you through everything.

## Next Steps

- **[Common Issues](common-issues.md)** - Troubleshooting guide
- **[Getting Started](../01-getting-started/first-boot-tour.md)** - First steps
- **[Keybinds Overview](../02-keybinds/overview.md)** - Learn shortcuts
- **[Workflows](../03-workflows/coding-workflow.md)** - Practical usage patterns

## Still Have Questions?

Open an issue on GitHub or ask in the community!

https://github.com/BrouZie/sokratOS

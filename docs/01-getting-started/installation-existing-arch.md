---
id: installation-existing-arch
title: Installation on Existing Arch Linux
tags: [installation, arch-linux, existing-system, migration]
---

# Installation on Existing Arch Linux

This guide covers installing sokratOS on an existing Arch Linux system with configurations already in place.

## ⚠️ Important Warning

sokratOS will **overwrite** several configuration files in your home directory. Before proceeding:

### Backup Your Existing Configurations

**Configurations that will be replaced:**

```bash
# Create backup directory
mkdir -p ~/config-backup-$(date +%Y%m%d)

# Backup files that will be overwritten
cp ~/.bashrc ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp ~/.tmux.conf ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/kitty ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/hypr ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/waybar ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/rofi ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/swaync ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/nvim ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/fastfetch ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/zathura ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/bash ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/gtk-3.0 ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/gtk-4.0 ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
cp -r ~/.config/matugen ~/config-backup-$(date +%Y%m%d)/ 2>/dev/null
```

Your backups will be in `~/config-backup-YYYYMMDD/`.

## Prerequisites

- ✅ Existing Arch Linux installation
- ✅ Active internet connection
- ✅ Backups of important configurations (see above)
- ✅ At least 10GB of free disk space
- ✅ Understanding that existing configs will be replaced

## Installation Steps

### Step 1: Review What You'll Get

sokratOS provides:
- Complete Hyprland setup with custom keybinds
- Waybar, Rofi, SwayNC for desktop UI
- Kitty terminal with theme integration
- Tmux with custom configuration
- Neovim with complete setup
- Custom utility scripts
- Theme switching system

If you want to keep your current setup for any of these, **do not install sokratOS** or be prepared to manually merge configurations after installation.

### Step 2: Clone the Repository

```bash
git clone https://github.com/BrouZie/sokratOS.git ~/.local/share/sokratOS
```

### Step 3: Review the Installation Script

Before running the installer, review what it will do:

```bash
# View the main installation script
less ~/.local/share/sokratOS/install.sh

# Check what packages will be installed
cat ~/.local/share/sokratOS/pacman.txt
cat ~/.local/share/sokratOS/paru.txt
```

This helps you understand what changes will be made to your system.

### Step 4: Run the Installation

```bash
bash ~/.local/share/sokratOS/install.sh
```

The installer will:
1. Set up auto-login (may override existing auto-login)
2. Install required packages (safe on existing systems)
3. Copy configurations to `~/.config/` (overwrites existing files)
4. Set up theme system
5. Install custom scripts

### Step 5: Handle Conflicts

If you had existing installations of:

**Hyprland**: Your old `~/.config/hypr/` is now in your backup. sokratOS has its own keybind scheme.

**Tmux**: Your `~/.tmux.conf` is backed up. The new config uses `Ctrl-Space` as prefix and includes custom keybinds.

**Neovim**: Your `~/.config/nvim/` is backed up. The new config uses Space as leader and includes many plugins.

## Post-Installation Integration

### Merging Your Old Configurations

If you want to integrate your old settings:

#### Hyprland Keybinds

1. Open both configs side by side:
   ```bash
   nvim ~/.config/hypr/configs/bindings.conf \
        ~/config-backup-*/hypr/configs/bindings.conf
   ```

2. Copy your custom keybinds to the new `bindings.conf`

3. Reload Hyprland: `SUPER + Shift + R`

#### Bash Configuration

The new `.bashrc` sources `~/.config/bash/` for modularity. You can:

1. Review your old `.bashrc`:
   ```bash
   nvim ~/config-backup-*/.bashrc
   ```

2. Add custom aliases/functions to `~/.config/bash/aliases.sh` or create new files in `~/.config/bash/`

#### Neovim Configuration

To use your old Neovim config instead:

```bash
# Remove sokratOS nvim config
rm -rf ~/.config/nvim

# Restore your backup
cp -r ~/config-backup-*/nvim ~/.config/
```

Or to try sokratOS nvim while keeping your old config:
```bash
# Rename sokratOS config
mv ~/.config/nvim ~/.config/nvim-sokratos

# Restore your config
cp -r ~/config-backup-*/nvim ~/.config/

# You can swap between them as needed
```

### Handling Package Conflicts

If you already had some packages installed:

- **AUR helper**: If you use `yay` instead of `paru`, the script installs `paru` but doesn't remove `yay`
- **Display managers**: If you used GDM/SDDM, the auto-login setup may conflict
- **Shell**: If you use `zsh`, your shell won't be changed to `bash` automatically

## Testing Your Installation

After installation and reboot:

1. **Test Hyprland starts**: Log out and log back in
2. **Test terminal**: Press `SUPER + Return` to open Kitty
3. **Test launcher**: Press `SUPER + Space` to open Rofi
4. **Test theme switching**: Press `SUPER + Shift + Space` to switch themes

If any of these fail, see [Troubleshooting](#troubleshooting) below.

## Keeping Both Setups

If you want to keep your old compositor/desktop alongside Hyprland:

1. Your old display manager session should still be available at login
2. Choose between them at the login screen
3. sokratOS only adds to your system, it doesn't remove other desktop environments

## Reverting the Installation

To completely revert to your backed-up configs:

```bash
# Remove sokratOS configurations
rm -rf ~/.config/hypr \
       ~/.config/waybar \
       ~/.config/rofi \
       ~/.config/swaync \
       ~/.config/kitty \
       ~/.config/nvim \
       ~/.config/fastfetch \
       ~/.config/zathura \
       ~/.config/bash \
       ~/.config/gtk-3.0 \
       ~/.config/gtk-4.0 \
       ~/.config/matugen \
       ~/.config/sokratOS \
       ~/.tmux.conf \
       ~/.bashrc

# Restore your backups
cp -r ~/config-backup-*/* ~/
cp ~/config-backup-*/.bashrc ~/
cp ~/config-backup-*/.tmux.conf ~/

# Optionally remove installed packages (not recommended if they're used by other programs)
# Review pacman.txt and paru.txt before removing anything
```

## Troubleshooting

### Display Manager Conflicts

If you have GDM, SDDM, or LightDM installed and auto-login isn't working:

```bash
# Disable other display managers
sudo systemctl disable gdm
sudo systemctl disable sddm
sudo systemctl disable lightdm

# Reboot
reboot
```

### Keybinds Not Working

If keybinds don't work:

1. Check Hyprland is running: `echo $HYPRLAND_INSTANCE_SIGNATURE`
2. If empty, you're not in Hyprland
3. Check the Hyprland log: `cat ~/.hyprland.log`

### Theme Issues

If themes aren't applying:

```bash
# Check theme system is set up
ls -la ~/.config/sokratOS/current/theme/

# Manually run theme switcher
sokratos-themes
```

### Scripts Not Found

If `sokratos-*` commands aren't found:

```bash
# Check they're linked correctly
ls -la ~/.local/share/sokratOS/bin/

# Ensure the bin directory is in your PATH
echo $PATH | grep -q "sokratOS/bin" || echo "Not in PATH!"

# Source your bashrc
source ~/.bashrc
```

## Next Steps

Continue to:
- [First Boot Tour](first-boot-tour.md) - Learn about your sokratOS setup
- [Keybinds Overview](../02-keybinds/overview.md) - Essential keyboard shortcuts
- [File Locations](../05-reference/file-locations.md) - Where everything lives

## Additional Resources

- [Hyprland Keybinds](../02-keybinds/hyprland.md) - Window management shortcuts
- [Theme Switcher Guide](../04-tweaking-and-theming/theme-switcher.md) - Customizing appearance
- [Common Issues](../90-troubleshooting/common-issues.md) - Troubleshooting help

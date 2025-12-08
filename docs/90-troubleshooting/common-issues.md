---
id: common-issues
title: Common Issues and Solutions
tags: [troubleshooting, problems, fixes, help]
---

# Common Issues and Solutions

Solutions to common problems in sokratOS.

## Installation Issues

### Installation Script Fails

**Symptom**: `install.sh` exits with error

**Solutions**:

1. **Check internet connection**:
   ```bash
   ping -c 3 archlinux.org
   ```

2. **Retry installation**:
   ```bash
   bash ~/.local/share/sokratOS/install.sh
   ```

3. **Check error message** - Usually indicates which step failed

4. **Manual package install**:
   ```bash
   sudo pacman -S <package-name>
   paru -S <aur-package>
   ```

### Out of Disk Space

**Symptom**: Installation fails with "No space left"

**Solution**:
```bash
# Check disk space
df -h

# Clean package cache
sudo pacman -Scc

# Remove old packages
sudo pacman -Rns $(pacman -Qtdq)
```

## Display and Graphics

### Black Screen After Login

**Symptom**: Login successful but screen stays black

**Solutions**:

1. **Switch to TTY**:
   ```
   Ctrl + Alt + F2
   ```

2. **Check Hyprland log**:
   ```bash
   cat ~/.hyprland.log | grep -i error
   ```

3. **Try starting manually**:
   ```bash
   Hyprland
   ```

4. **Check graphics drivers**:
   ```bash
   lspci -k | grep -A 3 VGA
   ```

### NVIDIA Issues

**Symptom**: Hyprland won't start on NVIDIA

**Solutions**:

1. **Install NVIDIA drivers**:
   ```bash
   sudo pacman -S nvidia nvidia-utils
   ```

2. **Add kernel parameters** (edit `/etc/default/grub`):
   ```
   GRUB_CMDLINE_LINUX_DEFAULT="... nvidia_drm.modeset=1"
   ```

3. **Regenerate grub config**:
   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

4. **Reboot**

### Multi-Monitor Not Working

**Symptom**: Second monitor not detected

**Solutions**:

1. **List monitors**:
   ```bash
   hyprctl monitors
   ```

2. **Configure in Hyprland**:
   Edit `~/.config/hypr/configs/monitors.conf`:
   ```conf
   monitor=DP-1,1920x1080@60,0x0,1
   monitor=DP-2,1920x1080@60,1920x0,1
   ```

3. **Reload config**:
   ```bash
   hyprctl reload
   ```

## UI Components

### Waybar Not Showing

**Symptom**: Status bar missing

**Solutions**:

1. **Check if running**:
   ```bash
   pgrep waybar
   ```

2. **Start manually**:
   ```bash
   waybar &
   ```

3. **Check errors**:
   ```bash
   waybar 2>&1 | grep -i error
   ```

4. **Restart**:
   ```bash
   SUPER + Shift + R
   # or
   refresh-app-daemons
   ```

### Rofi Won't Open

**Symptom**: `SUPER + Space` does nothing

**Solutions**:

1. **Check if installed**:
   ```bash
   which rofi
   ```

2. **Test manually**:
   ```bash
   rofi -show drun
   ```

3. **Check keybind**:
   ```bash
   grep "rofi" ~/.config/hypr/configs/bindings.conf
   ```

4. **Kill existing instance**:
   ```bash
   pkill rofi
   ```

### Notifications Not Working

**Symptom**: No notifications appear

**Solutions**:

1. **Check SwayNC running**:
   ```bash
   pgrep swaync
   ```

2. **Start SwayNC**:
   ```bash
   swaync &
   ```

3. **Test notification**:
   ```bash
   notify-send "Test" "This is a test"
   ```

4. **Restart daemon**:
   ```bash
   SUPER + Shift + R
   ```

## Terminal Issues

### Kitty Won't Open

**Symptom**: `SUPER + Return` does nothing

**Solutions**:

1. **Test from existing terminal**:
   ```bash
   kitty
   ```

2. **Check if installed**:
   ```bash
   which kitty
   ```

3. **Use fallback terminal**:
   ```bash
   # From TTY
   alacritty
   # or
   xterm
   ```

### Colors Look Wrong in Terminal

**Symptom**: Terminal colors broken or washed out

**Solutions**:

1. **Check TERM variable**:
   ```bash
   echo $TERM
   ```
   Should be `xterm-kitty`

2. **Set in config**:
   Add to `~/.bashrc`:
   ```bash
   export TERM=xterm-kitty
   ```

3. **Test 256 colors**:
   ```bash
   curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
   ```

### Tmux Not Starting

**Symptom**: `tmux` command fails

**Solutions**:

1. **Kill tmux server**:
   ```bash
   tmux kill-server
   ```

2. **Remove socket**:
   ```bash
   rm -rf /tmp/tmux-*
   ```

3. **Start fresh**:
   ```bash
   tmux
   ```

## Neovim Issues

### Neovim Plugins Not Working

**Symptom**: Plugins missing or broken

**Solutions**:

1. **Open plugin manager**:
   ```vim
   :Lazy
   ```

2. **Update plugins**:
   ```vim
   :Lazy update
   ```

3. **Sync plugins**:
   ```vim
   :Lazy sync
   ```

4. **Check health**:
   ```vim
   :checkhealth
   ```

### LSP Not Working

**Symptom**: No code completion or diagnostics

**Solutions**:

1. **Check LSP status**:
   ```vim
   :LspInfo
   ```

2. **Install language server**:
   ```vim
   :Mason
   ```

3. **Restart LSP**:
   ```vim
   :LspRestart
   ```

## Theme Issues

### Theme Not Applying

**Symptom**: Colors don't change when switching themes

**Solutions**:

1. **Check theme symlink**:
   ```bash
   ls -la ~/.config/sokratOS/current/theme/colors.conf
   ```

2. **Reload Kitty**:
   ```bash
   pkill -SIGUSR1 kitty
   ```

3. **Manually set theme**:
   ```bash
   sokratos-themes
   ```

### Wallpaper Won't Change

**Symptom**: `sokratos-next-theme` doesn't update wallpaper

**Solutions**:

1. **Check swww running**:
   ```bash
   pgrep swww
   ```

2. **Start swww**:
   ```bash
   swww init
   ```

3. **Test manually**:
   ```bash
   swww img ~/Pictures/wallpaper/your-image.jpg
   ```

## Keybind Issues

### Keybinds Not Working

**Symptom**: Keyboard shortcuts don't respond

**Solutions**:

1. **Check Hyprland running**:
   ```bash
   echo $HYPRLAND_INSTANCE_SIGNATURE
   ```

2. **Reload Hyprland config**:
   ```bash
   hyprctl reload
   ```

3. **Check keybind syntax**:
   ```bash
   cat ~/.config/hypr/configs/bindings.conf
   ```

4. **Test keybind**:
   ```bash
   hyprctl keyword bind SUPER,T,exec,kitty
   ```

### Specific Keybind Not Working

**Symptom**: One keybind doesn't work, others do

**Solutions**:

1. **Check for conflicts**:
   ```bash
   grep "SUPER, X" ~/.config/hypr/configs/*.conf
   ```

2. **Test application directly**:
   ```bash
   kitty  # If SUPER + Return doesn't work
   ```

3. **Check application installed**:
   ```bash
   which <application>
   ```

## Audio Issues

### No Sound

**Symptom**: Audio not working

**Solutions**:

1. **Check PipeWire running**:
   ```bash
   systemctl --user status pipewire pipewire-pulse
   ```

2. **Start PipeWire**:
   ```bash
   systemctl --user start pipewire pipewire-pulse
   ```

3. **Check volume**:
   ```bash
   wpctl get-volume @DEFAULT_AUDIO_SINK@
   ```

4. **Unmute**:
   ```bash
   wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
   ```

### Bluetooth Audio Issues

**Symptom**: Bluetooth device won't connect or no audio

**Solutions**:

1. **Start Bluetooth service**:
   ```bash
   sudo systemctl start bluetooth
   ```

2. **Connect device**:
   ```bash
   bluetoothctl
   [bluetooth]# scan on
   [bluetooth]# pair <MAC>
   [bluetooth]# connect <MAC>
   ```

## Performance Issues

### System Feels Slow

**Symptom**: Laggy or unresponsive

**Solutions**:

1. **Check CPU usage**:
   ```bash
   btop
   ```

2. **Kill resource-heavy processes**:
   ```bash
   kill <PID>
   ```

3. **Disable animations** (temporary):
   ```bash
   sokratos-focus-mode
   ```

4. **Check disk space**:
   ```bash
   df -h
   ```

### High Memory Usage

**Symptom**: RAM nearly full

**Solutions**:

1. **Check memory**:
   ```bash
   free -h
   ```

2. **Find memory hogs**:
   ```bash
   ps aux --sort=-%mem | head -10
   ```

3. **Clear cache**:
   ```bash
   sudo sync && sudo sysctl vm.drop_caches=3
   ```

## Network Issues

### WiFi Not Connecting

**Symptom**: Can't connect to wireless network

**Solutions**:

1. **Check NetworkManager**:
   ```bash
   systemctl status NetworkManager
   ```

2. **Start NetworkManager**:
   ```bash
   sudo systemctl start NetworkManager
   ```

3. **Connect via nmtui**:
   ```bash
   nmtui
   ```

4. **Check interface**:
   ```bash
   ip link show
   ```

## Recovery Procedures

### Hyprland Won't Start

1. **Switch to TTY**: `Ctrl + Alt + F2`
2. **Login**
3. **Check logs**: `cat ~/.hyprland.log`
4. **Try minimal config**:
   ```bash
   mv ~/.config/hypr ~/.config/hypr.bak
   cp -r ~/.local/share/sokratOS/install/configs/hypr ~/.config/
   ```

### Complete UI Freeze

1. **Switch to TTY**: `Ctrl + Alt + F2`
2. **Kill Hyprland**: `pkill Hyprland`
3. **Restart**: `reboot`

### Can't Login

1. **Boot to TTY**: `Ctrl + Alt + F2` at boot
2. **Disable auto-login**:
   ```bash
   sudo systemctl disable getty@tty1
   ```
3. **Reboot**

## Getting More Help

### Generate Debug Info

```bash
# System info
fastfetch > ~/debug-info.txt

# Hyprland version
hyprctl version >> ~/debug-info.txt

# Recent log
tail -50 ~/.hyprland.log >> ~/debug-info.txt

# Package versions
pacman -Q | grep -E "hyprland|waybar|kitty" >> ~/debug-info.txt
```

### Where to Ask for Help

1. **GitHub Issues**: https://github.com/BrouZie/sokratOS/issues
2. **Hyprland Discord**: https://discord.gg/hyprland
3. **Arch Forums**: https://bbs.archlinux.org/

### Information to Include

- sokratOS version / commit
- Error messages
- Steps to reproduce
- What you've tried
- System info (GPU, CPU, RAM)

## Next Steps

- **[FAQ](faq.md)** - Frequently asked questions
- **[File Locations](../05-reference/file-locations.md)** - Where to find configs
- **[Scripts Reference](../05-reference/scripts.md)** - Script troubleshooting

## Additional Resources

- [Arch Wiki](https://wiki.archlinux.org/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Hyprland GitHub Issues](https://github.com/hyprwm/Hyprland/issues)

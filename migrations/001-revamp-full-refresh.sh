#!/usr/bin/env bash

CONFIG_ROOT="$HOME/.local/share/sokratOS/install/configs"

# Ensure build-tools are installed
sudo pacman -Sy --needed base-devel

# Remove binary version if installed
pacman -Q matugen-bin &>/dev/null && yay -Rns matugen-bin
pacman -Q matugen-bin-debug &>/dev/null && yay -Rns matugen-bin-debug
sudo pacman -S matugen

revamp() {
	local src="$1" dest="$2"
	local backup
	if [[ -e "$dest" ]]; then
		backup="$HOME/.config/backups/$(basename "$dest")"
		mkdir -p "$HOME/.config/backups"
		mv "$dest" "$backup"
	fi
	if [[ -d "$src" ]]; then
		cp -r "$src" "$dest"
	elif [[ -f "$src" ]]; then
		mkdir -p "$(dirname "$dest")"
		cp "$src" "$dest"
	fi
}

echo "Backing up and refreshing all configs..."

# All config directories
revamp "$CONFIG_ROOT/hypr"       "$HOME/.config/hypr"
revamp "$CONFIG_ROOT/waybar"     "$HOME/.config/waybar"
revamp "$CONFIG_ROOT/kitty.conf" "$HOME/.config/kitty/kitty.conf"
revamp "$CONFIG_ROOT/nvim"       "$HOME/.config/nvim"
revamp "$CONFIG_ROOT/swaync"     "$HOME/.config/swaync"
revamp "$CONFIG_ROOT/gtk3.0"     "$HOME/.config/gtk3.0"
revamp "$CONFIG_ROOT/gtk4.0"     "$HOME/.config/gtk4.0"
revamp "$CONFIG_ROOT/matugen"    "$HOME/.config/matugen"
revamp "$CONFIG_ROOT/rofi"       "$HOME/.config/rofi"
revamp "$CONFIG_ROOT/fastfetch"  "$HOME/.config/fastfetch"
revamp "$CONFIG_ROOT/bashrc"     "$HOME/.bashrc"
revamp "$CONFIG_ROOT/bash"       "$HOME/.config/bash"
revamp "$CONFIG_ROOT/zshrc"      "$HOME/.zshrc"
revamp "$CONFIG_ROOT/zsh"        "$HOME/.config/zsh"
revamp "$CONFIG_ROOT/tmux.conf"  "$HOME/.tmux.conf"

# Clean bad neovim state
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.cache/nvim"

# Waybar symlinks (default to round style)
ln -sf "$HOME/.config/waybar/styles/round/config.jsonc" "$HOME/.config/waybar/config.jsonc"
ln -sf "$HOME/.config/waybar/styles/round/style.css"    "$HOME/.config/waybar/style.css"

# Regenerate colors with default wallpaper
sokratos-mat-theme "$HOME/.local/share/sokratOS/install/configs/wallpaper/elden-purple.jpg"

echo "All configs refreshed. Old configs backed up to ~/.config/backups/"

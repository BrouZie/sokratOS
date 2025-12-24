#!/bin/bash
# ==============================================================================
# Hyprland NVIDIA Setup Script for Arch Linux
# ==============================================================================
# This script automates the installation and configuration of NVIDIA drivers
# for use with Hyprland on Arch Linux, following the official Hyprland wiki.
#
# Updated for NVIDIA 590+ driver changes (Pascal and older require legacy AUR)
#
# Author: https://github.com/Kn0ax
#
# ==============================================================================

# --- GPU Detection ---
if [ -n "$(lspci | grep -i 'nvidia')" ]; then
  GPU_INFO=$(lspci | grep -i 'nvidia')
  
  # --- Driver Selection ---
  # Maxwell (GTX 9xx, 750/Ti) - Legacy 470xx driver
  if echo "$GPU_INFO" | grep -qE "GTX (9[0-9]{2}|750)"; then
    NVIDIA_DRIVER_PACKAGE="nvidia-470xx-dkms"
    NVIDIA_UTILS="nvidia-470xx-utils"
    LIB32_UTILS="lib32-nvidia-470xx-utils"
    USE_AUR=true
    
  # Pascal (GTX 10xx) - Legacy 580xx driver
  elif echo "$GPU_INFO" | grep -qE "GTX 10[0-9]{2}|GT 10[0-9]{2}"; then
    NVIDIA_DRIVER_PACKAGE="nvidia-580xx-dkms"
    NVIDIA_UTILS="nvidia-580xx-utils"
    LIB32_UTILS="lib32-nvidia-580xx-utils"
    USE_AUR=true
    
  # Turing (GTX 16xx, RTX 20xx), Ampere (30xx), Ada (40xx), and newer - Open kernel modules
  elif echo "$GPU_INFO" | grep -qE "GTX 16[0-9]{2}|RTX [2-9][0-9]{3}"; then
    NVIDIA_DRIVER_PACKAGE="nvidia-open-dkms"
    NVIDIA_UTILS="nvidia-utils"
    LIB32_UTILS="lib32-nvidia-utils"
    USE_AUR=false
    
  # Fallback to proprietary for unknown older cards
  else
    NVIDIA_DRIVER_PACKAGE="nvidia-dkms"
    NVIDIA_UTILS="nvidia-utils"
    LIB32_UTILS="lib32-nvidia-utils"
    USE_AUR=false
  fi

  # Check which kernel is installed and set appropriate headers package
  KERNEL_HEADERS="linux-headers" # Default
  if pacman -Q linux-zen &>/dev/null; then
    KERNEL_HEADERS="linux-zen-headers"
  elif pacman -Q linux-lts &>/dev/null; then
    KERNEL_HEADERS="linux-lts-headers"
  elif pacman -Q linux-hardened &>/dev/null; then
    KERNEL_HEADERS="linux-hardened-headers"
  fi

  # force package database refresh
  sudo pacman -Syu --noconfirm

  # Install base packages
  sudo pacman -S --needed --noconfirm \
    "${KERNEL_HEADERS}" \
    "egl-wayland"

  # Install driver packages
  if [ "$USE_AUR" = true ]; then
    yay -S --needed --noconfirm \
      "${NVIDIA_DRIVER_PACKAGE}" \
      "${NVIDIA_UTILS}" \
      "${LIB32_UTILS}"
  else
    sudo pacman -S --needed --noconfirm \
      "${NVIDIA_DRIVER_PACKAGE}" \
      "${NVIDIA_UTILS}" \
      "${LIB32_UTILS}" \
      "libva-nvidia-driver"
  fi

  # Configure modprobe for early KMS
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf >/dev/null

  # Configure mkinitcpio for early loading
  MKINITCPIO_CONF="/etc/mkinitcpio.conf"

  # Define modules
  NVIDIA_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"

  # Create backup
  sudo cp "$MKINITCPIO_CONF" "${MKINITCPIO_CONF}.backup"

  # Remove any old nvidia modules to prevent duplicates
  sudo sed -i -E 's/ nvidia_drm//g; s/ nvidia_uvm//g; s/ nvidia_modeset//g; s/ nvidia//g;' "$MKINITCPIO_CONF"
  # Add the new modules at the start of the MODULES array
  sudo sed -i -E "s/^(MODULES=\\()/\\1${NVIDIA_MODULES} /" "$MKINITCPIO_CONF"
  # Clean up potential double spaces
  sudo sed -i -E 's/  +/ /g' "$MKINITCPIO_CONF"

  sudo mkinitcpio -P

  # Add NVIDIA environment variables to hyprland.conf
  HYPRLAND_CONF="$HOME/.config/hypr/configs/envs.conf"
  if [ -f "$HYPRLAND_CONF" ]; then
    cat >>"$HYPRLAND_CONF" <<'EOF'

# NVIDIA environment variables
cursor {
	no_hardware_cursors = true
}
env = NVD_BACKEND,direct
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
EOF
  fi
fi

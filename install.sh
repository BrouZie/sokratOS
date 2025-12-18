#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

export REPO_PATH="$HOME/.local/share/sokratOS"
export REPO_INSTALL="$REPO_PATH/install"
export LOG_FILE="$HOME/.config/sokratOS-install.log"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Color codes for manual output (fallback when gum not available)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"
}

# Status message function (before gum is available)
status_msg() {
    echo -e "${BLUE}==>${NC} $1"
    log "STATUS: $1"
}

# Error handler
catch_errors() {
    echo -e "\n${RED}✗ sokratOS installation failed!${NC}"
    echo "Check the log file for details: $LOG_FILE"
    echo "You can retry by running: bash $REPO_PATH/install.sh"
    log "ERROR: Installation failed at line $1"
}

trap 'catch_errors $LINENO' ERR

# Function to run command with retries (for network operations)
run_with_retry() {
    local max_attempts=3
    local attempt=1
    local cmd="$*"

    while [ $attempt -le $max_attempts ]; do
        log "Attempting: $cmd (attempt $attempt/$max_attempts)"
        if eval "$cmd" >> "$LOG_FILE" 2>&1; then
            return 0
        fi

        if [ $attempt -lt $max_attempts ]; then
            log "Failed, retrying in 5 seconds..."
            sleep 5
        fi
        attempt=$((attempt + 1))
    done

    log "ERROR: Failed after $max_attempts attempts: $cmd"
    return 1
}

# Clear screen and show header
clear
cat << "EOF"
╔═══════════════════════════════════════╗
║                                       ║
║          sokratOS Installer           ║
║                                       ║
╚═══════════════════════════════════════╝

EOF

log "========== sokratOS Installation Started =========="

# Cache sudo credentials upfront and keep them alive
status_msg "Requesting sudo access..."
sudo -v
log "Sudo credentials cached"

# Keep sudo alive in background (updates timestamp every 60 seconds)
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_REFRESH_PID=$!
log "Sudo refresh background process started (PID: $SUDO_REFRESH_PID)"

# Cleanup function to kill sudo refresh on exit
cleanup() {
    if [ ! -z "$SUDO_REFRESH_PID" ]; then
        kill "$SUDO_REFRESH_PID" 2>/dev/null || true
        log "Sudo refresh process terminated"
    fi
}
trap cleanup EXIT

# Step 1: Auto-login
status_msg "Configuring auto-login..."
source "$REPO_INSTALL/autologin.sh" >> "$LOG_FILE" 2>&1
log "Auto-login configured"

# Step 1.5: Sync package databases
status_msg "Syncing package databases..."
run_with_retry "sudo pacman -Syu --noconfirm"
log "Package databases synced"

# Step 2: Install gum for better UX
status_msg "Installing gum for enhanced output..."
run_with_retry "sudo pacman -S --noconfirm --needed gum"
log "Gum installed"

# Now we can use gum for better output!
export GUM_SPIN_SPINNER="line"
export GUM_SPIN_TITLE_FOREGROUND="212"

# Helper function to run commands with gum spinner
gum_spin() {
    local title="$1"
    shift
    log "Starting: $title"
    if gum spin --title "$title" -- bash -c "$* >> '$LOG_FILE' 2>&1"; then
        log "Completed: $title"
        return 0
    else
        log "Failed: $title"
        return 1
    fi
}

echo ""
gum style --foreground 212 --bold "Installation Progress"
echo ""

# Step 3: Install all packages (the longest operation)
gum style --foreground 147 "📦 Installing system packages..."
gum_spin "Installing prerequisites..." "source '$REPO_INSTALL/prerequisites/all.sh'"
gum_spin "Installing terminal tools..." "source '$REPO_INSTALL/terminal/all.sh'"
gum_spin "Installing desktop environment..." "source '$REPO_INSTALL/desktop/all.sh'"
gum_spin "Installing extra packages..." "source '$REPO_INSTALL/xtras/all.sh'"

echo ""
gum style --foreground 147 "⚙️  Setting up configurations..."

# Step 4: Create directories and copy configs
gum_spin "Creating directories..." "mkdir -p \
    '$HOME/.config/sokratOS/current/theme' \
    '$HOME/.config/sokratOS/env.d' \
    '$HOME/.local/share/applications' \
    '$HOME/.config/kitty' \
    '$HOME/Pictures/wallpaper' \
    '$HOME/.local/bin'"

gum_spin "Copying configuration files..." "
    cp '$REPO_INSTALL/configs/bashrc' '$HOME/.bashrc'
    cp '$REPO_INSTALL/configs/fzf-dirs.sh' '$HOME/.config/sokratOS/env.d/fzf-dirs.sh'
    cp '$REPO_INSTALL/configs/kitty.conf' '$HOME/.config/kitty/kitty.conf'
    cp '$REPO_INSTALL/configs/tmux.conf' '$HOME/.tmux.conf'
    cp -r '$REPO_INSTALL/configs/bash' '$HOME/.config/bash'
    cp -r '$REPO_INSTALL/configs/colors/matugen' '$HOME/.config/sokratOS/matugen'
    cp -r '$REPO_INSTALL/configs/gtk-3.0' '$HOME/.config/gtk-3.0'
    cp -r '$REPO_INSTALL/configs/gtk-4.0' '$HOME/.config/gtk-4.0'
    cp -r '$REPO_INSTALL/configs/matugen' '$HOME/.config/matugen'
    cp -r '$REPO_INSTALL/configs/hypr' '$HOME/.config/hypr'
    cp -r '$REPO_INSTALL/configs/waybar' '$HOME/.config/waybar'
    cp -r '$REPO_INSTALL/configs/rofi' '$HOME/.config/rofi'
    cp -r '$REPO_INSTALL/configs/swaync' '$HOME/.config/swaync'
    cp -r '$REPO_INSTALL/configs/fastfetch' '$HOME/.config/fastfetch'
    cp -r '$REPO_INSTALL/configs/zathura' '$HOME/.config/zathura'
    cp -r '$REPO_INSTALL/configs/nvim' '$HOME/.config/nvim'
    cp '$REPO_INSTALL/configs/applications/'*.desktop '$HOME/.local/share/applications/'
    cp -r '$REPO_INSTALL/configs/applications/icons' '$HOME/.local/share/applications/'
"

# Configure keyboard layout based on system settings
gum_spin "Configuring keyboard layout..." "source '$REPO_INSTALL/configs/configure-keyboard.sh'"

echo ""
gum style --foreground 147 "🔧 Setting up development tools..."

# Step 5: Tmux and Neovim setup (can be parallelized)
{
    gum_spin "Setting up tmux plugins..." "
        if [[ ! -e ~/.tmux/plugins/tpm ]]; then
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        fi
        ~/.tmux/plugins/tpm/bin/install_plugins
    "
} &
tmux_pid=$!

{
    gum_spin "Setting up Neovim Python environment..." "
        uv venv --seed ~/.venvs/nvim
        uv pip install -p ~/.venvs/nvim/bin/python \
            pynvim jupyter_client nbformat cairosvg pillow plotly kaleido \
            pyperclip requests websocket-client pnglatex
    "
} &
python_pid=$!

# Wait for both parallel operations
wait $tmux_pid
wait $python_pid

# Neovim plugins (this is slow, so it stays separate)
gum_spin "Installing Neovim plugins (1-3 minutes)..." "nvim --headless -c 'Lazy! sync' -c 'MasonToolsInstallSync' -c 'qa'"

echo ""
gum style --foreground 147 "🎨 Finalizing setup..."

# Step 6.5: Add pywalfox and vimium-c to firefox
sudo mkdir -p /etc/firefox/policies
sudo tee /etc/firefox/policies/policies.json >/dev/null <<'JSON'
{
  "policies": {
    "Extensions": {
      "Install": [
        "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi",
        "https://addons.mozilla.org/firefox/downloads/latest/pywalfox/latest.xpi"
      ]
    }
  }
}
JSON

gum_spin "Checking graphics card..." "source $REPO_INSTALL/prerequisites/nvidia.sh"


# Step 7: Wallpaper and first login script
gum_spin "Setting up wallpaper and welcome screen..." "
    cp -r '$REPO_INSTALL/configs/wallpaper/'* '$HOME/Pictures/wallpaper/'
    cp '$REPO_INSTALL/sokratos-first-login' '$HOME/.local/bin/'
    chmod +x '$HOME/.local/bin/sokratos-first-login'
    cp '$REPO_INSTALL/WELCOME.md' '$HOME/.config/sokratOS/WELCOME.md'
"

# Success message
echo ""
gum style \
    --border double \
    --border-foreground 212 \
    --padding "1 2" \
    --margin "1 0" \
    "✓ sokratOS installation complete!" \
    "" \
    "Please reboot your system to start using sokratOS." \
    "" \
    "Installation log: $LOG_FILE"

log "========== sokratOS Installation Completed Successfully =========="

echo ""
if gum confirm --default=true "Reboot now to start using sokratOS!"; then
    log "User chose to reboot"
    echo ""
    gum style --foreground 212 "Rebooting in 3 seconds..."
    sleep 3
    sudo reboot
else
    log "User chose not to reboot"
    echo ""
    gum style --foreground 147 "Remember to reboot before launching Hyprland!"
fi

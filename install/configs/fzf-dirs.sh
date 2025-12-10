# custom-fzf-dirs: shared by bash and zsh
# Just defines dirs + helper functions. No keybindings here.

# How deep to search under SEARCH_PATHS
MAX_DEPTH=3

# Directories to search
SEARCH_PATHS=(
  "$HOME/Robotics"
  "$HOME/Projects"
  "$HOME/School"
  "$HOME/Documents"
)

# Specific .config subdirectories to include
CONFIG_DIRS=(
  "nvim"
  "hypr"
  "rofi"
  "kitty"
  "waybar"
  "bash"
  "matugen"
  "sokratOS"
  "fastfetch"
  "gtk-3.0"
  "gtk-4.0"
  "zathura"
  "swaync"
  "ghostty"
)

# Specific .local subdirectories to include
LOCAL_DIRS=(
  "bin"
)

# Specific .local/share subdirectories to include
LOCAL_SHARE_DIRS=(
  "applications"
  "sokratOS"
)

# --- fd detection (done once when the file is sourced) ---
# Using the full path: /usr/bin/fd
if command -v fd >/dev/null 2>&1; then
  _FZF_DIRS_FD_CMD="$(command -v fd)"
elif command -v fdfind >/dev/null 2>&1; then
  _FZF_DIRS_FD_CMD="$(command -v fdfind)"
else
  _FZF_DIRS_FD_CMD=""
fi

# 1) Print all candidate dirs, one per line
fzf_custom_list_dirs() {
  local path name

  # SEARCH_PATHS: use fd if available
  if [ -n "$_FZF_DIRS_FD_CMD" ]; then
    for path in "${SEARCH_PATHS[@]}"; do
      [ -d "$path" ] || continue

      # fd version: fast, respects .gitignore etc.
      "$_FZF_DIRS_FD_CMD" . "$path" \
        --type d \
        --min-depth 1 \
        --max-depth "$MAX_DEPTH" \
        --absolute-path \
        --exclude '.git' \
        --exclude 'node_modules' \
        --exclude '.venv' \
        --exclude '__pycache__' \
        --exclude '.cache'
    done
  fi

  # .config dirs
  for name in "${CONFIG_DIRS[@]}"; do
    path="$HOME/.config/$name"
    [ -d "$path" ] && printf '%s\n' "$path"
  done

  # .local dirs
  for name in "${LOCAL_DIRS[@]}"; do
    path="$HOME/.local/$name"
    [ -d "$path" ] && printf '%s\n' "$path"
  done

  # .local/share dirs
  for name in "${LOCAL_SHARE_DIRS[@]}"; do
    path="$HOME/.local/share/$name"
    [ -d "$path" ] && printf '%s\n' "$path"
  done
}

# 2) Run fzf on that list and print the chosen dir
fzf_custom_pick_dir() {
  fzf_custom_list_dirs \
    | fzf --prompt="> " --height 55% --layout=reverse
}

# ~/.config/bash/interactive.bash
# All configuration for interactive shells
# Loaded only when shell is interactive

# =============
# Shell Options
# =============

# History settings
shopt -s histappend      # Append to history file, don't overwrite
shopt -s cmdhist         # Save multi-line commands in one history entry
HISTCONTROL=ignoreboth:erasedups  # Ignore duplicates and lines starting with space
HISTSIZE=100000
HISTFILESIZE="${HISTSIZE}"

# Ensure command hashing is enabled (improves performance)
set -h

# =======================
# History Synchronization
# =======================

# Share history across shells in real-time
# Note: This will be prepended to PROMPT_COMMAND set by prompt.bash
PROMPT_COMMAND='history -a; history -n'

# ===============
# Bash Completion
# ===============

if [[ ! -v BASH_COMPLETION_VERSINFO ]] && [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

# ==========================
# External Tool Integrations
# ==========================

# Zoxide (smarter cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
  export _ZO_DOCTOR=0  # Disable zoxide doctor warnings
fi

# FZF (fuzzy finder) - key bindings and completion
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

# FZF configuration (use fd for better performance if available)
if command -v fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# =======
# Aliases
# =======

# File system aliases
if command -v eza >/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lt='eza --tree --level=2 --long --icons --git'
else
  alias ls='ls --color=auto -lh'
  alias lt='ls -lAh'
fi
alias lsa='ls -a'

# Navigation aliases
alias nconf="cd ~/.config/nvim/ && nvim ."
alias hyprconf="cd ~/.config/hypr/ && nvim ."

# Python virtual environment
alias svba="source .venv/bin/activate"

# Quick commands
alias ff="fastfetch"
alias grep='grep --color=auto'

# View images in terminal (kitty)
if command -v kitty >/dev/null; then
  alias icat="kitty +kitten icat"
fi

# Package manager fuzzy finders (Arch Linux)
if command -v fzf >/dev/null; then
  if command -v yay >/dev/null; then
    alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
  fi
  
  if command -v pacman >/dev/null; then
    alias pacmanf="pacman -Slq | fzf --multi --preview 'pacman -Sii {1}' --preview-window=down:75% | xargs -ro pacman -S"
  fi
  
  if command -v paru >/dev/null; then
    alias paruf="paru -Slq | fzf --multi --preview 'paru -Sii {1}' --preview-window=down:75% | xargs -ro paru -S"
  fi
fi

# =========
# Functions
# =========

# Extract various archive formats
extract() {
  local f="$1"
  
  if [[ ! -f "$f" ]]; then
    echo "Usage: extract <file>"
    echo "Supported: .tar.bz2 .tar.gz .bz2 .rar .gz .tar .tbz2 .tgz .zip .Z .7z"
    return 1
  fi
  
  case "$f" in
    *.tar.bz2) tar xjf "$f" ;;
    *.tar.gz)  tar xzf "$f" ;;
    *.bz2)     bunzip2 "$f" ;;
    *.rar)     unrar x "$f" ;;
    *.gz)      gunzip "$f" ;;
    *.tar)     tar xf "$f" ;;
    *.tbz2)    tar xjf "$f" ;;
    *.tgz)     tar xzf "$f" ;;
    *.zip)     unzip "$f" ;;
    *.Z)       uncompress "$f" ;;
    *.7z)      7z x "$f" ;;
    *)         echo "Unknown format: $f" ; return 1 ;;
  esac
}

# Enhanced cd that falls back to zoxide if directory doesn't exist
zd() {
  # No arguments: go home
  if [[ $# -eq 0 ]]; then
    builtin cd ~ && return
  fi
  
  # If it's a valid directory, just cd to it
  if [[ -d "$1" ]]; then
    builtin cd "$1"
  # Otherwise try zoxide (if available)
  elif command -v z >/dev/null; then
    z "$@" && printf " \U000F17A9 " && pwd
  else
    echo "Error: Directory not found and zoxide not available"
    return 1
  fi
}

# Override cd to use zd
alias cd='zd'

# ========================================
# Custom Navigation Integration (sokratOS)
# ========================================

# Navigation function wrapper using tmux and fzf
__sokratOS_nav__() {
  local script_name="sokratos-navigation"
  local script_path=""
  local candidate

  # Possible locations for the script
  local script_candidates=(
    "$HOME/.local/bin/$script_name"
    "$HOME/.local/share/sokratOS/bin/$script_name"
  )

  for candidate in "${script_candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      script_path="$candidate"
      break
    fi
  done

  # If we didn't find the script, silently do nothing
  [[ -z "$script_path" ]] && return 0

  # Run the script: outside tmux it prints the directory or nothing,
  # inside tmux it handles tmux navigation and prints nothing.
  local dir
  dir="$("$script_path")" || return 0

  # If we got a real directory, output a cd command that bash will execute
  if [[ -n "$dir" && -d "$dir" ]]; then
    printf 'builtin cd -- %q' "$dir"
  fi
}

# Bash readline bindings for custom navigation (Ctrl-F)
# In emacs mode
bind -m emacs-standard '"\C-f": "\C-u`__sokratOS_nav__`\C-m"'

# In vi mode - temporarily switch to emacs, run binding, then back
bind -m vi-command '"\C-f": "\C-z\C-f\C-z"'
bind -m vi-insert  '"\C-f": "\C-z\C-f\C-z"'

# Unbind Alt-C in vi-command mode to resolve fzf conflict
bind -m vi-command -r '\ec'

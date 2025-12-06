# ~/.config/zsh/interactive.zsh
# All configuration for interactive shells
# Loaded only when shell is interactive

# ======================
# Plugin Manager (Zinit)
# ======================

# Set zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not present
if [[ ! -d "$ZINIT_HOME" ]]; then
  echo "Installing zinit..."
  mkdir -p "$(dirname "$ZINIT_HOME")"
  if git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"; then
    echo "Zinit installed successfully"
  else
    echo "Failed to install zinit" >&2
  fi
fi

# Load zinit
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
  
  # Load plugins
  zinit light zsh-users/zsh-syntax-highlighting
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light Aloxaf/fzf-tab
fi

# =============
# Shell Options
# =============

# Directory navigation
setopt AUTO_CD

# History settings
HISTSIZE=10000
HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt APPENDHISTORY        # Append to history file
setopt SHAREHISTORY         # Share history between sessions
setopt HIST_IGNORE_SPACE    # Don't record commands starting with space
setopt HIST_IGNORE_ALL_DUPS # Remove older duplicate entries from history
setopt HIST_SAVE_NO_DUPS    # Don't write duplicate entries to history file
setopt HIST_IGNORE_DUPS     # Don't record consecutive duplicates
setopt HIST_FIND_NO_DUPS    # Don't display duplicates when searching
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from history
setopt EXTENDED_HISTORY     # Save timestamp and duration

# =================
# Completion System
# =================

# Initialize completion system
autoload -Uz compinit
compinit  # Removed -u flag for security

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Colored completion
zstyle ':completion:*' menu no                           # Disable default menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'  # Preview for cd

# ============
# Key Bindings
# ============

# Use vi mode
bindkey -v

# Reduce ESC delay (1 = 0.01s = 10ms)
export KEYTIMEOUT=1

# Fix backspace and other keys in vi mode
bindkey -M viins '^?' backward-delete-char # Backspace
bindkey -M viins '^W' backward-kill-word  # Ctrl-W
bindkey -M viins '^U' backward-kill-line  # Ctrl-U

# History search with Ctrl-P and Ctrl-N
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Accept autosuggestion with Ctrl-E (works in both insert and command mode)
bindkey -M viins '^E' forward-char
bindkey -M vicmd '^E' forward-char

# Disable Alt-C in vi command mode (conflicts with fzf's ESC-C sequence)
bindkey -M vicmd -r $'\ec'

# Note: Ctrl-E is bound to __sokratOS_nav_widget in the Functions section below

# ======================
# Styling & Integrations
# ======================

# Autosuggestion appearance (semi-transparent gray)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# Zoxide (smarter cd) - must be initialized before zd() function
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
  export _ZO_DOCTOR=0  # Disable zoxide doctor warnings
fi

# FZF shell integration
if command -v fzf >/dev/null; then
  eval "$(fzf --zsh)"
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

# Widget function for sokratOS navigation
__sokratOS_nav_widget() {
  local script_name="sokratos-navigation"
  local script_path=""
  local candidate

  # Possible locations for the script
  local script_candidates=(
    "$HOME/.local/bin/$script_name"
    "$HOME/.local/share/sokratOS/bin/$script_name"
  )

  # Find the script
  for candidate in "${script_candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      script_path="$candidate"
      break
    fi
  done

  # If script not found, do nothing
  [[ -z "$script_path" ]] && return 0

  # Run the script and capture output
  local dir
  dir="$("$script_path")" || return 0

  # If we got a valid directory, cd to it
  if [[ -n "$dir" && -d "$dir" ]]; then
    builtin cd -- "$dir"
    
    # Clear the command line and redraw prompt
    zle reset-prompt
  fi
}

# Register as a ZLE widget
zle -N __sokratOS_nav_widget

# Bind to Ctrl-F (works in both vi insert and command mode)
bindkey '^F' __sokratOS_nav_widget

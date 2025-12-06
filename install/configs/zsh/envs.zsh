# ~/.config/zsh/env.zsh
# Environment variables and PATH setup
# Loaded for ALL shells (interactive and non-interactive)

# Editor setup
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export MANPAGER="nvim +Man!"

# PATH management
append_path() {
  [[ -d "$1" ]] || return  # Skip if directory doesn't exist
  case ":$PATH:" in 
    *":$1:"*) ;;             # Already in PATH
    *) export PATH="$PATH:$1" ;;
  esac
}

# Add custom paths (only if they exist)
append_path "$HOME/.local/share/sokratOS/bin"
append_path "$HOME/.local/bin"
append_path "$HOME/go/bin"

# Remove duplicate entries from PATH
dedupe_path() {
  local -a parts out
  local p seen=""

  # Split PATH by colon
  parts=("${(@s/:/)PATH}")

  for p in "${parts[@]}"; do
    [[ -z "$p" ]] && continue
    case ":$seen:" in
      *":$p:"*) ;;           # Already seen, skip
      *)
        out+="$p"            # Add to output
        seen="${seen}:$p"
        ;;
    esac
  done

  # Join array back to string
  PATH="${(j/:/)out}"
}

dedupe_path

# Clean up helper functions
unfunction append_path dedupe_path

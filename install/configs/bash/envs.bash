# ~/.config/bash/env.bash
# Environment variables and PATH setup
# Loaded for ALL shells (interactive and non-interactive)

# Editor setup
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export MANPAGER="nvim +Man!"

# PATH management
add_path() {
  [[ -d "$1" ]] || return  # Skip if directory doesn't exist
  case ":$PATH:" in 
    *":$1:"*) ;;           # Already in PATH
    *) export PATH="$PATH:$1" ;;
  esac
}

# Add custom paths (only if they exist)
add_path "$HOME/.local/share/sokratOS/bin"
add_path "$HOME/.local/bin"
add_path "$HOME/go/bin"

# Remove duplicate entries from PATH
dedupe_path() {
  local oldIFS="$IFS"
  IFS=':'
  read -ra parts <<< "$PATH"
  IFS="$oldIFS"

  local out=()
  local seen=""
  
  for p in "${parts[@]}"; do
    [[ -z "$p" ]] && continue
    case ":$seen:" in
      *":$p:"*) ;;         # Already seen, skip
      *)
        out+=("$p")        # Add to output
        seen="${seen}:$p"
        ;;
    esac
  done

  IFS=':'
  echo "${out[*]}"
}

PATH="$(dedupe_path)"

# Clean up helper functions
unset -f add_path dedupe_path

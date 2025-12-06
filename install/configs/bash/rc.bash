# ~/.config/bash/rc.bash
# Main loader

BASHCFG="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

# Load environment variables (runs for all shells, including non-interactive)
[[ -f "$BASHCFG/envs.bash" ]] && source "$BASHCFG/envs.bash"

# Only continue for interactive shells
[[ $- != *i* ]] && return
[[ -f "$BASHCFG/interactive.bash" ]] && source "$BASHCFG/interactive.bash"
[[ -f "$BASHCFG/inputrc" ]] && bind -f "$BASHCFG/inputrc"
[[ -f "$BASHCFG/prompt.bash" ]] && source "$BASHCFG/prompt.bash"

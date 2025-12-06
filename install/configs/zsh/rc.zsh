# ~/.config/zsh/rc.zsh
# Main loader

ZSHCFG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Load environment variables (runs for all shells, including non-interactive)
[[ -f "$ZSHCFG/envs.zsh" ]] && source "$ZSHCFG/envs.zsh"

# Only continue for interactive shells
[[ -o interactive ]] || return
[[ -f "$ZSHCFG/interactive.zsh" ]] && source "$ZSHCFG/interactive.zsh"
[[ -f "$ZSHCFG/async.zsh" ]] && source "$ZSHCFG/async.zsh"
[[ -f "$ZSHCFG/prompt.zsh" ]] && source "$ZSHCFG/prompt.zsh"

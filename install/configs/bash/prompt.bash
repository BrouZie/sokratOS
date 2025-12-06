# ~/.config/bash/prompt.bash
# Bash prompt configuration

# Enable color support
force_color_prompt=yes
color_prompt=yes

# ================
# Helper Functions
# ================

# Get current git branch
git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Show virtual environment name
venv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "(venv) "
  fi
}

# ==============
# Prompt Builder
# ==============

set_prompt() {
  local last_status=$?
  
  # ANSI color codes
  local bold='\[\033[1m\]'
  local reset='\[\033[0m\]'
  local red='\[\033[31m\]'
  local green='\[\033[32m\]'
  local blue='\[\033[34m\]'
  local black='\[\033[30m\]'
	local yellow='\[\033[33m\]'

	# Add other colors if needed:
	# local magenta='\[\033[35m\]'
	# local cyan='\[\033[36m\]'
	# local white='\[\033[37m\]'
	# local bright_black='\[\033[90m\]'
	# local bright_red='\[\033[91m\]'
	# local bright_green='\[\033[92m\]'
	# local bright_yellow='\[\033[93m\]'
	# local bright_blue='\[\033[94m\]'
	# local bright_magenta='\[\033[95m\]'
	# local bright_cyan='\[\033[96m\]'
	# local bright_white='\[\033[97m\]'
  
  # Build prompt
  # Top line: venv indicator, current directory, git branch
  PS1="\n${bold}${green}\$(venv_info)${blue}\W${green}\$(git_branch)${reset}\n"
  
  # Bottom line: prompt symbol (blue if success, red if error)
  if [[ $last_status -eq 0 ]]; then
    PS1+="${blue}❯ ${reset}"
  else
    PS1+="${red}❯ ${reset}"
  fi
}

# ====================
# Prompt Command Setup
# ====================

# Append to PROMPT_COMMAND (history sync was already set in interactive.bash)
if [[ -n "$PROMPT_COMMAND" ]]; then
  PROMPT_COMMAND="$PROMPT_COMMAND; set_prompt"
else
  PROMPT_COMMAND="set_prompt"
fi

# Secondary prompt for multi-line commands
PS2="❯❯ "

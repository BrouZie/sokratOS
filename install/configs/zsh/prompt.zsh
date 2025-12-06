# Minimal Pure-style Zsh prompt with async Git
# Save this as ~/.config/zsh/prompt and source it from your .zshrc
# Check out the original creator here: https://github.com/sindresorhus/pure

# ------------
# Global state
# ------------

# Git status state updated asynchronously
typeset -gA PROMPT_GIT_STATE
PROMPT_GIT_STATE=(
  in_repo 0
  branch  ''
  dirty   0
  ahead   0
  behind  0
  stash   0
)

# Misc prompt state
typeset -gA PROMPT_STATE
typeset -g  PROMPT_PREPROMPT=""
typeset -g  PROMPT_GIT_ASYNC_INITIALIZED=0

# ------
# Colors
# ------

_prompt_setup_colors() {
  typeset -gA PROMPT_COLORS
  PROMPT_COLORS=(
    path              blue
    git_branch        242
    git_branch_cached 244
    git_dirty         218
    git_arrow         cyan
    git_stash         cyan
    user              242
    user_root         default
    host              242
    venv              242
    prompt_ok         magenta
    prompt_error      red
    continuation      242
  )
}

# --------------------------------
# SSH / container / root detection
# --------------------------------

_prompt_is_inside_container() {
  [[ -f "/.dockerenv" ]] && return 0
  [[ -f "/run/.containerenv" ]] && return 0
  if [[ -r /proc/1/cgroup ]] && command grep -qE '(docker|kubepods|containerd|lxc)' /proc/1/cgroup 2>/dev/null; then
    return 0
  fi
  return 1
}

_prompt_update_userhost() {
  emulate -L zsh
  setopt noshwordsplit

  local ssh="${SSH_CONNECTION:-$PROMPT_SSH_CONNECTION}"
  local who_out

  if [[ -z $ssh ]] && (( $+commands[who] )); then
    who_out=$(who -m 2>/dev/null) || who_out=""
    if [[ -z $who_out ]]; then
      local -a who_in
      who_in=( ${(f)"$(who 2>/dev/null)"} )
      who_out="${(M)who_in:#*[[:space:]]${TTY#/dev/}[[:space:]]*}"
    fi

    # Try to extract remote host from last field in parentheses: user pts/0 (host)
    local -H MATCH MBEGIN MEND
    if [[ $who_out =~ '\(([^)]+)\)$' ]]; then
      ssh=$MATCH
      export PROMPT_SSH_CONNECTION=$ssh
    fi
    unset MATCH MBEGIN MEND
  fi

  local user_part="" host_part=""

  if (( EUID == 0 )); then
    user_part="%F{${PROMPT_COLORS[user_root]}}%n%f"
  elif [[ -n $ssh ]] || _prompt_is_inside_container; then
    user_part="%F{${PROMPT_COLORS[user]}}%n%f"
  fi

  if [[ -n $user_part ]]; then
    host_part="%F{${PROMPT_COLORS[host]}}@%m%f"
    PROMPT_STATE[userhost]="$user_part$host_part"
  else
    PROMPT_STATE[userhost]=""
  fi
}

# ---------------------
# Async Git integration
# ---------------------

_prompt_git_async_init() {
  (( $+functions[async_init] )) || return 1
  if (( ! PROMPT_GIT_ASYNC_INITIALIZED )); then
    async_init
    async_start_worker prompt_git -n
    async_register_callback prompt_git _prompt_git_async_callback
    PROMPT_GIT_ASYNC_INITIALIZED=1
  fi
  return 0
}

_prompt_git_schedule() {
  _prompt_git_async_init || return

  # Cancel any stale job and start a new one for the current directory
  async_flush_jobs prompt_git

  async_job prompt_git zsh -c '
    emulate -L zsh
    setopt noshwordsplit

    local dir="$1"
    builtin cd -q -- "$dir" 2>/dev/null || { print "in_repo=0"; return 0; }

    if ! command git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      print "in_repo=0"
      return 0
    fi

    local branch dirty ahead behind stash

    branch=$(command git symbolic-ref --short HEAD 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null || echo "?")

    # Dirty if there are any changes (including untracked)
    if command git diff --no-ext-diff --quiet --ignore-submodules --exit-code 2>/dev/null \
       && test -z "$(command git status --porcelain --ignore-submodules -unormal 2>/dev/null)"; then
      dirty=0
    else
      dirty=1
    fi

    local counts
    counts=$(command git rev-list --left-right --count HEAD...@{u} 2>/dev/null) || counts=""

    if [[ -n $counts ]]; then
      ahead=${counts%%[[:space:]]*}
      behind=${counts##*[[:space:]]}
    else
      ahead=0
      behind=0
    fi

    if command git rev-parse --verify --quiet refs/stash >/dev/null 2>&1; then
      stash=$(command git rev-list --walk-reflogs --count refs/stash 2>/dev/null)
    else
      stash=0
    fi

    print -r -- "in_repo=1"
    print -r -- "branch=$branch"
    print -r -- "dirty=$dirty"
    print -r -- "ahead=$ahead"
    print -r -- "behind=$behind"
    print -r -- "stash=$stash"
  ' _ "$PWD"
}

_prompt_git_async_callback() {
  emulate -L zsh
  setopt noshwordsplit

  local job=$1
  local code=$2
  local out=$3

  if (( code != 0 )); then
    PROMPT_GIT_STATE[in_repo]=0
  else
    local line
    local -A data
    for line in ${(f)out}; do
      local key=${line%%=*}
      local val=${line#*=}
      data[$key]=$val
    done

    PROMPT_GIT_STATE[in_repo]=${data[in_repo]:-0}
    PROMPT_GIT_STATE[branch]=$data[branch]
    PROMPT_GIT_STATE[dirty]=${data[dirty]:-0}
    PROMPT_GIT_STATE[ahead]=${data[ahead]:-0}
    PROMPT_GIT_STATE[behind]=${data[behind]:-0}
    PROMPT_GIT_STATE[stash]=${data[stash]:-0}
  fi

  _prompt_build_preprompt

  if zle; then
    zle reset-prompt
  fi
}

_prompt_format_path() {
  emulate -L zsh
  setopt noshwordsplit

  local path_layers=${PURE_PROMPT_PATH_LAYERS:-3}

  # 1) When inside a git repo, only show the basename (last component).
  if [[ ${PROMPT_GIT_STATE[in_repo]:-0} -eq 1 ]]; then
    if [[ $PWD == $HOME ]]; then
      print '~'
    else
      print "${PWD:t}"
    fi
    return
  fi

  # 2) Outside git repos: use N-layer truncation with "../" when truncated.
  local full short base

  # %~ = full path with ~ for HOME
  full=${(%):-%~}
  # %N~ = last N components
  short=${(%):-%${path_layers}~}

  # Not truncated: just use the normal short path.
  if [[ $full == $short ]]; then
    print "$short"
    return
  fi

  # Truncated: prefix "../" and strip leading "~/" or "/"
  base=$short

  if [[ $base == ~/* ]]; then
    base=${base#\~/}
  elif [[ $base == ~ ]]; then
    base=""
  elif [[ $base == /* ]]; then
    base=${base#/}
  fi

  if [[ -n $base ]]; then
    print "../$base"
  else
    print ".."
  fi
}

# ----------------------------
# Preprompt builder (top line)
# ----------------------------

_prompt_build_preprompt() {
  emulate -L zsh
  setopt noshwordsplit

  local -a parts

  # username@host when relevant
  if [[ -n ${PROMPT_STATE[userhost]:-} ]]; then
    parts+=("${PROMPT_STATE[userhost]}")
  fi

  # Path: formatted according to our rules (git basename vs "../rest")
  local path_str=$(_prompt_format_path)
  parts+=("%F{${PROMPT_COLORS[path]}}${path_str}%f")

  # Git info
  if [[ ${PROMPT_GIT_STATE[in_repo]:-0} -eq 1 ]]; then
    local branch_color="${PROMPT_COLORS[git_branch]}"
    local branch_name="${PROMPT_GIT_STATE[branch]:-?}"
    local dirty_flag=""

    if [[ ${PROMPT_GIT_STATE[dirty]:-0} -eq 1 ]]; then
      branch_color="${PROMPT_COLORS[git_dirty]}"
      dirty_flag="*"
    fi

    parts+=("%F{${branch_color}}${branch_name}%f${dirty_flag}")

    # Ahead / behind arrows
    local arrows=""
    (( ${PROMPT_GIT_STATE[behind]:-0} > 0 )) && arrows+="${PURE_GIT_DOWN_ARROW:-⇣}"
    (( ${PROMPT_GIT_STATE[ahead]:-0}  > 0 )) && arrows+="${PURE_GIT_UP_ARROW:-⇡}"
    if [[ -n $arrows ]]; then
      parts+=("%F{${PROMPT_COLORS[git_arrow]}}${arrows}%f")
    fi

    # Stash indicator
    if (( ${PROMPT_GIT_STATE[stash]:-0} > 0 )); then
      parts+=("%F{${PROMPT_COLORS[git_stash]}}${PURE_GIT_STASH_SYMBOL:-≡}%f")
    fi
  fi

  PROMPT_PREPROMPT="${(j: :)parts}"
}

# ----------------------
# Vim-mode prompt symbol
# ----------------------

_prompt_reset_prompt_symbol() {
  PROMPT_STATE[prompt_symbol]=${PURE_PROMPT_SYMBOL:-❯}
}

_prompt_update_vim_prompt_symbol() {
  emulate -L zsh
  setopt noshwordsplit

  case $KEYMAP in
    vicmd) PROMPT_STATE[prompt_symbol]=${PURE_PROMPT_VICMD_SYMBOL:-❮} ;;
    *)     PROMPT_STATE[prompt_symbol]=${PURE_PROMPT_SYMBOL:-❯} ;;
  esac

  if zle; then
    zle reset-prompt
  fi
}

# Wrapper so we can use it with add-zle-hook-widget
_prompt_reset_prompt_symbol_widget() {
  _prompt_reset_prompt_symbol
}

# -----
# Hooks
# -----

_prompt_precmd() {
  emulate -L zsh
  setopt noshwordsplit

  _prompt_update_userhost

  # psvar[12] is used for venv / conda / nix-shell
  psvar[12]=''

  if [[ -n $CONDA_DEFAULT_ENV ]]; then
    psvar[12]="${CONDA_DEFAULT_ENV//[$'\t\r\n']}"
  elif [[ -n $VIRTUAL_ENV ]]; then
    # Respect user override: if they explicitly set VIRTUAL_ENV_DISABLE_PROMPT to something else,
    # don't hijack.
    if [[ -z $VIRTUAL_ENV_DISABLE_PROMPT || $VIRTUAL_ENV_DISABLE_PROMPT = 12 ]]; then
      psvar[12]="${VIRTUAL_ENV:t}"
      export VIRTUAL_ENV_DISABLE_PROMPT=12
    fi
  fi

  if zstyle -T ":prompt:pure:environment:nix-shell" show 2>/dev/null; then
    if [[ -n $IN_NIX_SHELL ]]; then
      psvar[12]="${name:-nix-shell}"
    fi
  fi

  _prompt_reset_prompt_symbol
  _prompt_git_schedule
  _prompt_build_preprompt

  # Basic warning if an Oh My Zsh theme is still enabled
  if [[ -n $ZSH_THEME ]]; then
    print "WARNING: ZSH_THEME='${ZSH_THEME}' is set. This custom prompt may not display correctly."
    unset ZSH_THEME
  fi
}

_prompt_preexec() {
  # Keep Python virtualenv from overwriting the prompt
  export VIRTUAL_ENV_DISABLE_PROMPT=${VIRTUAL_ENV_DISABLE_PROMPT:-12}
}

# ------------
# Prompt setup
# ------------

prompt_pure_setup() {
  setopt prompt_subst
  export PROMPT_EOL_MARK=''

  zmodload zsh/zle 2>/dev/null
  zmodload zsh/parameter 2>/dev/null
  autoload -Uz add-zsh-hook
  autoload -Uz +X add-zle-hook-widget 2>/dev/null

  _prompt_setup_colors

  add-zsh-hook precmd  _prompt_precmd
  add-zsh-hook preexec _prompt_preexec

  # Initial state
  _prompt_reset_prompt_symbol
  _prompt_update_userhost
  _prompt_build_preprompt

  # Top of bottom line: venv name (if any). Then prompt symbol, with vi-mode flip.
  local venv_part="%(12V.%F{${PROMPT_COLORS[venv]}}%12v%f .)"

  local main_indicator="%(?.%F{${PROMPT_COLORS[prompt_ok]}}.%F{${PROMPT_COLORS[prompt_error]}})\${PROMPT_STATE[prompt_symbol]}%f "

  # First line: ${PROMPT_PREPROMPT}
  # Second line: venv + prompt symbol
	PROMPT=$'\n''${PROMPT_PREPROMPT}'$'\n'"${venv_part}${main_indicator}"

  # Continuation prompt: double prompt symbol on wrapped lines
  local cont_indicator="%(?.%F{${PROMPT_COLORS[prompt_ok]}}.%F{${PROMPT_COLORS[prompt_error]}})\${PROMPT_STATE[prompt_symbol]}\${PROMPT_STATE[prompt_symbol]}%f "
  PROMPT2="%F{${PROMPT_COLORS[continuation]}}… %f${cont_indicator}"

  RPROMPT=""

  # Vi mode prompt symbol flip
  zle -N _prompt_update_vim_prompt_symbol
  zle -N _prompt_reset_prompt_symbol_widget

  if (( $+functions[add-zle-hook-widget] )); then
    add-zle-hook-widget zle-keymap-select _prompt_update_vim_prompt_symbol
    add-zle-hook-widget zle-line-finish _prompt_reset_prompt_symbol_widget
  fi

  # Prevent (ana)conda from clobbering PS1
  export CONDA_CHANGEPS1=no
}

# Run setup immediately when this file is sourced
prompt_pure_setup "$@"

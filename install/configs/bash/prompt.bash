# ~/.config/bash/prompt.bash
# Bash prompt configuration

# ---------- Bash prompt: colors & state ----------

# Color helpers (wrap escape codes in \[ \] so readline knows their width)
RESET='\[\e[0m\]'

COLOR_PATH='\[\e[34m\]'            # blue
COLOR_GIT_BRANCH='\[\e[38;5;242m\]'
COLOR_GIT_DIRTY='\[\e[38;5;218m\]'
COLOR_USER='\[\e[38;5;242m\]'
COLOR_USER_ROOT='\[\e[0m\]'        # default
COLOR_HOST='\[\e[38;5;242m\]'
COLOR_VENV='\[\e[38;5;242m\]'
COLOR_PROMPT_OK='\[\e[35m\]'       # magenta
COLOR_PROMPT_ERROR='\[\e[31m\]'
COLOR_CONTINUATION='\[\e[38;5;242m\]'

# Git state for prompt
PROMPT_IN_GIT=0
PROMPT_GIT_BRANCH=""
PROMPT_GIT_DIRTY=""

# Path truncation layers (same as PURE_PROMPT_PATH_LAYERS in Zsh)
: "${PURE_PROMPT_PATH_LAYERS:=3}"

# Git dirty symbol (same as PURE_GIT_DIRTY in Zsh)
: "${PURE_GIT_DIRTY:=*}"

# Prompt symbol (same as PURE_PROMPT_SYMBOL in Zsh)
: "${PURE_PROMPT_SYMBOL:=❯}"

# Detect if inside a container (docker/podman/etc.)
_prompt_is_inside_container() {
	[[ -f "/.dockerenv" ]] && return 0
	[[ -f "/run/.containerenv" ]] && return 0
	if [[ -r /proc/1/cgroup ]] && grep -Eq '(docker|kubepods|containerd|lxc)' /proc/1/cgroup 2>/dev/null; then
		return 0
	fi
	return 1
}

# ---------- Git info (branch + dirty only, sync) ----------

_prompt_git_info() {
	PROMPT_IN_GIT=0
	PROMPT_GIT_BRANCH=""
	PROMPT_GIT_DIRTY=""

	# Are we in a git repo?
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

	PROMPT_IN_GIT=1

	# Branch name (or short SHA as fallback)
	PROMPT_GIT_BRANCH=$(
		git symbolic-ref --short HEAD 2>/dev/null ||
			git rev-parse --short HEAD 2>/dev/null ||
			echo '?'
		)

		local dirty=0

		# Detect dirty status (tracked + untracked)
		if git rev-parse --verify HEAD >/dev/null 2>&1; then
			if ! git diff-index --quiet HEAD -- 2>/dev/null; then
				dirty=1
			fi
		fi

		if [[ -n "$(git status --porcelain --untracked-files=normal 2>/dev/null)" ]]; then
			dirty=1
		fi

		if [[ $dirty -eq 1 ]]; then
			PROMPT_GIT_DIRTY="$PURE_GIT_DIRTY"
		else
			PROMPT_GIT_DIRTY=""
		fi
	}

# ---------- Path formatting ----------
# - Inside git repo: show only basename (or ~ for $HOME).
# - Outside git: show last N components, and if truncated, prefix "../rest/of/path".

_prompt_format_path() {
	local layers=${PURE_PROMPT_PATH_LAYERS:-3}

	# In git repo: just basename (or ~ for $HOME)
	if [[ ${PROMPT_IN_GIT:-0} -eq 1 ]]; then
		if [[ $PWD == "$HOME" ]]; then
			printf '~'
		else
			printf '%s' "${PWD##*/}"
		fi
		return
	fi

	local -a segments=()
	local segcount
	local rel=""

	if [[ $PWD == "$HOME" ]]; then
		segments=( "~" )
	elif [[ $PWD == "$HOME"/* ]]; then
		rel=${PWD#"$HOME"/}      # e.g. ".local/share/applications"
		IFS='/' read -r -a segments_rest <<< "$rel"
		segments=( "~" "${segments_rest[@]}" )
	else
		# Not under $HOME
		local path="${PWD%/}"
		if [[ $path == "/" ]]; then
			segments=( "/" )
		else
			path="${path#/}"        # strip leading /
			IFS='/' read -r -a segments <<< "$path"
		fi
	fi

	segcount=${#segments[@]}

		if (( segcount <= layers )); then
			if [[ $PWD == "$HOME" ]]; then
				printf '~'
			elif [[ $PWD == "$HOME"/* ]]; then
				# rel may be empty if somehow not set; recompute just in case
				[[ -z $rel ]] && rel=${PWD#"$HOME"/}
				printf '~/%s' "$rel"
			else
				printf '%s' "$PWD"
			fi
			return
		fi

		local start=$((segcount - layers))
		local i tail=""
		for (( i=start; i<segcount; i++ )); do
			[[ $i -gt $start ]] && tail+='/'
			tail+="${segments[i]}"
		done

		printf '../%s' "$tail"
	}

# ---------- SSH / root / container aware user@host ----------

_prompt_userhost() {
	local ssh="${SSH_CONNECTION:-$PROMPT_SSH_CONNECTION}"
	local user_color host_color
	local out=""

	# Simple SSH detection is usually enough; we don't bother with fancy who-parsing here.
	# You can extend this if you really want the "lost SSH_CONNECTION" fix from Zsh.
	if [[ -z $ssh ]]; then
		ssh=""
	fi

	if (( EUID == 0 )); then
		user_color=$COLOR_USER_ROOT
	else
		user_color=$COLOR_USER
	fi
	host_color=$COLOR_HOST

	# Show user@host if: SSH, container, or root.
	if [[ -n $ssh ]] || _prompt_is_inside_container || (( EUID == 0 )); then
		out+="${user_color}\u${RESET}${host_color}@\h${RESET} "
	fi

	printf '%s' "$out"
}

# ---------- Main prompt builder ----------

_prompt_update_prompt() {
	local exit_status=$?   # MUST be first: captures status of last command

	# 1) Git info (sets PROMPT_IN_GIT, PROMPT_GIT_BRANCH, PROMPT_GIT_DIRTY)
	_prompt_git_info

	# 2) Path string according to our rules
	local path_str
	path_str=$(_prompt_format_path)

	# 3) user@host (only when SSH/container/root)
	local user_host
	user_host=$(_prompt_userhost)

	# 4) Top line: user@host + path + git
	local top_line=""
	top_line+="${user_host}${COLOR_PATH}${path_str}${RESET}"

	if [[ ${PROMPT_IN_GIT:-0} -eq 1 && -n ${PROMPT_GIT_BRANCH:-} ]]; then
		top_line+=" ${COLOR_GIT_BRANCH}${PROMPT_GIT_BRANCH}${RESET}"
		if [[ -n ${PROMPT_GIT_DIRTY:-} ]]; then
			top_line+="${COLOR_GIT_DIRTY}${PROMPT_GIT_DIRTY}${RESET}"
		fi
	fi

	# 5) Venv / conda / nix-shell name
	local venv_name=""
	if [[ -n ${CONDA_DEFAULT_ENV:-} ]]; then
		venv_name=$CONDA_DEFAULT_ENV
	elif [[ -n ${VIRTUAL_ENV:-} ]]; then
		venv_name=${VIRTUAL_ENV##*/}
	elif [[ -n ${IN_NIX_SHELL:-} ]]; then
		venv_name="nix-shell"
	fi

	local venv_part=""
	if [[ -n $venv_name ]]; then
		venv_part="${COLOR_VENV}${venv_name}${RESET} "
	fi

	# 6) Prompt symbol color based on last exit status
	local prompt_color
	if [[ $exit_status -eq 0 ]]; then
		prompt_color=$COLOR_PROMPT_OK
	else
		prompt_color=$COLOR_PROMPT_ERROR
	fi

	local symbol="$PURE_PROMPT_SYMBOL"

	# PS1:
	#   blank line
	#   top line: userhost + path + git
	#   bottom line: venv + colored symbol
	PS1="\n${top_line}\n${venv_part}${prompt_color}${symbol}${RESET} "

	# PS2 (continuation prompt): grey ellipsis + double symbol
	PS2="${COLOR_CONTINUATION}… ${RESET}${prompt_color}${symbol}${symbol}${RESET} "
}

# Hook our function into PROMPT_COMMAND
PROMPT_COMMAND=_prompt_update_prompt

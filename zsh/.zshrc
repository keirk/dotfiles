# ~/.zshrc

# Add mise to PATH (no eval, correct quoting)
export PATH="/Users/keirk/.local/bin:$PATH"

export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command /Users/keirk/.local/bin/mise
    return
  fi
  shift

  case "$command" in
    deactivate|shell|sh)
      # if argv doesn't contain -h or --help
      if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
        eval "$(command /Users/keirk/.local/bin/mise "$command" "$@")"
        return $?
      fi
      ;;
  esac
  command /Users/keirk/.local/bin/mise "$command" "$@"
}

_mise_hook() {
  eval "$(/Users/keirk/.local/bin/mise hook-env -s zsh)"
}

typeset -ag precmd_functions
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=(_mise_hook ${precmd_functions[@]})
fi

typeset -ag chpwd_functions
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=(_mise_hook ${chpwd_functions[@]})
fi

_mise_hook

if [ -z "${_mise_cmd_not_found:-}" ]; then
  _mise_cmd_not_found=1
  # preserve existing handler if present
  if typeset -f command_not_found_handler >/dev/null; then
    functions -c command_not_found_handler _command_not_found_handler
  fi

  typeset -gA _mise_cnf_tried

  _mise_fallback() {
    local _cmd="$1"; shift
    if typeset -f _command_not_found_handler >/dev/null; then
      _command_not_found_handler "$_cmd" "$@"
      return $?
    else
      print -u2 -- "zsh: command not found: $_cmd"
      return 127
    fi
  }

  command_not_found_handler() {
    local cmd="$1"; shift

    if [[ "$cmd" == "mise" || "$cmd" == mise-* || -n "${_mise_cnf_tried["$cmd"]}" ]]; then
      _mise_fallback "$cmd" "$@"
      return $?
    fi

    if /Users/keirk/.local/bin/mise hook-not-found -s zsh -- "$cmd"; then
      _mise_hook
      if command -v -- "$cmd" >/dev/null 2>&1; then
        "$cmd" "$@"
        return $?
      fi
    else
      _mise_cnf_tried["$cmd"]=1
    fi

    _mise_fallback "$cmd" "$@"
  }
fi


# claude 
alias yolo="claude --dangerously-skip-permissions"

# Java (macOS)
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$JAVA_HOME/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

[ -f "/Users/keirk/.ghcup/env" ] && . "/Users/keirk/.ghcup/env" # ghcup-envexport PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Added by Antigravity
export PATH="/Users/keirk/.antigravity/antigravity/bin:$PATH"

eval "$(starship init zsh)"


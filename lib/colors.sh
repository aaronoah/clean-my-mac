colors() {
  if which tput >/dev/null 2>&1; then
    local colors=$(tput colors)
  fi

  local RED=""
  local BLUE=""
  local GREEN=""
  local YELLOW=""
  local NORMAL=""

  if [ -n "$colors" ] && [ "$colors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    BLUE="$(tput setaf 4)"
    GREEN="$(tput setaf 6)"
    YELLOW="$(tput setaf 3)"
    NORMAL="$(tput sgr0)"
  fi

  export RED
  export BLUE
  export GREEN
  export YELLOW
  export NORMAL
}

colors
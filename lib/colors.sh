colors() {
  if which tput >/dev/null 2>&1; then
    local colors=$(tput colors)
  fi

  if [ -n "$colors" ] && [ "$colors" -ge 8 ]; then
    local RED="$(tput setaf 1)"
    local BLUE="$(tput setaf 4)"
    local GREEN="$(tput setaf 6)"
    local YELLOW="$(tput setaf 3)"
    local NORMAL="$(tput sgr0)"
  else
    local RED=""
    local BLUE=""
    local GREEN=""
    local YELLOW=""
    local NORMAL=""
  fi

  export $RED
  export $BLUE
  export $GREEN
  export $YELLOW
  export $NORMAL
}

colors
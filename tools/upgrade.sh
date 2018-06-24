#!/bin/bash

upgrade() {
  local colors
  local RED
  local BLUE
  local GREEN
  local YELLOW
  local NORMAL

  if which tput >/dev/null 2>&1; then
    colors=$(tput colors)
  fi

  if [[ -n "$colors" ]] && [[ "$colors" -ge 8 ]]; then
    RED="$(tput setaf 1)"
    BLUE="$(tput setaf 4)"
    GREEN="$(tput setaf 6)"
    YELLOW="$(tput setaf 3)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    BLUE=""
    GREEN=""
    YELLOW=""
    NORMAL=""
  fi

  command -v git >/dev/null 2>&1 || {
    printf "${RED}Error: git is not installed"
    exit 1
  }

  printf "${BLUE}Updating Clean My Mac ...${NORMAL}\n"
  cd "$CLEAN_MY_MAC"
  git pull --rebase --stat origin master && {
    printf "${GREEN}"
    echo '           __                                                                         '
    echo '     ___  / /   ___   _____  ____         ____ ___  __  __     ____ ___   _____   ___ '
    echo '   / ___\/ /  / _  \/ __  / / __  \      / __ `__ \/ / / /    / __ `__ \/ __  / / ___\'
    echo '  / /   / /  / /__\/ / / / / /  / /     / / / / / / / / /    / / / / / / / / / / /    '
    echo ' / /   / /  / ____/ / / / / /  / /     / / / / / / / / /    / / / / / / / / / / /     '
    echo '/ /___/ /__/ /___/ /_/  \/ /  / /_    / / / / / / /_/ /    / / / / / / /_/  \/ /___   '
    echo '\____/\___/\____/\______/__\  \__/   /_/ /_/ /_/\__  /    /_/ /_/ /_/\______/\____/   '
    echo '                                               ___/ /                                 '
    echo '                                             /_____/                                  '
    echo 'Awesome! your Clean My Mac is updated and/or at the current version. Enjoy'
    printf "${NORMAL}"
  } || {
    printf "${RED}Error: updating failed, try again later?${NORMAL}\n"
  }

}

upgrade
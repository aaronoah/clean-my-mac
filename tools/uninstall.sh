#!/bin/bash

uninstall_clean_my_mac() {
  source "$CLEAN_MY_MAC/lib/detect.sh"

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

  printf "Are you sure you want to remove Clean My Mac? [y/N] ${BLUE}"
  read confirmation
  if [[ "$confirmation" != y ]] && [[ "$confirmation" != Y ]] && [[ "$confirmation" != yes ]]; then
    echo "Uninstall cancelled"
    printf "${NORMAL}"
    exit
  fi

  printf "${BLUE}Removing $CLEAN_MY_MAC\n"
  if [[ -d "$CLEAN_MY_MAC" ]]; then
    rm -rf $CLEAN_MY_MAC
  fi

  if [[ -f "$HOME/.cleanmmrc" ]]; then
    rm "$HOME/.cleanmmrc"
  fi
  printf "done.${NORMAL}\n\n"

  printf "${BLUE}Thanks for using Clean My Mac.\n"
  printf "${NORMAL}"
}

uninstall_clean_my_mac
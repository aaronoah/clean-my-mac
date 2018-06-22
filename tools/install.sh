#!/bin/bash

{
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

  set -e # exit on errors

  if [[ ! -n "$CLEAN_MY_MAC" ]]; then
    CLEAN_MY_MAC=$HOME/.clean-my-mac
  fi

  if [[ -d "$CLEAN_MY_MAC" ]]; then
    printf "${YELLOW}Clean-My-Mac is already installed.${NORMAL}\n"
    printf "You'll need to remove $CLEAN_MY_MAC if you wish to reinstall.\n"
    printf "If you need to update Clean My Mac, run `upgrade_clean_my_mac`\n"
    exit
  fi

  command -v git >/dev/null 2>&1 || {
    printf "${RED}Error: git is not installed.\n"
    exit 1
  }

  umask g=w,o=w # revoke group user and other user write permissions

  printf "${BLUE}Cloning Clean My Mac...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }

  env git clone --depth=1 https://github.com/aaronoah/clean-my-mac.git "$CLEAN_MY_MAC" >/dev/null 2>&1 || {
    printf "${RED}Error: git clone of clean-my-mac failed.\n"
    exit 1
  }

  source "$CLEAN_MY_MAC/lib/detect_profile.sh"

  printf "${BLUE}Using the Clean My Mac template file and add it to ~/.cleanmmrc${NORMAL}\n"
  cp "$CLEAN_MY_MAC/templates/cleanmmrc.template" "$HOME/.cleanmmrc"

  printf "${BLUE}Build Clean My Mac...${NORMAL}\n"
  mkdir "$CLEAN_MY_MAC/bin/"
  cp "${CLEAN_MY_MAC}/clean_my_mac.sh" "${CLEAN_MY_MAC}/bin/clean_my_mac"
  chmod +x "${CLEAN_MY_MAC}/bin/clean_my_mac"
  cp "${CLEAN_MY_MAC}/tools/uninstall.sh" "${CLEAN_MY_MAC}/bin/uninstall_clean_my_mac"
  chmod +x "${CLEAN_MY_MAC}/bin/uninstall_clean_my_mac"

  printf "${BLUE}Finalizing...${NORMAL}\n"
  PROFILE=$(detect_profile)
  echo "export CLEAN_MY_MAC=$CLEAN_MY_MAC" >> $PROFILE
  echo "export PATH=\$CLEAN_MY_MAC/bin:\$PATH" >> $PROFILE

  printf "${GREEN}"
  echo '           __                                                                                      '
  echo '     ___  / /    ___    _____   ____          ______  ___  __   __      _____  ____   _____    ___ '
  echo '   / ___\/ /   / _  \ / __  / /  __  \       /  __  `__  \/  / /  /    /  __ ` __  \/  __  / / ___\'
  echo '  / /   / /   / /__\/  / / / /  /  / /      /  / /  / /  /  / /  /    /  / /  / /  /  / / / / /    '
  echo ' / /   / /   / ____/  / / / /  /  / /      /  / /  / /  /  / /  /    /  / /  / /  /  / / / / /     '
  echo '/ /___/ /___/ /___/  /_/  \/  /  / /_     /  / /  / /  /  /_/  /    /  / /  / /  /  /_/  \/ /___   '
  echo '\____/\____/\____/\_______/___\   \__/   /__/ /__/ /__/\____  /    /__/ /__/ /__/\_______/\____/   '
  echo '                                                      ___ /  /                                     '
  echo '                                                     /______/                                      ...is now installed!'
  echo ''
  printf "${NORMAL}"
  source "$HOME/.cleanmmrc"
}
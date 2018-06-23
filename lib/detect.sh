detect_profile() {
  local DETECTED_PROFILE=''

  if [[ -n "$BASH_VERSION" ]]; then
    if [[ -f "$HOME/.bashrc" ]]; then
      DETECTED_PROFILE="$HOME/.bashrc"
    fi
  elif [[ -n "$ZSH_VERSION" ]]; then
    if [[ -f "$HOME/.zshrc" ]]; then
      DETECTED_PROFILE="$HOME/.zshrc"
    fi
  fi

  echo $DETECTED_PROFILE
}

detect_shell() {
  local DETECTED_SHELL=''

  if [[ -n "$BASH_VERSION" ]]; then
    DETECTED_SHELL="bash"
  elif [[ -n "$ZSH_VERSION" ]]; then
    DETECTED_SHELL="zsh"
  fi

  echo $DETECTED_SHELL
}
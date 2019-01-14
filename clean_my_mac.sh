source "$CLEAN_MY_MAC/lib/targets.sh"
source "$CLEAN_MY_MAC/lib/detect.sh"

clean_my_mac() {

  # add extra commands to run for clean script
  # CAUTIOUS! THESE COMMANDS WILL BE RUN WHEN
  # RUNNING CLEAN_MY_MAC, DON'T GRANT ROOT
  # ACCESS TO ANY OF THEM IN THE FILE
  if [[ $1 == "extra" ]]; then
    vim "$CLEAN_MY_MAC/bin/extra.sh"
    chmod +x "$CLEAN_MY_MAC/bin/extra.sh"
    echo "" >> "$CLEAN_MY_MAC/bin/extra.sh"
  fi

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

  set -f # disable globbing

  local CLEAN_TARGETS=$(targets)
  local TARGETS=( $(echo $CLEAN_TARGETS | tr ':' ' ') )

  for target in ${TARGETS[@]}; do
    set +f
    if [[ "$(detect_shell)" = "zsh" ]]; then
      if [ $(command find ${~target} 2>/dev/null | wc -l) -eq 0 ]; then
        continue
      fi
      printf "${BLUE}Estimating size of ${~target} ... "
      space=$(command du -ch ${~target} | tail -n 1 | cut -f 1)

      printf "$space.${NORMAL}\n"
      printf "${BLUE}Removing ${~target} ... "
      rm -rf ${~target} >/dev/null 2>&1 || {
        printf "${RED}Error removing ${target}.${NORMAL}\n"
      }
    elif [[ "$(detect_shell)" = "bash" ]]; then
      if [ $(command find ${target} 2>/dev/null | wc -l) -eq 0 ]; then
        continue
      fi
      printf "${BLUE}Estimating size of ${target} ... "
      space=$(command du -ch ${target} | tail -n 1 | cut -f 1)

      printf "$space.${NORMAL}\n"
      printf "${BLUE}Removing $target ... "
      rm -rf ${target} >/dev/null 2>&1 || {
        printf "${RED}Error removing ${target}.${NORMAL}\n"
      }
    fi

    printf "${BLUE}done.\n"
    printf "${NORMAL}"
    set -f
  done

  # run extra commands
  if [[ -f "$CLEAN_MY_MAC/bin/extra.sh" ]]; then
    set -v # turn on verbose
    sh "$CLEAN_MY_MAC/bin/extra.sh"
    set +v
  fi

  set +f

  local SYSTEM_CACHES="/tmp, /var, /private"
  printf "\n${YELLOW}If you wish to optimize your system caches in $SYSTEM_CACHES, reboot your Mac\n"
  printf "${YELLOW}Don't manually delete ANY files in there, it could crash your Mac\n${NORMAL}"
  # DON'T EVER TRY MANUALLY DELETE SYSTEM FOLDERS, YOUR MAC MIGHT GET INTO TROUBLE!!
  # reboot to let Max OSX itself clear out junk files in /tmp, /private and /var,
  # if things still don't work out, try reboot Mac into safe mode, see http://osxdaily.com/2010/04/20/using-safe-boot-mode-in-mac-os-x/

}

clean_my_mac
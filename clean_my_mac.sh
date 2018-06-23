source "$CLEAN_MY_MAC/lib/colors.sh"
source "$CLEAN_MY_MAC/lib/targets.sh"
source "$CLEAN_MY_MAC/lib/detect.sh"

clean_my_mac() {
  set -f # disable globbing

  CLEAN_TARGETS=$(targets)
  TARGETS=( $(echo $CLEAN_TARGETS | tr ':' ' ') )

  for target in ${TARGETS[@]}; do
    set +f
    if [[ "$(detect_shell)" = "zsh" ]]; then
      if [ $(command find ${~target} 2>/dev/null | wc -l) -eq 0 ]; then
        continue
      fi
      printf "${YELLOW}Estimating size of ${~target} ... "
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
      printf "${YELLOW}Estimating size of ${target} ... "
      space=$(command du -ch ${target} | tail -n 1 | cut -f 1)

      printf "$space.${NORMAL}\n"
      printf "${BLUE}Removing $target ... "
      rm -rf ${target} >/dev/null 2>&1 || {
        printf "${RED}Error removing ${target}.${NORMAL}\n"
      }
    fi

    printf "${BLUE}done.${NROMAL}\n"
    set -f
  done

  set +f

  local SYSTEM_CACHES="/tmp, /var, /private"
  printf "${YELLOW}If you wish to optimize your system caches in $SYSTEM_CACHES, reboot your Mac\n"
  printf "${YELLOW}Don't manually delete ANY files in there, it could crash your Mac\n"
  # DON'T EVER TRY MANUALLY DELETE SYSTEM FOLDERS, YOUR MAC MIGHT GET INTO TROUBLE!!
  # reboot to let Max OSX itself clear out junk files in /tmp, /private and /var,
  # if things still don't work out, try reboot Mac into safe mode, see http://osxdaily.com/2010/04/20/using-safe-boot-mode-in-mac-os-x/

}

clean_my_mac
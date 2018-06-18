source "$CLEAN_MY_MAC/lib/colors.sh"
source "$CLEAN_MY_MAC/lib/targets.sh"

space_convert() {
  local number=$(expr $1 + 0)
  local UNITS=("K" "M" "G" "T")
  for unit in ${UNITS[@]}; do
    if [[ number > 1024 ]]; then
      number=$(expr $number / 1024)
    else
      echo "$number$unit"
      break
    fi
  done
}

clean_my_mac() {

  local total=0

  for target in ${targets[@]}; do
    find ${target} >/dev/null 2>&1 || {
      printf "${RED}Error: ${target} does not exist${NORMAL}"
      continue
    }
    printf "${YELLOW}Estimating size of ${target} ... "
    local space=$(du -shk ${target} | cut -f 1)
    total=$(expr $total + space)
    printf "$(space_convert $space).${NORMAL}\n"
    printf "${BLUE}Removing ${target} ... "
    rm -rf ${target} >/dev/null 2>&1 || {
      printf "${RED}Error removing ${target}.${NORMAL}\n"
    }
    printf "${BLUE}done.${NROMAL}\n"
  done

  printf "${GREEN}Clean up of total size: $(space_convert $total).${NORMAL}\n\n"

  local SYSTEM_CACHES=("/tmp" "var/" "private")
  printf "${YELLOW}If you wish to optimize your system caches in $SYSTEM_CACHES, reboot your Mac\n"
  printf "${YELLOW}Don't manually delete ANY files in there, it could crash your Mac\n"
  # DON'T EVER TRY MANUALLY DELETE SYSTEM FOLDERS, YOUR MAC MIGHT GET INTO TROUBLE!!
  # reboot to let Max OSX itself clear out junk files in /tmp, /private and /var,
  # if things still don't work out, try reboot Mac into safe mode, see http://osxdaily.com/2010/04/20/using-safe-boot-mode-in-mac-os-x/

}

clean_my_mac
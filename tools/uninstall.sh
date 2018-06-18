#!/bin/bash

source "$CLEAN_MY_MAC/lib/colors.sh"

printf "Are you sure you want to remove Clean My Mac? [y/N] ${BLUE}"
read confirmation
if [[ "$confirmation" != y ]] && [[ "$confirmation" != Y ]] && [[ "$confirmation" != yes ]]; then
  echo "Uninstall cancelled"
  exit
fi

printf "${BLUE}Removing ~/.clean-my-mac"
if [[ -d "$CLEAN_MY_MAC" ]]; then
  rm -rf $CLEAN_MY_MAC
fi
printf "done.${NORMAL}\n\n"

echo "${BLUE}Thanks for using Clean My Mac.${NORMAL}\n"
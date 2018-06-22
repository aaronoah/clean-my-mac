targets() {
  local TRASH_FOLDER="$HOME/.Trash"
  local USER_CACHE="$HOME/Library/Caches/*"
  local USER_LOGS="$HOME/Library/Logs"
  local APP_CACHE="$HOME/Library/Containers/*/Data/Library/Caches/*"

  export targets=($USER_CACHE $USER_LOGS $APP_CACHE $TRASH_FOLDER)
}

targets
targets() {
  local TRASH_FOLDER="$HOME/.Trash/*"
  local USER_CACHE="$HOME/Library/Caches/*"
  local USER_LOGS="$HOME/Library/Logs/*"
  local APP_CACHE="$HOME/Library/Containers/*/Data/Library/Caches/*"

  echo "$TRASH_FOLDER:$USER_CACHE:$USER_LOGS:$APP_CACHE"
}
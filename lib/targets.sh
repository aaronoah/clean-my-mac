targets() {
  local USER_CACHE="$HOME/Library/Caches/*"
  local USER_LOGS="$HOME/Library/Logs/*"
  local APP_CACHE="$HOME/Library/Containers/*/Data/Library/Caches/*"

  echo "$USER_CACHE:$USER_LOGS:$APP_CACHE"
}
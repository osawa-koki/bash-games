# !/bin/bash

# defining special chars.
readonly LF=$'\n'
readonly CR=$'\r'
readonly TAB=$'\t'
readonly NULL=$'\0'

game=$1

case "$1" in
  "add-nums")
    add-nums
    ;;
  "n")
    echo "NO"
    ;;
  *)
    echo "undefined";;
esac

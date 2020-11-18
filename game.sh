# !/bin/bash

# defining special chars.
readonly LF=$'\n'
readonly CR=$'\r'
readonly TAB=$'\t'
readonly NULL=$'\0'
readonly FG_BLACK=$'\e[30m'
readonly FG_RED=$'\e[31m'
readonly FG_GREEN=$'\e[32m'
readonly FG_YELLOW=$'\e[33m'
readonly FG_BLUE=$'\e[34m'
readonly FG_MAGENTA=$'\e[35m'
readonly FG_CYAN=$'\e[36m'
readonly FG_WHITE=$'\e[37m'
readonly FG_DEFAULT=$'\e[39m'
readonly BG_BLACK=$'\e[40m'
readonly BG_RED=$'\e[41m'
readonly BG_GREEN=$'\e[42m'
readonly BG_YELLOW=$'\e[43m'
readonly BG_BLUE=$'\e[44m'
readonly BG_MAGENTA=$'\e[45m'
readonly BG_CYAN=$'\e[46m'
readonly BG_WHITE=$'\e[47m'
readonly BG_DEFAULT=$'\e[49m'
readonly RESET=$'\e[0m'

game=$1

function add-nums() {
  prev_is_correct=$NULL
  total_timespan=0
  total=0
  correct=0
  question_count=10
  for i in $(seq 1 $question_count); do
    clear
    if [ "$prev_is_correct" = "$NULL" ]; then
      echo "${FG_MAGENTA}Let's start!${FG_DEFAULT}"
    elif "${prev_is_correct}"; then
      echo "Your answer is OK"
    else
      echo "Your answer is NG"
    fi
    num1=$((RANDOM % 10))
    num2=$((RANDOM % 10))
    num3=$((RANDOM % 10))
    num4=$((RANDOM % 10))
    answer=$(($num1 + $num2 + $num3 + $num4))
    echo ""
    echo "${TAB}$num1 + $num2 + $num3 + $num4 = ???"
    echo ""
    echo -n "${TAB}${TAB}${TAB} -> "
    read input
    if [ "$input" = "$answer" ]; then
      prev_is_correct=true
    else
      prev_is_correct=false
    fi
  done
}

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

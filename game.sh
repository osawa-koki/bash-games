# !/bin/bash

# defining special chars.
readonly LF=$'\n'
readonly CR=$'\r'
readonly TAB=$'\t'
readonly NULL=$'\0'

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
      echo "Let's start!"
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

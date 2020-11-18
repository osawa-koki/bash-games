# !/bin/bash

# defining special chars.
readonly LF=$'\n'
readonly CR=$'\r'
readonly TAB=$'\t'
readonly NULL=$'\0'
readonly FONT_NORMAL=$'\e[0m'
readonly FONT_BOLD=$'\e[1m'
readonly FONT_LIGHT=$'\e[2m'
readonly FONT_ITALIC=$'\e[3m'
readonly FONT_UNDERLINE=$'\e[4m'
readonly FONT_BLINK=$'\e[5m'
readonly FONT_RAPID_BLINK=$'\e[6m'
readonly FONT_REVERSE=$'\e[7m'
readonly FONT_CONCEALED=$'\e[8m'
readonly FONT_CROSSED_OUT=$'\e[9m'
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
      echo "Your answer is ${FG_BLUE}${FONT_BOLD}OK!!!${FONT_NORMAL}${FG_DEFAULT}"
    else
      echo "Your answer is ${FG_RED}${FONT_BOLD}NG...${FONT_NORMAL}${FG_DEFAULT}"
    fi
    # TODO: 0-32767の間で生成されるため、L.C.Mを用いていい感じに修正する。
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
  clear
  your_score=$(($correct * 100 / $question_count))
  echo "${FG_GREEN}"
  echo "${TAB}=============================="
  echo "${TAB}=                            ="
  printf "${TAB}=     ${FG_MAGENTA}Your score is %3d%%${FG_GREEN}     =${LF}" "$your_score"
  echo "${TAB}=                            ="
  echo "${TAB}=============================="
  echo "${FG_DEFAULT}"
}

function just10() {
  clear
  echo ""
  echo "${FG_RED}${FONT_BOLD} $ ${FONT_DEFAULT}${FG_DEFAULT} ${FG_MAGENTA}${FONT_BOLD}just10${FONT_NORMAL}${FG_DEFAULT} ${FG_GREEN}<measure just 10 seconds!>${FG_DEFAULT}"
  echo ""
  echo "${TAB}Press Enter to start."
  echo ""
  echo -n "${TAB}${TAB}${TAB} -> "
  read
  clear
  START=`TZ=JST-9 date +"%S%2N"`
  counter=0
  colors=("${FG_RED}" "${FG_GREEN}" "${FG_YELLOW}" "${FG_BLUE}" "${FG_MAGENTA}" "${FG_CYAN}")
  while true; do
    echo -n "${colors[$((RANDOM % ${#colors[@]}))]}"
    counter=$((counter + 1))
    if [ $counter -eq 50 ]; then
      counter=0
      echo -n "${CR}"
    fi
    echo -n "."
    read -t 0.01
    if [ $? = 0 ]; then
      break
    fi
  done
  END=`TZ=JST-9 date +"%S%2N"`
  clear
  timespan=$(($END - $START))
  result=`echo "scale=3; $timespan / 100" | bc | xargs printf "%.3f${LF}"`
  echo "${FG_BLUE}"
  echo "${TAB}=== ${FG_GREEN}your result${FG_BLUE} =============="
  echo "${TAB}=                            ="
  printf "${TAB}=        ${FG_MAGENTA}${FONT_BOLD}%.3f${FONT_NORMAL}${FG_BLUE} seconds       =${LF}" $result
  echo "${TAB}=                            ="
  echo "${TAB}=============================="
  echo "${FG_DEFAULT}"
}

function blackjack() {
  echo ""
  echo "${FG_RED}${FONT_BOLD} $ ${FONT_DEFAULT}${FG_DEFAULT} ${FG_MAGENTA}${FONT_BOLD}blackjack${FONT_NORMAL}${FG_DEFAULT} ${FG_GREEN}<play blackjack!>${FG_DEFAULT}"
  echo ""
  echo "${TAB}Press Enter to start."
  echo ""
  echo -n "${TAB}${TAB}${TAB} -> "
  read
  # トランプ情報を初期化
  declare -a suits=("♠" "♥" "♦" "♣")
  declare -A number_objects=(["A"]=1 ["2"]=2 ["3"]=3 ["4"]=4 ["5"]=5 ["6"]=6 ["7"]=7 ["8"]=8 ["9"]=9 ["10"]=10 ["J"]=10 ["Q"]=10 ["K"]=10)
  declare -a deck=()
  for suit in ${suits[@]}; do
    for number in ${!number_objects[@]}; do
      mark=${number_objects[${number}]}
      deck+=("$number-$mark-$suit")
    done
  done
  # デッキをシャッフル
  for i in $(seq 1 100); do
    index1=$((RANDOM % ${#deck[@]}))
    index2=$((RANDOM % ${#deck[@]}))
    tmp=${deck[$index1]}
    deck[$index1]=${deck[$index2]}
    deck[$index2]=$tmp
  done
  for card in ${deck[@]}; do
    echo $card
  done
  clear
  # プレイヤーの初期化
  player_score=0
  player_cards=()
  # ディーラーの初期化
  dealer_score=0
  dealer_cards=()
  # 表示関数
  function show() {
    clear
    echo "${FG_BLUE}"
    echo "${TAB}=== ${FG_GREEN}blackjack${FG_BLUE} =============="
    echo "${TAB}=                            ="
    echo "${TAB}= ${FG_MAGENTA}dealer${FG_BLUE} : ${FG_YELLOW}${dealer_cards[@]}${FG_BLUE} ="
    echo "${TAB}= ${FG_MAGENTA}player${FG_BLUE} : ${FG_YELLOW}${player_cards[@]}${FG_BLUE} ="
    echo "${TAB}=                            ="
    echo "${TAB}=============================="
    echo "${FG_DEFAULT}"
  }
  # 最初の2枚を配る
  for i in $(seq 1 2); do
    player_cards+=(${deck[0]})
    player_score=$(($player_score + ${number_objects[${deck[0]%%-*}]}))
    unset deck[0]
    deck=(${deck[@]})
    dealer_cards+=(${deck[0]})
    dealer_score=$(($dealer_score + ${number_objects[${deck[0]%%-*}]}))
    unset deck[0]
    deck=(${deck[@]})
  done
  show false
}

case "$1" in
  "add-nums")
    add-nums
    ;;
  "just10")
    just10
    ;;
  "blackjack")
    blackjack
    ;;
  *)
    echo "undefined";;
esac

# bash-games

bashで動作する簡単なゲーム。  

## add-nums

コンソールに出力される4つの数字の和を計算します。  

![add-nums](./docs/img/add-nums.gif)  

## just10

10秒ぴったりでタイマーを止めます。  

![just10](./docs/img/just10.gif)  

## blackjack

ブラックジャックです。  
トランプの数字の和を21以内で、できるだけ21に近づけます。  
21を超えたらNGです。  

![blackjack](./docs/img/blackjack.gif)  

## 使い方

```shell
./game.sh add-nums
./game.sh just10
./game.sh blackjack
```

<!--
```commit.sh
# !/bin/bash

echo -n "message -> "
read message

TZ=JST-9 date
date=`TZ=JST-9 date -d "2 years ago" +%Y-%m-%dT%T+09:00`

git add .
git commit --allow-empty -m "$message" --date="$date"
git rebase HEAD~1 --committer-date-is-author-date
#git push -u origin
```
-->

#!/bin/bash

echo -n "message -> "
read message

TZ=JST-9 date
date=`TZ=JST-9 date -d "2 years ago" +%Y-%m-%dT%T+09:00`

git add .
git commit --allow-empty -m "$message" --date="$date"
git rebase HEAD~1 --committer-date-is-author-date
#git push -u origin

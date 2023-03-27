#!/bin/bash

set -ueo pipefail

ls *md | sed 's/\.md//g' | awk '{ print "["$0"]("$0".html)" }' >index.md
rm -r .output

REMOTE="$(git remote -v | head -n1 | cut -f2 | cut -d ' ' -f 1)"
git clone --branch gh-pages $REMOTE .output

for MD in *md;
do (pandoc --template="template.html" $MD >".output/$( basename $MD .md ).html") done

cd .output
git add .
git commit -m "Updates the HTML ($DATE)"
git push origin gh-pages

cd ../

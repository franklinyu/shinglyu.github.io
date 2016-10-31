#/usr/bin/env bash

get_links() {
  grep -oP "\[[^\]]*\]\[[^\]]*\]" "${1}" |\
    cut -d "[" -f 3 |\
    sed "s/]$//g" 
}
echo "Links"
echo "-----------------"

get_links "${1}" |\
  sed -E "s/ /+/g" |\
  sed "s/^/https:\/\/www.google.com\/search\?q\=/g"

echo "-----------------"
get_links "${1}" |\
  sed "s/^/[/g" |\
  sed "s/$/]: /g"
#grep -oP "\[[^\]]*\]\[[^\]*]\]" "$1" |\
  #sed -E "s/\[|\]|\`//g" |\
  #sed -E "s/ /+/g" |\
  #sed "s/^/https:\/\/www.google.com\/search\?q\=/g"

echo ""
echo "Images"
echo "-----------------"
grep -oP "!\[[^\]]*\]()" "$1" |\
  sed -E "s/!|\[|\]|\`//g" |\
  sed -E "s/ /+/g" |\
  sed "s/^/https:\/\/www.google.com\/images\?q\=/g"

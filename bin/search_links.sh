#/usr/bin/env bash
echo "Links"
echo "-----------------"
grep -oP "\[[^\]]*\]()" "$1" |\
  sed -E "s/\[|\]|\`//g" |\
  sed -E "s/ /+/g" |\
  sed "s/^/https:\/\/www.google.com\/search\?q\=/g"

echo ""
echo "Images"
echo "-----------------"
grep -oP "!\[[^\]]*\]()" "$1" |\
  sed -E "s/!|\[|\]|\`//g" |\
  sed -E "s/ /+/g" |\
  sed "s/^/https:\/\/www.google.com\/images\?q\=/g"

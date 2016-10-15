#/usr/bin/env bash
grep -oP "\[[^\]]*\]()" "$1" | sed -E "s/\[|\]|\`//g" | sed "s/^/https:\/\/www.google.com\/search\?q\=/g"

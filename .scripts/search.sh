#!/bin/sh

# You can add search engines like this:
#
# ENGINES=\
# 'Google|https://www.google.com/search?q=
# Arch Wiki|https://wiki.archlinux.org/index.php?search='

ENGINES="$(cat $HOME/.engines)"

get_engine() {
    ENGINE="$(printf '%s' "$ENGINES" | cut -d'|' -f1 | rofi.sh -dmenu -i -p 'Choose a search engine')" || exit 1
    if ! printf '%s' "$ENGINES" | cut -d'|' -f1 | grep -q "$ENGINE"; then
        "$BROWSER" "$ENGINE"
        exit 0
    else
        URL="$(printf '%s' "$ENGINES" | grep "$ENGINE" | head -1 | cut -d'|' -f2)"
    fi
}

while true; do
    get_engine
    QUERY="$(rofi.sh -dmenu -p "Search $ENGINE")" || continue
    if [ -n "$QUERY" ]; then
        "$BROWSER" "$URL$QUERY"
        break
    fi
done

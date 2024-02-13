#!/bin/sh

DOTFILES="$(git --git-dir $HOME/.dotfiles ls-files | sed 's|^|~/|')"
SCRIPTS="$(git --git-dir $SCRIPTS/.git ls-files | sed "s|^|$SCRIPTS/|" | sed "s|$HOME|~|")"

CHOICE="$(printf '%s\n%s' "$DOTFILES" "$SCRIPTS" | rofi.sh -dmenu -i -p 'Choose a file')" || exit 1
alacritty -e sh -c "$EDITOR $CHOICE"

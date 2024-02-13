#!/bin/sh

eprintf() {
    printf "$@" 1>&2
}

CONFIG_FILE="$HOME/.config/alacritty/alacritty.yml"
CONFIG="$(sed 's/ *//g' "$CONFIG_FILE")"

if ! [ -f "$CONFIG_FILE" ]; then
    eprintf '%s: %s: No such file or directory\n' "$(basename "$0")" "$CONFIG_FILE"
    exit 1
fi

usage() {
    eprintf 'Usage: %s [-h] [-l] [-g] [-H] [-o <opacity>] [-t <theme>] [-f <font size>]\n\n' "$(basename "$0")"
    eprintf 'Options:\n'
    eprintf -- '-h\tShow this message\n'
    eprintf -- '-l\tList the available themes\n'
    eprintf -- '-g\tGet the current values (opacity:theme:font_size) (default behavior)\n'
    eprintf -- '-H\tLike -g, but returns values in a human-readable format\n'
    eprintf -- '-o\tSet the opacity (values in range [0, 1], accepts decimals)\n'
    eprintf -- '-f\tSet the font size (accepts decimals)\n'
    eprintf -- '-t\tSet the theme\n'
}

if [ "$#" -eq 0 ]; then
    GET=1
fi

while getopts ':hlgHo:t:f:' OPTION; do
    case "$OPTION" in
        h)
            usage 2>&1
            exit 0
            ;;
        l)
            LIST=1
            ;;
        g)
            GET=1
            ;;
        H)
            GET=1
            HUMAN=1
            ;;
        o)
            OPACITY="$OPTARG"
            ;;
        t)
            THEME="$OPTARG"
            ;;
        f)
            FONT_SIZE="$OPTARG"
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift "$((OPTIND -1))"

if [ "$#" -ne 0 ]; then
    usage
    exit 1
fi

list_themes() {
    printf '%s' "$CONFIG" | grep ':\&[a-z]' | cut -d: -f2 | cut -c2-
}

if [ -n "${LIST+x}" ]; then
    list_themes
elif [ -n "${GET+x}" ]; then
    _OPACITY="$(printf '%s' "$CONFIG" | grep '^opacity:' | cut -d: -f2)"
    _THEME="$(printf '%s' "$CONFIG" | grep '^colors:' | cut -d: -f2 | cut -c2-)"
    _FONT_SIZE="$(printf '%s' "$CONFIG" | grep '^size:' | cut -d: -f2)"

    if [ -n "${HUMAN+x}" ]; then
        printf 'Opacity: %s\nTheme: %s\nFont Size: %s\n' "$_OPACITY" "$_THEME" "$_FONT_SIZE"
    else
        printf '%s:%s:%s\n' "$_OPACITY" "$_THEME" "$_FONT_SIZE"
    fi
fi

if [ -n "${OPACITY+x}" ]; then
    if printf '%s' "$OPACITY" | grep -q -e '^[01]$' -e '^0\.[0-9]$'; then
        sed -i "s/opacity:.*/opacity: $OPACITY/" "$CONFIG_FILE"
    else
        eprintf '%s is not a valid value for opacity\n' "$OPACITY"
        eprintf 'Valid values are 0, 1 and 0.1, 0.2... 0.9\n'
        exit 1
    fi
fi

if [ -n "${THEME+x}" ]; then
    if list_themes | grep -q "$THEME"; then
        sed -i "s/colors: \*.*/colors: \*$THEME/" "$CONFIG_FILE"
    else
        eprintf "The theme you entered doesn't exist.\nThese are the available themes:\n"
        list_themes 1>&2
        exit 1
    fi
fi

if [ -n "${FONT_SIZE+x}" ]; then
    if printf '%s' "$FONT_SIZE" | grep -E -e '^[0-9]*\.?[0-9]?*$'; then
        sed -i "s/size: .*/size: $FONT_SIZE/" "$CONFIG_FILE"
    else
        eprintf '%s is not a valid value for font size.\n' "$FONT_SIZE"
        eprintf 'Valid values are numbers (accepts decimals)\n' "$FONT_SIZE"
        exit 1
    fi
fi

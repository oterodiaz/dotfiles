#!/bin/sh

eprintf() {
    printf "$@" 1>&2
}

if ! command -v ddcutil > /dev/null 2>&1; then
    eprintf 'You need to install ddcutil to run this script\n'
    exit 1
else
    alias ddcutil='ddcutil --sleep-less --noverify --sleep-multiplier .1'
fi

if ! groups "$USER" | grep -q 'i2c'; then
    eprintf 'You must be able to access i2c devices without root privileges to run this script\n'
    eprintf "Here's a guide on how to do that: https://www.ddcutil.com/i2c_permissions\n"
    exit 1
fi

usage() {
    eprintf 'Usage: %s [-h] [-g] [-s <+|-><0-100>]\n\n' "$(basename "$0")"
    eprintf 'Options:\n'
    eprintf -- '-h\tShow this message\n'
    eprintf -- '-g\tGet the current brightness value (default behavior)\n'
    eprintf -- '-s\tSet the brightness to an absolute (50, 75) or relative (-15, +10) value\n'
}

if [ "$#" -eq 0 ]; then
    GET=1
fi

while getopts ':hgs:' OPTION; do
    case "$OPTION" in
        h)
            usage 2>&1
            exit 0
            ;;
        g)
            GET=1
            ;;
        s)
            SET="$OPTARG"
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

if ! [ -f "$HOME/.local/share/brightness.sh/max_brightness" ]; then
    mkdir -p "$HOME/.local/share/brightness.sh" > /dev/null 2>&1
    ddcutil -t getvcp 10 | cut -d' ' -f5 > "$HOME/.local/share/brightness.sh/max_brightness"
fi

MAX_BRIGHTNESS="$(cat "$HOME/.local/share/brightness.sh/max_brightness")"

if [ -n "${GET+x}" ]; then
    CURRENT_BRIGHTNESS="$(ddcutil -t getvcp 10 | cut -d' ' -f4)"
    printf '%s\n' "$CURRENT_BRIGHTNESS"
fi

if [ -n "${SET+x}" ]; then
    if printf '%s' "$SET" | grep -qE '^[+-]?[0-9]*$'; then
        if printf '%s' "$SET" | grep -q '[+-]'; then
            OPERATOR="$(printf '%s' "$SET" | cut -c1)"
            VALUE="$(printf '%s' "$SET" | cut -c2-)"
            ddcutil setvcp 10 "$OPERATOR" "$VALUE"
            exit 0
        else 
            if [ "$SET" -gt "$MAX_BRIGHTNESS" ]; then
                SET="$MAX_BRIGHTNESS"
                eprintf 'The brightness value is too high\nWill set the brightness to the maximum (%s)\n' "$MAX_BRIGHTNESS"
            fi
            ddcutil setvcp 10 "$SET"
            exit 0
        fi
    else
        eprintf '%s is not a valid value for -s.\nExamples of valid values: 70 +10 -5 0\n' "'$VAL'"
        exit 1
    fi
fi

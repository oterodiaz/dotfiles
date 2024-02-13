#!/bin/sh

eprintf() {
    printf "$@" 1>&2
}

usage() {
    eprintf 'Usage: %s [-h] [-g] [-d] [-l] [-t]\n\n' "$(basename "$0")"
    eprintf 'Options:\n'
    eprintf -- '-h\tShow this message\n'
    eprintf -- '-g\tGet the dark mode status: returns 0 when dark mode is enabled, 1 otherwise (default behavior)\n'
    eprintf -- '-d\tSwitch to dark mode\n'
    eprintf -- '-l\tSwitch to light mode\n'
    eprintf -- '-t\tToggle between dark and light mode\n'
}

if [ "$#" -eq 0 ]; then
    GET=1
fi

while getopts ':hgdlt' OPTION; do
    case "$OPTION" in
        h)
            usage 2>&1
            exit 0
            ;;
        g)
            GET=1
            ;;
        d)
            DARK=1
            ;;
        l)
            LIGHT=1
            ;;
        t)
            TOGGLE=1
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

get_status() {
    dbus-send --session --dest=org.freedesktop.portal.Desktop --print-reply /org/freedesktop/portal/desktop org.freedesktop.portal.Settings.Read string:'org.freedesktop.appearance' string:'color-scheme' | grep -o 'uint32 1'
}

set_theme() {
    gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME"
    alacritty_config.sh -t "$ALACRITTY_THEME" &
    if command -v nvim > /dev/null 2>&1; then
        "$SCRIPTS/update_neovim_theme.py" &
    fi
    if [ -f "$HOME/.config/bat/config" ]; then
        sed -i "s/--theme .*/--theme '$BAT_THEME'/" "$HOME/.config/bat/config" &
    fi
    if command -v fish > /dev/null 2>&1; then
        fish -c "colorscheme '$FISH_THEME'" &
    fi
} > /dev/null 2>&1

light_config() {
    COLOR_SCHEME='default'
    ALACRITTY_THEME='iceberg'
    BAT_THEME='OneHalfLight'
    FISH_THEME='Tomorrow Day'
}

dark_config() {
    COLOR_SCHEME='prefer-dark'
    ALACRITTY_THEME='dark'
    BAT_THEME='OneHalfDark'
    FISH_THEME='Tomorrow Night'
}

if [ -n "${GET+x}" ]; then
    get_status
elif [ -n "${TOGGLE+x}" ]; then
    if [ "$(get_status)" = 0 ]; then
        light_config
    else
        dark_config
    fi
    set_theme
elif [ -n "${DARK+x}" ]; then
    dark_config
    set_theme
elif [ -n "${LIGHT+x}" ]; then
    light_config
    set_theme
fi

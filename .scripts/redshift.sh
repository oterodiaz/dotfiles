#!/bin/sh

eprintf() {
    printf "$@" 1>&2
}

if ! command -v redshift > /dev/null 2>&1; then
    eprintf 'You need to install redshift in order to use this script\n'
    exit 1
fi

usage() {
    eprintf 'Usage: %s [-h] [-e] [-d] [-t]\n\n' "$(basename "$0")"
    eprintf 'Options:\n'
    eprintf -- '-h\tShow this message\n'
    eprintf -- '-g\tGet the redshift status: returns 0 when enabled, 1 otherwise (default behavior)\n'
    eprintf -- '-e\tEnable redshift\n'
    eprintf -- '-d\tDisable redshift\n'
    eprintf -- '-t\tToggle redshift\n'
    eprintf -- '-f\tEnable a fade in/out animation\n'
}

if [ "$#" -eq 0 ]; then
    GET=1
fi

while getopts ':hgedtf' OPTION; do
    case "$OPTION" in
        h)
            usage 2>&1
            exit 0
            ;;
        g)
            GET=1
            ;;
        e)
            ENABLE=1
            ;;
        d)
            DISABLE=1
            ;;
        t)
            TOGGLE=1
            ;;
        f)
            FADE=1
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
    if [ -f /tmp/redshift_enabled ]; then
        printf '0'
    else
        printf '1'
    fi
}

_enable() {
    if [ -n "${FADE+x}" ]; then
        for i in $(seq 3500 50 6500 | sort -r); do
            redshift -P -O "$i" > /dev/null 2>&1
        done
    fi
    redshift -P -O 3500 > /dev/null 2>&1
    touch /tmp/redshift_enabled
}

_disable() {
    if [ -n "${FADE+x}" ]; then
        for i in $(seq 3500 50 6500); do
            redshift -P -O "$i" > /dev/null 2>&1
        done
    fi
    redshift -P -O 6500 > /dev/null 2>&1
    rm -f /tmp/redshift_enabled
}

if [ -n "${GET+x}" ]; then
    exit "$(get_status)"
elif [ -n "${TOGGLE+x}" ]; then
    if [ "$(get_status)" = 0 ]; then
        _disable
    else
        _enable
    fi
elif [ -n "${ENABLE+x}" ]; then
    _enable
elif [ -n "${DISABLE+x}" ]; then
    _disable
else
    usage
    exit 1
fi

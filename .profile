# This file will always be sourced by bash/zsh, 
# no matter the session type, including graphical 
# sessions.

EDITOR='nvim'
export EDITOR

SCRIPTS="$HOME/.scripts"
export SCRIPTS

if ! [ -n "${PROFILE_SOURCED+x}" ]; then
    PATH="$SCRIPTS":"$HOME/.local/bin":"$HOME/.emacs.d/bin":/var/lib/flatpak/exports/bin:"$HOME"/.cargo/bin:"$PATH"
    export PATH
fi

if [ -n "${DISPLAY+x}" ]; then
    if ! printf '%s' "$XDG_SESSION_DESKTOP" | grep -qi -e 'gnome' -e 'kde'; then
    if command -v qt5ct > /dev/null 2>&1; then
            QT_QPA_PLATFORMTHEME='qt5ct'
            export QT_QPA_PLATFORMTHEME
    fi

    if command -v xsettingsd > /dev/null 2>&1; then
            /usr/bin/xsettingsd &
    fi
    fi

    BROWSER='firefox'
    export BROWSER

    FILE_MANAGER='nautilus'
    export FILE_MANAGER
fi

export PROFILE_SOURCED=1

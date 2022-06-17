# This file will always be sourced by bash/zsh, 
# no matter the session type, including graphical 
# sessions (through ~/.xprofile)

EDITOR=nvim
export EDITOR

SCRIPTS="$HOME"/.scripts
export SCRIPTS

PATH="$SCRIPTS":"$HOME"/.local/bin:"$HOME"/.emacs.d/bin:"$PATH"
export PATH

if [ "$DISPLAY" ]; then
    if ! echo "$XDG_CURRENT_DESKTOP" | grep -qi -e "gnome" -e "kde"; then
        QT_QPA_PLATFORMTHEME=qt5ct
        export QT_QPA_PLATFORMTHEME
    fi

    BROWSER=firefox
    export BROWSER
fi

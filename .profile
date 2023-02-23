# This file will always be sourced by bash/zsh, 
# no matter the session type, including graphical 
# sessions.

EDITOR='nvim'
export EDITOR

SCRIPTS="$HOME/.scripts"
export SCRIPTS

if ! [ -n "${PROFILE_SOURCED+x}" ]; then
    PATH="$SCRIPTS":"$HOME/.local/bin":"$HOME/.emacs.d/bin":/usr/local/opt/python@3.11/libexec/bin:"$HOME"/.cargo/bin:"$PATH"
    export PATH
fi

export PROFILE_SOURCED=1

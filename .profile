# This file will always be sourced by bash/zsh, 
# no matter the session type, including graphical 
# sessions.

EDITOR='nvim'
export EDITOR

SCRIPTS="$HOME/.scripts"
export SCRIPTS

export HOMEBREW_NO_AUTO_UPDATE=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if ! [ -n "${PROFILE_SOURCED+x}" ]; then
    PATH="$SCRIPTS":"$HOME/.local/bin":/opt/homebrew/bin:/opt/homebrew/opt/python@3.12/libexec/bin:"$PATH"
    export PATH
fi

export PROFILE_SOURCED=1

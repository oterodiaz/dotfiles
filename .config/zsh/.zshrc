if [ -f /etc/zshenv ]; then
    . /etc/zshenv
fi

if [ -f "$HOME/.profile" ]; then
    emulate sh -c ". $HOME/.profile"
fi

if ! [[ -o interactive ]]; then
    # Shell is non-interactive. Be done now!
    return
fi

if [ -n "${INTELLIJ_ENVIRONMENT_READER+x}" ]; then
    # Shell started by IntelliJ Idea or Android Studio, we can't run fish
    return
fi

if [ -f "$HOME/.less_colors" ]; then
    . "$HOME/.less_colors"
fi

if command -v fish > /dev/null 2>&1; then
    USE_FISH_ZSH="${USE_FISH_ZSH:-true}"
    if "$USE_FISH_ZSH"; then
        exec fish
    fi
fi

if [ -f "$HOME/.aliases" ]; then
    emulate sh -c ". $HOME/.aliases"
fi

setopt autocd extendedglob nomatch inc_append_history extended_history hist_ignore_dups hist_ignore_space
unsetopt notify
bindkey -v
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit
autoload edit-command-line
compinit
zle -N edit-command-line

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=1000000000
SAVEHIST=1000000000

autoload -Uz promptinit
promptinit
prompt custom

. "$ZDOTDIR/keybindings"
. "$ZDOTDIR/pluginrc"

greeting

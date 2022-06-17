if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

if [ -f "$HOME"/.profile ]; then
    source "$HOME"/.profile
fi

if [ -f "$HOME"/.less_colors ]; then
    source "$HOME"/.less_colors
fi

if command -v fish > /dev/null 2>&1; then
    USE_FISH_BASH="${USE_FISH_BASH:-true}"
    if "$USE_FISH_BASH"; then
        exec fish
    fi
fi

if [ -f "$HOME"/.aliases ]; then
    source "$HOME"/.aliases
fi

rightprompt() {
    printf "%*s" $COLUMNS "$(date +%H:%M:%S) (bash)"
}

if [ "$SSH_CLIENT" ]; then
    PS1='\[\e[0;1;35m\]╭─[\u@\H]-[$?]: \[\e[0m\]\[\e[0;34m\]\w\[\e[0m\]
\[\e[0;38;5;240m\]\[$(tput sc; rightprompt; tput rc)\]\[\e[0m\]\[\e[0;1;35m\]╰─[ssh]->> \[\e[0m\]' 
else
    PS1='\[\e[0;1;35m\]╭─[\u@\H]-[$?]: \[\e[0m\]\[\e[0;34m\]\w\[\e[0m\]
\[\e[0;38;5;240m\]\[$(tput sc; rightprompt; tput rc)\]\[\e[0m\]\[\e[0;1;35m\]╰─>> \[\e[0m\]' 
fi

greeting

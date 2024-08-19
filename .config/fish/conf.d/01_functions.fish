function colorscheme
    function usage
        printf 'Usage: colorscheme [-h] [-l] [COLORSCHEME]\n\n' 1>&2
        printf 'Options:\n' 1>&2
        printf '-h\tShow this message\n' 1>&2
        printf '-l\tShow all colorscheme names\n' 1>&2
    end

    if not test -d "$__fish_config_dir/colorschemes"
        mkdir -p "$__fish_config_dir/colorschemes"
    end

    if test (count $argv) -ne 1
        usage
        return 1
    end

    if test "$argv[1]" = '-l'
        if ! find "$__fish_config_dir/colorschemes" -name '*.fish' -type f | grep -q .
            printf '%sYou don\'t have any colorschemes installed%s\n' (set_color -o red) (set_color normal)
            printf 'You can install them by putting *.fish files inside %s or a subfolder\n' "\$__fish_config_dir/colorschemes"
        else
            find "$__fish_config_dir/colorschemes" -name '*.fish' -type f -exec basename '{}' \; | sed 's/\.fish//'
        end
    else if test "$argv[1]" = '-h'
        usage 2>&1
    else
        if find "$__fish_config_dir/colorschemes" -name "$argv[1].fish" -type f | grep -q .
            source (find "$__fish_config_dir/colorschemes" -name "$argv[1].fish" -type f)
            printf 'Applied colorscheme: %s\n' "$argv[1]"
        else
            printf "The colorscheme '%s' doesn't exist\n" "$argv[1]" 1>&2
            return 1
        end
    end
    functions -e usage
end

if not status --is-interactive
    return
end

alias rm='rm -i'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias rs='clear; fish_greeting'
alias fcd="cd \$__fish_config_dir"
alias gpip='curl ifconfig.me; printf "\n"'
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if test (uname -s) = 'Darwin'
    alias glip='ipconfig getifaddr en0'
else
    alias glip='hostname -I'
    alias ip='ip -color=auto'
end

if command -v eza &> /dev/null
    alias ls='eza -lg --group-directories-first --icons --sort=name --no-time --git'
    alias ll='eza -lg --group-directories-first --icons --sort=name --no-time --git'
    alias la='eza -lga --group-directories-first --icons --sort=name --no-time --git'
else
    alias ls='ls --color=auto -l'
    alias ll='ls --color=auto -l'
    alias la='ls --color=auto -la'
end

if command -v bat &> /dev/null
    alias pcat='bat -pP'
end

if command -v nvim &> /dev/null
    alias vim='nvim'
    abbr -g 'nvim' 'vim'
    abbr -g 'vi' 'vim'
end

if command -v bash &> /dev/null
    alias fbash='USE_FISH_BASH=false bash'
end

if command -v zsh &> /dev/null
    alias fzsh='USE_FISH_ZSH=false zsh'
    if not set -q ZDOTDIR
        set -f ZDOTDIR (zsh -c 'echo "$ZDOTDIR"')
    end
    alias zcd="cd $ZDOTDIR"
end

if not test -f "$__fish_config_dir/fish_plugins"
    function install_fish_plugins
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
        fisher install jorgebucaran/autopair.fish
    end
end

# Mimic other shells' '!!' syntax
function last_history_item; echo $history[1]; end
abbr -a !! --position anywhere --function last_history_item

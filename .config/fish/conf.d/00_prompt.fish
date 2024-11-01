if not status --is-interactive
    return
end

set _main_color                    'magenta'
set _accent_color                  'brmagenta'

set _right_prompt_color            (set_color 585858)
set _prompt_color                  (set_color -o "$_main_color")
set _user_prompt_color             (set_color "$_main_color")
set _at_prompt_color               (set_color -o "$_main_color")
set _hostname_prompt_color         (set_color -o "$_main_color")
set _status_zero_prompt_color      (set_color -o "$_accent_color")
set _status_error_prompt_color     (set_color -o brred)
set _pwd_prompt_color              (set_color normal)(set_color "$_accent_color")
set _mode_prompt_normal_color      (set_color -o magenta)
set _mode_prompt_insert_color      (set_color -o brmagenta)
set _mode_prompt_replace_one_color (set_color -o yellow)
set _mode_prompt_replace_color     (set_color -o blue)
set _mode_prompt_visual_color      (set_color -o green)
set _ssh_prompt_color              (set_color -o "$_accent_color")
set _greeting_color                (set_color -o "$_main_color")

function fish_greeting
    # Skip greeting when we're in an IDE integrated terminal or if there's no greeting file
    if ! set -q IDE_SESSION; and test -f "$HOME/.greeting"
        printf "$_greeting_color"
        cat "$HOME/.greeting"
        set_color normal
    end
end

function fish_right_prompt
    printf '%s%s (fish)\n' "$_right_prompt_color" (date +%H:%M:%S)
    set_color normal
end

function fish_prompt
    printf "%s╭─[%s$USER%s@%s%s%s]─["(status_prompt)"]: %s%s\n" "$_prompt_color" "$_user_prompt_color" "$_at_prompt_color" "$_hostname_prompt_color" (hostname) "$_prompt_color" "$_pwd_prompt_color" (prompt_pwd)
    printf "%s╰"(custom_fish_mode_prompt)(ssh_prompt)">> %s" "$_prompt_color" (set_color normal)
end

# Disable the default mode prompt so we can define our own
function fish_mode_prompt
end

function status_prompt
    set -f _pipestatus (fish_status_to_signal $pipestatus)
    set -f _status_list
    for _status in $_pipestatus
        if test "$_status" = '0'
            set -a _status_list "$_status_zero_prompt_color$_status"
        else
            set -a _status_list "$_status_error_prompt_color$_status"
        end
    end
    printf (string join "$_prompt_color|" $_status_list)"$_prompt_color"
end

function custom_fish_mode_prompt
    if test "$fish_key_bindings" = 'fish_vi_key_bindings'
    or test "$fish_key_bindings" = 'fish_hybrid_key_bindings'
        switch "$fish_bind_mode"
            case "default"
                set -f _symbol "$_mode_prompt_normal_color"N
            case "insert"
                set -f _symbol "$_mode_prompt_insert_color"I
            case "replace_one"
                set -f _symbol "$_mode_prompt_replace_one_color"R
            case "replace"
                set -f _symbol "$_mode_prompt_replace_color"R
            case "visual"
                set -f _symbol "$_mode_prompt_visual_color"V
        end
        printf "─[%s%s]" "$_symbol" "$_prompt_color"
    else
        printf '%s' "$_prompt_color"
    end
end

function ssh_prompt
    if set -q SSH_CLIENT
        printf '─[%sssh%s]─' "$_ssh_prompt_color" "$_prompt_color"
    else
        printf '─'
    end
end

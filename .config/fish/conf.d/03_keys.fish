if not status --is-interactive
    return
end

if test "$fish_key_bindings" = 'fish_vi_key_bindings'
    bind -M insert \cf forward-char
    bind -M insert \cd forward-char
    bind -M default \cf forward-char
    bind -M default \x20 edit_command_buffer
end

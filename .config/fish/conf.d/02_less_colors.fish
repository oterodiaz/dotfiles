if not status --is-interactive
    return
end

if not set -q LESS_TERMCAP_{mb,md,me,se,so,ue,us}
    set -gx LESS_TERMCAP_mb (printf '%b' '\033[01;31m')
    set -gx LESS_TERMCAP_md (printf '%b' '\033[01;31m')
    set -gx LESS_TERMCAP_me (printf '%b' '\033[0m')
    set -gx LESS_TERMCAP_se (printf '%b' '\033[0m')
    set -gx LESS_TERMCAP_so (printf '%b' '\033[01;44;33m')
    set -gx LESS_TERMCAP_ue (printf '%b' '\033[0m')
    set -gx LESS_TERMCAP_us (printf '%b' '\033[01;32m')
    
    # This fixes colors in Fedora
    set -gx GROFF_NO_SGR 'yes'
end

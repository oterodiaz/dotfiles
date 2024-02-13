if dark_mode.sh; then
    rofi -theme spotlight-dark "$@"
else
    rofi -theme spotlight "$@"
fi

#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Error: exactly one argument is required"
  echo "Usage: $0 <application_name>"
fi

application="$1"
current_workspace=$(aerospace list-workspaces --focused)

osascript -e "
tell application \"$application\"
  if it is running then
    activate
    tell application \"System Events\" to keystroke \"n\" using {command down}
  else
    activate
  end if
end tell"

# If we move it too soon we'll move the window that was activated before
# creating the new one. So we use a magic number, but it works.
sleep 0.1
aerospace move-node-to-workspace --focus-follows-window "$current_workspace"

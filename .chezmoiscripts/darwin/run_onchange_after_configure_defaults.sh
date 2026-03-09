#!/bin/bash

set -eufo pipefail

# Accessibility (zoom)
# These require the terminal application to have full disk access,
# so we test the first one and output some guidance in case of errors
if ! defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true; then
  echo "The terminal application needs full disk access to run this script"
  echo "Enable it in System Settings -> Privacy & Security -> Full Disk Access"
  echo "Then, rerun this script with 'chezmoi apply' or 'chezmoi update'"
  exit 1
fi
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 262144 # Ctrl
defaults write com.apple.universalaccess closeViewZoomMode -int 0 # Full screen
defaults write com.apple.universalaccess closeViewPanningMode -int 2 # Keep pointer centered

chflags nohidden ~/Library

mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"

defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 21
defaults write -g AppleShowAllExtensions -bool true
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g NSWindowShouldDragOnGesture -bool true
defaults write -g NSUserKeyEquivalents -dict-add 'Save As...' '@$S'
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g NSColorSimulateHardwareAccent -bool true
defaults write -g NSColorSimulatedHardwareEnclosureNumber -int 7

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

defaults write com.apple.dock tilesize -int 64
defaults write com.apple.dock largesize -int 72
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

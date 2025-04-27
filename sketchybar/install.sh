#/bin/bash
set -e


# install dependencies

# install sketchybar
brew tap FelixKratz/formulae
brew install sketchybar

# fonts
brew install --cask font-hack-nerd-font

# json processor
brew install jq

# Hide the default MacOs menu bar
# For MacOs Sonoma: System Settings -> Control Center-> Automatically hide and show the menu bar -> Always
# For MacOs Ventura: System Settings -> Desktop & Dock -> Automatically hide and show the menu bar -> Always
# For Pre MacOS Ventura: System Preferences -> Dock & Menu Bar -> Automatically hide and show the menu bar (checked)

# start
brew services start sketchybar


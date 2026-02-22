#!/bin/bash

set -e

command_exists() {
  command -v "$1" >/dev/null 2>&1
}


# Install dependencies

if ! command_exists nvim; then
    echo "nvim is not installed. Installing..."
    brew install nvim
else
    echo "nvim is already installed."
fi

# Other binaries used inside vim
brew install lua
brew install lazygit
brew install ffmpeg
brew install shellcheck
brew install tldr
brew install fzf
brew install tree
brew install broot
brew install --cask xquartz
brew install feh

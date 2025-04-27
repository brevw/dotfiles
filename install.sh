#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "Installing config files and dependencies"

## install global dependencies

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

if ! command_exists git; then
    echo "Installing Git..."
    brew install git
else
    echo "Git is already installed."
fi

## install local dependencies and link the config files
mkdir -p "$HOME/.config"

#-->>>>>> iTerm2 + zsh
echo "Installing zsh..."
if [ -L "$HOME/.config/zsh" ]; then
    rm "$HOME/.config/zsh"
fi
ln -sf "$DOTFILES_DIR/zsh" "$HOME/.config/zsh"
source "$DOTFILES_DIR/zsh/install.sh"

#-->>>>>> SketchyBar
echo "Installing SketchyBar..."
if [ -L "$HOME/.config/sketchybar" ]; then
    rm "$HOME/.config/sketchybar"
fi
ln -sf "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"
source "$DOTFILES_DIR/sketchybar/install.sh"

#-->>>>>> tmux
echo "Installing tmux..."
if [ -L "$HOME/.config/tmux" ]; then
    rm "$HOME/.config/tmux"
fi
ln -sf "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
source "$DOTFILES_DIR/tmux/install.sh"

#-->>>>>> nvim
echo "Installing nvim..."
if [ -L "$HOME/.config/nvim" ]; then
    rm "$HOME/.config/nvim"
fi
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
source "$DOTFILES_DIR/nvim/install.sh"

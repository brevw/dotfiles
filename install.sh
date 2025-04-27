#/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Installing config files and dependencies"

# install dependencies and link the config files

echo "Installing SketchyBar..."
ln -sf "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"
source "$DOTFILES_DIR/sketchybar/install.sh"

echo "Installing tmux..."
ln -sf "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
source "$DOTFILES_DIR/tmux/install.sh"

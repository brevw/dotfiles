#!/bin/bash

set -e

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install dependencies

# Install iTerm2
if ! command_exists iterm2; then
    echo "Installing iTerm2..."
    brew install --cask iterm2
else
    echo "iTerm2 is already installed."
fi

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing..."

    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install PowerLevel10K Theme
POWERLEVEL10K_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$POWERLEVEL10K_DIR" ]; then
    echo "Installing PowerLevel10K theme..."
    git clone https://github.com/romkatv/powerlevel10k.git "$POWERLEVEL10K_DIR"
else
    echo "PowerLevel10K is already installed."
fi
# Install Meslo Nerd Font
if ! fc-list | grep -i "Meslo" > /dev/null; then
    echo "Meslo Nerd Font is not installed. Installing..."
    brew install --cask font-meslo-nerd-font
else
    echo "Meslo Nerd Font is already installed."
fi

# Install Zsh Plugins (zsh-autosuggestions, zsh-syntax-highlighting)
ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
else
    echo "zsh-autosuggestions plugin is already installed."
fi

if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting plugin is already installed."
fi



# add link from ~/.zshrc to ~/.config/zsh/.zshrc
ZSHRC_SOURCE="$HOME/.config/zsh/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

# Check if the symlink already exists and points to the correct target
if [ ! -L "$ZSHRC_TARGET" ] || [ "$(readlink "$ZSHRC_TARGET")" != "$ZSHRC_SOURCE" ]; then
    echo "Creating symlink from $ZSHRC_TARGET to $ZSHRC_SOURCE..."
    ln -sf "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
else
    echo "Symlink already exists and points to the correct location."
fi

#/bin/bash
set -e


# install dependencies

# install tmux
brew install tmux

# Install TPM (Tmux Plugin Manager) if it doesn't exist
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Cloning TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install tmux plugins using TPM
echo "Installing tmux plugins..."
tmux new-session -d -s tmp_session "run-shell '$HOME/.tmux/plugins/tpm/bin/install_plugins'"

echo "Tmux plugins installed successfully!"

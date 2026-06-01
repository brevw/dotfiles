
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Change language to english for neovim
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# Use the HOME environment variable to make the path dynamic
CONDA_PATH="$HOME/miniconda3"

# Set up conda if it's available
__conda_setup="$("$CONDA_PATH/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
        . "$CONDA_PATH/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_PATH/bin:$PATH"
    fi
fi

# Unset the temporary variable
unset __conda_setup
# <<< conda initialize <<<

# add additional paths to PATH
# priotity preferred
export PATH="$PATH:/bin"
# second priority
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:HOME/.local/bin"

# exports so that default usage (git commit for example) is nvim
export VISUAL="nvim"
export EDITOR="nvim"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# enable VI mode
export ZVM_CURSOR_STYLE_ENABLED=false
source ~/.oh-my-zsh/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# needed for feh to work (also need to use "open -a XQuartz" first)
export DISPLAY=:0

# config
alias mv="mv -i"


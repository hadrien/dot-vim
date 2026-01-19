#!/bin/bash
set -e

# Check for git (required by vim-plug to install plugins)
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed."
    echo "Please install git first: https://git-scm.com/downloads"
    exit 1
fi

# Backup existing ~/.vim if it exists
if [ -d ~/.vim ]; then
    echo "Backing up existing ~/.vim to ~/.vim.backup"
    rm -rf ~/.vim.backup
    mv ~/.vim ~/.vim.backup
fi

# Clone the repository
echo "Cloning dot-vim..."
git clone https://github.com/hadrien/dot-vim.git ~/.vim

# Install vim-plug
echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/main/plug.vim

# Install plugins
echo "Installing plugins..."
vim --not-a-term -c 'PlugInstall --sync' -c 'qa!'

echo "Done! Run 'vim' to get started."
echo "After first launch, run :CocInstall coc-pyright for Python LSP support."

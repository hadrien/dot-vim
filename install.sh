#!/bin/bash
set -e

# Backup existing ~/.vim if it exists
if [ -d ~/.vim ]; then
    echo "Backing up existing ~/.vim to ~/.vim.backup"
    rm -rf ~/.vim.backup
    mv ~/.vim ~/.vim.backup
fi

# Download and extract the repository
echo "Downloading dot-vim..."
curl -fsSL https://github.com/hadrien/dot-vim/archive/refs/heads/main.zip -o /tmp/dot-vim.zip
unzip -q /tmp/dot-vim.zip -d /tmp
mv /tmp/dot-vim-main ~/.vim
rm /tmp/dot-vim.zip

# Install vim-plug
echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
echo "Installing plugins..."
vim --not-a-term -c 'PlugInstall --sync' -c 'qa!'

echo "Done! Run 'vim' to get started."
echo "After first launch, run :CocInstall coc-pyright for Python LSP support."

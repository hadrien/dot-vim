# Vim Configuration

Personal Vim configuration optimized for Python, Terraform/OpenTofu, Bash, Docker, YAML, and JSON development.

## Installation

```bash
# Clone to ~/.vim
git clone https://github.com/hadrien/dot-vim.git ~/.vim

# Install vim-plug (plugin manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Open Vim and install plugins
vim +PlugInstall +qall
```

## Structure

```
~/.vim/
├── vimrc              # Main configuration (Vim checks this as 2nd user vimrc)
├── autoload/          # vim-plug lives here
├── plugged/           # Installed plugins (git-ignored)
└── undodir/           # Persistent undo history (git-ignored)
```

## Plugins

Managed with [vim-plug](https://github.com/junegunn/vim-plug).

| Category | Plugins |
|----------|---------|
| Fuzzy Finder | fzf, fzf.vim |
| File Explorer | NERDTree, vim-devicons |
| Git | vim-fugitive, vim-gitgutter |
| Editing | vim-surround, vim-commentary, auto-pairs, vim-repeat |
| Navigation | vim-easymotion, vim-tmux-navigator |
| UI | vim-airline, gruvbox, dracula |
| Linting | ALE |
| Languages | vim-polyglot, vim-terraform, python-syntax, vim-yaml, vim-json, Dockerfile.vim |
| Start Screen | vim-startify |

## Key Bindings

Leader key is `Space`.

### Fuzzy Finding (fzf)
- `Space f` - Find files
- `Space b` - Switch buffer
- `Space /` - Search in project (ripgrep)
- `Space g` - Git files
- `Space h` - File history
- `Ctrl-p` - Find files (alt)

### File Explorer
- `Space e` - Toggle NERDTree
- `Space n` - Find current file in tree

### Git
- `Space gs` - Git status
- `Space gd` - Git diff
- `Space gb` - Git blame
- `Space gl` - Git log

### General
- `Space w` - Save
- `Space q` - Quit
- `Space ?` - Show cheatsheet (Startify)
- `jk` - Exit insert mode

### Linting (ALE)
- `Space af` - Auto-fix file
- `]a` / `[a` - Next/prev lint error

## Dependencies

For best experience, install:

```bash
# macOS
brew install ripgrep fzf shellcheck

# Python linters/formatters
pip install flake8 mypy black isort ruff

# Terraform
brew install tflint

# Optional: Nerd Font for icons
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
```

## Local Overrides

Create `~/.vim/vimrc.local` for machine-specific settings (git-ignored).

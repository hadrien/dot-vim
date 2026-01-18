# Vim Configuration

Personal Vim configuration optimized for Python, Terraform/OpenTofu, Bash, Docker, YAML, and JSON development.

## Installation

```bash
# Clone to ~/.vim
git clone https://github.com/hadrien/dot-vim.git ~/.vim

# Install vim-plug (plugin manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins (non-interactive)
vim --not-a-term -c 'PlugInstall --sync' -c 'qa!'
```

## Structure

```
~/.vim/
├── vimrc              # Main configuration (Vim checks this as 2nd user vimrc)
├── coc-settings.json  # coc.nvim/LSP configuration
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
| UI | vim-airline, vim-startify |
| Colorschemes | gruvbox, dracula, molokai, nord, onedark, onehalf, catppuccin, rose-pine, everforest, sonokai, nightfox, tokyonight |
| LSP/Completion | coc.nvim (+ coc-pyright for Python) |
| Linting | ALE (ruff, ty for Python) |
| Testing | vim-test |
| Python | python-syntax, vim-python-pep8-indent, vim-virtualenv |
| Languages | vim-polyglot, vim-terraform, vim-yaml, vim-json, Dockerfile.vim |
| Start Screen | vim-startify |
| Sessions | vim-obsession (auto-save/restore) |

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
- `Space cs` - Colorscheme picker (live preview)
- `jk` - Exit insert mode

### Splits
- `:sp` - Horizontal split
- `:vsp` - Vertical split
- `:q` - Close split
- `Ctrl-h/j/k/l` - Navigate between splits
- `Space Up/Down` - Cycle between panes
- `Ctrl-Arrows` - Resize splits

### LSP (coc.nvim)
- `gd` - Go to definition
- `Double-click` - Go to definition (mouse)
- `gy` - Go to type definition
- `gi` - Go to implementation
- `gr` - Find references
- `K` - Show documentation
- `Space rn` - Rename symbol
- `Space ca` - Code action
- `]d` / `[d` - Next/prev diagnostic
- `Ctrl-o` / `Ctrl-i` - Jump back/forward

### Linting (ALE)
- Auto-fix on save (ruff for Python)
- `Space af` - Manual fix
- `]a` / `[a` - Next/prev lint error

### Testing (vim-test)
- `Space tn` - Run nearest test
- `Space tf` - Run test file
- `Space ts` - Run test suite
- `Space tl` - Run last test
- `Space tv` - Go to test file

### Terminal
- `Ctrl-w N` - Enter Normal mode (for visual selection, copy, search)
- `i` or `a` - Return to terminal mode

### OpenCode Integration
- `Space ag` - Copy file reference to clipboard (`@file#L<line>` or `@file#L<start>-<end>` for visual selection)

## Dependencies

For best experience, install:

```bash
# macOS
brew install ripgrep fzf shellcheck node

# Python tools (ruff for linting/formatting, ty for type checking)
pip install ruff
uv tool install ty   # or: pipx install ty

# Terraform
brew install tflint

# Optional: Nerd Font for icons
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
```

After running `:PlugInstall` in Vim, install coc-pyright:
```vim
:CocInstall coc-pyright
```

## Features

### Colorscheme Picker with Live Preview
- `Space cs` opens a buffer with all available colorschemes
- Navigate with `j`/`k` - theme changes instantly as you scroll
- `Enter` to select and save, `Esc`/`q` to cancel
- Selected colorscheme persists across sessions (saved to `~/.vim/.colorscheme`)
- Airline theme automatically matches the colorscheme

### Mouse Support
- Full mouse/trackpad support enabled (`mouse=a`)
- Click to position cursor, drag to select, scroll to navigate
- Works with splits and window resizing

### Startify Cheatsheet
- Opening Vim without arguments shows recent files + full keybinding cheatsheet
- Press `Space ?` anytime to return to the start screen

### Automatic Session Management
- If `.session.vim` exists in the current directory, it is auto-loaded and Obsession starts tracking
- If no `.session.vim` exists, Startify shows normally and Obsession starts tracking (creates the file)
- Session is saved continuously (on buffer switch and quit) - resilient to crashes
- To stop tracking: `:Obsess` (toggle) or `:Obsess!` (stop and delete)

## Local Overrides

Create `~/.vim/vimrc.local` for machine-specific settings (git-ignored).

## Agent Rules

When modifying `~/.vim/vimrc`, always keep these in sync:
1. **AGENTS.md** - Update the Key Bindings section
2. **Startify cheatsheet** - Update `g:startify_custom_header` in vimrc (the ASCII cheatsheet shown on Vim startup)

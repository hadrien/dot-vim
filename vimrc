" =============================================================================
" Fast & Developer-Friendly Vim Configuration
" =============================================================================

" --- Basic Settings ---
set nocompatible              " Disable Vi compatibility
set encoding=utf-8            " UTF-8 encoding
set fileencoding=utf-8
set hidden                    " Allow switching buffers without saving
set updatetime=300            " Faster completion & diagnostics
set timeoutlen=500            " Faster key sequence completion
set ttimeoutlen=10            " Faster escape key response

" --- Performance ---
set lazyredraw                " Don't redraw during macros
set ttyfast                   " Faster terminal connection
set synmaxcol=200             " Limit syntax highlighting for long lines

" --- UI ---
set number                    " Show line numbers
set relativenumber            " Relative line numbers for easy navigation
set cursorline                " Highlight current line
set signcolumn=yes            " Always show sign column (for git/diagnostics)
set showmatch                 " Show matching brackets
set showcmd                   " Show command in bottom bar
set cmdheight=2               " More space for messages
set laststatus=2              " Always show status line
set scrolloff=8               " Keep 8 lines above/below cursor
set sidescrolloff=8           " Keep 8 columns left/right of cursor
set splitbelow                " Horizontal splits below
set splitright                " Vertical splits to the right
set termguicolors             " True color support

" --- Mouse Support ---
set mouse=a                   " Enable mouse in all modes
set ttymouse=sgr              " Better mouse support (wider terminals, clicks beyond col 223)

" --- Search ---
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive if uppercase present

" --- Indentation ---
set autoindent                " Auto indent
set smartindent               " Smart indent
set expandtab                 " Use spaces instead of tabs
set tabstop=4                 " Tab width
set shiftwidth=4              " Indent width
set softtabstop=4             " Soft tab width

" --- File handling ---
set nobackup                  " No backup files
set nowritebackup             " No backup before overwriting
set noswapfile                " No swap files
set autoread                  " Auto reload changed files
set undofile                  " Persistent undo
set undodir=~/.vim/undodir    " Undo directory

" Create undo directory if it doesn't exist
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p", 0700)
endif

" --- Wildmenu (command-line completion) ---
set wildmenu                  " Enhanced command line completion
set wildmode=longest:full,full
set wildignore+=*.pyc,*/__pycache__/*,*.o,*.obj
set wildignore+=.git,.hg,.svn
set wildignore+=*.swp,*.bak
set wildignore+=node_modules/*,.terraform/*

" --- Leader key ---
let mapleader = " "           " Space as leader key
let maplocalleader = ","

" =============================================================================
" Plugins
" =============================================================================
call plug#begin('~/.vim/plugged')

" --- Fuzzy Finder (THE essential tool) ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- File Explorer ---
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'       " Icons (requires Nerd Font)

" --- Git ---
Plug 'tpope/vim-fugitive'           " Git commands
Plug 'airblade/vim-gitgutter'       " Git diff in sign column

" --- Editing ---
Plug 'tpope/vim-surround'           " Surround text objects
Plug 'tpope/vim-commentary'         " Easy commenting (gcc)
Plug 'tpope/vim-repeat'             " Repeat plugin commands with .
Plug 'jiangmiao/auto-pairs'         " Auto close brackets

" --- Navigation ---
Plug 'easymotion/vim-easymotion'    " Quick jumps
Plug 'christoomey/vim-tmux-navigator' " Seamless tmux/vim navigation

" --- Status Line ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --- Colorschemes ---
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" --- Language Support ---
Plug 'dense-analysis/ale'           " Async linting
Plug 'sheerun/vim-polyglot'         " Language packs

" --- Python ---
Plug 'vim-python/python-syntax'     " Enhanced Python syntax
Plug 'Vimjas/vim-python-pep8-indent' " PEP8 indentation

" --- Terraform/OpenTofu ---
Plug 'hashivim/vim-terraform'

" --- YAML/JSON ---
Plug 'stephpy/vim-yaml'
Plug 'elzr/vim-json'

" --- Dockerfile ---
Plug 'ekalinin/Dockerfile.vim'

" --- Completion (optional: enable if you want) ---
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- Start Screen ---
Plug 'mhinz/vim-startify'

call plug#end()

" =============================================================================
" Plugin Configuration
" =============================================================================

" --- Colorscheme ---
set background=dark
silent! colorscheme gruvbox

" --- FZF ---
" Use ripgrep if available for faster searching
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

let g:fzf_layout = { 'down': '40%' }

" --- NERDTree ---
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$', '__pycache__', '\.git$', 'node_modules', '\.terraform']
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Auto close NERDTree if it's the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --- ALE (Linting) ---
let g:ale_linters = {
\   'python': ['flake8', 'mypy', 'ruff'],
\   'terraform': ['terraform', 'tflint'],
\   'sh': ['shellcheck'],
\   'bash': ['shellcheck'],
\   'dockerfile': ['hadolint'],
\   'yaml': ['yamllint'],
\   'json': ['jsonlint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort', 'ruff'],
\   'terraform': ['terraform'],
\   'json': ['jq'],
\   'yaml': ['prettier'],
\}
let g:ale_fix_on_save = 0             " Set to 1 to auto-fix on save
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" --- Terraform ---
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" --- Airline ---
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='gruvbox'

" --- GitGutter ---
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" --- Python syntax ---
let g:python_highlight_all = 1

" --- Startify (Start Screen with Cheatsheet) ---
let g:startify_custom_header = []
let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   Recent Files'] },
    \ { 'type': 'dir',       'header': ['   Current Directory: '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
    \ ]
let g:startify_bookmarks = [
    \ { 'v': '~/.vim/vimrc' },
    \ { 'z': '~/.zshrc' },
    \ ]
let g:startify_files_number = 8
let g:startify_padding_left = 3
let g:startify_enable_special = 0
let g:startify_custom_footer = []

" Cheatsheet content for side panel
let g:cheatsheet_content = [
    \ 'CHEATSHEET              Leader = Space',
    \ '══════════════════════════════════════',
    \ '',
    \ 'FUZZY FINDING (fzf)',
    \ '──────────────────────────────────────',
    \ 'Space f    Find files',
    \ 'Space b    Switch buffer',
    \ 'Space /    Search in project (rg)',
    \ 'Space g    Git files only',
    \ 'Space h    File history',
    \ 'Space :    Command history',
    \ 'Ctrl-p     Find files (alt)',
    \ '',
    \ 'FILE EXPLORER',
    \ '──────────────────────────────────────',
    \ 'Space e    Toggle NERDTree',
    \ 'Space n    Find current file in tree',
    \ '',
    \ 'BUFFERS & WINDOWS',
    \ '──────────────────────────────────────',
    \ 'Shift-L    Next buffer',
    \ 'Shift-H    Previous buffer',
    \ 'Space bd   Delete buffer',
    \ 'Ctrl-hjkl  Navigate windows',
    \ 'Ctrl-Arrows Resize windows',
    \ '',
    \ 'EDITING',
    \ '──────────────────────────────────────',
    \ 'gcc        Comment/uncomment line',
    \ 'gc         Comment selection',
    \ 'cs"''       Change " to '' (surround)',
    \ 'ds"        Delete surrounding "',
    \ 'ysiw"      Surround word with "',
    \ 'S"         Surround selection (visual)',
    \ 'jk         Exit insert mode',
    \ '< / >      Indent (keeps selection)',
    \ '',
    \ 'NAVIGATION',
    \ '──────────────────────────────────────',
    \ 's{char}{char}  Jump to 2 chars',
    \ 'Space j/k  EasyMotion down/up',
    \ 'Ctrl-d/u   Half-page down/up (centered)',
    \ 'n / N      Next/prev search (centered)',
    \ '',
    \ 'GIT (fugitive)',
    \ '──────────────────────────────────────',
    \ 'Space gs   Git status',
    \ 'Space gd   Git diff',
    \ 'Space gb   Git blame',
    \ 'Space gl   Git log',
    \ ']c / [c    Next/prev git hunk',
    \ '',
    \ 'GENERAL',
    \ '──────────────────────────────────────',
    \ 'Space w    Save file',
    \ 'Space q    Quit',
    \ 'Space x    Save and quit',
    \ 'Space Space Clear search highlight',
    \ 'Space sv   Reload vimrc',
    \ '',
    \ 'CLIPBOARD',
    \ '──────────────────────────────────────',
    \ 'Space y    Yank to system clipboard',
    \ 'Space p    Paste from clipboard',
    \ 'Space Y    Yank line to clipboard',
    \ '',
    \ 'LINTING (ALE)',
    \ '──────────────────────────────────────',
    \ 'Space af   Fix file (auto-format)',
    \ ']a / [a    Next/prev lint error',
    \ '',
    \ 'VIM BASICS REMINDER',
    \ '──────────────────────────────────────',
    \ 'ciw        Change inner word',
    \ 'ci"        Change inside quotes',
    \ 'vip        Select paragraph',
    \ '=          Auto-indent selection',
    \ '.          Repeat last command',
    \ '',
    \ '══════════════════════════════════════',
    \ 'Press Space ? to show this anytime',
    \ ]

" Function to open cheatsheet in right split
function! OpenCheatsheet()
    " Open a new vertical split on the right
    botright vnew
    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nonumber
    setlocal norelativenumber
    setlocal nocursorline
    setlocal signcolumn=no
    setlocal filetype=cheatsheet
    " Add content
    call setline(1, g:cheatsheet_content)
    " Make it read-only
    setlocal nomodifiable
    " Set width
    vertical resize 42
    " Go back to Startify window
    wincmd h
endfunction

" Auto-open cheatsheet with Startify
augroup StartifyCheatsheet
    autocmd!
    autocmd User StartifyReady call OpenCheatsheet()
augroup END

" Close cheatsheet when leaving Startify
augroup StartifyLeave
    autocmd!
    autocmd BufLeave * if &filetype == 'startify' | only | endif
augroup END

" =============================================================================
" Key Mappings
" =============================================================================

" --- General ---
" Quick save
nnoremap <leader>w :w<CR>
" Quick quit
nnoremap <leader>q :q<CR>
" Save and quit
nnoremap <leader>x :wq<CR>
" Clear search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" --- FZF (Fuzzy Finding) ---
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>/ :Rg<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <C-p> :Files<CR>

" --- NERDTree ---
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

" --- Buffer Navigation ---
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" --- Window Navigation ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Window Resizing ---
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" --- Move lines up/down ---
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" --- Stay centered when jumping ---
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" --- Git ---
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Git log<CR>

" --- ALE ---
nnoremap <leader>af :ALEFix<CR>
nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>

" --- EasyMotion ---
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)

" --- Better escape (jk to exit insert mode) ---
inoremap jk <Esc>

" --- Keep visual selection when indenting ---
vnoremap < <gv
vnoremap > >gv

" --- Yank to system clipboard ---
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" --- Paste from system clipboard ---
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" --- Quick fix list navigation ---
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" --- Show cheatsheet/start screen anytime ---
nnoremap <leader>? :Startify<CR>

" =============================================================================
" File Type Specific Settings
" =============================================================================
augroup filetype_settings
    autocmd!
    " Python
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

    " YAML
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " JSON
    autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " Terraform
    autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " Bash/Shell
    autocmd FileType sh,bash setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " Dockerfile
    autocmd FileType dockerfile setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" =============================================================================
" Auto Commands
" =============================================================================
augroup general_settings
    autocmd!
    " Remove trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e

    " Return to last edit position when opening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Auto-reload files when changed externally
    autocmd FocusGained,BufEnter * checktime
augroup END

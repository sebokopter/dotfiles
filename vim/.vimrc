"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto read when a file is changed from the outside
set autoread

" :W saves the file as sudo
" (useful for editing root owned files as normal user)
command! W w !sudo tee % > /dev/null

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" always be in the right directory
set autochdir

" don't know exactly if I need this
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Programming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlighting
syntax on

" tabs are 4 whitespaces
set tabstop=4
set shiftwidth=4
set expandtab

" for indenting
set autoindent
set smartindent

" show matching brackets whent cursor is over one
set showmatch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .md indicates markdown, not modula2 filetype
" per default only .markdown is recognized as markdown file
au BufRead,BufNewFile *.md set filetype=markdown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" search options
set hlsearch
set incsearch
set smartcase

" linenumber
set number
set relativenumber

" show current cursor position
set ruler

" show tab completion suggestions in the command line
set wildmenu

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" change buffers without saving
set hidden

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Keyboard shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
let mapleader = "\<Space>"
" Fast saving
nmap <leader>w :w<cr>
nmap <leader>ww :w!<cr>
nmap <leader>q :wq<cr>
nmap <leader>qq :wq!<cr>

" in long break lines move around as expected
map j gj
map k gk

" Disable search highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohl<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Theme/Color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

try
    colorscheme desert
catch
endtry

" background color
set bg=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vundle and bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" automatic installation of vundle on fresh deployments
let installed_vundle=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let installed_vundle=1
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" begin bundles
Bundle 'gmarik/vundle'
" git wrapper
Bundle 'tpope/vim-fugitive'
" easymotion try it with <leader><leader>w or <leader><leader>f or any other motion
Bundle 'Lokaltog/vim-easymotion'
" ctrlp makes file selection easier
"Bundle 'kien/ctrlp.vim'
" NERDtree
Bundle 'scrooloose/nerdtree'
" source code browser
"Bundle 'vim-scripts/taglist.vim'
" lean and mean status/tabline
Bundle 'bling/vim-airline'
" seek long lines (remaps s key)
" doesn't work currently (because of github credential request wtf?)
"Bundle 'goldfeld/vim-seek'
" shows git like signs in first column
" doesn't work currently (is installed but no sign is shown)
"Bundle 'airblade/vim-gitgutter'
" shows undo tree
"Bundle 'sjl/gundo.vim'

if installed_vundle == 1
    :BundleInstall
endif


" NERDTree
nnoremap <silent><leader>f :NERDTreeToggle<Cr>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

" open NERDTree if more than 1 file is opend
autocmd VimEnter * if argc() > 1 | NERDTree | wincmd p | endif

" Taglist
noremap <silent><leader>t :TlistToggle<Cr>
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen = 1

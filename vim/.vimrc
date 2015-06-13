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

" use mouse even in terminal
"set mouse=a

"TODO: Control-C auf "+y mappen
"TODO:
"" show file in continuous mode
"" open all folds
"" disable dynamic numbers plugin
"" disable wrap in the first window, because this kills the sync
"" disable relative numbers
"" ensure enabled numbers
"" temorary scrolloff=0
"" open the current buffer in a vertical split
"" move our view and set scrollbind in the new split
"" move back to the old split
"" set scrollbind in this split, too
"" reset scrolloff to whatever it was
"nnoremap <silent> <leader>cm zR:<C-u>NumbersDisable<cr>:setl nowrap<cr>:set nornu<cr>:set nu<cr>:let &scrolloff=0<cr>:bo vs<cr>Ljzt:setl scrollbind<cr><C-w>p:setl scrollbind<cr>:let &scrolloff=my_scrolloff_value<cr>
" vim localrc

nmap <leader>tb :tab ball<CR>
map <F7> :tabprevious<CR>
map <F8> :tabnext<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Programming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlighting
syntax on

" tabs are 4 whitespaces
set tabstop=2
set shiftwidth=2
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
" workaround, since ansible is only automatically recognized if
" yml file has certain name or directory structure
au BufRead,BufNewFile *.yml set filetype=ansible

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
"TODO: change mapleader, or only use nmap, since space has every combination
"in insert mode double booked, once for writing and then for the leader
"combinations
let mapleader = "\<Space>"
" Fast saving
nmap <Leader>w :w<cr>
nmap <Leader>ww :w!<cr>
nmap <Leader>q :wq<cr>
nmap <Leader>qq :wq!<cr>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader><Leader> V

" in long break lines move around as expected
map j gj
map k gk

" Disable search highlight when <leader><cr> is pressed
nmap <silent> <leader><cr> :nohl<cr>


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
"" easymotion try it with <leader><leader>w or <leader><leader>f or any other motion
"Bundle 'Lokaltog/vim-easymotion'
" ctrlp makes file selection easier
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
"Bundle 'kien/ctrlp.vim'
" NERDTree
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
" source code browser
"Bundle 'vim-scripts/taglist.vim'
" lean and mean status/tabline
"Bundle 'bling/vim-airline'
" seek long lines (remaps s key)
" doesn't work currently (because of github credential request wtf?)
"Bundle 'goldfeld/vim-seek'
" git wrapper
"Bundle 'tpope/vim-fugitive'
" shows git like signs in first column
" doesn't work currently (is installed but no sign is shown)
"Bundle 'airblade/vim-gitgutter'
" shows undo tree
"Bundle 'sjl/gundo.vim'
" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more.
Bundle 'tpope/vim-surround'
" Syntastic is a syntax checking plugin for Vim that runs files through
" external syntax checkers and displays any resulting errors to the user.
"Bundle 'scrooloose/syntastic'
" Solarized Colorscheme for Vim
Bundle 'altercation/vim-colors-solarized'
" adds CoffeeScript support to vim. It covers syntax, indenting, compiling,...
Bundle 'kchmck/vim-coffee-script'
" For Ansible formatting
Bundle 'chase/vim-ansible-yaml'
" ctags (vim-misc is requirement)
"Bundle 'xolox/vim-misc'
"Bundle 'xolox/vim-easytags'
"Bundle 'majutsushi/tagbar'
" alternative file (get header from c source and vise versa)
" Simply type :AT to open up the alternate file
"Bundle 'vim-scripts/a.vim'
" insert matching delimiters (quotes, parenthesis, ...)
Bundle 'Raimondi/delimitMate'
" Highlight and strip trailing whitespace (ATTENTION: Makes whitespace inputs
" verrrrrrrrrry slow and unpredictable)
"Bundle 'ntpeters/vim-better-whitespace'
" Align CSV files at commas, align Markdown tables, and more
"Bundle 'godlygeek/tabular'
" Automatically insert the closing HTML tag
Bundle 'HTML-AutoCloseTag'
" Read Unix man pages
"Bundle 'jez/vim-superman'
" Navigate in the same way (C-h, C-j, C-k, C-l) and seamlessly between tmux and vim
"Bundle 'christoomey/vim-tmux-navigator'

if installed_vundle == 1
    :BundleInstall
endif


" NERDTree
" nnoremap <silent><leader>n :NERDTreeToggle<Cr>
" nnoremap <silent><leader>f :NERDTreeFind<Cr>
"let NERDTreeShowBookmarks=1
"let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
"let NERDTreeChDirMode=0
"let NERDTreeQuitOnOpen=0
"let NERDTreeMouseMode=2
"let NERDTreeShowHidden=1
"let NERDTreeKeepTreeInNewTab=1
" open NERDTree if more than 1 file is opend (better use NERDTreeTabs
"autocmd VimEnter * if argc() > 1 | NERDTree | wincmd p | endif
" TODO: open NERDTree if more than 1 file or a directory is opened

" jistr/vim-nerdtree-tabs
" Open/close NERDTree Tabs with \t
nmap <silent><leader>n :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_open_on_console_startup = 1

" Taglist
"noremap <silent><leader>t :TlistToggle<Cr>
"let Tlist_Use_Right_Window=1
"let Tlist_GainFocus_On_ToggleOpen = 1

" vim-coffee-script
" needs reload of filetype detection according to
" http://stackoverflow.com/questions/5602767/why-is-vim-not-detecting-my-coffescript-filetype
filetype off
filetype on

" scrooloose/syntastic
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
 au!
 au FileType tex let b:syntastic_mode = "passive"
augroup END

" xolox/vim-easytags
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" majutsushi/tagbar
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" airblade/vim-gitgutter
" Required after having changed the colorscheme
"hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" Raimondi/delimitMate
let delimitMate_expand_cr = 1
augroup mydelimitMate
 au!
 au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
 au FileType tex let b:delimitMate_quotes = ""
 au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
 au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

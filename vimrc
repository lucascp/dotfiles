set nocp bs=2 ts=2 sw=2 et ai si cin hls is ic scs nu sta sc sr ar aw

set ww=<,>,b,s,[,] mouse=a bg=dark fen fdm=marker
nm <F2> :w<CR>:mak!<CR>
nm <F3> :!%< < %<.in<CR>
nm <F4> :!gdb -tui ./%<<CR><CR>
"hi Normal guibg=black guifg=white
syn on

set mps+=<:>

set hi=1000

" always use utf-8
set encoding=utf-8

" set leader to ,
let mapleader = ","

" don't highlight next search and clear the window
nnoremap <C-l> :nohlsearch<CR><C-l>

" alt+hjkl for indenting and moving lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

" disable arrow keys, because that's the right thing to do
nnoremap <up> <nop>
nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" left and right arrows to switch buffer
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Wildmenu
if has("wildmenu")
  set wildignore+=*.a,*.o
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.tmp
  set wildmenu
  set wildmode=longest,list
endif

" Plugin dependent stuff
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"Bundle 'Syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'scrooloose/syntastic'
Bundle 'spf13/vim-colors'
Bundle 'techlivezheng/vim-plugin-minibufexpl'
Bundle 'vim-scripts/guicolorscheme.vim'
Bundle 'wincent/Command-T'
"Bundle 'rmartinho/vim-cpp11'

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall 
endif

" Mapping for fuzzyfinder
nmap <c-h> :FufHelp<CR> 

" Mapping for NERDtree
nmap <F8> :NERDTreeToggle<CR>

" Mapping for TagBar
nmap <F9> :TagbarToggle<CR>

" Mapping for MiniBufExpl
nmap <leader>mb :MBEToggle<CR>

" Configuration for Syntastic
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

"au GUIEnter * simalt ~x "x on an English Windows version. n on a French one
"set lines=50 columns=180

" cpp indent options
"set cino=N-s,i2s,(0,u0,w1,Ws,m1
set cino=N-s,L0,:0,l1,i2s,(0

" python settings
autocmd BufEnter *.py set et fo=croql sts=4 sw=4

" fugitive settings
autocmd BufReadPost fugitive://* set bufhidden=delete


" statusline
set laststatus=2
set statusline=
set statusline+=%<\                           " cut at start
set statusline+=%*[%n%H%M%R%W]%*\           " flags and buf no
set statusline+=%-40f\                        " path
set statusline+=%{fugitive#statusline()}    " git branch
set statusline+=%=[%{strlen(&ft)?&ft:'none'}\   " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}]  " encoding
set statusline+=%10((%l,%c)%)\                " line and column
set statusline+=%P                            " percentage of file


" set font to Consolas on win, inconsolata elsewhere
if has("gui_running")
  colo solarized
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
else
  colo molokai
endif


" clang-format for c++ files
map <C-I> :pyf ~/.vim/clang-format-3.4.py<CR>
imap <C-I> <ESC>:pyf ~/.vim/clang-format-3.4.py<CR>i

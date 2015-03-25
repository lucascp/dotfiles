set nocp bs=2 ts=2 sw=2 et ai si cin hls is ic scs nu sta sc sr ar aw

set ww=<,>,b,s,[,] mouse=a bg=dark fen fdm=marker
set completeopt=menu,menuone
nm <F2> :w<CR>:mak!<CR>
nm <F3> :!%< < %<.in<CR>
nm <F4> :!gdb -tui ./%<<CR><CR>
"hi Normal guibg=black guifg=white
syn on
filetype plugin on

set mps+=<:>

set hi=1000

" always use utf-8
set encoding=utf-8

" set leader to ,
let mapleader = ","

" don't highlight next search and clear the window
nnoremap <C-l> :nohlsearch<CR><C-l>

" disable arrow keys, because that's the right thing to do
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Wildmenu
if has("wildmenu")
  set wildignore+=*.a,*.o
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.tmp
  set wildmenu
  set wildmode=longest,list
endif

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

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
Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'spf13/vim-colors'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rhysd/vim-clang-format'

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall 
endif

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

" Mapping for NERDtree
nmap <F8> :NERDTreeToggle<CR>

" Mapping for TagBar
nmap <F9> :TagbarToggle<CR>

" CtrlP settings
let g:ctrlp_map = '<leader>t'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

" cpp indent options
set cino=N-s,L0,:0,l1,i2s,(0

" fugitive settings
autocmd BufReadPost fugitive://* set bufhidden=delete

" statusline
set laststatus=2
set statusline=
set statusline+=%<\                            " cut at start
set statusline+=%*[%n%H%M%R%W]%*\              " flags and buf no
set statusline+=%-40f\                         " path
set statusline+=%{fugitive#statusline()}       " git branch
set statusline+=%=[%{strlen(&ft)?&ft:'none'}\  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}]   " encoding
set statusline+=%10((%l,%c)%)\                 " line and column
set statusline+=%P                             " percentage of file

let g:clang_format#command = "clang-format-3.5"

" map to <C-I> in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer> <C-I> :ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer> <C-I> :ClangFormat<CR>


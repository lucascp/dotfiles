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

" easier window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
if has("nvim")
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

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

" Nvim specific
if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:terminal_scrollback_buffer_size=20000
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nmap <F8> :NERDTreeToggle<CR>

Plug 'tomasr/molokai'
"Plug 'spf13/vim-colors'
"Plug 'flazz/vim-colorschemes'

let g:fzf_install = 'yes | ./install'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': g:fzf_install }
Plug 'junegunn/fzf.vim'
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <leader><leader> :Files<CR>
nnoremap <leader><Enter> :Buffers<CR>

Plug 'sheerun/vim-polyglot'

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"let g:clang_library_path = '~/.vim/bundle/YouCompleteMe/third_party/ycmd'
"let g:clang_use_library=1
"let g:ycm_extra_conf_globlist = ['~/Projects/*', '~/remote/*', '!~/*']

Plug 'kana/vim-operator-user'

Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }
let g:clang_format#command = "clang-format-3.8"
autocmd FileType c,cpp,objc map <buffer><C-I> <Plug>(operator-clang-format)

call plug#end()

colo molokai

" set font to Consolas on win, inconsolata elsewhere
if has("gui_running")
  if has("gui_gtk2")
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  else
    set guifont=Inconsolata\ 12
  endif
endif

" cpp indent options
set cino=N-s,L0,:0,l1,i2s,(0

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


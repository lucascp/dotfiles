set nocp bs=2 ts=2 sw=2 et ai si cin hls is ic scs nu sta sc sr ar aw

set ww=<,>,b,s,[,] mouse=a bg=dark fen fdm=marker
set completeopt=menu,menuone

syn on
filetype plugin on

set mps+=<:>

set hi=1000

if !has('nvim') && has('vim_starting')
  set encoding=utf-8
endif

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
set directory=~/.vimswap//,/var/tmp//,/tmp//,.
set backupdir=~/.local/share/nvim/swap

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
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-characterize'

Plug 'tmhedberg/matchit'

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
nmap <F8> :NERDTreeToggle<CR>
nmap <leader>t :NERDTreeFind<CR>

Plug 'tomasr/molokai'

let g:fzf_install = 'yes | ./install'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': g:fzf_install }
Plug 'junegunn/fzf.vim'
nnoremap <leader><leader> :Files<CR>
nnoremap <leader><Enter> :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>c :BCommits<CR>
nnoremap <leader>r :Rg 
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


Plug 'junegunn/vim-easy-align'
nmap <leader>a <Plug>(EasyAlign)
xmap <leader>a <Plug>(EasyAlign)

Plug 'sheerun/vim-polyglot'

Plug 'pangloss/vim-javascript'

Plug 'kana/vim-operator-user'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1

Plug 'airblade/vim-gitgutter'

Plug 'w0rp/ale'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" let g:deoplete#enable_at_startup = 1

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

set nocompatible
set t_Co=256
set bg=dark
set modeline

set wildignore+=*.DS_Store
set wildignore+=*.pyc
set wildmenu

if has('win32')
  autocmd InsertEnter * set noimdisable
  autocmd InsertLeave * set imdisable
  autocmd FocusGained * set imdisable
  autocmd FocusLost * set noimdisable
  language messages en
  set directory=.,$TEMP
  set shellslash
endif
autocmd InsertLeave * set nopaste

set display+=lastline " Show as much as possible of the last line
set display+=uhex " Show unprintable characters as a hex number
set hlsearch " Search with highlight
set laststatus=2
set number
set nrformats-=octal
set scrolloff=3
set showcmd
set showmatch
set sidescroll=1
set sidescrolloff=10
set splitbelow
set splitright
set title
syntax on

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=blue guibg=red

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace //
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e
if version >= 702
  autocmd BufWinLeave * call clearmatches()
endif

" Text formatting
set autoindent
set expandtab
set smartindent
set softtabstop=4
set shiftwidth=4
set tabstop=4

autocmd FileType c,cpp,java,mkd,markdown
      \ setlocal softtabstop=4 shiftwidth=4 tabstop=4
autocmd FileType python
      \ setlocal softtabstop=4 shiftwidth=4 tabstop=4
" Disable automatic comment insertion
autocmd FileType *
      \ setlocal formatoptions-=c formatoptions-=o

" Mappings
"noremap j gj
"noremap k gk
"noremap <Down> gj
"noremap <Up> gk
"noremap gj j
"noremap gk k
"noremap H ^
"noremap L $
"inoremap <C-A> <ESC>I
"inoremap <C-E> <ESC>A
"cnoremap <C-A> <Home>
"cnoremap <C-E> <End>
" Break the undo block when Ctrl-u
"inoremap <C-U> <C-G>u<C-U>

" Search regex
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/

" Center display after searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


" Reselect visual block after shifting
vnoremap < <gv
vnoremap > >gv

" Splitted windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" man page settings
autocmd FileType c,cpp set keywordprg=man
autocmd FileType ruby set keywordprg=ri

augroup colorcolumn
  autocmd!
  autocmd FileType gitcommit
        \ if exists('+colorcolumn') |
        \   set colorcolumn=73 |
        \ else |
        \   let w:m2 = matchadd('ErrorMsg', '\%>72v.\+', -1) |
        \ endif
augroup END

" Markdown Vim Mode
let g:vim_markdown_folding_disabled = 1

" For some reason home and end keys are not mapping properly.
" Home key
imap <esc>OH <esc>0i
cmap <esc>OH <home>
nmap <esc>OH 0
" End key
nmap <esc>OF $
imap <esc>OF <esc>$a
cmap <esc>OF <end>

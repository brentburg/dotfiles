runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

set number
set hid
set smartcase
set lazyredraw
set magic
set expandtab
set tabstop=2
set shiftwidth=2
set cursorline
set colorcolumn=81
set nobackup
set nowb
set noswapfile
set wrap
set splitbelow
set splitright

let loaded_matchparen = 1

" Use tabs instead of spaces for golang
augroup go_tabs
  autocmd!
  autocmd Filetype go setlocal noexpandtab
augroup END

" Use tabs instead of spaces for Makefile
augroup make_tabs
  autocmd!
  autocmd Filetype make setlocal noexpandtab
augroup END

augroup vue_ft
  autocmd!
  autocmd BufNewFile,BufRead *.vue set filetype=html
augroup END

augroup close_preview
  autocmd!
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

nnoremap <space> <Nop>
let mapleader = " "

nmap <leader>w :w!<cr>

nmap <leader>bd :set background=dark<cr>
nmap <leader>bl :set background=light<cr>

let g:indentLine_char = '·'
let g:indentLine_concealcursor = ''

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map <silent> <leader>/ :noh<cr>
map <leader>c :bun!<cr>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

tnoremap <C-space> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Move a line of text using ctrl+[jk]
vmap <C-J> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-K> :m'<-2<cr>`>my`<mzgv`yo`z

map <leader>t :NERDTreeToggle<cr>

vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

let g:AutoPairsShortcutJump = '<C-a>'
let g:AutoPairsUseInsertedCount = 1

let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_aggregate_errors = 1

let g:airline_powerline_fonts=1
let g:airline_detect_whitespace=0

map <leader>pp :setlocal paste!<cr>

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
set background=dark

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" enable completion
let g:deoplete#enable_at_startup = 1

" configure ctrl-p to work for large projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
set wildignore+=*/node_modules/*

" jsx
let g:jsx_ext_required = 0

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

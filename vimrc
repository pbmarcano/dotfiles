filetype off                 " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'       " Let Vundle manage Vundle, required
Plugin 'airblade/vim-gitgutter'     " See which lines changed via git
Plugin 'ctrlpvim/ctrlp.vim'         " Search through repos
Plugin 'itchyny/lightline.vim'      " Better statusline
Plugin 'janko-m/vim-test'           " Testing in vim
Plugin 'junegunn/seoul256.vim'      " Seoul256 Colorscheme
Plugin 'pangloss/vim-javascript'    " Javascript color syntax
Plugin 'posva/vim-vue'              " Vue
Plugin 'shinchu/lightline-seoul256.vim' 
Plugin 'stephpy/vim-yaml'           " Proper yaml indenting
Plugin 'tpope/vim-commentary'       " GCC to comment out line
Plugin 'tpope/vim-endwise'          " End structures automatically
Plugin 'tpope/vim-fugitive'         " Git wrapper for vim
Plugin 'tpope/vim-liquid'           " Liquid syntax coloring
Plugin 'tpope/vim-markdown'         " Markdown syntax coloring
Plugin 'tpope/vim-projectionist'    " required for some navigation features
Plugin 'tpope/vim-rails'            " Rails commands
Plugin 'tpope/vim-repeat'           " Repeat plugin commands on '.'
Plugin 'tpope/vim-surround'         " surround text with commands
Plugin 'vimwiki/vimwiki'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Editor customization
syntax enable
let g:seoul256_background = 235
colorscheme seoul256

set number
set cursorline
set cc=80
set relativenumber
set synmaxcol=500
set backspace=indent,eol,start

" Search
set incsearch
set ignorecase smartcase 
set hlsearch

runtime macros/matchit.vim

" Lightline
set laststatus=2
let g:lightline = {
  \ 'colorscheme' : 'seoul256',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ], ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }

function! ToggleTheme()
  let dark = 235
  let light = 252
  let g:seoul256_background = (g:seoul256_background == dark? light : dark)
  colo seoul256
endfunction
map <Leader>bg :call ToggleTheme()<CR>

" Trying to make faster ruby syntax highlighting
set regexpengine=1
set ttyfast

" Leader mapping
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <Leader>h :nohlsearch<CR>
nmap <silent> <Leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <Leader>et :vsplit ~/.tmux.conf<CR>
nmap <Leader>sv :source $MYVIMRC<CR>
nmap <Leader>rm :vs README.md<CR>

nmap <Leader>bt :!npm run build<CR>
nmap <Leader>em :!elm make src/Main.elm --output main.js<CR>

" no more recording
map q <Nop>

" Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Make CtrlP use ag for listing the files. Way faster and respects gitignore.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " disable ctrlp caching, ag is fast enough
  let g:ctrlp_use_caching = 0
  " Use K to search for word in project
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  " Make Ag command to search in vim console
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
else
  "Ignore annoying stuff anyways, and make sure cache is enabled
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|_site\'
  let g:ctrlp_use_caching = 1
endif

function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  vsplit
  execute "buffer " . bufferName
endfunction
nmap <C-W>u :call MergeTabs()<CR>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

" For everything else, use a tab width of 2 space chars.
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.
set shiftwidth=2    " Indents will have a width of 2.
set softtabstop=2   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

syntax on

set rnu nu
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set autoread
set nobackup
set nowritebackup
set noswapfile
highlight Comment ctermfg=red


set relativenumber
set nu rnu
call plug#begin('~/.vim/plugged')
Plug 'iamcco/coc-tailwindcss'
Plug 'jaredgorski/spacecamp'
Plug 'ntk148v/vim-horizon'
Plug 'davidhalter/jedi-vim'   " jedi for python
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
" Fast python completion (use ncm2 if you want type info or snippet support)
Plug 'HansPinckaers/ncm2-jedi'
" Words in buffer completion
Plug 'ncm2/ncm2-bufword'
" Filepath completion
Plug 'ncm2/ncm2-path'
Plug 'tpope/vim-sensible'
Plug 'airblade/vim-gitgutter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/indentpython.vim'
Plug 'lepture/vim-jinja'
Plug 'joshdick/onedark.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/NERDTree'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'

call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"


colorscheme onedark

set encoding=UTF-8
let mapleader = " "
nnoremap <leader><CR> :source ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :Rg<CR>
nnoremap <leader>ne :NERDTreeToggle<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <C-S> :w<CR>
tnoremap <ESC> <C-\><C-N>
inoremap <C-S> <ESC>:write<CR>
autocmd StdinReadPre * let s:std
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | :vertical resize 60 | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "<C-y>" : "<C-g>u<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>



"toggle Tagbag
map <Leader>t :TagbarToggle<CR>

"Coc Config"
 let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

 " Remap for rename current word
nmap <F2> <Plug>(coc-rename)

"Allow NERDTree to show hidden files"
let NERDTreeShowHidden=1

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()


" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber


let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

let g:airline_powerline_fonts = 1

"" syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"map <leader>s :SyntasticCheck<CR>
"map <leader>sd :SyntasticReset<CR>
"map <leader>e :lnext<CR>
"map <leader>r :lprev<CR>

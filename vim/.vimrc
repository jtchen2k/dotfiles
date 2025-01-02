" @jtchen2k's configuration
" created: 2020.7
" updated: 2024.11

syntax on
set rnu!
set nu!
set autoindent
set rulerformat=%35(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set mouse=a
set showmatch
set ruler
set autoread
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set foldenable
set ai

highlight ColorColumn ctermbg=darkgray
set colorcolumn=120
set backspace=indent,eol,start
set incsearch
set ignorecase

scriptencoding utf-8
set listchars+=trail:·
set listchars+=tab:→\
set list

" remap <Leader>R to :source $MYVIMRC
nnoremap <Leader>R :source $MYVIMRC<CR>

" connect system clipboard (use star register)
" to copy / paste from system clipbord, first press <\> then y or p
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "+Y
noremap <Leader>P "+P

"" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeWinPos = "right"
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
let g:NERDTreeMouseMode=3

""""" airline
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#syntastic#enabled  = 1
let g:airline#extensions#tabline#enabled    = 1

""""" nerdcommenter
let g:NERDSpaceDelims   = 1

""""" copilot
" Disable Copilot by default
let g:copilot_enabled = v:false

"""" coc (intellisense and code completion, will only be enabled in nvim 0.8 and node is installed)

" ----- start of coc -----
if has('nvim-0.8') && executable('node')

set updatetime=300
set signcolumn=yes

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use tab to trigger autocomplete
inoremap <silent><expr> <Tab>
    \ coc#pum#visible() ? coc#pum#confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:vim_json_conceal=0
let g:coc_snippet_next = '<tab>'

" Symbol renaming
nmap <leader>e <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

endif
" ----- end of coc -----

call plug#begin()

Plug 'projekt0n/github-nvim-theme'
Plug 'vim-airline/vim-airline'
Plug 'godlygeek/tabular'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-sensible'
Plug 'ap/vim-css-color'
Plug 'github/copilot.vim'
Plug 'wakatime/vim-wakatime'

if has('nvim-0.8') && executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
  Plug 'jiangmiao/auto-pairs'
endif

call plug#end()

colorscheme pablo
if has('nvim') && v:version > 800
    colorscheme github_dark_dimmed
endif


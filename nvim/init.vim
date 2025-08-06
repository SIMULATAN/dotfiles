filetype plugin on " Auto-detect un-labeled filetypes
syntax on " Turn syntax highlighting on
set number relativenumber " Show relative line numbers on the left.
set ai " Sets auto-indentation
set si " Sets smart-indentation
set cursorline " Highlight current cursor line
set cursorlineopt=number " only highlight the current number
set smarttab " Be smart when using tabs
set wrap " Wrap overflowing lines
set hlsearch " When searching (/), highlights matches as you go
set incsearch " When searching (/), display results as you type (instead of only upon ENTER)
set ignorecase " When searching (/), ignore case entirely
set smartcase " When searching (/), automatically switch to a case-sensitive search if you use any capital letters
set ttyfast " Boost speed by altering character redraw rates to your terminal
set numberwidth=1 " Sets width of the 'gutter' column used for numbering to 0 (default 4)
set encoding=utf8 " Set text encoding as utf8
set clipboard^=unnamed,unnamedplus " sync with system clipboard

set mouse=a

set shiftwidth=4 " Use 4 spaces as tab size

let mapleader=","

" increment with Ctrl + Shift + X, analog to the default decrement with Ctrl + X
noremap <C-S-x> <C-a>| " requires your terminal emulator to send \x1b[120;5u when pressing ctrl + shift + x | kitty example: map ctrl+shift+x send_text all \x1b[120;5u | '120' is the keycode for "x"

" move down by every VISIBLE / wrapped line instead of every physical one
noremap <silent> k gk
noremap <silent> j gj

noremap <silent> <C-o> o<Esc>o
noremap <silent> <C-S-o> O<Esc>O| " requires your terminal emulator to send \x1b[79;5u when pressing ctrl + shift + o | kitty example: map ctrl+shift+o send_text all \x1b[79;6u

" move to end of visible line
noremap <silent> 0 g0
noremap <silent> $ g$

noremap <silent> <C-0> 0
noremap <silent> <C-$> $

" move lines with Alt like in VSC - thanks to Eric Murphy for this!
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nnoremap <A-C-j> yyp
nnoremap <A-C-k> yyP

set termguicolors

let g:airline_theme='dracula'

" plugins
call plug#begin()
Plug 'haya14busa/is.vim' " removes the search when moving away
Plug 'sheerun/vim-polyglot'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'alvan/vim-closetag'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lukas-reineke/indent-blankline.nvim' " the only proper indent guide
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'wakatime/vim-wakatime'
Plug 'uiiaoo/java-syntax.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'elkowar/yuck.vim'
Plug 'rhysd/conflict-marker.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'yasuhiroki/github-actions-yaml.vim'

Plug 'grafana/vim-alloy'
" Plug 'itspriddle/vim-shellcheck'
call plug#end()

" using tabs will result in horrible formatting in k8s ConfigMaps
autocmd FileType alloy setlocal shiftwidth=2 softtabstop=2 expandtab

" prevent shifting of line numbers
set signcolumn=yes

" switch between items with tab and shift-tab
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Alt-Enter to show quick fixes available
nnoremap <A-cr> <Plug>(coc-codeaction-cursor)
" apply code actions to whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
" Alt + Shift + Enter
noremap <A-s-cr> <Plug>(coc-fix-current)

" Jump between diagnostics
nmap <silent> <F2> <Plug>(coc-diagnostic-next)
nmap <silent> <S-F2> <Plug>(coc-diagnostic-prev)

augroup my_dracula
  autocmd!
	" transparent background
  autocmd ColorScheme dracula highlight Normal guibg=NONE ctermbg=NONE
  " highlight trailing whitespaces in red
  autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup END
colorscheme dracula

let g:Hexokinase_highlighters = ['foregroundfull']

" clears search when pressing the spacebar
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" search the current word when pressing F8 (like *, but without jumping)
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" insert a single character (by inserting a underscore and then going into
" replace char mode)
nnoremap <C-i> i_<Esc>r

" persistent history / undo
set undodir=/tmp/vim-undo-dir.$USER
if !isdirectory(&undodir)
    call mkdir(&undodir, "", 0700)
endif
set undofile

" make d delete and not cut text
nnoremap d "_d
vnoremap d "_d

" disable the default highlight group
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<<\+ .*$'
let g:conflict_marker_common_ancestors = '^|||||||\+ .*$'
let g:conflict_marker_end   = '^>>>>>>>\+ .*$'

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81

lua <<EOF
vim.opt.list = true
vim.opt.listchars:append("space:·")
vim.opt.listchars:append("eol:↴")

local highlight = {
  "ColorColumn",
  "Whitespace",
}
require("ibl").setup {
  indent = { highlight = highlight, char = "" },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
}

require'lspconfig'.ts_ls.setup{}
require'lspconfig'.svelte.setup{}
EOF

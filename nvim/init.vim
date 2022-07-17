set number " Show absolute line numbers on the left.
filetype plugin on " Auto-detect un-labeled filetypes
syntax on " Turn syntax highlighting on
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
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
call plug#end()

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

lua <<EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF

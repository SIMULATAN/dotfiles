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
set shiftwidth=4 " Use 4 spaces as tab size
set encoding=utf8 " Set text encoding as utf8
set clipboard^=unnamed,unnamedplus " sync with system clipboard

if has("gui_running")
  set mouse=a
endif

set termguicolors

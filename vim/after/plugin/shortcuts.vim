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

" clears search when pressing the spacebar
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" search the current word when pressing F8 (like *, but without jumping)
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" insert a single character (by inserting a underscore and then going into
" replace char mode)
nnoremap <C-i> i_<Esc>r

" make d delete and not cut text
nnoremap d "_d
vnoremap d "_d

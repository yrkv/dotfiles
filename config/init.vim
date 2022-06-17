
call plug#begin()
Plug 'sickill/vim-monokai'
Plug 'vim-airline/vim-airline'
" TODO: vim-polyglot sets default to sh??????
"Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
call plug#end()


set modeline
set tabstop=4 shiftwidth=4 expandtab
set smartindent

set number
set scrolloff=5

let g:monokai_term_italic = 1
colorscheme monokai

set lazyredraw
" set cursorline relativenumber " slow(?)

vnoremap <leader>y :w !xclip -i -sel clipboard<CR><CR>
noremap <leader>p :r !xclip -o -sel clipboard<CR><CR>

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
" Line numbers
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
" Relative line numbers
" set relativenumber
set laststatus=2
" Clear last search highlighting
set nohlsearch
" Disable show mode since lightline is already displaying it
set noshowmode
" Coc : TextEdit might fail if hidden is not set.
set hidden
" Coc : Give more space for displaying messages.
set cmdheight=2
" Coc : Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Coc : Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Current line highlighted : Not sure it works in all cases
set cursorline
set noerrorbells

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'terryma/vim-expand-region'
" Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
"Plug 'SirVer/ultisnips'
" Plug 'unblevable/quick-scope'
call plug#end()

" Color scheme
" Invert color when selecting text
let g:gruvbox_invert_selection=0
colorscheme gruvbox
" set background=dark

" Remappings
" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader = " "

" jj to go back to normal mode 
inoremap jj <Esc>

" Remap VIM 0 to first non-blank character
map 0 ^

" Remap to replace current selection by what is in the buffer (works in visual mode). From ThePrimeAgen video : "Vim
" registers ..."
vnoremap <leader>p "_dP

" Fuzzy search in git files with Ctrl + P (fzf)
nnoremap <C-p> :GFiles<CR>

" Easier way to split windows
nmap <C-k> :vsp<CR>
nmap <C-j> :sp<CR>
" Eaasier way to move between windows
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" show substitutions incrementally
if has("nvim")
    set inccommand=nosplit
endif

" How to open new file on fuzzy search
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Coc : add nodejs path
let g:coc_node_path = "~/nodejs/bin/node"
" Coc.nvim : Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" not sure what is the use of the line below
let g:coc_global_extensions = ["coc-pyright"]
" Coc : Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Coc : Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Coc : Goto code definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer. : needed to format whole
" file with black
command! -nargs=0 Format :call CocAction('format')

augroup mygroup
autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType python setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Coc : Rename a variable
nmap <leader>rr <Plug>(coc-rename)

" See all occurences across project
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
" Toggle File tree
map <C-n> :NERDTreeToggle<CR>

" Nerd Commenter DOES NOT WORK 
" nmap <C-c> <Plug>NERDCommenterToggle
" vmap <C-c> <Plug>NERDCommenterToggle<CR>gv

" Tabs
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>

" Others
" yank highlighting
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight' .on_yank()
augroup END

" Quick-scope
" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Some nice remaps from ThePrimeAgen video 'MUST HAVE VIM REMAPS'
" Y behave like D, C, ... : yank end of line
nnoremap Y yg_
"Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Fast saving
nmap <leader>w :w!<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" vim-expand-region plugin
map + <Plug>(expand_region_expand)
map = <Plug>(expand_region_shrink)

"vim-lightline : show git status
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

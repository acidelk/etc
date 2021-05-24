" --------
" vim-plug
" --------

call plug#begin('~/.vim/plugged')


" l&f
Plug 'mhinz/vim-startify'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vcs
Plug 'airblade/vim-gitgutter'

" navigation
Plug 'ervandew/supertab'
Plug 'rbgrouleff/bclose.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/vim-slash'


" ------------
" text editing
" ------------
Plug 'neoclide/coc.nvim'
Plug 'elzr/vim-json'
Plug 'Chiel92/vim-autoformat'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'xolox/vim-misc'
Plug 'thinca/vim-quickrun'

" python formatter
Plug 'python/black', { 'tag': 'stable' }

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" time management
Plug 'wakatime/vim-wakatime'

" git diff
Plug 'sindrets/diffview.nvim'

" ---------
" languages
" ---------

" markdown
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'

" writing
Plug 'junegunn/goyo.vim'


call plug#end()


" ---
" l&f
" ---

let mapleader=","

syntax enable

filetype plugin indent on

set background=dark
nnoremap <leader>sb :let &background = ( &background == "dark"? "light" : "dark" )<cr>

colorscheme solarized

set hidden
set nofoldenable

set encoding=utf8

set clipboard=unnamed

set cursorline

" buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" shifting
xnoremap <  <gv
xnoremap >  >gv

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

set laststatus=0
set noshowmode
set nonu

" NerdTree
nnoremap <leader>t :NERDTreeToggle <CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


"indents
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set smarttab
set list listchars=tab:\>\

au FileType java,groovy setlocal shiftwidth=4 tabstop=4

au BufEnter * EnableStripWhitespaceOnSave

" execution
nnoremap <F5> :QuickRun<cr>

" undo
nnoremap <F6> :GundoToggle<cr>

" navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" yanking
:vmap y ygv<Esc>

" custom config
let $GENERATED_RC = $HOME.'/.nvim.generated'

if filereadable($GENERATED_RC)
  source $GENERATED_RC
endif


" ------
" search
" ------

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack


" ----
" goyo
" ----

nnoremap <F3> :Goyo <CR>

let g:goyo_height = '100%'
let g:goyo_width = '100%'


" ---------
" limelight
" ---------

let g:limelight_conceal_ctermfg = 'Gray'


" ------
" python
" ------

let g:pymode_options_colorcolumn = 0
let g:pymode_python = 'python3'
let g:pymode_rope = 1

let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'

" remove automatic line numbers and put everything else back
let g:pymode_options = 0

"au Filetype python call SetPymodeOptions()

"function SetPymodeOptions()
  "setlocal complete+=t
  "setlocal formatoptions-=t
  "setlocal nowrap
  "setlocal textwidth=88
  "setlocal commentstring=#%s
  "setlocal define=^\s*\\(def\\\\|class\\)
"endfunction

" disable autodoc
set completeopt=menu


" ----------
" formatting
" ----------

nnoremap <leader>f :Autoformat <CR>
au Filetype python call SetFormatCodeKeyPython()

function SetFormatCodeKeyPython()
  nmap <leader>f :Black <CR>
endfunction


" ------
" syntax
" ------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


" -------
" folding
" -------

set foldmethod=syntax
set nofoldenable


" --------
" markdown
" --------

let g:instant_markdown_autostart = 1


" ---
" fzf
" ---

nnoremap <silent> <C-f>f :FZF<cr>
nnoremap <silent> <C-f>w :Ag<cr>
nnoremap <silent> <C-f>h :History<cr>
nnoremap <silent> <C-f>cc :Commits<cr>
nnoremap <silent> <C-f>c :BCommits<cr>
nnoremap <silent> <C-f>b :Buffers<cr>
nnoremap <silent> <C-f>l :BLines<cr>
nnoremap <silent> <C-f>m :Marks<cr>
nnoremap <silent> <C-f>s :Snippets<cr>


" ----------
" file types
" ----------

au BufEnter Vagrantfile :setlocal filetype=ruby
au BufEnter *.json.j2 :setlocal filetype=json
au BufEnter *.yml.j2 :setlocal filetype=yaml


" ------------
" editorconfig
" ------------

let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" ------
" ranger
" ------

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

nnoremap - :Ranger<CR>


" ---------
" vim files
" ---------

if exists('*mkdir') && (!isdirectory($HOME.'/.vim') || !isdirectory($HOME.'/.vim/files'))
  call mkdir($HOME.'/.vim')
  call mkdir($HOME.'/.vim/files')
  call mkdir($HOME.'/.vim/files/backup')
  call mkdir($HOME.'/.vim/files/swap')
  call mkdir($HOME.'/.vim/files/undo')
  call mkdir($HOME.'/.vim/files/info')
endif

set backup
set backupdir   =$HOME/.vim/files/backup//
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo//
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" for edit crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" jump to last cursor position
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

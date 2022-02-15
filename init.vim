" ==================== INITIALIZE PLUGINS ====================

call plug#begin('~/.config/nvim/plugged')

" essentials for our sanity

Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'

" language servers and formatting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mhartington/formatter.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/nvim-lsp-installer'
Plug 'tami5/lspsaga.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-lua/popup.nvim',
Plug 'nvim-telescope/telescope.nvim',
 
" writing tools
Plug 'dpelle/vim-LanguageTool'

" colorscheme and theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'hoob3rt/lualine.nvim'

" narrow region
Plug 'chrisbra/NrrwRgn'

" jinja
Plug 'lepture/vim-jinja'

" nim
Plug 'alaviss/nim.nvim'

" dart
Plug 'dart-lang/dart-vim-plugin'
call plug#end()

" ==================== SETUP GLOBAL VARIABLES ====================

let g:languagetool_jar='/opt/Transient/bin/LanguageTool-5.4/languagetool-commandline.jar'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:user_emmet_install_global = 0
set conceallevel=0 "don't hide markdown tags

" ==================== SETUP VIM LOOK & FEEL ====================

set t_Co=256
set title
colorscheme tokyonight 
set background=dark
set mouse=a
set visualbell
set encoding=utf-8
filetype on
filetype plugin on
filetype indent on
syntax enable
set ignorecase
set smartcase
set autoindent
set cindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set ts=4
set number
set relativenumber
set nowrap
set synmaxcol=2048
set clipboard=unnamedplus
let mapleader = ","
set nofoldenable
set listchars=tab:»·,eol:·
set splitright
set splitbelow
set cmdheight=1
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes

" ==================== SETUP AUTOFILE ====================

au FileType wiki setl sw=2
au FileType html,css,php,blade,vue,jsx,svelte,gohtmltmpl EmmetInstall
au FileType html,css,ts,vue,jsx,tmpl setl sw=2
au FileType dart setl sw=2
au CompleteDone * pclose
au TermOpen * setlocal nonumber norelativenumber
au Filetype txt,md,markdown let b:AutoPairs = {'(':')','{':'}',"'":"'",'"':'"', '```':'```', '`':'`'}
au Filetype txt,md,markdown setlocal linebreak
au Filetype txt,md,markdown setlocal wrap 


" ==================== SETUP KEYMAP   ====================
" --- motions ---
nmap <C-u> 25k
nmap <C-d> 25j
" --- window motions ---
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
" --- vim terminal motions ---
nnoremap tt :new<CR>:term<CR> :resize 7<CR>A
nnoremap et :new<CR>:term<CR> :resize 26<CR>A
nnoremap vv :vnew<CR>:term<CR>A
nnoremap <leader>ff :tabnew<CR>:term<CR>A
tnoremap <esc><esc> <C-\><C-n>
" --- filetype conversion
nnoremap <leader>js :set filetype=javascript<cr>
nnoremap <leader>jh :set filetype=html<cr>
nnoremap <leader>jp :set filetype=php<cr>
nnoremap <leader>jo :set filetype=json<cr>
nnoremap <leader>jd :set filetype=htmldjango<cr>:w

" --- manual autoformatter ---
nnoremap <leader>jn :%!python3 -m json.tool<cr>
nnoremap <leader>jq :%!sql-formatter-cli -i %<cr>

" --- writing ---
nnoremap <leader>md :set wrap linebreak nolist<cr>
nnoremap <leader>nd :set nowrap<cr>

" ---- tabs and buffers ---
nnoremap <leader>tc :tabnew<cr>
nnoremap <leader>tn :tabNext<cr>
nnoremap <leader>tp :tabprevious<cr>
nnoremap <leader>ww :noa w<CR>

" ---- [PLUGIN] EasyAlign ---
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ---- NerdTree 
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ==================== LUA INIT ====================
lua require('init_syntax')
lua require('init_completion')
lua require('init_lsp')
lua require('init_statusline')
lua require('init_prettier')
lua require('init_telescope')

" ==================== CUSTOM FUNCTIONS ====================
function! VueTransTempl()
    normal! gv"ay
    normal! gvx
    let selected = @a
    exe "normal! i{{ $t(\"" . selected . "\") }}" 
endfunction

function! VueTransText()
    normal! gv"ay
    normal! gvx
    let selected = @a
    exe "normal! i$t('" . selected . "')" 
endfunction

function! VueTransUnquote()
    normal! gv"ay
    normal! gvx
    let selected = @a
    exe "normal! i$t(" . selected . ")" 
endfunction

function! InsertDate()
    let curdate = strftime('%a %d %b %Y')
    exe "normal! i " . curdate
endfunction

function! InsertTomorrowDate()
    let curdate = strftime('%a %d %b %Y', localtime() + (24 * 3600))
    exe "normal! i " . curdate
endfunction

function! InsertTime()
    let curdate = strftime('%H:%M:%S')
    exe "normal! a[ " . curdate ." ]"
endfunction

function! InsertISOTime()
    let curdate = strftime('%Y-%m-%dT%T.%Y%m')
    exe "normal! a" . curdate .""
endfunction

nnoremap <leader>id :call InsertDate()<CR>
nnoremap <leader>in :call InsertTomorrowDate()<CR>
nnoremap <leader>it :call InsertTime()<CR>
nnoremap <leader>ir :call InsertISOTime()<CR>
vnoremap <leader>vi :call VueTransTempl()<CR>
vnoremap <leader>vk :call VueTransText()<CR>
vnoremap <leader>vl :call VueTransUnquote()<CR>

nnoremap <leader>fp :!prettier % --print-width=100 --tab-width=4 --write<CR>

au BufNewFile,BufRead *.jj,*.tpl set ft=jinja

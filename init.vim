"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"__     ___             ____             __ _         _____ _ _      
"\ \   / (_)_ __ ___   / ___|___  _ __  / _(_) __ _  |  ___(_) | ___ 
" \ \ / /| | '_ ` _ \ | |   / _ \| '_ \| |_| |/ _` | | |_  | | |/ _ \
"  \ V / | | | | | | || |__| (_) | | | |  _| | (_| |_|  _| | | |  __/
"   \_/  |_|_| |_| |_(_)____\___/|_| |_|_| |_|\__, (_)_|   |_|_|\___|
"                                             |___/                  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" nerdtree
Plug 'scrooloose/nerdtree'

map <silent><C-e> :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

au VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
au VimEnter * call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
au VimEnter * call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
au VimEnter * call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
au VimEnter * call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
au VimEnter * call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
au VimEnter * call NERDTreeHighlightFile('rb', 'Red', 'none', '#ffa500', '#151515')
au VimEnter * call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')

highlight! link NERDTreeFlags NERDTreeDir


" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme="bubblegum" 
let g:airline_powerline_fonts = 1   
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'


" devicons
Plug 'ryanoasis/vim-devicons'

function! Fzf_dev()
  let l:fzf_files_options = ' -m --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview "bat --color always --style numbers {2..}"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let result = []
    for candidate in a:candidates
      let filename = fnamemodify(candidate, ':p:t')
      let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
      call add(result, printf("%s %s", icon, candidate))
    endfor

    return result
  endfunction

  function! s:edit_file(items)
    let items = a:items
    let i = 1
    let ln = len(items)
    while i < ln
      let item = items[i]
      let parts = split(item, ' ')
      let file_path = get(parts, 1, '')
      let items[i] = file_path
      let i += 1
    endwhile
    call s:Sink(items)
  endfunction

  let opts = fzf#wrap({})
  let opts.source = <sid>files()
  let s:Sink = opts['sink*']
  let opts['sink*'] = function('s:edit_file')
  let opts.options .= l:fzf_files_options
  call fzf#run(opts)
endfunction


" rainbow
Plug 'luochen1990/rainbow'

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


" python
Plug 'sillybun/vim-repl'
Plug 'vim-scripts/indentpython.vim'
Plug 'klen/python-mode'
Plug 'ivanov/vim-ipython'
Plug 'klen/python-mode'
Plug 'ivanov/vim-ipython'

nnoremap <F5> :REPLToggl


" clap
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }

noremap <C-q> :Clap<CR>

let g:clap_theme = 'material_design_dark'
let g:clap_layout = { 'relative': 'editor' }


" taglist
Plug 'vim-scripts/taglist.vim'

let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

map <silent> t :TagbarOpenAutoClose<CR>


" tagbar
Plug 'preservim/tagbar'

nmap <F2> :TagbarToggle<CR>

filetype plugin indent on

let g:tagbar_ctags_bin='/usr/bin/ctags'  
let g:tagbar_width=30  
let g:tagbar_right=1  

highlight LineNr cterm=bold ctermfg=red
highlight StorageClass cterm=bold ctermfg=darkgreen
highlight Type cterm=bold ctermfg=blue
highlight LineNr cterm=bold ctermbg=black
highlight phpStructure cterm=bold ctermfg=darkred
highlight phpFunctions cterm=bold ctermfg=256
highlight Title ctermfg=blue 
highlight pythonString cterm=bold ctermfg=gray
highlight pythonFunction cterm=bold 
highlight pythonInclude cterm=bold ctermfg=lightblue
highlight javaScriptStringS ctermfg=gray 
highlight String ctermfg=gray
hi Search cterm=NONE ctermfg=darkred ctermbg=yellow cterm=reverse
highlight Directory ctermfg=blue 


" C/Cpp
Plug 'vim-scripts/c.vim'


" indentline
Plug 'yggdroot/indentline'

let g:indentLine_char_list = ['|', '¦', '┆', '┊']


" leaderf
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }


" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

map <F3> :FZF<CR>


" ale
Plug 'w0rp/ale'

let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_enter = 1
let b:ale_linters = ['pylint']
let b:ale_fixers = ['autopep8', 'yapf']

nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
nmap <Leader>s :ALEToggle<CR>
nmap <Leader>d :ALEDetail<CR>
let g:ale_linters = {
\   'python': ['pyflakes'],
\}
"}}}
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pyflakes'],
\}
" ctrp
Plug 'kien/ctrlp.vim'

map <F4> :CtrlPLine<CR>


" nerdcommend
Plug 'scrooloose/nerdcommenter'

let g:NERDToggleCheckAllLines = 1

nnoremap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>


" dashboard
Plug 'glepnir/dashboard-nvim'

let g:indentLine_fileTypeExclude = ['defx', 'denite', 'startify', 'tagbar', 'vista_kind', 'vista', 'coc-explorer', 'dashboard']
let g:dashboard_default_executive ='fzf'
let g:mapleader="\<Space>"

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2

let g:dashboard_custom_header =<< trim END
=================     ===============     ===============   ========  ========
\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
||.=='    _-'                                                     `' |  /==.||
=='    _-'                        N E O V I M                         \/   `==
\   _-'                                                                `-_   /
 `''                                                                      ``'
END
" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" theme
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'navarasu/onedark.nvim'


"  telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" markdown
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'plasticboy/vim-markdown'
Plug 'jamshedvesuna/vim-markdown-preview' 
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chrome'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
" keyboard
map <F12> :PlugInstall<CR>
map wq :wq<CR>
map sa :q!<CR>
map qq :q<CR>
imap jk <Esc>
noremap <F9> :w<CR>
noremap <F10> :wq<CR>
noremap <F8> :q!<CR>

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ____       _   _   _             
"/ ___|  ___| |_| |_(_)_ __   __ _ 
"\___ \ / _ \ __| __| | '_ \ / _` |
" ___) |  __/ |_| |_| | | | | (_| |
"|____/ \___|\__|\__|_|_| |_|\__, |
"                            |___/ 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
syntax on
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=''
set expandtab
set tabstop=4 
set shiftwidth=4 
set softtabstop=4 
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
filetype plugin indent on
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
"       _   _               
"  ___ | |_| |__   ___ _ __ 
" / _ \| __| '_ \ / _ \ '__|
"| (_) | |_| | | |  __/ |   
" \___/ \__|_| |_|\___|_|   
""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F6> ms:call AddAuthor()<cr>'s
function AddAuthor()
    let n=1
    while n < 5
        let line = getline(n)
        if line =~'^\s*\*\s*\S*Last\s*modified\s*:\s*\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
 
function UpdateTitle()
    normal m'
    execute '/* Last modified\s*:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    normal "
    normal mk
    execute '/* Filename\s*:/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
 
function AddTitle()
    call append(0,"/**********************************************************")
    call append(1," * Author        : Johnson")
    call append(2," * Email         : 1138401083@qq.com")
    call append(3," * Last modified : ".strftime("%Y-%m-%d %H:%M"))
    call append(4," * Filename      : ".expand("%:t"))
    call append(5," * Description   : ")
    call append(6," * *******************************************************/")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

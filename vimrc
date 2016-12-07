" F2 toggles line numbers
" F3 toggles file browser
" F4 toggles object browser
" F5 toggles undo tree
" F10 toggles paste mode
" <leader>h clears highlighting and signify symbols
"
" jj <Esc>
" JJ <Esc>
" kk <Esc>
" KK <Esc>
"
" Shift-L :bnext
" Shift-H :bprev
" Shift-J 20 lines down
" Shift-K 20 lines up
"
" Ctrl-j Move down a window
" Ctrl-k Move up a window
" Ctrl-h Move left a window
" Ctrl-l Move right a window
"
" <Tab> Jump to next word
" Shift-<Tab> Jump back a word
"
set nocompatible
let $MYVIMRC = $HOME."/.vim/vimrc"

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

syntax on

" General settings
set number
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set hidden
set noautowrite
set nosmartindent
set smarttab
set showmatch
set scrolloff=5
set ttyfast
set visualbell
set autochdir
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*.git
set nowrapscan
set textwidth=0

highlight MatchParen ctermbg=4

set cul

set t_Co=256
hi CursorLine cterm=NONE ctermbg=18 ctermfg=white guibg=18 guifg=white
hi colorcolumn cterm=NONE ctermbg=black guibg=black
hi LineNr cterm=NONE ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow
hi search cterm=NONE ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
hi signcolumn cterm=NONE ctermbg=black guibg=black
hi Pmenu cterm=NONE ctermbg=darkgreen ctermfg=white guibg=darkgreen guifg=white
hi PmenuSel cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
hi visual cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
hi statusline cterm=NONE ctermbg=4 ctermfg=white
hi statuslinenc cterm=NONE ctermbg=black ctermfg=white

nnoremap <Leader>c :set cursorline!<CR>

hi SpellBad cterm=NONE ctermbg=darkred ctermfg=yellow guibg=darkred guifg=yellow

set incsearch
set hlsearch

set listchars=trail:_
set nolist
set timeout
set timeoutlen=400
set ttimeoutlen=100

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F3> :NERDTreeToggle<CR>
let g:tagbar_autofocus = 1
nnoremap <F4> :TagbarToggle<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :set nolist!<CR>
nnoremap <silent> <leader>h :noh<CR>:silent! call flake8#Flake8UnplaceMarkers()<CR>:sign unplace *<CR>
nnoremap <silent> <leader>g :redir @g<CR>:g//<CR>:redir END<CR>:new<CR>:put! g<CR>

nnoremap <F10> :set invpaste paste?<Enter>
inoremap <F10> <C-O><F10>
set pastetoggle=<F10>

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
inoremap jj <Esc>
inoremap kk <Esc>
inoremap JJ <Esc>
inoremap KK <Esc>

cnoremap w!! w !sudo tee % > /dev/null

" A little macro to remove special aligning
let @u = ':silent! s/\(\S\)\s\{2,\}/\1 /g:silent! s/\S\zs\s\+\ze[:\])]//g'
noremap <leader>u :norm @u<CR>

" A macro to capitalize SQL keywords
let @i = ':silent! s/\<\(desc\|trigger\|after\|for\|each\|row\|returns\|replace\|function\|execute\|procedure\|with\|case\|when\|then\|else\|end\|type\|using\|foreign\|references\|cascade\|if\|check\|coalesce\|boolean\|union\|false\|true\|integer\|text\|serial\|primary\|key\|into\|insert\|drop\|limit\|unique\|index\|default\|column\|add\|table\|create\|alter\|delete\|interval\|set\|begin\|order by\|group by\|commit\|update\|rollback\|as\|select\|distinct\|from\|null\|or\|is\|inner\|right\|outer\|join\|in\|not\|exists\|on\|where\|and\|constraint\)\>\c/\U&/g'

" Back to being a WIP
let @_ = ":silent! s/\\('\\)\\@<![^']\\{-}\\zs\\<\\(trigger\\|after\\|for\\|each\\|row\\|returns\\|replace\\|function\\|execute\\|procedure\\|with\\|case\\|when\\|then\\|else\\|end\\|type\\|using\\|foreign\\|references\\|cascade\\|if\\|check\\|coalesce\\|boolean\\|union\\|false\\|true\\|integer\\|text\\|serial\\|primary\\|key\\|into\\|insert\\|drop\\|limit\\|unique\\|index\\|default\\|column\\|add\\|table\\|create\\|alter\\|delete\\|interval\\|set\\|begin\\|order by\\|group by\\|commit\\|update\\|rollback\\|as\\|select\\|distinct\\|from\\|null\\|or\\|is\\|inner\\|left\\|right\\|outer\\|join\\|in\\|not\\|exists\\|on\\|where\\|and\\|constraint\\)\\>\\ze[^']\\{-}\\('\\)\\@!\\c/\\U&/g"
noremap <leader>s :norm @i<CR><CR>

" Add some mappings
noremap ,# :call CommentLineToEnd('#')<CR>+
noremap ,* :call CommentLinePincer('/* ', ' */')<CR>+
"Allow command to accept a count
noremap <silent> <S-j> @='20j'<CR>
noremap <silent> <S-k> @='20k'<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprev<CR>
vnoremap <S-l> 5l
vnoremap <S-h> 5h
noremap <S-y> y$
noremap <S-Up> :tabp<CR>
noremap <S-Down> :tabn<CR>
noremap <S-Left> :bprev<CR>
noremap <S-Right> :bnext<CR>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l
noremap <C-Left> <C-w>h
nnoremap <Tab> w
vnoremap <Tab> w
nnoremap <S-Tab> b
vnoremap <S-Tab> b
vnoremap gb :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
nnoremap <leader>a <Esc>:LAck!
nnoremap <C>a <Esc>:LAck!
noremap <leader>fc /\v^[<=>]{7}( .*\|$)<CR>

nnoremap ,v :source $MYVIMRC<CR>
nnoremap ,e :e $MYVIMRC<CR>

runtime ftplugin/man.vim

" AutoCommands!
augroup EditVim
    autocmd!

    au InsertEnter * if &buftype != 'nofile' | hi LineNr ctermbg=darkred   guibg=darkred | endif
    au InsertEnter * if &buftype != 'nofile' | hi CursorLine ctermbg=darkred guibg=darkred | else | hi CursorLine ctermbg=NONE guibg=NONE | endif
    au InsertLeave * if &buftype != 'nofile' | hi LineNr ctermbg=NONE guibg=NONE | endif
    au InsertLeave * hi CursorLine ctermbg=18 guibg=darkblue

    au FileType svn,*commit* setlocal spell
    au FileType git,*commit* setlocal spell
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    "recalculate the trailing whitespace warning when idle, and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_conflict_warning
augroup END

augroup filetype_python
    autocmd!
    au FileType python set foldmethod=indent
    au FileType python set foldlevel=99
    "au FileType python set nosmartindent
    "au FileType python BracelessEnable +indent +highlight-cc2
    au FileType python map <buffer> <leader>8 :call Flake8()<CR>
    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    au FileType python set listchars=trail:_
    au FileType python set list

    " Also highlight all tabs and trailing whitespace characters.
    au FileType python highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow
    au FileType python match ExtraWhitespace /\s\+$\|\t/
    au BufWritePost,cursorhold * filetype detect
    "au FileType python colo molokai
augroup END

augroup filetype_htmldjango
    autocmd!
    au FileType htmldjango set foldmethod=indent
    au FileType htmldjango set foldlevel=99
augroup END

augroup filetype_cs
    autocmd!
    au FileType cs set omnifunc=syntaxcomplete#Complete
    au FileType cs set foldmethod=marker
    au FileType cs set foldmarker={,}
    au FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
    au FileType cs set foldlevelstart=2
    au FileType cs set smartindent
augroup END

augroup filetype_text
    autocmd!
    au FileType text setlocal textwidth=80
    au FileType text setlocal smartindent
    au FileType text setlocal spell spelllang=en_us
    au FileType text setlocal noexpandtab
augroup END

augroup filetype_help
    autocmd!
    au FileType help setlocal nospell
augroup END

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

function! RaiseExceptionForUnresolvedErrors()
    let s:file_name = expand('%:t')

    let s:conflict_line = search('\v^[<=>]{7}( .*|$)', 'nw')
    if s:conflict_line != 0
        throw 'Found unresolved conflicts in ' . s:file_name . ':' . s:conflict_line
    endif

    let s:whitespace_line = search('\s\+$', 'nw')
    if s:whitespace_line != 0
        throw 'Found trailing whitespace in ' . s:file_name . ':' . s:whitespace_line
    endif

    if &filetype == 'python'
        silent %yank p
        new
        silent 0put p
        silent $,$d
        silent %!pyflakes
        silent exe '%s/<stdin>/' . s:file_name . '/e'

        let s:un_res = search('\(unable to detect \)\@<!undefined name', 'nw')
        if s:un_res != 0
            let s:message = 'Syntax error! ' . getline(s:un_res)
            bd!
            throw s:message
        endif

        let s:ui_res = search('unexpected indent', 'nw')
        if s:ui_res != 0
            let s:message = 'Syntax error! ' . getline(s:ui_res)
            bd!
            throw s:message
        endif

        let s:ui_res = search('expected an indented block', 'nw')
        if s:ui_res != 0
            let s:message = 'Syntax error! ' . getline(s:ui_res)
            bd!
            throw s:message
        endif

        let s:is_res = search('invalid syntax', 'nw')
        if s:is_res != 0
            let s:message = 'Syntax error! ' . getline(s:is_res)
            bd!
            throw s:message
        endif

        let s:is_res = search('unindent does not match any outer indentation level', 'nw')
        if s:is_res != 0
            let s:message = 'Syntax error! ' . getline(s:is_res)
            bd!
            throw s:message
        endif

        let s:is_res = search('EOL while scanning string literal', 'nw')
        if s:is_res != 0
            let s:message = 'Syntax error! ' . getline(s:is_res)
            bd!
            throw s:message
        endif

        let s:is_res = search('trailing comma not allowed without surrounding parentheses', 'nw')
        if s:is_res != 0
            let s:message = 'Syntax error! ' . getline(s:is_res)
            bd!
            throw s:message
        endif

        let s:is_res = search('problem decoding source', 'nw')
        if s:is_res != 0
            let s:message = 'pyflakes error! Check results manually! ' . getline(s:is_res)
            bd!
            throw s:message
        endif

        bd!
    endif
endfunction
autocmd BufWritePre * call RaiseExceptionForUnresolvedErrors()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        if winnr() == winnr('$')
            execute ":bnext"
        else
            normal gt
        endif
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction

function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support and tabs open
        if winnr() == 1
            execute ":bprev"
        else
            normal gT
        endif
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction

" Signify Settings
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow
highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow

"QuickSilver Config
let g:QSMatchFn = 'fuzzy'
let g:QSIgnore = ".*\.pyc$;.*\.swp$"

" PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" ctrlp
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_map = '<c-p>'
nnoremap <leader>t :let g:ctrlp_working_path_mode = 'c'<CR>:CtrlP<CR>:let g:ctrlp_working_path_mode = 'r'<CR>
nnoremap <leader>p :let g:ctrlp_working_path_mode = 'r'<CR>:CtrlP<CR>
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
" If ag is available use it as filename list generator instead of 'find'
let g:ackprg = 'ag --nogroup --nocolor --column'
set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --ignore ''**/*.pyc'' --hidden -g ""'

"let g:ctrlp_user_command = {
"    \ 'types': {
"      \ 1: ['.git', 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'],
"      \ 2: ['.svn', 'ag %s -i --nocolor --nogroup --ignore ''.svn'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'],
"      \ },
"    \ 'fallback': 'find %s -type f'
"    \ }

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:100'

"NERDTree
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.pyc$', '\.swp$']

"Syntastic Settings
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=["pyflakes"]
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

"Flake8
let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

"YCM
set completeopt=menuone
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:bufferline_rotate = 1

" Jedi
let g:jedi#documentation_command = ''

"SuperTab
let g:SuperTabDefaultCompletionType = "context"

"statusline setup
set statusline=
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

set statusline+=%{fugitive#statusline()}

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{StatuslineConflictWarning()}
set statusline+=%*
"
"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#warningmsg#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}\ " Space at the end of the line left intentionally
set statusline+=%{StatuslineLongLineWarning()}\ " Space at the end of the line left intentionally

set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

function! StatuslineConflictWarning()
    if !exists("b:statusline_conflict_warning")

        if !&modifiable
            let b:statusline_conflict_warning = ''
            return b:statusline_conflict_warning
        endif

        if search('\v^[<=>]{7}( .*|$)', 'nw') != 0
            let b:statusline_conflict_warning = '[con!]'
        else
            let b:statusline_conflict_warning = ''
        endif
    endif
    return b:statusline_conflict_warning
endfunction

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

set laststatus=2

python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int(vim.eval('line(".")'))

    strLine = vim.current.line
    strWhite = re.search('^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)simport ipdb; ipdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'noremap <F12> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    nCurrentLine = int(vim.eval('line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import ipdb" or strLine.lstrip()[:29] == "import ipdb; ipdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command("normal %dG" % nLine)
        vim.command("normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command("normal %dG" % nCurrentLine)

vim.command("noremap <F24> :py RemoveBreakpoints()<cr>")
EOF
"vim:syntax=vim

for i in range(97,122)
        let c = nr2char(i)
        exec "set <M-".c.">=\<Esc>".c
endfor

set nobackup

if version >= 703
    set undofile
    set undolevels=1000
    set undoreload=1000
    set cm=blowfish
endif

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory',
              \ 'undodir': 'undodir' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "//"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          if version < 703
              if settingname == 'undodir'
                  continue
              endif
          endif
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()


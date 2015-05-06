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
hi CursorLine cterm=NONE ctermbg=18 ctermfg=white guibg=darkblue guifg=white
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
let g:pyflakes_use_quickfix = 0
let g:pep8_map='<leader>8'
"let g:pep8_map='<F8>'

set incsearch
set hlsearch

set listchars=tab:>.,trail:.,extends:#,nbsp:.
set nolist
set timeout
set timeoutlen=400
set ttimeoutlen=100


nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F3> :NERDTreeToggle<CR>
let g:tagbar_autofocus = 1
nnoremap <F4> :TagbarToggle<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :set nolist!<CR>
nnoremap <silent> <leader>h :noh<CR>:SyntasticClear<CR>:sign unplace *<CR>
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

" AutoCommands!
augroup EditVim
    autocmd!
    au InsertEnter * highlight LineNr ctermbg=red   guibg=red
    au InsertLeave * highlight LineNr ctermbg=NONE guibg=NONE
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
    au FileType python set nosmartindent
    "au FileType python colo molokai
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

" A little macro to remove special aligning
let @u = ':s/\(\S\)\s\{2,\}/\1 /g'
noremap <leader>u :norm @u<CR>

" A macro to capitalize SQL keywords
let @s = ':silent! s/\<\(coalesce\|boolean\|union\|false\|true\|integer\|text\|serial\|primary\|key\|into\|insert\|drop\|limit\|unique\|index\|default\|column\|add\|table\|create\|alter\|delete\|interval\|set\|begin\|order by\|group by\|commit\|update\|rollback\|as\|select\|distinct\|from\|null\|or\|is\|inner\|right\|outer\|join\|in\|not\|exists\|on\|where\|and\|constraint\)\>\c/\U&/g'
noremap <leader>s :norm @s<CR><CR>

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
let g:SuperTabCrClosePreview = 0

"Pydiction Config
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

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
noremap <leader>j :RopeGotoDefinition<CR>
noremap <leader>r :RopeRename<CR>
nnoremap <leader>a <Esc>:LAck!
nnoremap <C>a <Esc>:LAck!
noremap <leader>fc /\v^[<=>]{7}( .*\|$)<CR>
"noremap <leader>n <Plug>TaskList
"It would be nice to get the following lines to work at some point
nnoremap <leader>N :noautocmd vimgrep #TODO\|NOTE#j **/*.py <CR>
nnoremap <leader>n :noautocmd vim #TODO\|NOTE#j *.py <CR>

" Yapf!!!
nnoremap <leader>y :call Yapf()<cr>
vnoremap <leader>y :!yapf<cr>
autocmd FileType python set formatprg=yapf

nnoremap ,v :source $MYVIMRC<CR>
nnoremap ,e :e $MYVIMRC<CR>

nnoremap ,d :cd ~/TexturaWD/textura<CR>
runtime ftplugin/man.vim

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

let NERDTreeHijackNetrw=1

"Syntastic Settings
let g:syntastic_check_on_open=1
let g:syntastic_python_checker="pyflakes"
let g:syntastic_quiet_warnings=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

"VCSCommand Settings
let g:VCSCommandDeleteOnHide = 1

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

set statusline+=%{StatuslineTrailingSpaceWarning()}\ 

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
"NERDTree
let NERDChristmasTree=1

set laststatus=2

" Signify Settings
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow
highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow

"QuickSilver Config
let g:QSMatchFn = 'fuzzy'

python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)sipdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import ipdb":
            break
    else:
        vim.current.buffer.append( 'import ipdb', 1)
        vim.command( 'normal j1')

vim.command( 'noremap <F12> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import ipdb" or strLine.lstrip()[:16] == "ipdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( "normal %dG" % nCurrentLine)

vim.command( "noremap <S-F12> :py RemoveBreakpoints()<cr>")
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


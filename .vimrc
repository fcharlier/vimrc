set nocompatible " be iMproved
filetype off     " required!

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage bundle
Bundle 'gmarik/vundle'

" Repos from github
"Bundle 'name/repo'
"
" Vimscripts
"Bundle 'vimscriptname'
"
" Other git
"Bundle 'git://url/repo.git'

Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'tomtom/quickfixsigns_vim'
Bundle 'rodjek/vim-puppet'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'fcharlier/openssl.vim'
Bundle 'tpope/vim-repeat'
Bundle 'vim-scripts/snipMate'
Bundle 'vim-scripts/sudo.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'tomtom/tcomment_vim'
Bundle 'mattn/emmet-vim'
Bundle 'Townk/vim-autoclose'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'tomasr/molokai'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'kablamo/vim-git-log'
Bundle 'caio/querycommandcomplete.vim'
" Bundle 'tlib'
" Bundle 'vcscommand'

filetype plugin indent on " required!
syntax on

"
" Change <Leader>
let mapleader = ","

set showmatch

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

set cinoptions=':0,+4,(4,u0'
set expandtab tabstop=4 shiftwidth=4 smarttab autoindent cindent softtabstop=4 " http://py.vaults.ca/~x/python_and_vim.html

set titlestring=%f title " Display filename in terminal window
set rulerformat=%l:%c "Display current column/line in bottom right
set showcmd
set splitbelow

" Keep more lines of context
set scrolloff=3

" swap ' and ` to go back to a marker place
nnoremap ' `
nnoremap ` '


"
" ===================================================================
" snipMate personnal settings
" ===================================================================
let g:snips_author = 'François Charlier'

"
" ===================================================================
" colorscheme
" ===================================================================
"
" http://www.vim.org/scripts/script.php?script_id=2340

if has('gui')
    let g:molokai_original=1
    colorscheme molokai

    set gfn=Envy\ Code\ R\ for\ Powerline\ 10

    set guioptions-=m
    set guioptions-=T
else
    " Force 256color mode (for FreeBSD, bad termcap)
    if $TERM =~ "xterm-256color" || $TERM =~ "screen"
        set t_Co=256
    endif

    if &t_Co > 255
        let g:molokai_original=1
        colorscheme molokai
    else
        colorscheme delek
    endif
endif
" http://dengmao.wordpress.com/2007/01/22/vim-color-scheme-wombat/
"       + xtermize-gvim-scheme
"colorscheme wombat256
" http://www.frexx.de/xterm-256-notes/
"colorscheme asu1dark
"colorscheme blackdust
"colorscheme desert256


"
" ===================================================================
" Status line
" ===================================================================
"
" first, enable status line always
set laststatus=2
if has('statusline')
"    set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]%=[LEN=%L]
" http://informatique-et-liberte.tuxfamily.org/2009/06/27/vim-et-son-vimrc-une-barre-detat-personnalisee/#more-250
    set statusline=\ %f%m%r\ u+%B\ [%{strlen(&ft)?&ft:'aucun'},%{strlen(&fenc)?&fenc:&enc},%{&fileformat},ts:%{&tabstop}]%=l.%l/%L,c.%c%V\ %P

"     now set it up to change the status line based on mode
"    if version >= 700
"      au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
"      au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
"    endif
"    hi statusline term=reverse ctermfg=0 ctermbg=2 guibg=green
endif


"
" ===================================================================
" Abbreviations - General Editing - Inserting Dates and Times
" ===================================================================
"
" First, some command to add date stamps (with and without time).
" I use these manually after a substantial change to a webpage.
" [These abbreviations are used with the mapping for ",L".]
"
iab Ydate <C-R>=strftime("%Y-%m-%d")<CR>
" Example: 2002-04-06
"
iab Ytime <C-R>=strftime("%H:%M")<CR>
" Example: 14:28
"
iab YDT <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
" Example: 2002-06-24 20:44

iab BDate <C-R>=strftime("meta-creation_date: %d.%m.%Y %H:%M")<CR>

" HTML accent characters ...
"       imap é &eacute;
"       imap è &egrave;
"       imap à &agrave;
"       imap ç &ccedil;
"       imap ê &ecirc;
"       imap â &acirc;
"       imap ô &ocirc;
"       imap î &icirc;
"       imap ù &ugrave;

" From vimcasts.org, tip #1
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"
" Folds
"
"persist folds at file close
" au BufWritePost,BufLeave,WinLeave ?* mkview
" au BufReadPre ?* silent loadview


" Shortcut to rapidly un-hilite search resyults
nmap <leader>hh :nohlsearch<CR>

nmap <leader>px :%!xmllint --format --recover - 2>/dev/null<CR>

map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', '^\.svn$']


autocmd BufRead,BufNewFile *.pl,*.plx,*.pm,*.t command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy -q
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm,*.t noremap <leader>t :Tidy<CR>
autocmd BufWritePre * call StripTrailingWhite()
"autocmd FileType python compiler pylint
au BufRead,BufNewFile {capfile,Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
au FileType {ruby,yaml} setl sw=2 ts=2 sts=2 et

function! StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\%(^--\)\@<!\s\+$//
    call winrestview(l:winview)
endfunction

" set formatprg=par\ -w72rjq\ P+\\[
set spelllang=en_us

let g:qcc_query_command="lbdbq '%s'"
au BufRead /tmp/mutt* setlocal tw=72 spell omnifunc=QueryCommandComplete
let g:qcc_multiline=1

if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Gist should be able to read multiple files
let g:gist_get_multiplefile = 1

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

" http://vim.wikia.com/wiki/Create_underlines,_overlines,_and_strikethroughs_using_combining_characters
function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

" enable backups of encrypted files
let g:openssl_backup=1

" Align '=>' signs
nmap <leader>= :Tabularize/=><CR>

" Indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"This allows for change paste motion cp{motion}
"http://stackoverflow.com/questions/2471175/vim-replace-word-with-contents-of-paste-buffer/5357194#5357194
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

let g:pymode_rope = 0

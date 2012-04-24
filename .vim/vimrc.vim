" TODO check these out
"  sign http://www.vim.org/scripts/script.php?script_id=1580
"  formatting http://www.vimoutliner.org
"  mu-template http://www.vim.org./scripts/script.php?script_id=222
"  snipMate    http://www.vim.org./scripts/script.php?script_id=2540
"  Command-T   http://www.vim.org/scripts/script.php?script_id=3025
"  lookupfile.vim taglist.vim ctags.vim autoproto.vim
"  ptags

source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

colorscheme xoria256
filetype plugin on
" filetype indent on  " very annoying on perl syntax
syntax enable

set ttimeoutlen=100 " remove cursor color change delay on exiting INSERT mode
set nocp
set autoindent
set copyindent
set virtualedit=all
set fileencoding=utf-8
set bufhidden=hide
set nowrap
set tabstop=2
set shiftwidth=2
set wildmode=list:longest
set imsearch=-1
" set keymap=russian-jcukenwin
set iminsert=0
set ignorecase
set smartcase
set hlsearch
set list
set listchars=tab:▸\ ,eol:¬
" set statusline=%<%f\ %h\%m\%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" set statusline=%F%m%r%h%w\ [FMT=%{&ff}]\ [TYPE=%Y]\
"   [ASC=\%03.3b(\%02.2B)]\ [POS=%03l,%02v(%L)]\ [%p%%]
" set laststatus=2
" set dictionary += /path/to/dictionary
" set relativefilenumber

if $TERM == 'screen-256color'
	" escape sequences for changing cursor color
	let &t_SI = "\<Esc>]12;yellow\x7"
	let &t_EI = "\<Esc>]12;orchid3\x7"
else
	let &t_SI = ""
	let &t_EI = ""
endif

" TODO fix this, maybe rewrite in vimscript (too slow on large files)
" let b:MyShiftWidth = 2
" function! MyFoldTitle()
" 	let line = getline(v:foldstart)
" 	let line = substitute(line,'\t', repeat(' ',b:MyShiftWidth),'g')
" 	let line = substitute(line,'/\*\|\*/\|\!@#\|#@!','','g')
" 	let line = substitute(line,'\(.\{75,75}\).*','\1...','g')
" 	let lines_count = v:foldend - v:foldstart
" 	return line . " <" . lines_count . " lines>"
" endfunction
" set foldtext=MyFoldTitle()
" 
" function! PerlReturn(param)
" 	let g:perlresult = a:param
" endfunction
" 
" function! PerlFoldExpr(lnum)
" 	perl << EOF
" 	my ($ok,$num) = VIM::Eval("a:lnum");
" 	my $prefix_rx   = qr/(?: *(?:"|#|\/\/) *)*/;
" 	my $wspace_rx   = qr/$prefix_rx(?:EOF|(\s*))/;
" 	my $finalize_rx = qr/^$wspace_rx(endfunction|endif|\<\/|]|})[^{]*$/i;
" 
" 	my $line1 = $curbuf->Get($num);
" 	$line1 =~ /^$wspace_rx/; my $i = $1;
" 	$i =~ s/ +/ /i;
" 	my $i1 = length $i;
" 
" 	if    ($line1 =~ /^$wspace_rx$/) { $R = "=" }
" 	elsif ($line1 =~ /$finalize_rx/)     { $R = "<".($i1+1) }
" 	else { my $line2;
" 		for (1..5) {
" 			$line2 = $curbuf->Get(++$num);
" 			last if $line2 !~ /^$wspace_rx$/;
" 		}
" 		$line2 =~ /^$wspace_rx/; my $i = $1;
" 		$i =~ s/ +/ /i;
" 		my $i2 = length $i;
" 
" 		if ($line2 =~ /$finalize_rx/) { $R = "=" } else {
" 			if    ($i1 < $i2) { $R = ">".($i1+1) }
" 			elsif ($i1 > $i2) { $R = "<".($i2+1) }
" 			else              { $R = "=" }
" 		}
" 	}
" 	VIM::Eval("PerlReturn('$R')");
"EOF
" 	return g:perlresult
" endfunction
"
" set foldexpr=PerlFoldExpr(v:lnum)
set foldmethod=marker

" autocommands
function! SetPathToProperLocation()
	let codedir = expand('%:p:h')
	if   codedir == '$HOME/.vim'
	\ || codedir == '$HOME/.fvwm'
		exe 'set path='.codedir.'/**'
	else
		set path=$HOME/programming/**
	endif
endfunction

augroup test_path_set
	au!
	au BufEnter *.cpp call SetPathToProperLocation()
	au BufEnter *.vim call SetPathToProperLocation()
	au BufEnter *.pl  call SetPathToProperLocation()
	au BufEnter *.ft  call SetPathToProperLocation()
augroup END

	au FocusLost * :silent! wa
" 	au BufNewFile,BufRead *.xml %!~/using/scripts/formatXml.pl
	au BufNewFile,BufRead *.ft  set commentstring=\\\ %s
	au BufNewFile,BufRead *.c   set commentstring=\ /*\ %s\ */
	au BufNewFile,BufRead *.cpp set commentstring=\ //\ %s
	au BufNewFile,BufRead *.pod %!/usr/bin/pod2text
	au BufReadPost fugitive://* set bufhidden=delete

" TODO do I need these? Probably not.
" function! LoadSettings(ext)
" 	silent!  execute 'source $HOME/.vim/templates/'.a:ext.'.pat'
" endfunction
" function! LoadTemplate(ext)
" 	silent! :execute '0r     $HOME/.vim/templates/'.a:ext.'.tpl'
" 	silent!  execute 'source $HOME/.vim/templates/'.a:ext.'.pat'
" endfunction
" nnoremap <C-\>      /<+.*+><cr>:silent! foldopen!<cr>d/+>/e<cr>:nohls<cr>i
" inoremap <C-\> <ESC>/<+.*+><cr>:silent! foldopen!<cr>d/+>/e<cr>:nohls<cr>i
" iabbrev for( for(!!;<++>;<++>){<cr><++><cr>}<Esc>:call search('!!','b')<cr>cf!


" TODO rewrite as smart Tab mapping that checks previous symbols
" imap f;<Tab> :   ;<esc>hhi
" imap fd<Tab> do  loop <esc>5hi
" imap fi<Tab> if  then <esc>5hi
" imap fe<Tab> if  else then <esc>10hi
" imap fu<Tab> begin  until <esc>6hi
" imap fw<Tab> begin  while repeat <esc>13hi
" imap fr<Tab> begin  repeat <esc>7hi

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb

	nmap <C-[>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-[>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" Using 'CTRL-P' then a search type makes the vim window
	" split horizontally, with search result displayed in
	" the new window.

	nmap <C-P>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-P>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-P>d :scs find d <C-R>=expand("<cword>")<CR><CR>

	" Hitting CTRL-P *twice* before the search type does a vertical
	" split instead of a horizontal one

	nmap <C-P><C-P>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P><C-P>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P><C-P>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P><C-P>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P><C-P>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-P><C-P>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-P><C-P>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif

nnoremap ; :
vnoremap ; :
nnoremap q; q:
vnoremap q; q:
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <tab> %
vnoremap <tab> %

let mapleader=","
nnoremap <leader>a :Ack 
nnoremap <leader>m :Man 
nnoremap <leader>s :split<CR>
nnoremap <leader>n :new<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader><space> :noh<cr>

nmap <silent> <leader>ev :e $HOME/.vim/vimrc.vim<CR>
nmap <silent> <leader>sv :so $HOME/.vim/vimrc.vim<CR>

" select pasted text
nnoremap <leader>v V`]

" very magical regexps
nnoremap / /\v
vnoremap / /\v

" simple REPL interaction for forth
perl << EOF
my $replPipe = "~/programming/forth/pipe.sh";;
my $replBuffer;
sub replAccum      { $replBuffer .= $_[0]."\n" }
sub replPasteAccum {
	open(my $pipe, "| $replPipe");
	print {$pipe} $replBuffer;
	close $pipe;
	$replBuffer = "";
}
sub replPasteLine  { my ($x,$y) = $curwin->Cursor();
	my $content = $curbuf->Get($x) . "\n";
	open(my $pipe, "| $replPipe");
	print {$pipe} $content;
	close $pipe;
}
sub replPasteFile { my $content = "";
	$content .= $curbuf->Get($_)."\n" for 0 .. $curbuf->Count();
	open(my $pipe, "| $replPipe");
	print {$pipe} $content;
	close $pipe;
}
sub replPastePara { my ($x,$y) = $curwin->Cursor();
	my ($top,$bottom) = ($x-1,$x+1);
	my $content = $curbuf->Get($x);

	while(1) { my $line = $curbuf->Get($top);
		last if $top <= 0 or $line =~ /^$/;
		$content = "$line\n$content"; $top--;
	}
	while(1) { my $line = $curbuf->Get($bottom);
		last if $bottom > $curbuf->Count() or $line =~ /^$/;
		$content = "$content\n$line"; $bottom++;
	}
	$content =~ s|^\t*||g;
	$content .= "\n";

	open(my $pipe, "| $replPipe");
	print {$pipe} $content;
	close $pipe;
}
EOF

nnoremap <leader>rr :perl replPasteLine()<cr>
nnoremap <leader>ra :perl replPasteFile()<cr>
nnoremap <leader>rw :perl replPastePara()<cr>
vnoremap <leader>rr :perldo replAccum($_)<cr>:perl replPasteAccum()<cr>

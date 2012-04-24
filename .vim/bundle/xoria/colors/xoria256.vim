" Vim color file
"	
"	 Name:       xoria256.vim
"	 Version:    1.4
"	 Maintainer: Dmitriy Y. Zotikov (xio) <xio@ungrund.org>
"	
"	 Should work in recent 256 color terminals.  88-color terms like urxvt are
"	 NOT supported.
"	
"	 Don't forget to install 'ncurses-term' and set TERM to xterm-256color or
"	 similar value.
"	
"	 Color numbers (0-255) see:
"	 http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

" Initialization
if &t_Co != 256
	echomsg ""
	echomsg "err: please use a 256-color terminal"
	echomsg ""
	finish
endif

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "xoria256"
" Colors
	"" General
		hi Normal       ctermfg=252             cterm=none
		hi Cursor                   ctermbg=214
		hi CursorColumn             ctermbg=238
		hi CursorLine               ctermbg=238 cterm=none
		hi Error        ctermfg=15  ctermbg=1
		hi ErrorMsg     ctermfg=15  ctermbg=1
		hi FoldColumn   ctermfg=247 ctermbg=NONE
		hi Folded       ctermfg=244 ctermbg=black
		hi IncSearch    ctermfg=0   ctermbg=0     cterm=none
		hi LineNr       ctermfg=247 ctermbg=233
		hi MatchParen   ctermfg=gray ctermbg=0    cterm=bold
		hi NonText      ctermfg=darkgray          cterm=bold
		hi Pmenu        ctermfg=0   ctermbg=246
		hi PmenuSbar                ctermbg=243
		hi PmenuSel     ctermfg=0   ctermbg=243
		hi PmenuThumb               ctermbg=252
		hi Search       ctermfg=0   ctermbg=gray
		hi SignColumn   ctermfg=248
		hi SpecialKey   ctermfg=darkgray
		hi SpellBad     ctermfg=160             cterm=underline
		hi SpellCap     ctermfg=189             cterm=underline
		hi SpellRare    ctermfg=168             cterm=underline
		hi StatusLine               ctermbg=239 cterm=bold
		hi StatusLineNC             ctermbg=237 cterm=none
		hi TabLine      ctermfg=fg  ctermbg=242 cterm=none
		hi TabLineFill  ctermfg=fg  ctermbg=239 cterm=none
		hi Title        ctermfg=225
		hi Todo         ctermfg=0   ctermbg=184
		hi Underlined   ctermfg=39              cterm=underline
		hi VertSplit    ctermfg=239 ctermbg=239 cterm=none
		hi Visual       ctermfg=255 ctermbg=96
		hi VisualNOS    ctermfg=255 ctermbg=60
		hi WildMenu     ctermfg=0   ctermbg=150 cterm=bold
	"" Syntax highlighting
		hi Comment      ctermfg=244
		hi Constant     ctermfg=229
		hi Identifier   ctermfg=182 cterm=none
		hi Ignore       ctermfg=238
		hi Number       ctermfg=180
		hi PreProc      ctermfg=150
		hi Special      ctermfg=174
		hi Statement    ctermfg=110 cterm=none
		hi Type         ctermfg=146 cterm=none
	"" Special
		""" .diff
			hi diffAdded    ctermfg=150
			hi diffRemoved  ctermfg=174
		""" vimdiff
			hi diffAdd      ctermbg=blue
			hi diffDelete   ctermbg=red   cterm=none
			hi diffChange   ctermbg=black cterm=none
			hi diffText     ctermbg=gray  cterm=none

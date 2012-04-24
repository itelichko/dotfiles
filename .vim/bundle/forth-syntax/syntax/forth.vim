" Vim syntax file
" Language:    FORTH
" Maintainer:  XXX
" Last Change: ~9999
" Filenames:   *.ft,*.fs,*.gft
" URL:	       NONE

syntax clear

" if exists("b:current_syntax")
" 	finish
" endif

syn sync ccomment
syn sync maxlines=200
syn case ignore

" Some special, non-FORTH keywords
syn keyword forthTodo contained TODO FIXME XXX
syn match forthTodo contained 'Copyright\(\s([Cc])\)\=\(\s[0-9]\{2,4}\)\='

setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255

syn match   forthWord        display "\S\+"
syn match   forthStringWord  display +\S\+" \+[^"]*"+
syn match   forthBraceWord   display +\S\+( \+[^)]*)+
syn match   forthSpaceError  display " \+\t"me=e-1
syn match   forthSingleSpace display "\> \<"
syn region  forthDeclaration start=+:\s\++ end=+\>+ contains=forthSymbol
syn match   forthSymbol      display +[^:]\&\S\++ contained
syn match   forthDeclaration + ;+
syn match   forthDeclaration +;+

syn keyword forthOperators + - * / MOD /MOD NEGATE ABS MIN MAX
syn keyword forthOperators AND OR XOR NOT LSHIFT RSHIFT INVERT 2* 2/ 1+
syn keyword forthOperators 1- 2+ 2- 8* UNDER+
syn keyword forthOperators M+ */ */MOD M* UM* M*/ UM/MOD FM/MOD SM/REM
syn keyword forthOperators D+ D- DNEGATE DABS DMIN DMAX D2* D2/
syn keyword forthOperators F+ F- F* F/ FNEGATE FABS FMAX FMIN FLOOR FROUND
syn keyword forthOperators F** FSQRT FEXP FEXPM1 FLN FLNP1 FLOG FALOG FSIN
syn keyword forthOperators FCOS FSINCOS FTAN FASIN FACOS FATAN FATAN2 FSINH
syn keyword forthOperators FCOSH FTANH FASINH FACOSH FATANH F2* F2/ 1/F
syn keyword forthOperators F~REL F~ABS F~
syn keyword forthOperators 0< 0<= 0<> 0= 0> 0>= < <= <> = > >= U< U<=
syn keyword forthOperators U> U>= D0< D0<= D0<> D0= D0> D0>= D< D<= D<>
syn keyword forthOperators D= D> D>= DU< DU<= DU> DU>= WITHIN ?NEGATE
syn keyword forthOperators ?DNEGATE WITHIN?

syn keyword forthStack DROP NIP DUP OVER TUCK SWAP ROT -ROT ?DUP PICK ROLL
syn keyword forthStack 2DROP 2NIP 2DUP 2OVER 2TUCK 2SWAP 2ROT 2-ROT
syn keyword forthStack 3DUP 4DUP 5DUP 3DROP 4DROP 5DROP 8DROP 4SWAP 4ROT
syn keyword forthStack 4-ROT 4TUCK 8SWAP 8DUP
syn keyword forthRStack >R R> R@ RDROP 2>R 2R> 2R@ 2RDROP
syn keyword forthRstack 4>R 4R> 4R@ 4RDROP
syn keyword forthFStack FDROP FNIP FDUP FOVER FTUCK FSWAP FROT

syn keyword forthSP SP@ SP! FP@ FP! RP@ RP! LP@ LP!

syn keyword forthMemory @ ! +! C@ C! 2@ 2! F@ F! SF@ SF! DF@ DF!
syn keyword forthAdrArith CHARS CHAR+ CELLS CELL+ CELL ALIGN ALIGNED FLOATS
syn keyword forthAdrArith FLOAT+ FLOAT FALIGN FALIGNED SFLOATS SFLOAT+
syn keyword forthAdrArith SFALIGN SFALIGNED DFLOATS DFLOAT+ DFALIGN DFALIGNED
syn keyword forthAdrArith MAXALIGN MAXALIGNED CFALIGN CFALIGNED
syn keyword forthAdrArith ADDRESS-UNIT-BITS ALLOT ALLOCATE HERE FREE
syn keyword forthMemBlks MOVE ERASE CMOVE CMOVE> FILL BLANK

syn keyword forthCond IF ELSE ENDIF THEN CASE OF ENDOF ENDCASE ?DUP-IF
syn keyword forthCond ?DUP-0=-IF AHEAD CS-PICK CS-ROLL CATCH THROW WITHIN

syn keyword forthLoop BEGIN WHILE REPEAT UNTIL AGAIN RECURSE
syn keyword forthLoop ?DO LOOP I J K +DO U+DO -DO U-DO DO +LOOP -LOOP
syn keyword forthLoop UNLOOP LEAVE ?LEAVE EXIT DONE FOR NEXT

syn keyword forthDefine CONSTANT 2CONSTANT FCONSTANT VARIABLE 2VARIABLE
syn keyword forthDefine FVARIABLE CREATE USER VALUE TO DEFER IS DOES> IMMEDIATE
syn keyword forthDefine COMPILE-ONLY COMPILE RESTRICT INTERPRET POSTPONE EXECUTE
syn keyword forthDefine LITERAL CREATE-INTERPRET/COMPILE INTERPRETATION>
syn keyword forthDefine <INTERPRETATION COMPILATION> <COMPILATION ] LASTXT
syn keyword forthDefine COMP' POSTPONE, FIND-NAME NAME>INT NAME?INT NAME>COMP
syn keyword forthDefine NAME>STRING STATE C; CVARIABLE
syn keyword forthDefine , 2, F, C, 

syn keyword forthMath DECIMAL HEX BASE
syn match   forthInteger '\<-\=[0-9.]*[0-9.]\+\>'
syn match   forthInteger '\<&-\=[0-9.]*[0-9.]\+\>'

" recognize hex and binary numbers, the '$' and '%' notation is for gforth
syn match   forthInteger '\<\$\x*\x\+\>' " *1* --- dont't mess
syn match   forthInteger '\<\x*\d\x*\>'  " *2* --- this order!
syn match   forthInteger '\<%[0-1]*[0-1]\+\>'
syn match   forthFloat   '\<-\=\d*[.]\=\d\+[DdEe]\d\+\>'
syn match   forthFloat   '\<-\=\d*[.]\=\d\+[DdEe][-+]\d\+\>'

" syn match   forthComment '\s\\\s.*$'
" syn match   forthComment '^\\\s*'
" syn region  forthComment           start='/\*' end='\*/'
syn region  forthCommentOuter      start='\s*\\' end='\ze.' contains=forthCommentInner
syn region  forthCommentInner      start='\\'    end='$'            contained
syn region  forthStackCommentOuter start='(\s'   end='\s*'  contains=forthStackCommentInner
syn region  forthStackCommentInner start='(\s'   skip='\\)' end=')' contained
syn region  forthLocalsOuter       start='{\s'   end='\s*'  contains=forthLocalsInner
syn region  forthLocalsInner       start='{\s'   skip='\\}' end='}' contained
" syn region  forthStackComment start='\s*\zs(\s' skip='\\)\ze\s*' end=')'
" syn region  forthStackLocals  start='\s*\zs{\s' skip='\\}\ze\s*' end='}'

command -nargs=+ HiLink hi def link <args>

HiLink forthTodo       Todo
HiLink forthSpaceError Error

hi forthSymbol       ctermbg=black  ctermfg=182  cterm=bold
hi forthDeclaration  ctermbg=NONE   ctermfg=182  cterm=bold

hi forthCommentOuter      ctermbg=NONE ctermfg=244
hi forthCommentInner      ctermbg=0    ctermfg=244
hi forthStackCommentOuter ctermbg=NONE ctermfg=244 cterm=bold
hi forthStackCommentInner ctermbg=0    ctermfg=244 cterm=bold,underline
hi forthLocalsOuter       ctermbg=NONE ctermfg=146 cterm=bold
hi forthLocalsInner       ctermbg=0    ctermfg=146 cterm=bold,underline

hi forthSingleSpace  ctermbg=0
hi forthWord         ctermbg=0
hi forthStringWord   ctermbg=0 ctermfg=229
hi forthBraceWord    ctermbg=0 ctermfg=176
hi forthOperators    ctermbg=0 ctermfg=180
hi forthMath         ctermbg=0 ctermfg=180
hi forthInteger      ctermbg=0 ctermfg=229
hi forthFloat        ctermbg=0 ctermfg=176
hi forthDefine       ctermbg=0 ctermfg=150        cterm=bold
hi forthStack        ctermbg=0 ctermfg=174        cterm=bold
hi forthFStack       ctermbg=0 ctermfg=174        cterm=bold
hi forthSP           ctermbg=0 ctermfg=174        cterm=bold
hi forthMemory       ctermbg=0 ctermfg=174        cterm=bold
hi forthAdrArith     ctermbg=0 ctermfg=lightgreen cterm=bold
hi forthMemBlks      ctermbg=0 ctermfg=174        cterm=bold
hi forthCond         ctermbg=0 ctermfg=110        cterm=bold,underline
hi forthRstack       ctermbg=0 ctermfg=110        cterm=bold,underline
hi forthLoop         ctermbg=0 ctermfg=110        cterm=bold,underline

delcommand HiLink

se ts=3
se sw=3
" se sts=3

let b:current_syntax = "forth"

"   " new words
"   syn match forthClassDef '\<:class\s*[^ \t]\+\>'
"   syn match forthObjectDef '\<:object\s*[^ \t]\+\>'
"   syn match forthColonDef '\<:m\?\s*[^ \t]\+\>'
"   syn keyword forthEndOfColonDef ; ;M ;m
"   syn keyword forthEndOfClassDef ;class
"   syn keyword forthEndOfObjectDef ;object
"
"   syn match forthDefine "\[IFDEF]"
"   syn match forthDefine "\[IFUNDEF]"
"   syn match forthDefine "\[THEN]"
"   syn match forthDefine "\[ENDIF]"
"   syn match forthDefine "\[ELSE]"
"   syn match forthDefine "\[?DO]"
"   syn match forthDefine "\[DO]"
"   syn match forthDefine "\[LOOP]"
"   syn match forthDefine "\[+LOOP]"
"   syn match forthDefine "\[NEXT]"
"   syn match forthDefine "\[BEGIN]"
"   syn match forthDefine "\[UNTIL]"
"   syn match forthDefine "\[AGAIN]"
"   syn match forthDefine "\[WHILE]"
"   syn match forthDefine "\[REPEAT]"
"   syn match forthDefine "\[COMP']"
"   syn match forthDefine "'"
"   syn match forthDefine '\<\[\>'
"   syn match forthDefine "\[']"
"   syn match forthDefine '\[COMPILE]'
"   
"   " debugging
"   syn keyword forthDebug PRINTDEBUGDATA PRINTDEBUGLINE
"   syn match forthDebug "\<\~\~\>"
"   
"   " Assembler
"   syn keyword forthAssembler ASSEMBLER CODE END-CODE ;CODE FLUSH-ICACHE C,
"   
"   " basic character operations
"   syn keyword forthCharOps (.) CHAR EXPECT FIND WORD TYPE -TRAILING EMIT KEY
"   syn keyword forthCharOps KEY? TIB CR
"   " recognize 'char (' or '[char] (' correctly, so it doesn't
"   " highlight everything after the paren as a comment till a closing ')'
"   syn match forthCharOps '\<char\s\S\s'
"   syn match forthCharOps '\<\[char\]\s\S\s'
"   syn region forthCharOps start=+."\s+ skip=+\\"+ end=+"+
"   
"   " char-number conversion
"   syn keyword forthConversion <<# <# # #> #>> #S (NUMBER) (NUMBER?) CONVERT D>F 
"   syn keyword forthConversion D>S DIGIT DPL F>D HLD HOLD NUMBER S>D SIGN >NUMBER
"   syn keyword forthConversion F>S S>F
"   
"   " interpreter, wordbook, compiler
"   syn keyword forthForth (LOCAL) BYE COLD ABORT >BODY >NEXT >LINK CFA >VIEW HERE
"   syn keyword forthForth PAD WORDS VIEW VIEW> N>LINK NAME> LINK> L>NAME FORGET
"   syn keyword forthForth BODY> ASSERT( ASSERT0( ASSERT1( ASSERT2( ASSERT3( )
"   syn region forthForth start=+ABORT"\s+ skip=+\\"+ end=+"+
"   
"   " vocabularies
"   syn keyword forthVocs ONLY FORTH ALSO ROOT SEAL VOCS ORDER CONTEXT #VOCS
"   syn keyword forthVocs VOCABULARY DEFINITIONS
"   
"   " File keywords
"   syn keyword forthFileMode R/O R/W W/O BIN 
"   syn keyword forthFileWords OPEN-FILE CREATE-FILE CLOSE-FILE DELETE-FILE
"   syn keyword forthFileWords RENAME-FILE READ-FILE READ-LINE KEY-FILE
"   syn keyword forthFileWords KEY?-FILE WRITE-FILE WRITE-LINE EMIT-FILE
"   syn keyword forthFileWords FLUSH-FILE FILE-STATUS FILE-POSITION
"   syn keyword forthFileWords REPOSITION-FILE FILE-SIZE RESIZE-FILE
"   syn keyword forthFileWords SLURP-FILE SLURP-FID STDIN STDOUT STDERR
"   syn keyword forthBlocks OPEN-BLOCKS USE LOAD --> BLOCK-OFFSET
"   syn keyword forthBlocks GET-BLOCK-FID BLOCK-POSITION LIST SCR BLOCK
"   syn keyword forthBlocks BUFER EMPTY-BUFFERS EMPTY-BUFFER UPDATE UPDATED?
"   syn keyword forthBlocks SAVE-BUFFERS SAVE-BUFFER FLUSH THRU +LOAD +THRU
"   syn keyword forthBlocks BLOCK-INCLUDED
"   
"   " XXX If you find this overkill you can remove it. this has to come after the
"   " highlighting for numbers otherwise it has no effect.
"   syn region forthComment start='0 \[if\]' end='\[endif\]' end='\[then\]' contains=forthTodo
"   
"   " Strings
"   syn region forthString start=+\.*\"+ end=+"+ end=+$+
"   " XXX
"   syn region forthString start=+s\"+ end=+"+ end=+$+
"   syn region forthString start=+c\"+ end=+"+ end=+$+
"   
"   " Include files
"   syn match forthInclude '^INCLUDE\s\+\k\+'
"   syn match forthInclude '^require\s\+\k\+'
"   syn match forthInclude '^fload\s\+'
"   syn match forthInclude '^needs\s\+'
"   
"   " Locals definitions
"   syn region forthLocals start='{\s' start='{$' end='\s}' end='^}'
"   syn match forthLocals '{ }' " otherwise, at least two spaces between
"   syn region forthDeprecated start='locals|' end='|'
"   
"   " Define the default highlighting.
"   " For version 5.7 and earlier: only when not done already
"   " For version 5.8 and later: only when an item doesn't have highlighting yet
"   if version >= 508 || !exists("did_forth_syn_inits")
"       if version < 508
"   	let did_forth_syn_inits = 1
"   	command -nargs=+ HiLink hi link <args>
"       else
"   	command -nargs=+ HiLink hi def link <args>
"       endif
"   
"       " The default methods for highlighting. Can be overriden later.
"       HiLink forthTodo Todo
"       HiLink forthMath Number
"       HiLink forthInteger Number
"       HiLink forthFloat Float
"       HiLink forthColonDef Define
"       HiLink forthEndOfColonDef Define
"       HiLink forthDefine Define
"       HiLink forthDebug Debug
"       HiLink forthAssembler Include
"       HiLink forthCharOps Character
"       HiLink forthConversion String
"       HiLink forthForth Statement
"       HiLink forthVocs Statement
"       HiLink forthString String
"       HiLink forthComment Comment
"       HiLink forthClassDef Define
"       HiLink forthEndOfClassDef Define
"       HiLink forthObjectDef Define
"       HiLink forthEndOfObjectDef Define
"       HiLink forthInclude Include
"       HiLink forthLocals Type " nothing else uses type and locals must stand out
"       HiLink forthDeprecated Error " if you must, change to Type
"       HiLink forthFileMode Function
"       HiLink forthFileWords Statement
"       HiLink forthBlocks Statement
"       HiLink forthSpaceError Error
"   
"       delcommand HiLink
"   endif
"   

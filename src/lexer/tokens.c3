module lexer;

import std::collections::list;

// struct Token 
// {
// 	TokenType type;
// 	uint start;
// 	uint end;
// }

// struct TokenStream 
// {
// 	String source;
// 	List{ Token } tokens;
// }

<*
 TokenType has the token value if applicable, else an empty string
 search for a non-empty string for tokens with a pre-defined value
*>
enum TokenType : uint (String token)
{
	INVALID_TOKEN = "",

	// Single-character tokens.
	AMP 		= "&",
	AT 			= "@",
	BANG 		= "!",
	BIT_NOT 	= "~",
	BIT_OR 		= "=",
	BIT_XOR 	= "^",
	COLON 		= ":",
	COMMA 		= ",",
	EOS 		= ";",
	EMPTY_LINE 	= "", // a line with only white spaces (useful for code formatting)
	EQ 			= "=",
	GREATER 	= ">",
	DIV 		= "/",
	DOLLAR 		= "$",
	DOT 		= ".",
	HASH 		= "#",
	LESS 		= "<",
	LBRACE 		= "{",
	LBRACKET 	= "[",
	LPAREN 		= "(",
	MINUS 		= "-",
	MOD 		= "%",
	PLUS 		= "+",
	QUESTION 	= "?",
	RBRACE 		= "}",
	RBRACKET 	= "]",
	RPAREN 		= ")",
	STAR 		= "*",
	UNDERSCORE 	= "_",
	SPACE 		= " ",

	// two character tokens.
	AND				= "&&",
	ARROW			= "->", // Not used but reserved
	BANGBANG		= "!!",
	BIT_AND_ASSIGN	= "&=",
	BIT_OR_ASSIGN	= "|=",
	BIT_XOR_ASSIGN	= "^=",
	DIV_ASSIGN		= "/=",
	DOTDOT			= "..",
	BUILTIN			= "$$",
	ELVIS			= "?:",
	EQEQ			= "==",
	GREATER_EQ		= ">=", 
	IMPLIES			= "=>", // short function syntax's returns defined after =>
	LESS_EQ			= "<=",
	LVEC  			= "[<",
	MINUS_ASSIGN  	= "-=",
	MINUSMINUS  	= "--",
	MOD_ASSIGN  	= "%=",
	MULT_ASSIGN  	= "*=",
	NOT_EQUAL  		= "!=",
	OR  			= "||",
	PLUS_ASSIGN  	= "+=",
	PLUSPLUS  		= "++",
	RVEC  			= ">]",
	QUESTQUEST  	= "??",
	SCOPE 		 	= "::",
	SHL  			= "<<",
	SHR  			= ">>",

	// Three or more
	ELLIPSIS 		= "...",
	SHL_ASSIGN 		= "<<=",
	SHR_ASSIGN 		= ">>=",
	CT_AND 			= "&&&",
	CT_CONCAT 		= "+++",
	CT_OR 			= "|||",
	
	// Literals.
	IDENT  			= "", // Any normal ident.
	CONST_IDENT  	= "", // Any purely uppercase ident,
	TYPE_IDENT  	= "", // Any ident on the format FooBar or __FooBar

	// We want to parse $foo separately,
	// otherwise we allow things like "$ foo" which would be pretty bad.
	CT_IDENT			= "", // $foobar
	CT_CONST_IDENT		= "", // $FOOBAR
	CT_TYPE_IDENT		= "", // $Foobar

	// Lazy identifiers, we want to parse #foo separately.
	HASH_IDENT			= "", // #foobar
	HASH_CONST_IDENT	= "", // #FOOBAR
	HASH_TYPE_IDENT		= "", // #Foobar

	// Macros
	AT_IDENT			= "", // @macro
	AT_CONST_IDENT		= "", // @MACRO
	AT_TYPE_IDENT		= "", // @Macro

	COMMENT_SINGLE_INLINE		= "//", // //single INLINE comment (after other code on the same line)
	COMMENT_SINGLE				= "//", // //single line comment (only comment on that line)
	COMMENT_MULTI				= "/*", //  /* multiline on new line */
	COMMENT_MULTI_END			= "*/",
	COMMENT_MULTI_INLINE		= "", //  some /* multiline on the same line */

	STRING			= "\"", // "Teststring"
	RAW_STRING		= "`", // `Teststring`
	INTEGER			= "", // 123 0x23 0b10010 0o327
	CHAR_LITERAL	= "", // 'a' 'FO' 'BARS' '\u1232'
	REAL			= "", // 0x23.2p-2a 43.23e23
	BYTES			= "", // Base64 or Hex

	DOC_COMMENT 	= "", // Doc Comment start this is a comment line inside of a doc comment, there are functional lines as well

	// Basic types names
	VOID			= "void",
	// FIRST_KEYWORD = TOKEN_VOID,
	BOOL			= "bool",
	CHAR			= "char",
	DOUBLE			= "double",
	FLOAT			= "float",
	FLOAT16			= "float16",
	BFLOAT			= "bfloat",
	INT128			= "int128",
	ICHAR			= "ichar",
	INT				= "int",
	IPTR			= "iptr",
	ISZ				= "isz",
	LONG			= "long",
	SHORT			= "short",
	UINT128			= "uint128",
	UINT			= "uint",
	ULONG			= "ulong",
	UPTR			= "uptr",
	USHORT			= "ushort",
	USZ				= "usz",
	FLOAT128		= "float128",
	ANY				= "any",
	ANYFAULT		= "anyfault",
	TYPEID			= "typeid",

	// Keywords
	ASSERT		= "assert",
	ASM			= "asm",
	STRUCT		= "struct",
	ALIAS		= "alias",
	TYPEDEF		= "typedef",
	BITSTRUCT	= "bitstruct",
	FAULT		= "fault",
	UNION		= "union",
	BREAK		= "break",
	CASE		= "case",
	CATCH		= "catch",
	CONTINUE	= "continue",
	DEFAULT		= "default",
	DEFER		= "defer",
	DO			= "do",
	ELSE		= "else",
	ENUM		= "enum",
	EXTERN		= "extern",
	FALSE		= "false",
	FOR			= "for",
	FOREACH		= "foreach",
	FOREACH_R	= "foreach_r",
	FN			= "fn",
	TLOCAL		= "tlocal",
	IF			= "if",
	INLINE		= "inline",
	IMPORT		= "import",
	MACRO		= "macro",
	MODULE		= "module",
	NEXTCASE	= "nextcase",
	NULL		= "null",
	INTERFACE	= "interface",
	RETURN		= "return",
	STATIC		= "static",
	SWITCH		= "switch",
	TRUE		= "true",
	TRY			= "try",
	VAR			= "var",
	WHILE		= "while",
	CONST		= "const",
	// LAST_NON_CT_KEYWORD = TOKEN_WHILE,

	CT_ALIGNOF		= "$alignof",
	CT_ANDFN		= "$and",
	CT_APPEND		= "$append",
	CT_ASSERT		= "$assert",
	CT_ASSIGNABLE	= "$assignable",
	CT_CASE			= "$case",
	CT_CONCATFN		= "$concat",
	CT_DEFAULT		= "$default",
	CT_DEFINED		= "$defined",
	CT_ECHO			= "$echo",
	CT_ELSE			= "$else",
	CT_EMBED		= "$embed",
	CT_ENDFOR		= "$endfor",
	CT_ENDFOREACH	= "$endforeach",
	CT_ENDIF		= "$endif",
	CT_ENDSWITCH	= "$endswitch",
	CT_EVAL			= "$eval",
	CT_EVALTYPE		= "$evaltype",
	CT_ERROR		= "$error",
	CT_EXEC			= "$exec",
	CT_EXTNAMEOF	= "$extnameof",
	CT_FEATURE		= "$feature",
	CT_FOR			= "$for",
	CT_FOREACH		= "$foreach",
	CT_IF			= "$if",
	CT_INCLUDE		= "$include",
	CT_IS_CONST		= "$is_const",
	CT_NAMEOF		= "$nameof",
	CT_OFFSETOF		= "$offsetof",
	CT_ORFN			= "$or",
	CT_QNAMEOF		= "$qnameof",
	CT_SIZEOF		= "$sizeof",
	CT_STRINGIFY	= "$stringify",
	CT_SWITCH		= "$switch",
	CT_TYPEFROM		= "$typefrom",
	CT_TYPEOF		= "$typeof",
	CT_VACOUNT		= "$vacount",
	CT_VATYPE		= "$vatype",
	CT_VACONST		= "$vaconst",
	CT_VAREF		= "$varef",
	CT_VAARG		= "$vaarg",
	CT_VAEXPR		= "$vaexpr",
	CT_VASPLAT		= "$vasplat",
	// LAST_KEYWORD = TOKEN_CT_VASPLAT
	DOCS_START 		= "<*",
	DOCS_END 		= "*>",
	DOCS_EOL 		= "",

	EOF				= "",  // \n - SHOULD ALWAYS BE THE LAST TOKEN.
	// LAST = TOKEN_EOF,
}




// enum TokenValues : uint (String token)
// {
// 	// Single-character tokens.
// 	AMP 		= "&",
// 	AT 			= "@",
// 	BANG 		= "!",
// 	BIT_NOT 	= "~",
// 	BIT_OR 		= "=",
// 	BIT_XOR 	= "^",
// 	COLON 		= ":",
// 	COMMA 		= ",",
// 	EOS 		= ";",
// 	// EMPTY_LINE 	= "", // a line with only white spaces (useful for code formatting)
// 	EQ 			= "=",
// 	GREATER 	= ">",
// 	DIV 		= "/",
// 	DOLLAR 		= "$",
// 	DOT 		= ".",
// 	HASH 		= "#",
// 	LESS 		= "<",
// 	LBRACE 		= "{",
// 	LBRACKET 	= "[",
// 	LPAREN 		= "(",
// 	MINUS 		= "-",
// 	MOD 		= "%",
// 	PLUS 		= "+",
// 	QUESTION 	= "?",
// 	RBRACE 		= "}",
// 	RBRACKET 	= "]",
// 	RPAREN 		= ")",
// 	STAR 		= "*",
// 	UNDERSCORE 	= "_",
// 	// SPACE 		= " ",

// 	// two character tokens.
// 	AND				= "&&",
// 	ARROW			= "->", // Not used but reserved
// 	BANGBANG		= "!!",
// 	BIT_AND_ASSIGN	= "&=",
// 	BIT_OR_ASSIGN	= "|=",
// 	BIT_XOR_ASSIGN	= "^=",
// 	DIV_ASSIGN		= "/=",
// 	DOTDOT			= "..",
// 	BUILTIN			= "$$",
// 	ELVIS			= "?:",
// 	EQEQ			= "==",
// 	GREATER_EQ		= ">=", 
// 	IMPLIES			= "=>", // short function syntax's returns defined after =>
// 	LESS_EQ			= "<=",
// 	LVEC  			= "[<",
// 	MINUS_ASSIGN  	= "-=",
// 	MINUSMINUS  	= "--",
// 	MOD_ASSIGN  	= "%=",
// 	MULT_ASSIGN  	= "*=",
// 	NOT_EQUAL  		= "!=",
// 	OR  			= "||",
// 	PLUS_ASSIGN  	= "+=",
// 	PLUSPLUS  		= "++",
// 	RVEC  			= ">]",
// 	QUESTQUEST  	= "??",
// 	SCOPE 		 	= "::",
// 	SHL  			= "<<",
// 	SHR  			= ">>",

// 	// Three or more
// 	ELLIPSIS 		= "...",
// 	SHL_ASSIGN 		= "<<=",
// 	SHR_ASSIGN 		= ">>=",
// 	CT_AND 			= "&&&",
// 	CT_CONCAT 		= "+++",
// 	CT_OR 			= "|||",
	
// 	COMMENT_SINGLE_INLINE		= "//", // //single INLINE comment (after other code on the same line)
// 	COMMENT_SINGLE				= "//", // //single line comment (only comment on that line)
// 	COMMENT_MULTI				= "/*", //  /* multiline on new line */
// 	COMMENT_MULTI_END			= "*/",
// 	COMMENT_MULTI_INLINE		= "", //  some /* multiline on the same line */

// 	STRING			= "\"", // "Teststring"
// 	RAW_STRING		= "`", // `Teststring`

// 	// Basic types names
// 	VOID			= "void",
// 	// FIRST_KEYWORD = TOKEN_VOID,
// 	BOOL			= "bool",
// 	CHAR			= "char",
// 	DOUBLE			= "double",
// 	FLOAT			= "float",
// 	FLOAT16			= "float16",
// 	BFLOAT			= "bfloat",
// 	INT128			= "int128",
// 	ICHAR			= "ichar",
// 	INT				= "int",
// 	IPTR			= "iptr",
// 	ISZ				= "isz",
// 	LONG			= "long",
// 	SHORT			= "short",
// 	UINT128			= "uint128",
// 	UINT			= "uint",
// 	ULONG			= "ulong",
// 	UPTR			= "uptr",
// 	USHORT			= "ushort",
// 	USZ				= "usz",
// 	FLOAT128		= "float128",
// 	ANY				= "any",
// 	ANYFAULT		= "anyfault",
// 	TYPEID			= "typeid",

// 	// Keywords
// 	ASSERT		= "assert",
// 	ASM			= "asm",
// 	STRUCT		= "struct",
// 	ALIAS		= "alias",
// 	TYPEDEF		= "typedef",
// 	BITSTRUCT	= "bitstruct",
// 	FAULT		= "fault",
// 	UNION		= "union",
// 	BREAK		= "break",
// 	CASE		= "case",
// 	CATCH		= "catch",
// 	CONTINUE	= "continue",
// 	DEFAULT		= "default",
// 	DEFER		= "defer",
// 	DO			= "do",
// 	ELSE		= "else",
// 	ENUM		= "enum",
// 	EXTERN		= "extern",
// 	FALSE		= "false",
// 	FOR			= "for",
// 	FOREACH		= "foreach",
// 	FOREACH_R	= "foreach_r",
// 	FN			= "fn",
// 	TLOCAL		= "tlocal",
// 	IF			= "if",
// 	INLINE		= "inline",
// 	IMPORT		= "import",
// 	MACRO		= "macro",
// 	MODULE		= "module",
// 	NEXTCASE	= "nextcase",
// 	NULL		= "null",
// 	INTERFACE	= "interface",
// 	RETURN		= "return",
// 	STATIC		= "static",
// 	SWITCH		= "switch",
// 	TRUE		= "true",
// 	TRY			= "try",
// 	VAR			= "var",
// 	WHILE		= "while",
// 	CONST		= "const",
// 	// LAST_NON_CT_KEYWORD = TOKEN_WHILE,

// 	CT_ALIGNOF		= "$alignof",
// 	CT_ANDFN		= "$and",
// 	CT_APPEND		= "$append",
// 	CT_ASSERT		= "$assert",
// 	CT_ASSIGNABLE	= "$assignable",
// 	CT_CASE			= "$case",
// 	CT_CONCATFN		= "$concat",
// 	CT_DEFAULT		= "$default",
// 	CT_DEFINED		= "$defined",
// 	CT_ECHO			= "$echo",
// 	CT_ELSE			= "$else",
// 	CT_EMBED		= "$embed",
// 	CT_ENDFOR		= "$endfor",
// 	CT_ENDFOREACH	= "$endforeach",
// 	CT_ENDIF		= "$endif",
// 	CT_ENDSWITCH	= "$endswitch",
// 	CT_EVAL			= "$eval",
// 	CT_EVALTYPE		= "$evaltype",
// 	CT_ERROR		= "$error",
// 	CT_EXEC			= "$exec",
// 	CT_EXTNAMEOF	= "$extnameof",
// 	CT_FEATURE		= "$feature",
// 	CT_FOR			= "$for",
// 	CT_FOREACH		= "$foreach",
// 	CT_IF			= "$if",
// 	CT_INCLUDE		= "$include",
// 	CT_IS_CONST		= "$is_const",
// 	CT_NAMEOF		= "$nameof",
// 	CT_OFFSETOF		= "$offsetof",
// 	CT_ORFN			= "$or",
// 	CT_QNAMEOF		= "$qnameof",
// 	CT_SIZEOF		= "$sizeof",
// 	CT_STRINGIFY	= "$stringify",
// 	CT_SWITCH		= "$switch",
// 	CT_TYPEFROM		= "$typefrom",
// 	CT_TYPEOF		= "$typeof",
// 	CT_VACOUNT		= "$vacount",
// 	CT_VATYPE		= "$vatype",
// 	CT_VACONST		= "$vaconst",
// 	CT_VAREF		= "$varef",
// 	CT_VAARG		= "$vaarg",
// 	CT_VAEXPR		= "$vaexpr",
// 	CT_VASPLAT		= "$vasplat",
// 	// LAST_KEYWORD = TOKEN_CT_VASPLAT
// 	DOCS_START 		= "<*",
// 	DOCS_END 		= "*>",
// }


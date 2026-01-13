module parser;

import std::io;
import c3::lexer;
import ast;

faultdef
	INVALID_INDEX,
	NO_MORE_TOKENS,
	NO_MATCH,
	PARSE_FAIL, /// Unrecoverable parsing error
;

struct Parser
{
	Ast* ast;
	Token[] tokens;
	uint count;
	uint pos;
}

<*
	Check next token, without advancing.
	@return? NO_MORE_TOKENS : "End of tokens array"
*>
fn Token*? peek(Parser* parser)
{
	if (parser.pos >= parser.count) return NO_MORE_TOKENS?;
	return &parser.tokens[parser.pos];
}
<*
	Check if next token matches type. If so, advance and return that token.
	Use when token value is needed.
	@return? NO_MORE_TOKENS : "End of tokens array"
	@return? NO_MATCH : "Token types did not match"
*>
fn Token*? match(Parser* parser, TokenType token_type)
{
	Token* token = peek(parser)!;
	if (token != null && token.type == token_type)
	{
		parser.pos += 1;
		return token;
	}
	return NO_MATCH?;
}

<*
	Parse full function block.
	@return? PARSE_FAIL
*>
fn uint? parse_function(Parser* parser)
{
	uint decl_idx = ast::new_decl(parser.ast);
	Decl* decl = ast::get_decl(parser.ast, decl_idx);

	{
		defer catch log::error("Failed to start parsing function");
		match(parser, TokenType.FUNC) ?? PARSE_FAIL?!;
		log::verbose("Started parsing function");
		decl.kind = DeclKind.FUNCTION;
		decl.range.start = parser.pos;
	}

	/// TODO: parse return type
	{
		defer catch log::error("Failed to parse function return type");
	}

	{
		defer catch log::error("Failed to parse function name");
		Token* function_name = match(parser, TokenType.FUNC) ?? PARSE_FAIL?!;
		log::debug("Function name: %s", function_name.text);
		decl.func.name = parser.pos;
	}

	/// If no left parentheses, ignore and start parsing parameters anyway
	if (catch err = match(parser, TokenType.LPAREN))
	{
		log::warn("While parsing function: no left parentheses");
	}
	decl.func.param_start = parser.pos;

	//TODO: parse all params
	while (!match(parser, TokenType.RPAREN)!!)
	{
		// uint param_idx = parse_param(parser);
		break;
	}
	decl.func.param_count = (uint)parser.ast.params.len();

	// parse body
	//decl.func.body_stmt = parse_block(parser);

	decl.range.end = parser.pos;

	return decl_idx;
}


fn uint? parse_decl(Parser* parser)
{
	Token* token = peek(parser)!;
	log::info("Parsing %s", *token);
	switch (token.type)
	{
		case TokenType.FUNC:
			return parse_function(parser);
		default:
			parser.pos += 1;
			return INVALID_INDEX?;
	}
}
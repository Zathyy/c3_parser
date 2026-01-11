module parser;

import std::io;
import c3::lexer;
import ast;

const uint INVALID_INDEX = uint.max;

struct Parser 
{
	Ast* ast;
	Token[] tokens;
	uint count;
	uint pos;
}

fn Token* peek(Parser* p)
{
	if (p.pos >= p.count) return null;
	return &p.tokens[p.pos];
}

fn bool match(Parser* p, TokenType t)
{
	Token* token = peek(p);
	if (token != null && token.type == t)
	{
		p.pos += 1;
		return true;
	}

	return false;
}

fn uint expect(Parser* p, TokenType t)
{
	uint idx = p.pos;
	if (match(p, t))
	{
		return idx;
	}

	// not a valid token, return invalid_index
	Token* got = peek(p);

	if (p.pos < p.count)
	{
		p.pos += 1;
	}

	return INVALID_INDEX;
}

fn uint parse_function(Parser* p)
{
	uint decl_idx = ast::new_decl(p.ast); // create new Decl, return index
	Decl* d = ast::get_decl(p.ast, decl_idx);

	d.kind = DeclKind.FUNCTION;
	d.range.start = p.pos;

	// fn keyword
	expect(p, TokenType.FUNC);         
	Token* name = peek(p);
	d.func.name = p.pos;

	// function name
	expect(p, TokenType.IDENT);           

	expect(p, TokenType.LPAREN);

	d.func.param_start = (uint)p.ast.params.len();

	//TODO: parse all params
	while (!match(p, TokenType.RPAREN))
	{
		// uint param_idx = parse_param(p);
		break;
	}
	d.func.param_count = ((uint)p.ast.params.len()) - d.func.param_start;

	// parse body
	//d.func.body_stmt = parse_block(p);

	d.range.end = p.pos;

	return decl_idx;
}


fn uint parse_decl(Parser* p)
{
	Token* token = peek(p);
	if (token == null)
	{
		return INVALID_INDEX;
	}

	std::io::printf("parsing: %s \n", *token);

	switch (token.type)
	{
		case TokenType.FUNC:
			return parse_function(p);
		default:
			p.pos += 1;
			return INVALID_INDEX;
	}
}
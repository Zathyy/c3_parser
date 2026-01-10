module parser;

import std::io;
import c3::lexer;

struct Parser 
{
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
	if (!match(p, t))
	{

	}
}

fn uint parse_decl(Parser* p)
{
	Token* token = peek(p);
	switch (token.type)
	{
		default:
			
	}
}
module c3_parser::parser;
import c3_parser::ast;

import c3::lexer;

fn Lexer? AstNodeDecl.parse(&self, Lexer lexer)
{
	if (try new_lexer = self.parse_module(lexer))
	{
		return new_lexer;
	}
	return INCOMPATIBLE?;
}
fn Lexer? AstNodeDecl.parse_module(&self, Lexer lexer)
{
	Token token = lexer.next() ?? INCOMPATIBLE?!;
	if (token.type != TokenType.MODULE) return INCOMPATIBLE?;
	self.name.start = lexer.position();
	Lexer temp_lexer = lexer;
	while (@ok(@try(token, temp_lexer.next())))
	{
		if (!@ok(@try(token, temp_lexer.next()))) break;
		if (token.type != TokenType.SCOPE) break;
		lexer = temp_lexer;
	}
	self.name.end = lexer.position();
	return lexer;
}

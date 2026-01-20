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
<*
	TODO: parse attributes, generic syntax
*>
fn Lexer? AstNodeDecl.parse_module(&self, Lexer lexer)
{
	Token token = lexer.next() ?? INCOMPATIBLE?!;
	if (token.type != TokenType.MODULE) return INCOMPATIBLE?;
	token = lexer.next() ?? INCOMPATIBLE?!;
	self.name.start = token.position();
	Lexer temp_lexer = lexer;
	while LOOP: (@ok(@try(token, temp_lexer.next())))
	{
		switch (token.type)
		{
			case IDENT:
			case SCOPE:
				self.name.end = token.position_end();
			default:
				break LOOP;
		}
		lexer = temp_lexer;
	}
	if (token.type == TokenType.EOS) lexer = temp_lexer;
	return lexer;
}

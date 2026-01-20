module c3_parser::parser;
import c3_parser::ast;

import c3::lexer;

faultdef
	INCOMPATIBLE,
;

fn Lexer? AstNode.parse(&self, Lexer lexer)
{
	self.range.start = { lexer.ln, lexer.col };
	if (try new_lexer = self.decl.parse(lexer))
	{
		self.type = DECLARATION;
		self.range.end = new_lexer.position();
		return new_lexer;
	}
	return INCOMPATIBLE?;
}

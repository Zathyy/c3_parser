module c3_parser::parser;
import c3_parser::ast;

import c3::lexer;

faultdef
	INCOMPATIBLE,
;

fn Lexer? AstNode.parse(&self, Lexer lexer)
{
	if (try new_lexer = self.decl.parse(lexer))
	{
		self.type = DECLARATION;
		return new_lexer;
	}
	return INCOMPATIBLE?;
}

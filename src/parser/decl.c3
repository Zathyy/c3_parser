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
	DString module_name;
	module_name.tinit();
	Lexer temp_lexer = lexer;
	while (@ok(@try(token, temp_lexer.next())))
	{
		module_name.append(token.text);
		if (!@ok(@try(token, temp_lexer.next()))) break;
		if (token.type != TokenType.SCOPE) break;
		module_name.append("::");
		lexer = temp_lexer;
	}
	// TODO: figure out proper allocator for node data
	self.name = module_name.copy_str(mem);
	return lexer;
}

module c3_parser;
import c3::lexer;

import std::io;

fn int main(String[] args)
{
	Lexer lexer;
	lexer.init("module test::new;");
	AstNode node;
	node.parse(lexer)!!;
	io::printn(node);
	return 0;
}

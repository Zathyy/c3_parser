module test @test;

import std::io;
import std::collections::list;

import c3::lexer;
import parser;
import ast;

fn void test_parser()
{
	String src = (String)&test_file;

	List{ Token } tokens;
	tokens.init(mem, 1000);
	defer tokens.free();

	Lexer lexer;
	lexer.init(src);
	while (try tok = lexer.next())
	{
		tokens.push(tok);
	}

	Ast ast;
	ast::ast_init(&ast);
	defer ast::ast_free(&ast);

	Parser parser;
	parser.ast = &ast;
	parser.tokens = tokens.array_view();
	parser.count = (uint)tokens.len();
	parser.pos = 0;

	foreach (token : tokens)
	{
		uint idx = parser::parse_decl(&parser);
		io::printn(idx);
	}
}
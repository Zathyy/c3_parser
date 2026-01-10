module test @test;

import std::io;
import lexer;

char[*] test_file = $embed("test_file.c3");

// WIP output with: 	c3c test --test-show-output
fn void test_example()
{
	String src = (String)&test_file;
    // int some_val = 9;
    // test::eq(some_val-1, 8);
    
    // int[] some_slice = {1,2,3};
    // test::eq(some_slice.len, 3);



	io::printn();
	
	lexer::init();
	lexer::lex((String)&test_file);

	io::printf("number of tokens: %s \n", lexer::g_tokens.len());
	io::printf("number of starts: %s \n", lexer::g_starts.len());
	io::printf("number of ends: %s \n", lexer::g_ends.len());

	uint length = (uint)lexer::g_tokens.len();
	for (uint i = 0; i < length; i++)
	{
		if (lexer::g_tokens[i] == TokenType.EOF) continue;
		io::printf("%s  %s \n", src[lexer::g_starts[i]..lexer::g_ends[i] - 1], lexer::g_tokens[i].token);
	}

	lexer::free();
}
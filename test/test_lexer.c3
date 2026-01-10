module test @test;

import std::io;
import lexer;

// WIP output with: 	c3c test --test-show-output
fn void test_example()
{
	String src = `fn void! foo(int a)`;
    // int some_val = 9;
    // test::eq(some_val-1, 8);
    
    // int[] some_slice = {1,2,3};
    // test::eq(some_slice.len, 3);
	io::printn();
	
	lexer::lex(src);
}
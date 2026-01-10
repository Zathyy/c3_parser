module something::something;

import std::io;

struct Foo 
{
	float a;
	int    b;

	uint	c;
}

fn void? some_foo(int a, float b, char c)
{
	int* local_var = &a;

	*local_var = 10;

	io::printn("foooo");
}

fn void? some_some_foo(String src)
{

}
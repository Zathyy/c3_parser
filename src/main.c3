module c3_parser;
import std::io;
import lexer;

fn int main(String[] args)
{
	
	foreach(TokenType item : TokenType.values)
	{
		io::printn(item);
		io::printn(item.token);
	}

	return 0;
}

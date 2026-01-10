module lexer;

// TODO: 
// - add emit function to add a token to a list
// - more lex functions

struct Lexer 
{
	String source;
	int pos;
	int length;
}

fn bool is_alpha(char c) @inline
{
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}

fn bool is_digit(char c) @inline
{
    return c >= '0' && c <= '9';
}

<*
	is alpha-numeric
*>
fn bool is_alnum(char c) @inline 
{
	return is_alpha(c) || is_digit(c);
}

fn bool Lexer.is_eof(&self) @inline 
{
	return self.pos >= self.length;
}

fn char Lexer.peek(&self)
{
	if (self.is_eof()) return 0;
	return self.source[self.pos];
}

fn char Lexer.peek_next(&self) 
{
	if (self.is_eof()) return 0;
	return self.source[self.pos + 1];
}

fn char Lexer.advance(&self)
{
	char c = self.peek();
	self.pos += 1;
	return c;
}

fn bool Lexer.match(&self, char c) 
{
	if (self.peek() == c)
	{
		self.pos += 1;
		return true;
	}

	return false;
}

fn int Lexer.lex_whitespace(&self)
{
    int start = self.pos;
    while (true) 
	{
        switch (self.peek())
		{
            case ' ':
            case '\t':
                self.advance();
                break;
            default:
                return start;
        }
    }
}

fn int Lexer.lex_identifier(&self) 
{
	int start = self.pos;
	self.advance();

	while (is_alnum(self.peek()))
	{
		self.advance();
	}

	return start;
}

fn int Lexer.lex_number(&self)
{
    int start = self.pos;
    self.advance();

    while (is_digit(self.peek()))
	{
        self.advance();
    }
	
    return start;
}

fn void parse(String source)
{
	Lexer lexer = { 
		.source = source,
		.pos = 0,
		.length = source.len,
	};

	while (!lexer.is_eof())
	{
		int start = lexer.pos;

		switch (lexer.peek())
		{
			case ' ': nextcase;
			case '\t': 
			{
				lexer.lex_whitespace();
				//todo: emit
				break;
			}
		}
	}
}
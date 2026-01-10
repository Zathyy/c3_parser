module lexer;

import std::collections::list;
import std::io;
// TODO: 
// - add emit function to add a token to a list 
// - more lex functions

//struct Lexer 
//{
//	String source;
//	uint pos;
//	List{ Token } tokens;
//}

List{ TokenType } g_tokens;
List{ uint } g_starts;
List{ uint } g_ends;

fn void init(Allocator alloc = mem)
{
	g_tokens.init(alloc);
	g_starts.init(alloc);
	g_ends.init(alloc);
}

fn void free()
{
	g_tokens.free();
	g_starts.free();
	g_ends.free();
}

fn void emit(TokenType type, uint start, uint end)
{
	g_tokens.push(type);
	g_starts.push(start);
	g_ends.push(end);
}

<*
 useful when determining the difference between types, variables, constants
*>
fn bool is_alpha_lower(char c) @inline
{
    return (c >= 'a' && c <= 'z');
}

<*
 constants are all upper case
 custom types start with an upper case letter
*>
fn bool is_alpha_upper(char c) @inline
{
    return (c >= 'A' && c <= 'Z');
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
fn bool is_alpha_num(char c) @inline 
{
	return is_alpha(c) || is_digit(c);
}

fn bool is_whitespace(String src, uint pos) @inline
{
	switch (peek(src, pos))
	{
		case ' ':
		case '\t':
		case '\n':
		case '\r':
			return true;
		default:
			return false;
	}
}

fn bool is_eof(String src, uint pos) @inline 
{
	return pos >= src.len;
}

<*
 check char at pos without advancing past
*>
fn char peek(String src, uint pos)
{
	if (is_eof(src, pos)) return 0;
	return src[pos];
}

<*
 check char next after pos, without advancing pos
*>
fn char peek_next(String src, uint pos) 
{
	if (is_eof(src, pos+1)) return 0;
	return src[pos + 1];
}

<*
 increment pos without returning char
*>
fn void advance(String src, uint* pos)
{
	if (is_eof(src, *pos))
	{
		return;
	}
	
	*pos += 1;
}

<*
 read and return char at pos, increment pos
*>
fn char peek_advance(String src, uint* pos)
{
	char c = peek(src, *pos);
	*pos += 1;
	return c;
}

fn bool match(String src, uint* pos, char c) 
{
	if (peek(src, *pos) == c)
	{
		*pos += 1;
		return true;
	}

	return false;
}


<*
 consumes whitespace
*>
fn uint lex_whitespace(String src, uint* pos)
{
    int start_pos = *pos;
    while (true) 
	{
		if (is_whitespace(src, *pos)) 
		{
			advance(src, pos);
		}
		else
		{
			return start_pos;
		}
    }
}

fn void lex_identifier(String src, uint* pos) 
{
	int start_pos = *pos;
	advance(src, pos); // we have at least one valid char

	// how many other valid chars?
	while (!is_eof(src, *pos) && is_alpha_num(peek(src, *pos)))
	{
		advance(src, pos);
	}

	emit(TokenType.IDENT, start_pos, *pos);
}

fn void lex_number(String src, uint* pos)
{
    int start_pos = *pos;
	advance(src, pos); // we have at least one valid char

	// how many other valid chars?
    while (!is_eof(src, *pos) && is_digit(peek(src, *pos)))
	{
        advance(src, pos);
    }
	
	emit(TokenType.INTEGER, start_pos, *pos);	
}

// fn list{Token} emit(void)
// {
// 	return 
// }

<*
 this is a bit inefficient since its iterating over things without a value
 TODO: separate out tokens with a value, from types of token for faster iteration, but make the thing not a pain to maintain
*>
fn TokenType find_token_type(String token)
{
	foreach (TokenType item : TokenType.values)
	{
		if (item.token == "")
		{
			continue;
		}
		
		if (token == item.token)
		{
			return item;
		}
		
	}

	return TokenType.INVALID_TOKEN;
}

<*
 TODO: output slice of tokens
 TODO: output slice of start positions for each token
 TODO: output slice of end positions for each token
*>
fn void lex(String src)
{
	uint pos = 0;
	
	while (!is_eof(src, pos))
	{
		char c = peek(src, pos);

		if (is_whitespace(src, pos))
		{
			lex_whitespace(src, &pos);
			continue;
		}
		
		// Identifiers start with a lower case letter
		if (is_alpha(c))
		{
			// TODO: something is going wrong here, non alphanumeric chars are being included
			lex_identifier(src, &pos);
			continue;
		}
		
		if (is_digit(c))
		{
			lex_number(src, &pos);
			continue;
		}

		uint start = pos;
		advance(src, &pos);
		switch (peek(src, pos))
		{
			case '(':
				emit(TokenType.LPAREN, start, pos);
				break;
			default:
				emit(TokenType.INVALID_TOKEN, start, pos);
				break;
		}
	}

	emit(TokenType.EOF, pos, pos);
}
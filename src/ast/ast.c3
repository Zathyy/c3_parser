module c3_parser::ast;
import c3::lexer;

import std::io;
import std::collections::range;

struct AstPosition (Printable)
{
	usz line, col;
}
fn bool AstPosition.eq(self, AstPosition other) @operator(==)
	=> self.line == other.line && self.col == other.col;
fn usz? AstPosition.to_format(&self, Formatter* fmt) @dynamic
	=> fmt.printf("%d:%d", self.line, self.col);
macro AstPosition Lexer.position(self)
	=> { self.ln, self.col };

struct AstRange
{
	AstPosition start, end;
}
fn usz? AstRange.to_format(&self, Formatter* fmt) @dynamic
	=> fmt.printf("%s->%s", self.start, self.end);

enum AstNodeType
{
	DECLARATION,
}
struct AstNode (Printable)
{
	AstNodeType type;
	AstRange range;
	union
	{
		AstNodeDecl decl;
		// more types go here later
	}
}

fn usz? AstNode.to_format(&self, Formatter* fmt) @dynamic
{
	switch (self.type)
	{
	case DECLARATION:
		return fmt.printf("%s", self.decl);
	}
}

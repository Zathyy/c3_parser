module c3_parser::ast;

import std::io;

enum AstNodeType
{
	DECLARATION,
}
struct AstNode (Printable)
{
	AstNodeType type;
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

module c3_parser::ast;

import std::io;

enum AstNodeDeclType
{
	MODULE,
}
struct AstNodeDecl (Printable)
{
	AstNodeDeclType type;
	AstRange name;
	AstRange[] attributes;
	union
	{
		char dummy;
		// more types go here later
	}
}

fn usz? AstNodeDecl.to_format(&self, Formatter* fmt) @dynamic
{
	switch (self.type)
	{
	case MODULE:
		return fmt.printf("{ <MODULE> name: %s, attributes: %s }",
			self.name,
			self.attributes,
		);
	}
}
fn String? AstNodeDecl.to_string(self, Allocator alloc, String text)
{
	switch (self.type)
	{
	case MODULE:
		return string::format(alloc, "(decl_module %s)", self.name.slice_text(text));
	}
}

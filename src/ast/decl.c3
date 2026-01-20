module c3_parser::ast;

enum AstNodeDeclType
{
	MODULE,
}
struct AstNodeDecl
{
	AstNodeDeclType type;
	String name;
	String[] attributes;
	union
	{
		AstNodeDeclModule _module;
		// more types go here later
	}
}
struct AstNodeDeclModule
{
	char dummy;
}

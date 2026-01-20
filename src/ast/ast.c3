module c3_parser::ast;

enum AstNodeType
{
	DECLARATION,
}
struct AstNode
{
	AstNodeType type;
	union
	{
		AstNodeDecl decl;
		// more types go here later
	}
}

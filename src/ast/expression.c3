module ast;

// expression -> (values)

typedef ExprHandle = uint;

enum ExpressionKind : uint (String name)
{
	BINARY = "BINARY",
	LITERAL = "LITERAL",
	CAST = "CAST",
}

struct Expression 
{
	ExprKind kind;
	SourceSpan span;

	union 
	{
		BinaryExpr binary;
		IfExpr if_expr;
		LiteralExpr literal;
	}
}

struct BinaryExpr 
{
	BinaryOp op;
	ExprHandle lhs;
	ExprHandle rhs;
}

struct IfExpr 
{
	ExprHandle cond_expr;
	ExprHandle if_expr;
	ExprHandle else_expr;
}

struct LiteralExpr 
{

}
module ast;

enum ExprKind
{
	NAME,
	LITERAL,
	CALL
}

<*
	Expression
*>
struct Expr 
{
	ExprKind kind;
	TokenRange range;

	union 
	{
		struct name
		{
			uint name_token;
		}

		struct literal 
		{
			uint literal_token;
		}

		struct call 
		{
			uint callee;
			uint arg_start;
			uint arg_count;
		}
	}
}
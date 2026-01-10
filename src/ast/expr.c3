module ast;

enum ExprKind
{
	NAME,
	LITERAL,
	CALL
}

struct Expr 
{
	ExprKind kind;
	uint start_token;
	uint end_token;

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
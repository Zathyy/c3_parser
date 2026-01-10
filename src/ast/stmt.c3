module ast;

enum StmtKind : char
{
	BLOCK,
	IF,
	RETURN,
	EXPR,
	DECL
}

struct Stmt 
{
	StmtKind kind;
	uint start_token;
	uint end_token;

	union
	{
		struct block
		{ 
			uint stmt_start; 
			uint stmt_count;
		}

		struct ret
		{ 
			uint expr; 
		}

		struct expr
		{ 
			uint expr;
		}
	}
}
module ast;

enum StmtKind : char
{
	BLOCK,
	RETURN,
	EXPR,
}

<*
	Statement.
	Record describing how other nodes are arranged.
*>
struct Stmt 
{
	StmtKind kind;
	TokenRange range;

	union
	{
		<*
			a scope block, { ... }
		*>
		struct block
		{ 
			// index into AST.stmts
			uint stmt_start; 

			// how many statements
			uint stmt_count;
		}

		<*
			Example:
			Represents: return a + b;
		*>
		struct ret
		{ 
			uint expr; 
		}

		<*		
			Expression used as a statement.
			foo();
			a + b;
			x = y;
		*>
		struct expr
		{ 
			uint expr;
		}
	}
}
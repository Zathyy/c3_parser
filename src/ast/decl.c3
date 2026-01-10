module ast;

enum DeclKind : char 
{
	MODULE,
	IMPORT,
	STRUCT,
	FUNCTION,
}

struct Decl 
{
	DeclKind kind;
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

struct FunctionDecl
{
	uint name_token;     // index into Token[]
	uint params_start;   // index into Param arena
	uint params_count;
	uint body_stmt;      // index into Stmt arena
}
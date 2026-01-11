module ast;

enum DeclKind : char 
{
	MODULE,
	IMPORT,
	STRUCT,
	FUNCTION,
}

<*
	Decleration.
*>
struct Decl 
{
	DeclKind kind;
	TokenRange range;

	union
	{
		// foo :: bar :: example
		struct mod
		{
			uint start;
			uint len;
		}

		// import decl
		struct imp
		{
			uint start;
			uint len;
		}

		// struct
		struct str 
		{
			uint name; // Foo
			uint member_start; // index into Decl[] or Stmt[]
			uint member_count; // number of members
		}

		// function
		struct func
		{
			uint name;
			uint param_start;
			uint param_count;
			uint body_stmt;
		}
	}
}
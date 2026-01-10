module parser;

import std::io;

fn bool parse_file(String path)
{
	File? file = file::open(path, "r");
	defer (void)file.close();

	char[] buffer = mem::new_array(char, 4000);

	if (catch file.read(buffer)) 
	{
		return false;
	}

	return true;
}
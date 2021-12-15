#ifndef ARGUMENTS_H
#define ARGUMENTS_H
#endif

#include <map>
#include <string>

enum ValidArguments {
    china,		// china mode
    nuke,		// deletes all files
	help	
};

class ArgumentParser
{

public:

    ArgumentParser();

    ~ArgumentParser();

    static void parse_arguments(char *args[]);

};
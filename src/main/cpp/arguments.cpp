#include <iostream>
#include <map>

#include "arguments.h"

ArgumentParser::ArgumentParser() {}

ArgumentParser::~ArgumentParser() {}

void ArgumentParser::parse_arguments(char *args[]) 
{

    std::map<std::string, ValidArguments> valid_args = {
        {"-china", china},
        {"-nuke", nuke},
        {"-help", help}
    };

    std::map<std::string, ValidArguments>::iterator it;

    it = valid_args.find(std::string(args[1]));

    if (it != valid_args.end()) {

        switch(valid_args[std::string(args[1])]) {

            case 0:
                // enable china mode
                std::cout << "冰淇淋" << "\n";
                break;
            case 1:
                // nuke files
                std::cout << "not implemented yet!" << "\n";
                break;
            case 2:
                std::cout << "TODO: help message" << "\n";
                break;
            default:
                std::cout << "somehow invalid option. try running valk -help." << "\n";
                break;
        }
    } else {
        std::cout << "try running valk -help" << "\n";
    }
    // if (std::string(args[1]) == "-china") {
    //     std::cout << "冰淇淋" << "\n";
    // }
    
}
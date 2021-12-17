#include <iostream>
#include <map>

#include <spdlog/spdlog.h>

#include "arguments.h"

ArgumentParser::ArgumentParser() {}

ArgumentParser::~ArgumentParser() {}

void ArgumentParser::parse_arguments(char *args[]) 
{
    // hacky switch on string
    std::map<std::string, ValidArguments> valid_args = {
        {"-china", china},
        {"-nuke", nuke},
        {"-help", help},
        {"-debug", debug}
    };

    std::map<std::string, ValidArguments>::iterator it;

    it = valid_args.find(std::string(args[1]));

    if (it != valid_args.end()) {

        switch(valid_args[std::string(args[1])]) {

            case 0:
                // enable china mode
                spdlog::info("冰淇淋 mode enabled");
                break;
            case 1:
                // nuke files
                std::cout << "not implemented yet!" << "\n";
                break;
            case 2:
                // display a help message
                std::cout << "TODO: help message" << "\n";
                break;
            case 3:
                // turn on debug mode
                spdlog::set_level(spdlog::level::debug);
                spdlog::info("debug mode has been enabled.");
                spdlog::debug("you should be able to see this message now.");
                break;
            default:
                spdlog::error("somehow invalid option. try running valk -help.");
                break;
        }
    } else {
        std::cout << "try running valk -help" << "\n";
    }
    
}
#include <iostream>
#include <string>

#include "server.h"
#include "arguments.h"

int main(int argc, char *argv[]) {
    if (argc > 1) {
        // TODO: check and parse arguments correctly
        std::cout << "little trolling " << argv[1] << "\n";
        ArgumentParser::parse_arguments(argv);
    }

    Server* s = new Server();
    s->startup_sequence();
    return 0;
}
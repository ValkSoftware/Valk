#include <iostream>
#include <string>

#include "server.h"
#include "arguments.h"

int main(int argc, char *argv[]) {
    if (argc == 2) { ArgumentParser::parse_arguments(argv); }

    Server* s = new Server();
    s->startup_sequence();

    return 0;
}
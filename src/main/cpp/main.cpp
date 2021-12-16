#include <iostream>
#include <string>
#include <asio.hpp>

#include "server.h"
#include "arguments.h"

int main(int argc, char *argv[]) 
{
    if (argc == 2) { ArgumentParser::parse_arguments(argv); }

    Server* s = new Server();
    s->startup_sequence();

    using asio::ip::tcp;

    asio::io_context net_thread_context;
    tcp::acceptor conn_acceptor(net_thread_context, tcp::endpoint(tcp::v4(), 25565)); // TODO replace port with config

    for(;;)
    {
        tcp::socket socket(net_thread_context);
        conn_acceptor.accept(socket);
        asio::error_code ignore;
        asio::write(socket, asio::buffer("YO"), ignore);
    }

    return 0;
}
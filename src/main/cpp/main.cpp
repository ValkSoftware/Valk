#include <iostream>
#include <string>
#include <spdlog/spdlog.h>
#include <pthread.h>
#include <evpp/tcp_server.h>
#include <evpp/buffer.h>
#include <evpp/tcp_conn.h>

#include "server.h"
#include "arguments.h"

int main(int argc, char *argv[]) 
{
    if (argc == 2) { ArgumentParser::parse_arguments(argv); }

    Server* s = new Server();
    s->startup_sequence();

    // TODO replace port with config
    std::string addr = "0.0.0.0:25565";

    int net_threads = 4;
    evpp::EventLoop loop;
    evpp::TCPServer server(&loop, addr, "valk", net_threads);
    
    server.SetMessageCallback([](const evpp::TCPConnPtr& conn, evpp::Buffer* msg)
    {   
        spdlog::info("received {}, sending it back", msg->ToString());
        conn->Send(msg);
    });

    server.SetConnectionCallback([](const evpp::TCPConnPtr& conn) 
    {
        if (conn->IsConnected()) {
            std::cout << "new connection from " << conn->remote_addr();
        } else {
            std::cout << "connection from " << conn->remote_addr() << "closed";
        }
    });

    server.Init();
    server.Start();
    loop.Run();

    return 0;
}
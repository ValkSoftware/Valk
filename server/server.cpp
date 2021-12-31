#include <iostream>

#include <spdlog/spdlog.h>

#include "server.h"

Server::Server() {}
Server::~Server() {}

void Server::startup_sequence()
{
    spdlog::info("-------------------------------------------");
    spdlog::info("   █ █");
    spdlog::info("  ██ ██    Valk Software's valk.");
    spdlog::info("  █   █    Eagle-eyed perfection.");
    spdlog::info(" ██ █ ██");
    spdlog::info("  █   █    © 2021-2022");
    spdlog::info("  ██ ██    Version: 0.0.1 (pre-alpha)");
    spdlog::info("   █ █");
    spdlog::info("-------------------------------------------");
    spdlog::info("starting up...");



}

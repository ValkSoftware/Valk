plugins {
    `cpp-application`
    `cpp-unit-test`
}

version = "0.0.1"

application {
    targetMachines.add(machines.linux.x86_64)
}

tasks.withType(CppCompile::class.java).configureEach {
    compilerArgs.add("-pthread")
    compilerArgs.add("-DSPDLOG_HEADER_ONLY") // spdlog dependency
    compilerArgs.add("-DASIO_STANDALONE") // asio dependency
    compilerArgs.add("-std=c++17")
    compilerArgs.add("-levpp")
}

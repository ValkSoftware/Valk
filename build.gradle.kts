plugins {
    `cpp-application`
    `cpp-unit-test`
}

version = "0.0.1"

application {
    targetMachines.add(machines.linux.x86_64)
}

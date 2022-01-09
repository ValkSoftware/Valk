@echo off

if %1=="fast" ( 
    goto :fastbuild
    EXIT /B 0
) else if %1=="prod" ( 
    goto :testprod 
    EXIT /B 0
) else if %1=="build" ( 
    goto :build
    EXIT /B 0
) else (
    goto :prod
    EXIT /B 0
)

:fastbuild
if not exist .\output (
    mkdir output
)
v -o .\output\valk -os windows -show-timings -enable-globals . 
EXIT /B 0

:testprod
if not exist .\ouput (
    mkdir ouput
)   
v -cc gcc -o .\output\valk -os windows -prod -show-timings -enable-globals .
EXIT /B 0

:prod
if not exist .\output (
    mkdir output
)
v -cc gcc -o .\output\valk -os windows -prod -gc boehm -show-timings -enable-globals . 
EXIT /B 0

:build 
if not exist .\output (
    mkdir output
)
v -cc gcc -o .\output\valk -os windows -gc boehm -show-timings -enable-globals .
EXIT /B 0
#!/bin/bash

if [[ -d "./output/" ]]
then
    v -cc gcc -o output/valk -prod -show-timings -gc boehm -enable-globals .
else 
    mkdir output
    v -cc gcc -o output/valk -prod -show-timings -gc boehm -enable-globals . 
fi
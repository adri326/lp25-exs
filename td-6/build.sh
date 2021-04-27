#!/bin/sh

[ ! -d build ] && mkdir build

$CC hello.c -o ./build/hello
$CC swap.c -o ./build/swap
$CC inversion.c -o ./build/inversion
$CC concat.c -o ./build/concat
$CC concat-malloc.c -o ./build/concat-malloc

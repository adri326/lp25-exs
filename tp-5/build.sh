#!/bin/sh

[ ! -d build ] && mkdir build

${CC} ./polynome.c -lm -o build/polynome
${CC} ./polynome_fct.c -lm -o build/polynome_fct
${CC} ./anagramme.c -lm -o build/anagramme
${CC} ./tri_taille.c -lm -o build/tri_taille

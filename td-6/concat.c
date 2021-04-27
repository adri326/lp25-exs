#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define LEN 100

// Concatène les arguments donnés au programmes, avec une longueur maximale

int main(int argc, char* argv[]) {
    char res[LEN + 1] = {0};
    int remaining = LEN;

    for (int arg = 1; arg < argc && remaining > 0; arg++) {
        strncat(res, argv[arg], remaining);
        remaining -= strlen(argv[arg]);
    }

    printf("%s\n", res);
}

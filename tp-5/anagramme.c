#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

// Janky UTF-8 handling, sorry
/// Strips spaces and special characters from the string and converts all letters to lowercase
char* treat_string(char* raw) {
    char* res = malloc(sizeof(char) * (strlen(raw) + 1));
    if (!res) exit(1);
    size_t o = 0;
    for (size_t n = 0; raw[n]; n++) {
        if (raw[n] >= 'A' && raw[n] <= 'Z' || raw[n] >= 'a' && raw[n] <= 'z') {
            res[o++] = tolower(raw[n]);
        }
    }
    res[o] = 0;
    return res;
}

/// Reverses a string
void reverse(char* str) {
    size_t len = strlen(str);
    char* buffer = malloc(sizeof(char) * (len + 1));
    strcpy(buffer, str);
    for (size_t n = 0; n < len; n++) {
        str[len - n - 1] = buffer[n];
    }
    free(buffer);
}

/// Returns true iff the string is an anagram (only taking into account latin letters)
bool is_anagram(char* str) {
    char* fwd_treated = treat_string(str);
    char* rev_treated = treat_string(str);
    reverse(rev_treated);
    // printf("> %s\n> %s\n", fwd_treated, rev_treated);
    bool res = true;
    size_t n = 0;
    for (; fwd_treated[n] && rev_treated[n]; n++) {
        if (fwd_treated[n] != rev_treated[n]) {
            res = false;
            break;
        }
    }
    // It is an anagram if both strings were looked through
    res = res && !fwd_treated[n] && !rev_treated[n];
    free(fwd_treated);
    free(rev_treated);
    return res;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Error: this program requires as argument the string to check for anagram-ness!");
        return 1;
    }

    if (is_anagram(argv[1])) {
        printf("`%s` is an anagram!", argv[1]);
    } else {
        printf("`%s` is not an anagram!", argv[1]);
    }

}

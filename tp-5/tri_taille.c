#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

// This is a slightly unconventional sorting algorithm, which is a kind of radix sort
char** reorder(size_t count, char** words) {
    char** res = (char**)malloc(sizeof(char*) * count);
    size_t res_ptr = 0;

    // Array of different lengths
    size_t* lengths = (size_t*)malloc(sizeof(size_t*));
    size_t n_lengths = 0;

    // Fill `lengths`
    for (size_t n = 0; n < count; n++) {
        bool found = false;
        size_t len = strlen(words[n]);
        for (size_t o = 0; o < n_lengths; o++) {
            if (lengths[o] == len) {
                found = true;
                break;
            }
        }
        if (!found) {
            n_lengths += 1;
            size_t* tmp = (size_t*)realloc(lengths, sizeof(size_t*) * n_lengths);
            if (tmp == NULL) {
                free(lengths);
                exit(1);
            }
            lengths = tmp;
            lengths[n_lengths - 1] = len;
        }
    }

    // Sort `lengths`
    {
        bool changed = true;
        for (size_t x = 0; x < n_lengths - 1 && changed; x++) {
            changed = false;
            for (size_t n = 0; n < n_lengths - 1; n++) {
                if (lengths[n] > lengths[n + 1]) {
                    size_t tmp = lengths[n];
                    lengths[n] = lengths[n + 1];
                    lengths[n + 1] = tmp;
                    changed = true;
                }
            }
        }
    }

    // Iterate for the values of `lengths`...
    for (size_t n = 0; n < n_lengths; n++) {
        char** arr = (char**)malloc(sizeof(char*) * count);
        size_t n_words = 0;

        // Append the words that match `lengths[n]` in length to `arr`
        for (size_t o = 0; o < count; o++) {
            if (strlen(words[o]) == lengths[n]) {
                arr[n_words++] = words[o];
            }
        }

        // Small bubble sort to sort `arr` by its secondary factor
        bool changed = true;
        for (size_t x = 0; x < n_words && changed; x++) {
            changed = false;
            for (size_t o = 0; o < n_words - 1; o++) {
                if (strcmp(arr[o], arr[o + 1]) > 0) {
                    char* tmp = arr[o];
                    arr[o] = arr[o + 1];
                    arr[o + 1] = tmp;
                    changed = true;
                }
            }
        }

        // Add the sorted values of arr to the result
        for (size_t o = 0; o < n_words; o++) {
            res[res_ptr++] = arr[o];
        }

        free(arr);
    }

    return res;
}

int main(int argc, char* argv[]) {
    char** res = reorder(argc - 1, &argv[1]);

    for (size_t n = 0; n < argc - 1; n++) {
        printf("%s", res[n]);
        if (n != argc - 2) printf(" ");
        else printf("\n");
    }

    free(res);
}

#include <stdio.h>

// Écrire une fonction échangeant la valeur de deux pointeurs

void swap(int* a, int* b) {
    int c = *a;
    *a = *b;
    *b = c;
}

int main() {
    int a = 4;
    int b = 6;

    printf("a = %d, b = %d\n", a, b);

    swap(&a, &b);

    printf("a = %d, b = %d\n", a, b);
}

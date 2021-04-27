#include <stdio.h>

// Écrire un programme qui inverse les valeurs de deux variables de type identique.

// Les instructions pour cet exercice n'étaient pas claires

int main() {
    long a = 327;
    long b = -10443;

    printf("a = %ld, b = %ld\n", a, b);

    {
        long tmp = a;
        a = b;
        b = tmp;
    }

    printf("a = %ld, b = %ld\n", a, b);
}

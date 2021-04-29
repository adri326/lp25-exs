#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <float.h>
#include <complex.h>
#include <stdbool.h>

/**
    Holds a variable number of solutions to a polynome of order <= 2.
**/
struct Solution {
    double complex first; // First solution (if n_solutions >= 1)
    double complex second; // Second solution (if n_solution == 2)
    int n_solutions; // Number of solutions
};
typedef struct Solution Solution;

/**
    Prints a complex number.
**/
void print_complex(double complex c) {
    if (fabs(cimag(c)) > DBL_EPSILON) {
        printf("%lf + %lfi", creal(c), cimag(c));
    } else if (fabs(creal(c)) > DBL_EPSILON) {
        printf("%lf", creal(c));
    } else {
        printf("0.0");
    }
}

/**
    Prints a Solution as a n-uple
**/
void print_solution(Solution solution) {
    if (solution.n_solutions == 2) {
        printf("(");
        print_complex(solution.first);
        printf(", ");
        print_complex(solution.second);
        printf(")");
    } else if (solution.n_solutions == 1) {
        printf("(");
        print_complex(solution.first);
        printf(")");
    } else {
        printf("nil");
    }
}

/**
    Inputs a floating-point number, prompting the user until they enter a new number or exiting early if stdin is closed
**/
double input(char* prompt) {
    while (true) {
        char str[1024];
        double res = 0;

        printf("%s", prompt);

        if (!fgets(str, 1024, stdin)) exit(1);

        const int scanf_res = sscanf(str, "%lf", &res);

        if (scanf_res != 1) {
            printf("Invalid number entered!\n");
        } else if (isnan(res) || isinf(res)) {
            printf("Invalid number entered!\n");
        } else {
            return res;
        }
    }
}

int main() {
    printf("Solves ax² + bx + c = 0\n");

    double a = input("a: ");
    double b = input("b: ");
    double c = input("c: ");

    double delta = b * b - 4.0 * a * c;
    Solution solution;

    if (fabs(a) <= DBL_EPSILON && fabs(b) <= DBL_EPSILON) {
        solution.n_solutions = 0;
    } else if (fabs(a) <= DBL_EPSILON) {
        solution.n_solutions = 1;
        solution.first = solution.second = -c / b;
    } else {
        if (delta == 0) {
            solution.n_solutions = 1;
            solution.first = solution.second = -b / 2.0 / a;
        } else if (delta > 0) {
            solution.n_solutions = 2;
            solution.first = (double complex)((-b + sqrt(delta)) / 2.0 / a);
            solution.second = (double complex)((-b - sqrt(delta)) / 2.0 / a);
        } else {
            solution.n_solutions = 2;
            double complex complex_part = I / 2.0 / (double complex)a;
            solution.first = (double complex)((-b) / 2.0 / a) + complex_part;
            solution.second = (double complex)((-b) / 2.0 / a) - complex_part;
        }
    }

    print_solution(solution);
    printf("\n");
}

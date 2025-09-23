#include <stdio.h>

int main() {
    int val;
    int val2;

    printf("Valor 1: ");
    scanf("%d", &val);
    printf("Valor 2: ");
    scanf("%d", &val2);

    printf("Soma: %d\n", val + val2);
    printf("Subtração: %d\n", val - val2);
    printf("Multiplicação: %d\n", val * val2);
    printf("Divisão: %d\n", val / val2);
    
    return 0;
}
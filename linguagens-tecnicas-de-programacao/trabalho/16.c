#include <stdio.h>

int main() {
    int array[3];
    printf("Informe 3 valores: ");
    for(int i = 1; i <= 3; i++) {
        printf("Valor %d: ", i);
        scanf("%d", &array[i-1]);
        
    }
    printf("A multiplicação é: %d\n", array[1] * array[2] * array[0]);
}
#include <stdio.h>

int main() {
    int notas[3];
    
    for(int i = 0; i < 3; i++) {
        printf("Nota %d: ", i+1);
        scanf("%d", &notas[i]);
    }
    
    int soma = notas[0] + notas[1] + notas[2];
    float media = soma / 3.0;
    printf("Média: %.2f\n", media);
    return 0;
}
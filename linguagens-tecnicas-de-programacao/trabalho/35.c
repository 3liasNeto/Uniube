#include <stdio.h>
#include <string.h>

int main() {
      char sex;

    printf("Qual o seu sexo (M/F): ");
    scanf(" %c", &sex);

    switch (sex) {
        case 'M':
        case 'm':
            printf("Masculino\n");
            break;
        case 'F':
        case 'f':
            printf("Feminino\n");
            break;
        default:
            printf("Entrada invalida\n");
    }
    
    return 0;
}
#include <stdio.h>

int main() {
    int val;
    printf("Valor: ");
    scanf("%d", &val);

    if(val > 0){
        printf("Positivo\n");
    } else if (val < 0){
        printf("Negativo\n");
    } else {
        printf("Zero\n");
    }

    return 0;
}
#include <stdio.h>

int main() {
    int val;

    printf("Valor: ");
    scanf("%d", &val);

    if(val % 2 == 0){
        printf("Par\n");
    } else {
        printf("Ímpar\n");
    }
    
    return 0;
}
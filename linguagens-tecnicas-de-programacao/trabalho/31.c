#include <stdio.h>

int main() {
    int val[2];

    for(int i = 0; i < 2; i++){
        printf("Valor %d: ", i + 1);
        scanf("%d", &val[i]); 
    }

    if(val[0] > val[1]){
        printf("O maior é: %d\n", val[0]);
    } else if (val[1] > val[0]){
        printf("O maior é: %d\n", val[1]);
    } else {
        printf("São iguais: %d e %d\n", val[0], val[1]);
    }
    
    return 0;
}
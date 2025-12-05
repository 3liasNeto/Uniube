#include <stdio.h>
#include <stdlib.h>

int main(){
    float total;

    while(1){
        float num;
        printf("Digite um numero (0 para finalizar): ");
        scanf("%f", &num);

        if(num == 0){
            break;
        }
        total += num;
    }
    printf("Total: %.2f\n", total); 
    
    return 0;
}
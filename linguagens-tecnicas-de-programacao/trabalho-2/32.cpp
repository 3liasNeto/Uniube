#include <stdio.h>
#include <stdlib.h>
#define WEEKDAYS 7

int main(){
    float total = 0, largest_num = -1, history[WEEKDAYS];

    for(int i = 0; i < WEEKDAYS; i++){
        printf("Digite a produção do dia %d: R$ ", i + 1);
        scanf("%f", &history[i]);
        total += history[i];
        if(history[i] > largest_num){
            largest_num = history[i];
        }
    }

    printf("\nHistórico de Produção da Semana:\n");
    for(int i = 0; i < WEEKDAYS; i++){
        printf("Produção do dia %d: R$ %.2f\n", i + 1, history[i]);
    }

    printf("\n");
    printf("A maior produção da semana foi: R$ %.2f\n", largest_num);
    printf("O total produzido na semana foi: R$ %.2f\n", total);
    
    return 0;
}
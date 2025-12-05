#include <stdio.h>
#include <stdlib.h>

int main(){
    int qty;

    printf("Digite a quantidade de valores: ");
    scanf("%d", &qty);

    int *values = (int *)malloc(qty * sizeof(int));

    if(values == NULL){
        printf("Erro ao alocar memoria.\n");
        return 1;
    }

    for(int i = 0; i < qty; i++){
        int val;
        printf("Digite o valor %d: ", i + 1);
        scanf("%d", &val);

        if(val < 0){
            values[i] = 0;
            continue;
        }

        values[i] = val;
    }

    printf("\nValores armazenados: ");
    for(int i = 0; i < qty; i++){
        printf(" %d ", values[i]);
    }

    free(values);
    return 0;
}
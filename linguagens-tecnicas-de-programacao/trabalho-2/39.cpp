#include <stdio.h>
#include <stdlib.h>

int main(){
    int qty;

    printf("Digite a quantidade de valores: ");
    scanf("%d", &qty);

    int *numbers = (int *)malloc(qty * sizeof(int));

    if(numbers == NULL){
        printf("Erro ao alocar memoria.\n");
        return 1;
    }

    for(int i = 0; i < qty; i++){
        printf("Digite o valor %d: ", i + 1);
        scanf("%d", &numbers[i]);
    }

    printf("\nValores armazenados invertidos: ");
    for(int i = qty - 1; i >= 0; i--){
        printf(" %d ", numbers[i]);
    }

    free(numbers);
    return 0;
}
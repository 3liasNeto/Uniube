#include <stdio.h>
#include <stdlib.h>


int max(int[3]);
int min(int[3]);

int main(){
    int num[3];

    for(int i = 0; i < 3; i++){
        printf("Digite o numero %d: ", i + 1);
        scanf("%d", &num[i]);
    }

    printf("O maior numero é: %d\n", max(num));
    printf("O menor numero é: %d\n", min(num));

    return 0;
}

int max(int numbers[3]){
    int biggest = numbers[0];

    for(int i = 1; i < 3; i++){
        if(numbers[i] > biggest){
            biggest = numbers[i];
        }
    }

    return biggest;
}

int min(int numbers[3]){
    int smallest = numbers[0];

    for(int i = 1; i < 3; i++){
        if(numbers[i] < smallest){
            smallest = numbers[i];
        }
    }

    return smallest;
}
#include <stdio.h>
#include <stdlib.h>
#define LIMIT 50

float get_smaller(float acc, float curr);
float get_bigger(float acc, float curr);

int main(){
    float notes[LIMIT], average, total, bigger = 0, smaller = 0;
    int qty_notes;

    printf("Digite a quantidade de notas (max %d): ", LIMIT);
    scanf("%d", &qty_notes);

    if(qty_notes > LIMIT || qty_notes <= 0){
        printf("Número de notas inválido.\n");
        return 1;
    }

    for(int i = 0; i < qty_notes; i++){
        printf("Digite a nota %d: ", i + 1);
        scanf("%f", &notes[i]);

        bigger = get_bigger(bigger, notes[i]);
        smaller = get_smaller(smaller, notes[i]);
        total += notes[i];
    }

    average = total / qty_notes;

    printf("\n=============================\n");
    printf("Resumo das notas:\n");
    printf("Maior nota: %.2f\n", bigger);
    printf("Menor nota: %.2f\n", smaller);
    printf("Média das notas: %.2f\n", average);
    printf("Total das notas: %.2f\n", total);
    printf("=============================\n");
    return 0;
}

float get_smaller(float acc, float curr){
    if(acc == 0 || curr < acc){
        return curr;
    }
    return acc;
}

float get_bigger(float acc, float curr){
    if(curr > acc){
        return curr;
    }
    return acc;
}
#include <stdio.h>
#include <stdlib.h>


typedef struct {
    float note[3];
    float weight[3];
} MediaData;

float median(MediaData);

int main(){
    MediaData data;

    for(int i = 0; i < 3; i++){
        printf("=== Exemplo %d ===\n", i + 1);
        printf("Digite a nota %d: ", i + 1);
        scanf("%f", &data.note[i]);
        printf("Digite o peso da nota %d: ", i + 1);
        scanf("%f", &data.weight[i]);
    }

    float med = median(data);

    printf("A média ponderada é: %.2f\n", med);
    return 0;
}

float median(MediaData data){
    float total_weight = 0.0, weighted_sum = 0.0;

    for(int i = 0; i < 3; i++){
        weighted_sum += data.note[i] * data.weight[i];
        total_weight += data.weight[i];
    }

    if(total_weight == 0){
        return 0.0;
    }

    return weighted_sum / total_weight;
}
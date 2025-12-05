#include <stdio.h>
#include <stdlib.h>

typedef struct {
    float largura;
    float altura;
} Retangulo;

float area(Retangulo);
float perimetro(Retangulo);

int main(){
    Retangulo rect;

    printf("Digite a largura do retângulo: \n");
    scanf("%f", &rect.largura);
    printf("Digite a altura do retângulo: \n\n");
    scanf("%f", &rect.altura);

    printf("Área do retângulo: %.2f\n", area(rect));
    printf("Perímetro do retângulo: %.2f\n", perimetro(rect));

    return 0;
}

float area(Retangulo r){
    return r.largura * r.altura;
}

float perimetro(Retangulo r){
    return 2 * (r.largura + r.altura);
}
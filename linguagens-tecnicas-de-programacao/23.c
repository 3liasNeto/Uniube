#include <stdio.h>

int main() {
    float peso, altura;
    printf("Peso (kg): ");
    scanf("%f", &peso);
    printf("Altura (m): ");
    scanf("%f", &altura);
    float imc = peso / (altura * altura);
    printf("IMC: %.2f\n", imc);
    return 0;
}
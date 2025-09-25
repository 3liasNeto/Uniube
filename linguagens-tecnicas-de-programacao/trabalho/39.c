#include <stdio.h>

int main()
{
    unsigned short age;
    float peso, altura;

    printf("Idade: ");
    scanf("%hu", &age);
    printf("Peso (kg): ");
    scanf("%f", &peso);
    printf("Altura (m): ");
    scanf("%f", &altura);

    double imc = peso / (altura * altura);

    if (age < 18)
    {
        printf("classificação IMC para adultos; usar com cautela");
    };

    if (imc < 18.5)
    {
        printf("Abaixo do peso\n");
    }
    else if (imc >= 18.5 && imc < 25.9)
    {
        printf("Peso normal\n");
    }
    else if (imc >= 25 && imc < 30)
    {
        printf("Sobrepeso\n");
    }
    else
    {
        printf("Obesidade\n");
    }

    return 0;
}
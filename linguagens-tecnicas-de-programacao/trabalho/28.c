#include <stdio.h>

int main()
{
    int minutos;
    printf("Digite a quantidade de minutos: ");
    scanf("%d", &minutos);

    int horas = minutos / 60;
    int resto = minutos % 60;

    printf("%d minutos = %d hora(s) e %d minuto(s)\n", minutos, horas, resto);
    return 0;
}
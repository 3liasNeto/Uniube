#include <stdio.h>

int main()
{
    float speed;
    unsigned short limit;
    char via;
    double multa = 0.0;

    printf("Velocidade (km/h): ");
    scanf("%f", &speed);
    printf("Via (U/R): ");
    scanf(" %c", &via);
    printf("Limite (km/h): ");
    scanf("%hu", &limit);

    float tolerancia = 0.0;

    if (via == 'U' || via == 'u')
    {
        tolerancia = 0.07;
    }
    else if (via == 'R' || via == 'r')
    {
        tolerancia = 0.05;
    }
    else
    {
        printf("Tipo de via invalido!\n");
        return 1;
    }

    float limite_com_tolerancia = limit * (1 + tolerancia);

    printf("\nVelocidade registrada: %.2f km/h\n", speed);
    printf("Limite com tolerancia: %.2f km/h\n", limite_com_tolerancia);

    if (speed > limite_com_tolerancia)
    {
        float excesso = (speed - limit) / limit * 100;

        if (excesso <= 20)
        {
            multa = 130.16;
        }
        else if (excesso <= 50)
        {
            multa = 195.23;
        }
        else
        {
            multa = 880.41;
        }

        printf("Excesso: %.2f%%\n", excesso);
        printf("Multa aplicada: R$ %.2lf\n", multa);
    }
    else
    {
        printf("Dentro do limite. Sem multa.\n");
    }
    return 0;
}
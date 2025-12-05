#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Usando Object Map/Dispatch Map para mapear números aos dias da semana || E usando ponteiros para strings
void map_weekdays()
{
    const char *weekdays[] = {
        "Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"};
    int day;

    printf("Digite um número entre 1 a 7 para obter o dia da semana correspondente: ");
    scanf("%d", &day);

    if (day >= 0 && day <= 6)
    {
        printf("O dia é: %s\n", weekdays[day]);
    }
    else
    {
        printf("Entrada inválida! Por favor, insira um número entre 1 a 7.\n");
    }
};

int main(){
    int day;
    printf("Digite um número entre 1 a 7 para obter o dia da semana correspondente: ");
    scanf("%d", &day);

    switch(day){
        case 1:
            printf("O dia é: Domingo\n");
            break;
        case 2:
            printf("O dia é: Segunda-feira\n");
            break;
        case 3:
            printf("O dia é: Terça-feira\n");
            break;
        case 4:
            printf("O dia é: Quarta-feira\n");
            break;
        case 5:
            printf("O dia é: Quinta-feira\n");
            break;
        case 6:
            printf("O dia é: Sexta-feira\n");
            break;
        case 7:
            printf("O dia é: Sábado\n");
            break;
        default:
            printf("Entrada inválida! Por favor, insira um número entre 1 a 7.\n");
    }

    return 0;
}
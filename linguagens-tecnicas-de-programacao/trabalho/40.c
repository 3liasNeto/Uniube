#include <stdio.h>

int main() {
    unsigned short dia, mes;
    unsigned int ano;
    int bissexto = 0, valido = 1, dias_no_mes;

    printf("Informe a data (DD MM AAAA): ");
    printf("Dia: ");
    scanf("%hu", &dia);
    printf("Mês: ");
    scanf("%hu", &mes);
    printf("Ano: ");
    scanf("%u", &ano);

    if ((ano % 400 == 0) || (ano % 4 == 0 && ano % 100 != 0)) {
        bissexto = 1;
    }

    switch (mes) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            dias_no_mes = 31;
            break;
        case 4: case 6: case 9: case 11:
            dias_no_mes = 30;
            break;
        case 2:
            dias_no_mes = bissexto ? 29 : 28;
            break;
        default:
            valido = 0;
    }

    if (valido && dia >= 1 && dia <= dias_no_mes) {
        printf("Data: %02hu/%02hu/%u → válida", dia, mes, ano);
        if (bissexto) {
            printf(" (ano bissexto)\n");
        } else {
            printf("\n");
        }
    } else {
        printf("Data: %02hu/%02hu/%u → inválida\n", dia, mes, ano);
    }

    return 0;
}
#include <stdio.h>
#include <ctype.h>

int main() {
    double consumo;
    double tarifa_base;
    char bandeira, baixa_renda;
    double valor_base, adicional = 0.0, total, desconto = 0.0;

    printf("Consumo (kWh): ");
    scanf("%lf", &consumo);
    
    if (consumo <= 0) {
        printf("Erro: Consumo deve ser maior que zero!\n");
        return 1;
    }

    printf("Tarifa base por kWh (R$): ");
    scanf("%lf", &tarifa_base);  // %lf para double
    
    if (tarifa_base <= 0) {
        printf("Erro: Tarifa deve ser maior que zero!\n");
        return 1;
    }

    printf("Bandeira (V = Verde, A = Amarela, R = Vermelha): ");
    scanf(" %c", &bandeira);

    printf("Baixa renda (S/N): ");
    scanf(" %c", &baixa_renda);

    valor_base = consumo * tarifa_base;

    bandeira = toupper(bandeira);
    baixa_renda = toupper(baixa_renda);

    switch (bandeira) {
        case 'V':
            adicional = 0.0;
            break;
        case 'A':
            adicional = consumo * 0.01874;
            break;
        case 'R':
            adicional = consumo * 0.03971;
            break;
        default:
            printf("Erro: Bandeira inválida! Use V, A ou R.\n");
            return 1;
    }

    total = valor_base + adicional;

    if (baixa_renda == 'S' && consumo <= 150) {
        desconto = total * 0.15;
        total -= desconto;
    }

    printf("\n--- Conta de Energia ---\n");
    printf("Consumo: %.1f kWh\n", consumo);
    printf("Bandeira: %c\n", bandeira);
    printf("Valor base: R$ %.2f\n", valor_base);
    printf("Adicional bandeira: R$ %.2f\n", adicional);
    if (desconto > 0.0) {
        printf("Desconto baixa renda (15%%): -R$ %.2f\n", desconto);
    }
    printf("Valor final: R$ %.2f\n", total);

    return 0;
}
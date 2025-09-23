#include <stdio.h>

int main() {
    int largura, comprimento;
    scanf("Largura: %d", &largura);
    scanf("Comprimento: %d", &comprimento);
    int area = largura * comprimento;
    printf("Área Do Retângulo: %d\n", area);
    return 0;
}
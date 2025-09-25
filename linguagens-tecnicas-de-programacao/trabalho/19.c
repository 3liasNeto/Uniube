#include <stdio.h>

int main() {
    int width, length;
    printf("Informe a largura: ");
    scanf("%d", &width);
    printf("Informe o comprimento: ");
    scanf("%d", &length);
    int area = width * length;
    printf("Área Do Retângulo: %d\n", area);
    return 0;
}
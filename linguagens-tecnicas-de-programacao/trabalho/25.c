#include <stdio.h>

int main() {
    // * Cubo
    int lado;

    printf("Lado do Cubo: ");
    scanf("%d", &lado);
    int volume = lado * lado * lado;
    printf("Volume do Cubo: %d\n", volume);
    return 0;
}
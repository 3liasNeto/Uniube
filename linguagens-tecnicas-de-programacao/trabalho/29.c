#include <stdio.h>

int main() {
    float k;
    printf("Km/h: ");
    scanf("%f", &k);
    float ms = k * (1000.0 / 3600.0);
    printf("Velocidade: %.2f Km/h\n", k);
    printf("Velocidade: %.2f m/s\n", ms);
    return 0;
}